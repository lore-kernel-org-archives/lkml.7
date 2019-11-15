Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5BD20718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573813147;
	bh=NZ63NmQNdqqOg8QZk/cSBZAcCPCaW4OKgvlGkuOPuu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qtJz+4d4lBc5VRHN6rsacGTtgHqdrSyPqw+YW0hlV13kzgLTxP/SAZ4AiEtsIFyV
	 OXoD03YTi4V0Fl9dvuOiAseZCN56tHbQxQEaCfTGRdT4UxTLC2owp7NgPaDo4MOuM6
	 vt3CU54KcB+FnRddXoCRZsV0qX1dpswz3GI41HLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfKOKTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:19:06 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8604420718;
        Fri, 15 Nov 2019 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573813145;
        bh=NZ63NmQNdqqOg8QZk/cSBZAcCPCaW4OKgvlGkuOPuu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=By8G6G5e28iA0Gr4bOhEr021LSlPDBGfHVO0N5aCMvrVTJJvlcseP8YM2r4e+EJYq
         TQQAo+FYUxYBJ7e2EpyKYTq3uMup1e9SWyd6iEUlzU7hd8hRDAKNDTxWgS8qc3CwBU
         xaheU4z7POPb7ogz3JHCyaVaoGyErw0LNtkwTLPY=
Date:   Fri, 15 Nov 2019 18:19:02 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@unikie.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drivers/base: Fix memory leak in error paths
Message-ID: <20191115101902.GB337025@kroah.com>
References: <20191114121840.5585-1-jouni.hogander@unikie.com>
 <20191115032603.GG793701@kroah.com>
 <878soha7tc.fsf@unikie.com>
 <20191115082022.GB55909@kroah.com>
 <8736epa202.fsf@unikie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736epa202.fsf@unikie.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:05:17PM +0200, Jouni Högander wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> >> This memory leak was reported by Syzkaller:
> >> >> 
> >> >> BUG: memory leak unreferenced object 0xffff8880675ca008 (size 256):
> >> >>   comm "netdev_register", pid 281, jiffies 4294696663 (age 6.808s)
> >> >>   hex dump (first 32 bytes):
> >> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> >> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> >> >>   backtrace:
> >> >>     [<0000000058ca4711>] kmem_cache_alloc_trace+0x167/0x280
> >> >>     [<000000002340019b>] device_add+0x882/0x1750
> >> >>     [<000000001d588c3a>] netdev_register_kobject+0x128/0x380
> >> >>     [<0000000011ef5535>] register_netdevice+0xa1b/0xf00
> >> >>     [<000000007fcf1c99>] __tun_chr_ioctl+0x20d5/0x3dd0
> >> >>     [<000000006a5b7b2b>] tun_chr_ioctl+0x2f/0x40
> >> >>     [<00000000f30f834a>] do_vfs_ioctl+0x1c7/0x1510
> >> >>     [<00000000fba062ea>] ksys_ioctl+0x99/0xb0
> >> >>     [<00000000b1c1b8d2>] __x64_sys_ioctl+0x78/0xb0
> >> >>     [<00000000984cabb9>] do_syscall_64+0x16f/0x580
> >> >>     [<000000000bde033d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> >>     [<00000000e6ca2d9f>] 0xffffffffffffffff
> >> >
> >> > How is this a leak?  This is in device_add(), not removing the device.
> >> > When the structure really is freed then it can be removed.
> >> 
> >> In net/core/net-sysfs.c:netdev_register_kobject device_add allocates
> >> dev->p. Now if register_queue_kobjects fails the error path is calling
> >> device_del and dev->p is never freed. Proper fix here could be to call
> >> put_device after device_del?
> >
> > Hm, this sounds like you have a reference count leak here, as
> > put_device() should be properly called already in this case.  You might
> > want to look further to see where exactly the register_queue_kobjects()
> > call fails in order to see if we grabbed a reference we forgot to put
> > back on an error path.
> 
> Ok, did some more debugging on
> this. net/core/net-sysfs.c:netdev_register_kobject is doing
> device_initialize(dev). This is in
> drivers/base/core.c:device_initialize:
> 
>  * NOTE: Use put_device() to give up your reference instead of freeing
>  * @dev directly once you have called this function.
> 
> My understanding is that remaining reference on error path is taken by
> device_initialize and as instructed in the note above it should be given
> up using put_device?

Yes, that is correct.

> Tested this and it's fixing the memory leak I found in my Syzkaller
> exercise. Addition to that it seems to be fixing also this one:
> 
> https://syzkaller.appspot.com/bug?id=f5f4af9fb9ffb3112ad6e30f717f769decdccdfc

Great!  Care to submit a patch for this?

thanks,

greg k-h
