Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE475C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C912073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="GGQXyqfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKOKF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:05:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35784 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfKOKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:05:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so10073832ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E3sXchnQK6r0cbCO41TzSdNyYDZO5b9qiU92SWHzyaY=;
        b=GGQXyqfAOOdn2W+1sXwtBvsy92bU6TkWIfV4fpktp026z4PB3TSvxZ0SBhT8E7OlT6
         Q0NPLYkSp6Ly+KCZ0MCiexwh4ckM7I+V5D/eNPIuOF+QJXEDzTa25PYbqdH3XS+QYyRT
         xK0lc680H8iIyhT8xFqqYqJLoGbSe2S3PGPAlDbsEqKs0yKUCU1msu/kMU7uRfHP/nYE
         EWYzNYe+dL5s9xxB5FsA14YsJeLZAShYgAhjgagOvHfMwGi47t72O4u5Nk085epZU8J1
         w7Ms9aP3ZzLHfvR0YEPibjX+UzuHx5M3peE6Hz3bQVElSqHGtAYG8G/LqF6Zf/zBtbzB
         fIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=E3sXchnQK6r0cbCO41TzSdNyYDZO5b9qiU92SWHzyaY=;
        b=Vs8/oTD2YvLuhoT9CMaQVlxsSI539zwB4/qqNMKf8qomqEZRUIJ0cc7cJ1WdPGzcL9
         4gOYsF/9V6Rr/+v/Kso2MBg0+MLtiDggJHfNWrhKNx2WZRYOPoH55ozJlCn6x14m1KvK
         KX9+FVxqnZAcVJIDc5dnh6gJ5Y4CrmAdhj2/A/O20F65MWrC66dNa7lygN/ew254ymuX
         EYtBqPsnDoQLusJ8OemOx8GAejT28p0DyxAd1pcKW9M06pJug+s7IDkEcPck6KkJan8d
         MMFpLAMIN2VEgCnMS9BMeupEzlj8V0tNhz9eh8acmVeWI7j0PH7tiZwYC4j5ZUdxHd9G
         PCJA==
X-Gm-Message-State: APjAAAU5osjr0Y2SKfqc5pMWA579PQ2JTU1u5enYuR9RuFlaicviYx/Q
        MHtDTCQ5QmUG3cSWhFkUKyZb6uFqnLfSLw==
X-Google-Smtp-Source: APXvYqy4I4omiLNNVKrf3idEsLlQPggt3o4md59DtcnBbH4pie88Z1O31ITPk0/nYDiBggFn9sRPNA==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr9981244ljc.139.1573812318913;
        Fri, 15 Nov 2019 02:05:18 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id e14sm3727391ljb.75.2019.11.15.02.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 02:05:18 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drivers/base: Fix memory leak in error paths
References: <20191114121840.5585-1-jouni.hogander@unikie.com>
        <20191115032603.GG793701@kroah.com> <878soha7tc.fsf@unikie.com>
        <20191115082022.GB55909@kroah.com>
Date:   Fri, 15 Nov 2019 12:05:17 +0200
In-Reply-To: <20191115082022.GB55909@kroah.com> (Greg Kroah-Hartman's message
        of "Fri, 15 Nov 2019 16:20:22 +0800")
Message-ID: <8736epa202.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> >> This memory leak was reported by Syzkaller:
>> >>=20
>> >> BUG: memory leak unreferenced object 0xffff8880675ca008 (size 256):
>> >>   comm "netdev_register", pid 281, jiffies 4294696663 (age 6.808s)
>> >>   hex dump (first 32 bytes):
>> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> >>   backtrace:
>> >>     [<0000000058ca4711>] kmem_cache_alloc_trace+0x167/0x280
>> >>     [<000000002340019b>] device_add+0x882/0x1750
>> >>     [<000000001d588c3a>] netdev_register_kobject+0x128/0x380
>> >>     [<0000000011ef5535>] register_netdevice+0xa1b/0xf00
>> >>     [<000000007fcf1c99>] __tun_chr_ioctl+0x20d5/0x3dd0
>> >>     [<000000006a5b7b2b>] tun_chr_ioctl+0x2f/0x40
>> >>     [<00000000f30f834a>] do_vfs_ioctl+0x1c7/0x1510
>> >>     [<00000000fba062ea>] ksys_ioctl+0x99/0xb0
>> >>     [<00000000b1c1b8d2>] __x64_sys_ioctl+0x78/0xb0
>> >>     [<00000000984cabb9>] do_syscall_64+0x16f/0x580
>> >>     [<000000000bde033d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> >>     [<00000000e6ca2d9f>] 0xffffffffffffffff
>> >
>> > How is this a leak?  This is in device_add(), not removing the device.
>> > When the structure really is freed then it can be removed.
>>=20
>> In net/core/net-sysfs.c:netdev_register_kobject device_add allocates
>> dev->p. Now if register_queue_kobjects fails the error path is calling
>> device_del and dev->p is never freed. Proper fix here could be to call
>> put_device after device_del?
>
> Hm, this sounds like you have a reference count leak here, as
> put_device() should be properly called already in this case.  You might
> want to look further to see where exactly the register_queue_kobjects()
> call fails in order to see if we grabbed a reference we forgot to put
> back on an error path.

Ok, did some more debugging on
this. net/core/net-sysfs.c:netdev_register_kobject is doing
device_initialize(dev). This is in
drivers/base/core.c:device_initialize:

 * NOTE: Use put_device() to give up your reference instead of freeing
 * @dev directly once you have called this function.

My understanding is that remaining reference on error path is taken by
device_initialize and as instructed in the note above it should be given
up using put_device? Tested this and it's fixing the memory leak I found
in my Syzkaller exercise. Addition to that it seems to be fixing also
this one:

https://syzkaller.appspot.com/bug?id=3Df5f4af9fb9ffb3112ad6e30f717f769decdc=
cdfc

BR,

Jouni H=C3=B6gander
