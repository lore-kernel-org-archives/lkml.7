Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA9FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A5921A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+a1VT2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404890AbfJPRId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:08:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34741 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389259AbfJPRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:08:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so18145466lfm.1;
        Wed, 16 Oct 2019 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FuDtedlY48DcctCZGWagsRf8MsM87uwA3mMuVGQ2AP8=;
        b=j+a1VT2OS4bm7ECykAC43ju60WarYAfWCbRzuFLrL1hxbpgI3Z4j7pRhUEai/49rJ9
         i48Z56uH5ua66STUHM58TXOltWf4jqVt4q70XzNx6Xa/pb+7PaTc9wej5Uc6Wn5/krkQ
         Vb5+qH2HJrsvo4vOpu/boufSBlQMCwGX9+hcTLZy3E696r2y0B23YccJG92eOKxRjjzJ
         fvBSjdk9kz2z5Rin4tvxtefT/UsjzQ9A2Vht8QkBkV33orbNGrGwyM5GMDqwjZP8Jlgj
         qKETLs4Jb5W07NgAbvDu2uVy5YSvJHNegP8luJGJOGZUHoKkAQ9Dvqv6sVk1rmMfwZP/
         zr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FuDtedlY48DcctCZGWagsRf8MsM87uwA3mMuVGQ2AP8=;
        b=eYpbH9QG43SeINBZuzrQaaXbFmxC/tSjQTSakajQIuwWfu23KsxjDskq93ipH7ItBN
         I2/ZM1pce6wU1eCuwLMgnevPGFWWlqFeGECeJN3nyPpScBv8w8IRVhLdPfgURFB8nfOp
         Be3rVwBMRf3WhQF3bB90uGS69TxUSyzdDuJ5TfRkFRmhb646yI1emN/WqfQyjJhrv0uQ
         U/sQWc6U+H/rHJtVp3B2fU1G3IJcFZw1cyMN5EJ7D78PkRkLXirrm0EN7OxC4loa+XGh
         wPQQLq9b4pZgM9qOIAxL7jped56UVWAOGxlQTk7iW8mU5CIgiMn32+ALVgYe6uyP0m1i
         rLAw==
X-Gm-Message-State: APjAAAUtqLxjpzu5CQah3F/5uV8fQK3rv8JVBEVGEr7o9KLAqMpFj2x6
        pvVqgz4x3HW9xDU74KEclMM=
X-Google-Smtp-Source: APXvYqybaFGO1u4fZEPYMstx4sfISrbUPkeIsHhbcRYljDhIpvBSINMvFHrAxe5eS+JI8E/hZaMnnA==
X-Received: by 2002:a19:6a08:: with SMTP id u8mr1490535lfu.74.1571245709687;
        Wed, 16 Oct 2019 10:08:29 -0700 (PDT)
Received: from localhost.localdomain ([87.101.228.250])
        by smtp.gmail.com with ESMTPSA id q24sm6299182ljj.6.2019.10.16.10.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 10:08:29 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] arm64: dts: meson-gxm-vega-s96: set rc-vega-s9x ir keymap
Date:   Wed, 16 Oct 2019 21:07:36 +0400
Message-Id: <1571245657-4471-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
References: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an IR node to the Vega S96 dts to include the rc-vega-s9x keymap.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
index e2ea675..0bdf51d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts
@@ -35,3 +35,7 @@
 		reg = <0>;
 	};
 };
+
+&ir {
+	linux,rc-map-name = "rc-vega-s9x";
+};
-- 
2.7.4

