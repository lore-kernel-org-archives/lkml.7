Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F29C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549962148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPrysw8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCKO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:27:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41266 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCKO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:27:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so3814487pfn.8;
        Mon, 11 Mar 2019 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ICrXTJ3B/DEaY6SBZ7LMgfjNBRMJJDkMINCPKs+DbHo=;
        b=JPrysw8a19p+xe87/VaXEvMgroOuMO6ui1V4tK8VlYccVOAJhDhKe/zv94+Funzrok
         N3JD9c7IsFnH3woSRpF3mMfrMGKIG4La6MpAW6ccRNytXXMhj16kuG1T15EPq/7NAxMQ
         sttds+HOJn2IcOBLfF+k7MHRppH7NjPla3KTo26iWbJtHEC8JrXYvhbvN5D2CTIS/Cze
         DfsEKBnWpyAq8W2CFR6FCfJJDq7pNcZ6kl+Xi4f4i8zPh2Wb/Nl5LkFSq8qM05z8VAv3
         lLbSAfq9O3Sd4Q7TorvIvezYYq0GVv2epeNMPAKQBTgRXGutq5kukHL9ZjMTt6P+kRNl
         Dm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ICrXTJ3B/DEaY6SBZ7LMgfjNBRMJJDkMINCPKs+DbHo=;
        b=UgRZqsZuddHwlxgx23JjghqT7XKWWd3iZof6dRrYuMKtTYBn0RSHxplxzLO26QrgTA
         mnnHCbW5W4T6XE7tSjyQhLFgTZ1AMMtxDtKSgYgbbMkZO3DANjyU4Q7ZRXHuX421s8dN
         CidSlMd5qW93CajcbatsVVs6m5Vm0fHek5Og3G4JVXDwbxq2Be7HTUcZ7aL3UpTVGvVh
         kaqPhW876kHLeNDYVZYvXdVo75PlolF8GUz+UPZbkPJGDXbcPL9CiaeoYOS4hZaYgQSw
         mKY6Fw5k1XzSHj+vueEU0PpmrcSZVj2OzlbWntHqkbsFNENFWj8CwEBcbanryKjk2yBT
         uzwQ==
X-Gm-Message-State: APjAAAXeUY/hU85lWJmPPJwYko74IrwVuYmo85A8e++Xdl9A958tzMTj
        khrwHZ3Rz+p5RWdcqwTGPgg=
X-Google-Smtp-Source: APXvYqzRRy8YMZDqz6BWj3qw5XdTO6PMRW8wakYFMbaT+Hw2l2iiCq4BA/M4ZP7HGOxJI/bqJS3g8A==
X-Received: by 2002:a62:1c45:: with SMTP id c66mr33607619pfc.90.1552314433059;
        Mon, 11 Mar 2019 07:27:13 -0700 (PDT)
Received: from nishad (p640014-ipngn8201hodogaya.kanagawa.ocn.ne.jp. [60.46.49.14])
        by smtp.gmail.com with ESMTPSA id q207sm8710490pgq.88.2019.03.11.07.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 07:27:12 -0700 (PDT)
Date:   Mon, 11 Mar 2019 19:57:04 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6ull: Use the correct style for SPDX License
 Identifier
Message-ID: <20190311142700.GA5867@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in imx6ull-pinfunc-snvs.h.

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46
and making some manual changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
index f6fb6783c193..54cfe72295aa 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  * Copyright (C) 2017 NXP
-- 
2.17.1

