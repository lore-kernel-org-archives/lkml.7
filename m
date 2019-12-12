Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAC4C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A182021556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjb4J4Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfLLXQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:16:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42148 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfLLXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:16:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id x13so275260plr.9;
        Thu, 12 Dec 2019 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QugmQVfkr5kZ5L06QzjGjrkPPpkKJsHosocYw9nkXYU=;
        b=Jjb4J4VzVLPOmC6bbFASdp8Qh98F+OA+usrxiVMhS8CCy4yqe3wt7Coib+5Kam75vL
         JC32YNicxYhCea7HUEKC6kRu5HcOESEN/qt4vxIBl15a93NfUQE3VYepnlkCKA9OZP5r
         d4LSMMzRRPeLdcvOT1yqHfZ7Tdo9ohpUKwryKqOuYwLuhqOAKd1AL0GnmkT3TJvAvXGX
         O4uZges96v3Zb1JH7yZuxRfoYib/b4DANcxU9AdHlDxPcTtf3QUb2TJ0q9Kk3kX2nk37
         ZpkvZ5ud19a15wY7VX+ytCc6nfiOdomTTuAaxZatfrIH0Eh6P+7PHih/VNUouM27NfGt
         acwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QugmQVfkr5kZ5L06QzjGjrkPPpkKJsHosocYw9nkXYU=;
        b=AlpD/LGeQ0fRPfrTHB4K4mGbZLAgcX4uUbUyc4E+D9L/WdgqWlkb7aKFd7Z2R+i9Jp
         yaMDqXwbT6fC3vFBGzBKGpC+ztB74JPNVktL23g8GONu8uc4agOyszDC0VdkYTZ8T22u
         iYzFaldF22bYPvmNuxl6nR4Q/Er9g7WT7bhXiE4NVtkdhEMSpCgB4QWMK8RRD2tfMPYf
         i8tZio2tO0dFxmAcUbdZQhm6IwDYuUqLWdoRZDyK93ysVzJ2VbdfY3LqYzvHSSajSlMp
         k/s/yPK7Le1iILh3HNL1PKKu8jlNNO+SGPZoB99hBbOEPkXY9fGpXo1KpJGo9eZMFsIW
         NGug==
X-Gm-Message-State: APjAAAXBVlqlTJav0Fqjp9MLxvO86c1bEk7+t1MGZVY+86gUQGa46sY6
        TVW0UApvWFbCm12bps+QYRM=
X-Google-Smtp-Source: APXvYqxyMrVg9IcNBWLaeMiBnoSXUAohAjqNoUjd0LnkUQuoYfNNWWihyzKcX1cckq+MRBMfevi95Q==
X-Received: by 2002:a17:90a:c795:: with SMTP id gn21mr12912024pjb.95.1576192608724;
        Thu, 12 Dec 2019 15:16:48 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1072])
        by smtp.gmail.com with ESMTPSA id ev11sm9423307pjb.1.2019.12.12.15.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:16:48 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: delete no-hw-checksum from Facebook NetBMC dts
Date:   Thu, 12 Dec 2019 15:16:20 -0800
Message-Id: <20191212231622.302-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series is to delete "no-hw-checksum" from all Facebook Network
BMC platforms, because ftgmac100's checksum issue has been fixed by
commit 88824e3bf29a ("net: ethernet: ftgmac100: Fix DMA coherency issue
with SW checksum").

Patch #1 removes "no-hw-checksum" from Minipack and CMM BMCs (MAC-PHY
connection), and patch #2 deletes the property from Yamp BMC (MAC/NC-SI
connection).

Tao Ren (2):
  ARM: dts: aspeed: delete no-hw-checksum from Facebook NetBMC Common
    dtsi
  ARM: dts: aspeed: delete no-hw-checksum from yamp dts

 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts        | 1 -
 arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi | 1 -
 2 files changed, 2 deletions(-)

-- 
2.17.1

