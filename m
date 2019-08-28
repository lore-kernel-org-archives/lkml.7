Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F97C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1174822CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1Mj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:39:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41588 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Mj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:39:59 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i2xEv-0002EI-OW; Wed, 28 Aug 2019 12:39:53 +0000
Date:   Wed, 28 Aug 2019 14:39:53 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/4] binder: add a mount option to show global stats
Message-ID: <20190828123952.zzffvezeq4hykxej@wittgenstein>
References: <20190827204152.114609-1-hridya@google.com>
 <20190827204152.114609-2-hridya@google.com>
 <20190828092237.GA23192@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828092237.GA23192@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:22:37AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 27, 2019 at 01:41:49PM -0700, Hridya Valsaraju wrote:
> > Currently, all binder state and statistics live in debugfs.
> > We need this information even when debugfs is not mounted.
> > This patch adds the mount option 'stats' to enable a binderfs
> > instance to have binder debug information present in the same.
> > 'stats=global' will enable the global binder statistics. In
> > the future, 'stats=local' will enable binder statistics local
> > to the binderfs instance. The two modes 'global' and 'local'
> > will be mutually exclusive. 'stats=global' option is only available
> > for a binderfs instance mounted in the initial user namespace.
> > An attempt to use the option to mount a binderfs instance in
> > another user namespace will return an EPERM error.
> > 
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > ---
> >  drivers/android/binderfs.c | 47 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 45 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index cc2e71576396..d95d179aec58 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -51,18 +51,27 @@ static DEFINE_IDA(binderfs_minors);
> >  /**
> >   * binderfs_mount_opts - mount options for binderfs
> >   * @max: maximum number of allocatable binderfs binder devices
> > + * @stats_mode: enable binder stats in binderfs.
> >   */
> >  struct binderfs_mount_opts {
> >  	int max;
> > +	int stats_mode;
> >  };
> >  
> >  enum {
> >  	Opt_max,
> > +	Opt_stats_mode,
> >  	Opt_err
> >  };
> >  
> > +enum binderfs_stats_mode {
> > +	STATS_NONE,
> > +	STATS_GLOBAL,
> > +};
> > +
> >  static const match_table_t tokens = {
> >  	{ Opt_max, "max=%d" },
> > +	{ Opt_stats_mode, "stats=%s" },
> >  	{ Opt_err, NULL     }
> >  };
> >  
> > @@ -290,8 +299,9 @@ static void binderfs_evict_inode(struct inode *inode)
> >  static int binderfs_parse_mount_opts(char *data,
> >  				     struct binderfs_mount_opts *opts)
> >  {
> > -	char *p;
> > +	char *p, *stats;
> >  	opts->max = BINDERFS_MAX_MINOR;
> > +	opts->stats_mode = STATS_NONE;
> >  
> >  	while ((p = strsep(&data, ",")) != NULL) {
> >  		substring_t args[MAX_OPT_ARGS];
> > @@ -311,6 +321,24 @@ static int binderfs_parse_mount_opts(char *data,
> >  
> >  			opts->max = max_devices;
> >  			break;
> > +		case Opt_stats_mode:
> > +			stats = match_strdup(&args[0]);
> > +			if (!stats)
> > +				return -ENOMEM;
> > +
> > +			if (strcmp(stats, "global") != 0) {
> > +				kfree(stats);
> > +				return -EINVAL;
> > +			}
> > +
> > +			if (!capable(CAP_SYS_ADMIN)) {
> > +				kfree(stats);
> > +				return -EINVAL;
> 
> Can a non-CAP_SYS_ADMIN task even call this function?  Anyway, if it

It can. A task that has CAP_SYS_ADMIN in the userns the corresponding
binderfs mount has been created in can change the max=<nr> mount option.
Only stats=global currently requires capable(CAP_SYS_ADMIN) aka
CAP_SYS_ADMIN in the initial userns to prevent non-initial userns from
snooping at global statistics.

> can, put the check at the top of the case, and just return early before
> doing any extra work like checking values or allocating memory.
> 
> > +			}
> > +
> > +			opts->stats_mode = STATS_GLOBAL;
> > +			kfree(stats);
> > +			break;
> >  		default:
> >  			pr_err("Invalid mount options\n");
> >  			return -EINVAL;
> > @@ -322,8 +350,21 @@ static int binderfs_parse_mount_opts(char *data,
> >  
> >  static int binderfs_remount(struct super_block *sb, int *flags, char *data)
> >  {
> > +	int prev_stats_mode, ret;
> >  	struct binderfs_info *info = sb->s_fs_info;
> > -	return binderfs_parse_mount_opts(data, &info->mount_opts);
> > +
> > +	prev_stats_mode = info->mount_opts.stats_mode;
> > +	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (prev_stats_mode != info->mount_opts.stats_mode) {
> > +		pr_info("Binderfs stats mode cannot be changed during a remount\n");
> 
> pr_err()?
> 
> thanks,
> 
> greg k-h
