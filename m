Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADCC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A34206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573788368;
	bh=in4Nnx88Okt+KpvaUkR9Q/qLvzFGmG47hGjfkSFHv8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NCm5bSbPhB/3Y/AHswAG4cX4EcTkm0ke/dH2YyGGlNjXraQbmhPHNck0peR9S0v3d
	 zqqOG+ebUIQwBknb3Pswuxp+q0VjAyLd1OMVGnBSMq55gSkmtBJRxEiuFJ2cKEQTTq
	 TkDDvtt3bUyaGQqaF4RCWH/oWYyWs/E68FDiX1x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKOD0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfKOD0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:26:07 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49843206EF;
        Fri, 15 Nov 2019 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573788366;
        bh=in4Nnx88Okt+KpvaUkR9Q/qLvzFGmG47hGjfkSFHv8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+mXwz9J/5MdQ6cepQtOUF75lhBEi7KNVFNfzWGUeBUc83TTj/YVYegZhVO9smCmD
         p1ws6/WqUgV3FvFB2p0UlHktimSkCcWOJygljE8HSqKW9aciNp7lMtGmXd+71GITHQ
         3rGPV1uQYM/OulI29TsvcQB06Mb43Vs786TqvZ8E=
Date:   Fri, 15 Nov 2019 11:26:03 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jouni.hogander@unikie.com
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drivers/base: Fix memory leak in error paths
Message-ID: <20191115032603.GG793701@kroah.com>
References: <20191114121840.5585-1-jouni.hogander@unikie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114121840.5585-1-jouni.hogander@unikie.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 02:18:40PM +0200, jouni.hogander@unikie.com wrote:
> From: Jouni Hogander <jouni.hogander@unikie.com>
> 
> Currently error paths are using device_del to clean-up preparations
> done by device_add. This is causing memory leak as free of dev->p
> allocated in device_add is freed in device_release. This is fixed by
> moving freeing dev->p to counterpart of device_add i.e. device_del.

Are you sure that is safe?  The device can still be "alive" after
device_del() is called.  The only place you know that it should be freed
is in the release callback.

> This memory leak was reported by Syzkaller:
> 
> BUG: memory leak unreferenced object 0xffff8880675ca008 (size 256):
>   comm "netdev_register", pid 281, jiffies 4294696663 (age 6.808s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>   backtrace:
>     [<0000000058ca4711>] kmem_cache_alloc_trace+0x167/0x280
>     [<000000002340019b>] device_add+0x882/0x1750
>     [<000000001d588c3a>] netdev_register_kobject+0x128/0x380
>     [<0000000011ef5535>] register_netdevice+0xa1b/0xf00
>     [<000000007fcf1c99>] __tun_chr_ioctl+0x20d5/0x3dd0
>     [<000000006a5b7b2b>] tun_chr_ioctl+0x2f/0x40
>     [<00000000f30f834a>] do_vfs_ioctl+0x1c7/0x1510
>     [<00000000fba062ea>] ksys_ioctl+0x99/0xb0
>     [<00000000b1c1b8d2>] __x64_sys_ioctl+0x78/0xb0
>     [<00000000984cabb9>] do_syscall_64+0x16f/0x580
>     [<000000000bde033d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [<00000000e6ca2d9f>] 0xffffffffffffffff

How is this a leak?  This is in device_add(), not removing the device.
When the structure really is freed then it can be removed.

Or are you triggering an error in device_add() somehow to trigger this
callback?

thanks,

greg k-h
