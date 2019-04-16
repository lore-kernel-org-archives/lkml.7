Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2D20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555420875;
	bh=k0J5TkdbVMDv+FcRU72n6TkwsNHHnvKb/k27W5cOT1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m18zpfHQR5cUncP2Fx3djQ1COcDJ7DDmzQaGGF5ZF+mLodREMabYQTyY+H17tAO4r
	 nnvcL7M6gmeVk4La2+ODLhYlYmzjCxjBWMp5A70M8FPZXzH3KAJpQ2v1TxhYYUgbpU
	 C+nmGbW9X366GProQSpQW8jDnYrNPqD9AzR0mJJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfDPNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfDPNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:21:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05E62077C;
        Tue, 16 Apr 2019 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555420873;
        bh=k0J5TkdbVMDv+FcRU72n6TkwsNHHnvKb/k27W5cOT1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2Og6Yscwf30e/eb8jT8qfY10M8OcgVnBGbxm7pCxMl0DQR9qsRAJ60qkdwN4/VBK
         IUj6Zv8AeYdZiT5RMP+TxCDiwsJHe88OotVsNtmE2ySKQ9rZ7XLs6H21K+/Y8tY9h+
         GLz6qdnG0TkJXDX7qUTCsQK7eexg38cloZxGC1LE=
Date:   Tue, 16 Apr 2019 15:08:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: rocket: Fix a kernel address leakage in rp_ioctl
Message-ID: <20190416130802.GC7406@kroah.com>
References: <20190331115127.29731-1-huangfq.daxian@gmail.com>
 <e8e20b1b-d853-968e-d380-a142877e9b9d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e20b1b-d853-968e-d380-a142877e9b9d@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:34:08AM +0200, Jiri Slaby wrote:
> On 31. 03. 19, 13:51, Fuqian Huang wrote:
> > If the cmd is RCPK_GET_STRUCT, copy_to_user will copy info to
> > user space. As info->port.ops is the address of a constant object
> > rocket_port_ops (assigned in init_r_port), a kernel address leakage.
> > 
> > This patch sets all the pointer fields to NULL before copy the
> > object to user space to avoid kernel address leakage.
> > 
> > All pointer fields except
> > .magic field and the pointer in .dep_map field in struct mutex
> > which only exist under debug configurations of CONFIG_DEBUG_MUTEXES
> > and CONFIG_DEBUG_LOCK_ALLOC
> > are set to NULL.
> > 
> > The set NULL pointer fields are address of kernel objects:
> >  - pointers to constant objects: port.ops, port.client_ops
> >  - pointers to tty_struct instance
> >  - pointer.xmit_buf (allocated in rp_open)
> >  - pointer fields of wait_queue_head_t and struct mutex
> > 
> > I cannot think of a scenario where user space needs the address of
> > these kernel objects. So I set them all NULL before copy_to_user.
> > Another reason is that I have checked all uses of copy_to_user and
> > copy_from_user in this file, they do not use any of these pointer
> > fields. So these pointer fields can be set NULL safely.
> > 
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> >  drivers/tty/rocket.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> > index b121d8f8f3d7..df0b8ebab266 100644
> > --- a/drivers/tty/rocket.c
> > +++ b/drivers/tty/rocket.c
> > @@ -1271,6 +1271,48 @@ static int get_version(struct r_port *info, struct rocket_version __user *retver
> >  	return 0;
> >  }
> >  
> > +static int get_struct(struct r_port *info, void *argp)
> > +{
> > +	struct r_port *new;
> > +	int ret = 0;
> > +
> > +	new = kzalloc(sizeof(struct r_port), GFP_KERNEL);
> > +	if (!new)
> > +		return -ENOMEM;
> > +	memcpy(new, info, sizeof(struct r_port));
> > +	new->port.buf.head = NULL;
> > +	memset(&new->port.buf.work.entry, 0, sizeof(struct list_head));
> > +	new->port.buf.work.func = NULL;
> > +#ifdef CONFIG_LOCKDEP
> > +	new->port.buf.work.lockdep_map.key = NULL;
> > +	memset(&new->port.buf.work.lockdep_map.class_cache, 0,
> > +		sizeof(struct lock_class *) * NR_LOCKDEP_CACHING_CLASSES);
> > +	new->port.buf.work.lockdep_map.name = NULL;
> > +#endif
> > +	memset(&new->port.buf.lock.wait_list, 0, sizeof(struct list_head));
> > +	new->port.buf.sentinel.next = NULL;
> > +	memset(&new->port.buf.free, 0, sizeof(struct llist_head));
> > +	new->port.buf.tail = NULL;
> > +	new->port.tty = NULL;
> > +	new->port.itty = NULL;
> > +	new->port.ops = NULL;
> > +	new->port.client_ops = NULL;
> > +	memset(&new->port.open_wait.head, 0, sizeof(struct list_head));
> > +	memset(&new->port.delta_msr_wait.head, 0, sizeof(struct list_head));
> > +	memset(&new->port.mutex.wait_list, 0, sizeof(struct list_head));
> > +	memset(&new->port.buf_mutex.wait_list, 0, sizeof(struct list_head));
> > +	new->port.xmit_buf = NULL;
> > +	new->port.client_data = NULL;
> > +	new->ctlp = NULL;
> > +	new->channel.CtlP = NULL;
> > +	new->xmit_buf = NULL;
> > +	memset(&new->write_mtx.wait_list, 0, sizeof(struct list_head));
> > +	if (copy_to_user(argp, new, sizeof(struct r_port)))
> > +		ret = -EFAULT;
> > +	kfree(new);
> > +	return ret;
> 
> Ugh, no.
> 
> 1) The structure is defined as rocket _internal-only_.
> 2) It changed many times over time (whenever tty_port was changed at least).
> 3) Differs depending on various CONFIG_* options.
> 
> I seriously doubt anybody used the ioctl, ever. (What size would they
> pass, so that copy_to_user won't fail?)
> 
> So now, I am in favor of killing the ioctl completely. We also never
> exposed the ioctl number to userspace.

I agree, let's just delete the ioctl completly.

Fuqian, can you send a patch doing that please?

thanks,

greg k-h
