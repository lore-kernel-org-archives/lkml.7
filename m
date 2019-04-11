Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F00C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7563D2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M77lrMxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDKKrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56081 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so6090428wmf.5;
        Thu, 11 Apr 2019 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwhAx+QnGniZO7ghVRiFuf4mvV7+VICXC3x0clxm7ls=;
        b=M77lrMxKYrgpS1XnhqpDZB0JXI7TQg5GPnmSt4TErmBc3J2xeq/uCtgRqQq8KxrJ7g
         vny42RsUs3ewLzKDaqih/oYO2YzPi6r0ovFTiFBoNviWGAETx8k3d2CJWS3897Ve2NyM
         FzDAqgt6+NJJG+EmNvEy8a3i+YQiihSB/M/eH7L6p5YaRFnfI+wL6rURx4AVsB5/tRMk
         DeSTtWluC4bKhkr4nSlChkfvRXUTIHLuNGG7Hkp5WUBmoOIT6BdbdsBLIb63pi+6qwDC
         0vYk8kL0/8W3gAm/fh8ehQMrbkfUGaeNnuLelslJ7EDSbbUurjzzZqhTvPeZXXr6JZsE
         nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwhAx+QnGniZO7ghVRiFuf4mvV7+VICXC3x0clxm7ls=;
        b=YJ4iuJoAm6CRgFWpQsULlHQ7lsnsLMlxkYWsCfg0bf6XgdVbTKLGn2HF3OWFLWs6RR
         1Xr5vRyPEbyy5Rr5qOk5jqpW748VyfUbfJwFR+QHs2xXHHUdLxA+FmEsjhUtJiEdyBl+
         ONIxEqe0cjir8UQapJflWEQQhcW9NcFQ0P5L+xbDnHQSOy1DEX7nEhPSuJfvpeBFvBOJ
         /7hSl8M8Gc+ffcHCiv+R1OeeG/tgldNa9YlaGjiM4iq77HdqKjf78gQl6h4wrRaj9B37
         aVtrp913IIATXKBypP5BOyy4fasE6kOzR6vleAznzpxBdUQvvFXyKQXxRsRkARM5AZGD
         lQpA==
X-Gm-Message-State: APjAAAUDqpsMP1uaOxNghS+1hAbtKGM9Mz2F2i75QjwvgivDgmWRaSB1
        gxG8G+HANIzDuFyo+xI5NVlx8AVHBH73lQ==
X-Google-Smtp-Source: APXvYqzX26vtj0jqewyPzLVVEUATgJgwbRsMtQLdoxISsfwR5f5CHl0sNLVm3HcmNLD7nE/dewaAPQ==
X-Received: by 2002:a1c:a711:: with SMTP id q17mr6347416wme.111.1554979656547;
        Thu, 11 Apr 2019 03:47:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:36 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/8] Add Allwinner H6 Mali Midgard GPU
Date:   Thu, 11 Apr 2019 12:57:12 +0200
Message-Id: <20190411105720.32357-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Allwinner H6 has a Mali-T720 MP2. The drivers are
out-of-tree so this series only introduce the dt-bindings.

The first patch is from Neil Amstrong and has been already
merged in linux-amlogic. It is required for this series.

The second patch is from Icenowy Zheng where I changed the
order has required by Rob Herring.
See: https://patchwork.kernel.org/patch/10699829/

The GPU opp table was taken from Jernej Škrabec's patch
on LibreELEC.tv.

Thanks,
Clement

Changes in v2 (Thanks to Maxime Ripard):
 - Drop GPU OPP Table
 - Add clocks and clock-names in required

Clément Péron (7):
  dt-bindings: gpu: add bus clock for Mali Midgard GPUs
  dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for Pine H64
  arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
  arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
  arm64: dts: allwinner: Add mali GPU supply for OrangePi 3

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
 6 files changed, 61 insertions(+)

-- 
2.17.1

