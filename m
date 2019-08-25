Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFAC21744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0G77X/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfHYECh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfHYECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so12077818wrj.12;
        Sat, 24 Aug 2019 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OfWp6DdTWFBY5iMG3Y4I12ubDq+isq8BawGVdp8q8tE=;
        b=u0G77X/SBFfXDGhxY1mgwkw+Lc2DpUIoIdKiKE75hN27NrmpsHPOmAB9IvCgyFpaqq
         rqRhGnNYOp+OwHv0oIwXSLEAcbca8ahJGUAlfO+gLJS5615+roz8DGgd2YFJiSiPppth
         wolUraO1EjUXvX7Zk1xK9BPSsj37Tk9bck9BVZQK8a0SPRJRvPSfrQZnDBGBud1XnH7l
         p47u5vyuCd70xoosyLni2CDNTOwMFqM3GkPUn4PBC1fHw4RsW7+9JmVfzzIKVsJznXNz
         VqfLDKUQdveYiqSz6Zzj5P3wEMkJIrQIUdm/kstxbgI/DFhsAScgmbJQ4/7XGapeKdVY
         xGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OfWp6DdTWFBY5iMG3Y4I12ubDq+isq8BawGVdp8q8tE=;
        b=p2fwGTlJHBkeLoFSZ2P/A3Qe4pOVdDKhWtqsu9ztDVIjqNGwVt0wOWbzj0WTUC+owY
         p7ayBKxrqVlnKNquqGRyxwAWZUgDpdEPxUk4RxBBr1SauTPRoLKbvvln3wf1JciHqHtn
         6minVin5jz4emWjqyKsozvA71o3MDmxtWu/WjnmyY1sRRfE/56+WrkxzYsp+8keohUh5
         tG5W1G+PHZDAdlkuPm8cbHjHK4NyoPbRp81kVfNAMihVvz7eIW3OdyWtj1bB9I6zHLFm
         juVzQ/fQ0ANVt9RrRXZX509UH/TVtQCbRbZgaLA/h/FWzpCdlnRnTfZGVz4Nw58nUoI+
         Kh/g==
X-Gm-Message-State: APjAAAVyXuzM5po9oki/wmbMpIbGcsDnDSWwareqnhoI4l9RYr3jlpHF
        AtQxXytPnEDFuIATvnhWDys=
X-Google-Smtp-Source: APXvYqzIzM7anln1kp1dhBf/Fy8v6RC5KHmIZwhYYq5nmO5CVTPGaWeWNBN7WkqDnGAFj51lP5TGPg==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr14601540wrn.230.1566705753817;
        Sat, 24 Aug 2019 21:02:33 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 6/7] arm64: dts: meson-gxl-s905w-tx3-mini: add rc-tx3mini keymap
Date:   Sun, 25 Aug 2019 08:01:27 +0400
Message-Id: <1566705688-18442-7-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the rc-tx3mini keymap to the ir node

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
index 789c819..dd729ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
@@ -20,3 +20,7 @@
 		reg = <0x0 0x0 0x0 0x40000000>; /* 1 GiB or 2 GiB */
 	};
 };
+
+&ir {
+	linux,rc-map-name = "rc-tanix-tx3mini";
+};
-- 
2.7.4

