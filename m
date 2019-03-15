Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368002186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfCOM6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:58:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:47038 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCOM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:58:07 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 95BEA2008B3;
        Fri, 15 Mar 2019 12:58:05 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 7A85E21449; Fri, 15 Mar 2019 13:57:46 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:57:46 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
Message-ID: <20190315125746.GA15624@light.dominikbrodowski.net>
References: <20190315074307.GA31430@light.dominikbrodowski.net>
 <3476.1552650285@warthog.procyon.org.uk>
 <20190315115002.GA9055@light.dominikbrodowski.net>
 <20190315121813.GY2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315121813.GY2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:18:13PM +0000, Al Viro wrote:
> On Fri, Mar 15, 2019 at 12:50:02PM +0100, Dominik Brodowski wrote:
> > On Fri, Mar 15, 2019 at 11:44:45AM +0000, David Howells wrote:
> > > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > 
> > > > [    0.839322] RIP: 0010:sysfs_init_fs_context+0x82/0xd0
> > > 
> > > Could you load your kernel into gdb and then do:
> > > 
> > > 	i li *sysfs_init_fs_context+0x82
> > 
> > Doesn't seem necessary as per my mail to Al a few seconds ago:
> > kobj_ns_grab_current(KOBJ_NS_TYPE_NET) returns NULL, so
> > 
> >         fc->user_ns = get_user_ns(netns->user_ns);
> > 
> > will try to dereference a null pointer.
> > 
> > Thanks,
> > 	Dominik
> > 
> 
> Charming...  It's netns being turned off, and the thing we'd missed
> is that kobj_ns_current_may_mount() becomes constant true in that
> setup.  IOW, ns_capable(..., CAP_SYS_ADMIN) is suppressed entirely
> in that case (well, aside of what may_mount() has done in
> do_mount/sys_fsmount).
> 
> So what we need is making that "change fc->user_ns" conditional
> on netns != NULL, as in
> 
> diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
> index 4cb21b558a85..1b56686ab178 100644
> --- a/fs/sysfs/mount.c
> +++ b/fs/sysfs/mount.c
> @@ -71,9 +71,11 @@ static int sysfs_init_fs_context(struct fs_context *fc)
>  	kfc->magic = SYSFS_MAGIC;
>  	fc->fs_private = kfc;
>  	fc->ops = &sysfs_fs_context_ops;
> -	if (fc->user_ns)
> -		put_user_ns(fc->user_ns);
> -	fc->user_ns = get_user_ns(netns->user_ns);
> +	if (netns) {
> +		if (fc->user_ns)
> +			put_user_ns(fc->user_ns);
> +		fc->user_ns = get_user_ns(netns->user_ns);
> +	}
>  	fc->global = true;
>  	return 0;
>  }

That fixes the issue at hand, thanks (verified both on top of the
problematic commit and on top of mainline).

Thanks,
	Dominik
