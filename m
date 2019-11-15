Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02BA2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="qlTFholu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKOH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:59:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43701 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:59:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so9630269ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 23:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TfZCE8XJRS2orWRrItYHlrJ8IwyjIIAY3mBdfPZoME0=;
        b=qlTFholuGVwywOf3HAYf7AR256NsOgf9/UvQjBzYTvtqbKMbzjOyUdhASTe67P9Y4K
         lT8wZlQOgqV2TzQ2xXxAr33ROhHvNI+zgJubrqNz90TK7THkpwFZIJ1QFapM4OvJDeZE
         CtjQTJ63jZSwZ82zkrrS0jSsa71VM0+dr5iEPf6HAc1YYzSPW5BX4Pu8YX5aoy8n2qXJ
         KLjQFGfoSsIO06dLf86/+y3c2Hchyw2xhYzjzz/xAMm2PgspakzFx2YkaNhf/yN0QjGN
         lI+Xd6fcQFvEZyJujOAyEZBw2fGdho0JpB85NWXKmikblgIZBBbwa1Kmgd8h631I+TC0
         hlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=TfZCE8XJRS2orWRrItYHlrJ8IwyjIIAY3mBdfPZoME0=;
        b=k99WjbSuhDsJYoIwdXDGN38TCLbEeDSAy5wHvk7vv4RkVv4ct3inwKVSNgirDDYHNV
         5kq3QeBARvPuYBdMnSqzf8n51+LnOv8IjSJm/hXB+ejG7GLgOlxgeGaRzVtrdigxZldb
         uyPRy9HD9QmeEw7V1b7u3cTU04FuLtWeRxVEgZQ4x61wT72xFArkaozYLGS9vtIklSCE
         rz+YX+srv1vG+Wt1A1jNFJqWGLNMk4RzF7FkL8PCCGGtLFARqAaM3nVwrDydk3fxnxu+
         IQtbkHRvljPtCvC6iIA9XmlBtD9mtB2czJg5JsDCeU+kongCOC3WuJGkxizgZHvkgOI9
         ehpw==
X-Gm-Message-State: APjAAAV7ijNPBfbFCf9vM6PYGkRZqgAb2+JVTOT0jMEffHulP7IRv/Ug
        wfuVeyzDbaNZEwX8y2bCnJIwNA==
X-Google-Smtp-Source: APXvYqy6pyV0+R8s+Own+oKYGVaairdwlPnbopRhAjIwkuypSTfZNgycwE+hbvF0eBr8cD2siA9npg==
X-Received: by 2002:a2e:2903:: with SMTP id u3mr10219487lje.131.1573804785634;
        Thu, 14 Nov 2019 23:59:45 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id 3sm3783547lfq.55.2019.11.14.23.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 23:59:45 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drivers/base: Fix memory leak in error paths
References: <20191114121840.5585-1-jouni.hogander@unikie.com>
        <20191115032603.GG793701@kroah.com>
Date:   Fri, 15 Nov 2019 09:59:43 +0200
In-Reply-To: <20191115032603.GG793701@kroah.com> (Greg Kroah-Hartman's message
        of "Fri, 15 Nov 2019 11:26:03 +0800")
Message-ID: <878soha7tc.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Nov 14, 2019 at 02:18:40PM +0200, jouni.hogander@unikie.com wrote:
>> From: Jouni Hogander <jouni.hogander@unikie.com>
>>=20
>> Currently error paths are using device_del to clean-up preparations
>> done by device_add. This is causing memory leak as free of dev->p
>> allocated in device_add is freed in device_release. This is fixed by
>> moving freeing dev->p to counterpart of device_add i.e. device_del.
>
> Are you sure that is safe?  The device can still be "alive" after
> device_del() is called.  The only place you know that it should be freed
> is in the release callback.

Now as you pointed this out I'm not.

>
>> This memory leak was reported by Syzkaller:
>>=20
>> BUG: memory leak unreferenced object 0xffff8880675ca008 (size 256):
>>   comm "netdev_register", pid 281, jiffies 4294696663 (age 6.808s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>   backtrace:
>>     [<0000000058ca4711>] kmem_cache_alloc_trace+0x167/0x280
>>     [<000000002340019b>] device_add+0x882/0x1750
>>     [<000000001d588c3a>] netdev_register_kobject+0x128/0x380
>>     [<0000000011ef5535>] register_netdevice+0xa1b/0xf00
>>     [<000000007fcf1c99>] __tun_chr_ioctl+0x20d5/0x3dd0
>>     [<000000006a5b7b2b>] tun_chr_ioctl+0x2f/0x40
>>     [<00000000f30f834a>] do_vfs_ioctl+0x1c7/0x1510
>>     [<00000000fba062ea>] ksys_ioctl+0x99/0xb0
>>     [<00000000b1c1b8d2>] __x64_sys_ioctl+0x78/0xb0
>>     [<00000000984cabb9>] do_syscall_64+0x16f/0x580
>>     [<000000000bde033d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>     [<00000000e6ca2d9f>] 0xffffffffffffffff
>
> How is this a leak?  This is in device_add(), not removing the device.
> When the structure really is freed then it can be removed.

In net/core/net-sysfs.c:netdev_register_kobject device_add allocates
dev->p. Now if register_queue_kobjects fails the error path is calling
device_del and dev->p is never freed. Proper fix here could be to call
put_device after device_del?

>
> Or are you triggering an error in device_add() somehow to trigger this
> callback?

This was found using Syzkaller with fault injection and memory leak
detection enabled. Error is not triggered in device_add but after
device_add.

BR,

Jouni H=C3=B6gander
