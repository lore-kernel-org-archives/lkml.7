Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2075BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651621871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554466226;
	bh=FgbBeGBwf/FknIeXXQIak+ir1xIoUck+DYgNl5oq1Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uK66LKqD1xbrAnthrMT605gDeTuCe5VIuTIXRC5igQgwThB/T33qDvSh/HjSphI84
	 9YmZITRpyVoMJzT/2vYLzsRQ8U2zXqwHOL7MydGDLLMguLahWTGI6jVmQyLH4ojgFN
	 g4s49YntvOpK79AQHNiUlbfLvm0yO5HWPEecq/sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfDEMKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEMKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:10:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC2C20449;
        Fri,  5 Apr 2019 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554466222;
        bh=FgbBeGBwf/FknIeXXQIak+ir1xIoUck+DYgNl5oq1Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCTIAhfLxnwSOS/Zvw1ZMTtPhvvgY+OlXLHaa2UWu+TzMA4/r3lzp8LMhzRSK72r2
         FV/ady3FFowAN1CJDgT0Xkw+wxJadpXkOfZ1RlSVifaASNXqVCfaTq1toYWGyFURjE
         XGtcnbZWFQE2yHc0aG7dkzmZHOGrkHn5qs1Rrr4E=
Date:   Fri, 5 Apr 2019 14:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v0] kernfs: Skip kernfs_put of parent from child node
Message-ID: <20190405121020.GA32479@kroah.com>
References: <1554463267-30841-1-git-send-email-gkohli@codeaurora.org>
 <20190405113304.GA28420@kroah.com>
 <a491b524-54e2-839d-d8e6-c21e7ab7fdd1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a491b524-54e2-839d-d8e6-c21e7ab7fdd1@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:13:00PM +0530, Gaurav Kohli wrote:
> 
> On 4/5/2019 5:03 PM, Greg KH wrote:
> > On Fri, Apr 05, 2019 at 04:51:07PM +0530, Gaurav Kohli wrote:
> > > While adding kernfs node for child to the parent kernfs
> > > node and when child node founds that parent kn count is
> > > zero, then below comes like:
> > > 
> > > WARNING: fs/kernfs/dir.c:494 kernfs_get+0x64/0x88
> > > 
> > > This indicates that parent is in kernfs_put path/ or already
> > > freed, and if the child node keeps continue to
> > > make new kernfs node, then there is chance of
> > > below race for parent node:
> > > 
> > > CPU0				         CPU1
> > > //Parent node			         //child node
> > > kernfs_put
> > > atomic_dec_and_test(&kn->count)
> > > //count is 0, so continue
> > > 					  kernfs_new_node(child)
> > > 					  kernfs_get(parent);
> > > 					  //increment parent count to 1
> > > 					  //warning come as parent count is 0
> > > 					  /* link in */
> > > 					  kernfs_add_one(kn);
> > > 					  // this should fail as parent is
> > > 					  //in free path.
> > > 					  kernfs_put(child)
> > > kmem_cache_free(parent)
> > > 					  kmem_cache_free(child)
> > > 					  kn = parent
> > > 					  atomic_dec_and_test(&kn->count))
> > > 					  //this is 0 now, so release will
> > > 					  continue for parent.
> > > 					  kmem_cache_free(parent)
> > > 
> > > To prevent this race, child simply has to decrement count of parent
> > > kernfs node and keep continue the free path for itself.
> > > 
> > > Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
> > > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > > 
> > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > index b84d635..d5a36e8 100644
> > > --- a/fs/kernfs/dir.c
> > > +++ b/fs/kernfs/dir.c
> > > @@ -515,7 +515,6 @@ void kernfs_put(struct kernfs_node *kn)
> > >   	if (!kn || !atomic_dec_and_test(&kn->count))
> > >   		return;
> > >   	root = kernfs_root(kn);
> > > - repeat:
> > >   	/*
> > >   	 * Moving/renaming is always done while holding reference.
> > >   	 * kn->parent won't change beneath us.
> > > @@ -545,8 +544,8 @@ void kernfs_put(struct kernfs_node *kn)
> > >   	kn = parent;
> > >   	if (kn) {
> > > -		if (atomic_dec_and_test(&kn->count))
> > > -			goto repeat;
> > > +	/* Parent may be on free path, so simply decrement the count */
> > That's the wrong indentation :(
> > 
> > And how are you hitting this issue?  What user of kernfs is causing
> > this?
> 
> Hi Greg,
> 
> Thanks,  will fix comment indentation, seen during sys-executor running:
> 
> We have only one instance , In logs below warning also came:
> 
> WARNING: CPU: 4 kernel/msm-4.14/fs/kernfs/dir.c:494 kernfs_get+0x64/0x88
> 
> which indicated parent is in put path.
> 
> [  160.125151] Disabling lock debugging due to kernel taint
> [  160.130626] INFO: Allocated in __kernfs_new_node+0x8c/0x3c0 age=11 cpu=2
> pid=7098
> [  160.138314]     kmem_cache_alloc+0x358/0x388
> [  160.142445]     __kernfs_new_node+0x8c/0x3c0
> [  160.146590]     kernfs_new_node+0x80/0xc8
> [  160.150462]     kernfs_create_dir_ns+0x44/0xfc
> [  160.154777]     sysfs_create_dir_ns+0xa8/0x130
> [  160.158416] CPU5: update max cpu_capacity 1024
> [  160.159085]     kobject_add_internal+0x278/0x650
> [  160.163567]     kobject_add_varg+0xe0/0x130
> [  160.167606]     kobject_add+0x15c/0x1d0
> [  160.168452] CPU5: update max cpu_capacity 780
> [  160.171287]     get_device_parent+0x2d0/0x34c
> [  160.175510]     device_add+0x240/0xde0
> [  160.178371] CPU6: update max cpu_capacity 916
> [  160.179108]     input_register_device+0x5f4/0xa0c
> [  160.183686]     uinput_ioctl_handler+0x1184/0x2198
> [  160.202436] INFO: Freed in kernfs_put+0x2c8/0x434 age=14 cpu=0 pid=7096
> [  160.209230]     kernfs_put+0x2c8/0x434
> [  160.212825]     kobject_del+0x50/0xcc
> [  160.216332]     cleanup_glue_dir+0x124/0x16c
> [  160.220456]     device_del+0x55c/0x5c8
> [  160.224047]     __input_unregister_device+0x274/0x2a8
> [  160.228974]     input_unregister_device+0x90/0xd0
> [  160.233553]     uinput_destroy_device+0x15c/0x1dc
> [  160.238131]     uinput_release+0x44/0x5c
> [  160.241898]     __fput+0x1f4/0x4e4
> [  160.245127]     ____fput+0x20/0x2c
> 
> 
> during code review, I have found race between kernfs parent put call and
> child get call.

So this is a sysfs usage of this?  Using input devices or cpu devices
for the stress test?

thanks,

greg k-h
