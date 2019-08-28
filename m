Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A08C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30F0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566984162;
	bh=HryJYf5g08YQjfvT68Ede1Nd4RLNa68zczGsa66UktA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BHK1/JCyJ4M0sNhuojhYRgHWCcxUja+gW3Dt6ReTqtFoanYO/+VVnnbnc6tO4VeIw
	 QS3TbfveFXOApyOxUQ0OQ9fNhXgwWV6S99vy3ezrjJ9WH1C/3oIzGSaWHXZt+GxyyG
	 OrN/aLhLSBIVOw6xkH1P4NOeIbMQD1ZbLP37ZaBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfH1JWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfH1JWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:22:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377B02173E;
        Wed, 28 Aug 2019 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566984159;
        bh=HryJYf5g08YQjfvT68Ede1Nd4RLNa68zczGsa66UktA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSYHZeREby00ePW9bDdBeQYwY+gDqs9Oz9kmWf8N8yaOhHQgAI/rdKXmGDWkHBU+G
         cWIYFHTKVNXD9yY/Awne0jwAO3vRaXnTd1FLmRryisDCYtNQOwl8E/hAq0O5eZ1xOc
         Ne8rxhaEuFQBbvDuE2TF/opB8l+ndhWG5/eIRmic=
Date:   Wed, 28 Aug 2019 11:22:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/4] binder: add a mount option to show global stats
Message-ID: <20190828092237.GA23192@kroah.com>
References: <20190827204152.114609-1-hridya@google.com>
 <20190827204152.114609-2-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827204152.114609-2-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:41:49PM -0700, Hridya Valsaraju wrote:
> Currently, all binder state and statistics live in debugfs.
> We need this information even when debugfs is not mounted.
> This patch adds the mount option 'stats' to enable a binderfs
> instance to have binder debug information present in the same.
> 'stats=global' will enable the global binder statistics. In
> the future, 'stats=local' will enable binder statistics local
> to the binderfs instance. The two modes 'global' and 'local'
> will be mutually exclusive. 'stats=global' option is only available
> for a binderfs instance mounted in the initial user namespace.
> An attempt to use the option to mount a binderfs instance in
> another user namespace will return an EPERM error.
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>  drivers/android/binderfs.c | 47 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index cc2e71576396..d95d179aec58 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -51,18 +51,27 @@ static DEFINE_IDA(binderfs_minors);
>  /**
>   * binderfs_mount_opts - mount options for binderfs
>   * @max: maximum number of allocatable binderfs binder devices
> + * @stats_mode: enable binder stats in binderfs.
>   */
>  struct binderfs_mount_opts {
>  	int max;
> +	int stats_mode;
>  };
>  
>  enum {
>  	Opt_max,
> +	Opt_stats_mode,
>  	Opt_err
>  };
>  
> +enum binderfs_stats_mode {
> +	STATS_NONE,
> +	STATS_GLOBAL,
> +};
> +
>  static const match_table_t tokens = {
>  	{ Opt_max, "max=%d" },
> +	{ Opt_stats_mode, "stats=%s" },
>  	{ Opt_err, NULL     }
>  };
>  
> @@ -290,8 +299,9 @@ static void binderfs_evict_inode(struct inode *inode)
>  static int binderfs_parse_mount_opts(char *data,
>  				     struct binderfs_mount_opts *opts)
>  {
> -	char *p;
> +	char *p, *stats;
>  	opts->max = BINDERFS_MAX_MINOR;
> +	opts->stats_mode = STATS_NONE;
>  
>  	while ((p = strsep(&data, ",")) != NULL) {
>  		substring_t args[MAX_OPT_ARGS];
> @@ -311,6 +321,24 @@ static int binderfs_parse_mount_opts(char *data,
>  
>  			opts->max = max_devices;
>  			break;
> +		case Opt_stats_mode:
> +			stats = match_strdup(&args[0]);
> +			if (!stats)
> +				return -ENOMEM;
> +
> +			if (strcmp(stats, "global") != 0) {
> +				kfree(stats);
> +				return -EINVAL;
> +			}
> +
> +			if (!capable(CAP_SYS_ADMIN)) {
> +				kfree(stats);
> +				return -EINVAL;

Can a non-CAP_SYS_ADMIN task even call this function?  Anyway, if it
can, put the check at the top of the case, and just return early before
doing any extra work like checking values or allocating memory.

> +			}
> +
> +			opts->stats_mode = STATS_GLOBAL;
> +			kfree(stats);
> +			break;
>  		default:
>  			pr_err("Invalid mount options\n");
>  			return -EINVAL;
> @@ -322,8 +350,21 @@ static int binderfs_parse_mount_opts(char *data,
>  
>  static int binderfs_remount(struct super_block *sb, int *flags, char *data)
>  {
> +	int prev_stats_mode, ret;
>  	struct binderfs_info *info = sb->s_fs_info;
> -	return binderfs_parse_mount_opts(data, &info->mount_opts);
> +
> +	prev_stats_mode = info->mount_opts.stats_mode;
> +	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
> +	if (ret)
> +		return ret;
> +
> +	if (prev_stats_mode != info->mount_opts.stats_mode) {
> +		pr_info("Binderfs stats mode cannot be changed during a remount\n");

pr_err()?

thanks,

greg k-h
