Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037F4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFDD22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NYZPG4YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfGYXnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:43:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40889 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfGYXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so23513332pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=mfnZxOLDEeVO3qt5r3vvVtE+ErJ1uBMl6JY5u4LfgE8=;
        b=NYZPG4YGuOK9pb/2O879xjVVXKhk7WAvahsuMxvB98qIUqyPiOnrQfQ7P+Ixq3MPma
         duSsO5O/64u+E2DWqn5D9KXPJfVirf/E7wKVvcvQiNcVhx+9dgbDE55NwVx+TNdUFPtL
         HvSNEOHGX3NOIDAQ/pq7NQ+imv/wl1pWJXUdb6QOiYLbj793p9+d5af8/iOesOe5lQzm
         lS/0RgANQyEPvRMRa4YecacmiEKGzvpM819v62SGJVVAytNGiVNtL8m3osIFWFdWup3d
         3xF7zo67ZntoeI8Yaft3hgxhzcj+lGU7e4kaRtzhJehqB+RlDKNfFuNEkMxdc4aEElLS
         hXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mfnZxOLDEeVO3qt5r3vvVtE+ErJ1uBMl6JY5u4LfgE8=;
        b=j2IhWpi2ANFKjBjAu8LtIdRJJxgWxDHwhG1Vj5SFbcSAomQjy3oV0JyUCtofkEohBs
         8JjDZuVXYi0ycFBLn6AfGHQIaoPP7hiZClHBIyFFhUMxqJovh7C0IvYTwBLDUDEtCNNr
         GL7R9NqE1m+7mZy8tK7BZTXvEnJTiAZ1RJ+d/fG+bZatDPKR0rk3ZPg5YXJ0bUc95c8s
         pE6/3TXNLdpGbklTVCyJuxqXFyfZ26BPon8rQ6TijF05igkb7HsWV6NeqTsiU8cqAzGp
         o2Fpxiyz2CylRGCPjPYCEaBy8BrUJjmc5h7yfARXhPWsNXvhansZEWnsGXK9U/SbBLcR
         deEQ==
X-Gm-Message-State: APjAAAWnfxRVzEaZk70tMv81m++pMSI5zQgwRBCRrNNiNyr2KhbI6zJa
        XakAmIki+neT9moFqhvV5tSRxA==
X-Google-Smtp-Source: APXvYqzhoS3YtUHt0ZnWmTrTLKzKcKwKjxpCWou1XYaUkEeTyPdkWoXNaQqca3bgA+hs4A+tDUQLAw==
X-Received: by 2002:aa7:8201:: with SMTP id k1mr18609232pfi.97.1564098085191;
        Thu, 25 Jul 2019 16:41:25 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c1da:f078:8d:a297])
        by smtp.googlemail.com with ESMTPSA id s11sm49036956pgv.13.2019.07.25.16.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 16:41:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xavier Ruppen <xruppen@gmail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com,
        Xavier Ruppen <xruppen@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: odroid-n2: keep SD card regulator always on
In-Reply-To: <20190719192954.26481-1-xruppen@gmail.com>
References: <20190719192954.26481-1-xruppen@gmail.com>
Date:   Thu, 25 Jul 2019 16:41:20 -0700
Message-ID: <7htvb9smvz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Ruppen <xruppen@gmail.com> writes:

> When powering off the Odroid N2, the tflash_vdd regulator is
> automatically turned off by the kernel. This is a problem
> when issuing the "reboot" command while using an SD card.
> The boot ROM does not power this regulator back on, blocking
> the reboot process at the boot ROM stage, preventing the
> SD card from being detected.
>
> Adding the "regulator-always-on" property fixes the problem.
>
> Signed-off-by: Xavier Ruppen <xruppen@gmail.com>

Thanks for the fix and the detailed background description.

Queued as a fix for v5.3.

Note that I also added this to the commit log, for the benefit of anyone
wanting to backport.

Fixes: c35f6dc5c377 ("arm64: dts: meson: Add minimal support for Odroid-N2")

>
> Here is what the boot ROM output looks like without this patch:
>
>     [root@alarm ~]# reboot 
>     [...]
>     [   24.275860] shutdown[1]: All loop devices detached.
>     [   24.278864] shutdown[1]: Detaching DM devices.
>     [   24.287105] kvm: exiting hardware virtualization
>     [   24.318776] reboot: Restarting system
>     bl31 reboot reason: 0xd
>     bl31 reboot reason: 0x0
>     system cmd  1.
>     G12B:BL:6e7c85:7898ac;FEAT:E0F83180:2000;POC:F;RCY:0;
>     EMMC:800;NAND:81;SD?:0;SD:400;USB:8;LOOP:1;EMMC:800;
>     NAND:81;SD?:0;SD:400;USB:8;LOOP:2;EMMC:800;NAND:81;
>     SD?:0;SD:400;USB:8;LOOP:3; [...]
>
> Other people can be seen having this problem on the odroid
> forum [1].
>
> The cause of the problem was found by Martin Blumenstingl
> on #linux-amlogic. We may want to add his Suggested-by tag
> if he agrees.

Added.

Thanks!

Kevin
