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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86991C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE4D21744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay+Hq9I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfHYECZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37502 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfHYECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so12691754wme.2;
        Sat, 24 Aug 2019 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5nNhd18MvwU8IC7GxybIhRsED8y+5jrB7YM1thtsV4=;
        b=ay+Hq9I1SH/G7X2WBWSkTU5FtlKBlJPSNA7Naj1Cj4ThMxpMKFn0csUhA9ucx26arS
         EbkmTSYQUxj3zfsdmkVxsRVdFmJX2R74cThGlcbaWLK3QkRFxv5IcBDI9oKaxoUV2s20
         y5dLzttp22mFpshuwRoKWonptKX5EaMDKgLSJldSR19p4q93vQcFQ+CjGQzGkGrEWhkE
         c1dTdREt1QTy90HFJoWi3ZTzC62Gaz24VGEhEOU3MlfAzejSjZHqMTFbNzBLmQZ86cMH
         zNhQE2HEGN2ahhWbsv118AURzWO2dhwi+gFXoky7l55+2ZADU3n8hhjpq19B9Bjs2t1E
         5Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E5nNhd18MvwU8IC7GxybIhRsED8y+5jrB7YM1thtsV4=;
        b=QCWJRlvkk/yqIK3U2ngqVBQqjl00Lf7vZygJ1IzpIwWf1jBd2bPJMtsGoGVivgX4wy
         5xDAA7ffmuKVbcYn9Ra8zTQMBoga4A+GMHPKTFJjH/zwCBU/zOtxmbjrMYVgwABzjCsp
         q3jL34ejxCWLAnOU8PqIKowkU38yp7QlrxFXsa92q803JGoCwoAiZ2p6TyFF2pbX+rJt
         60JqGeY9e3lF6GuchwXjewbGLqJQBd9yeXEvgxGRYE4NxZ6BkBjVoMA/iSHNW4n6Fj8V
         ZZTKJZ6HDSIvuJZBoD7olfjqEzDbIKyc0j3ElIAFnkvRonDHOJaamCZa5qdkE4g9JAI+
         SZdw==
X-Gm-Message-State: APjAAAXnvKZUMvHn54gZwUWPKS84Ba1K9ZjKCAWrN7017bX1/S8e97LJ
        faGqiTtsGHAi7pbq/tLdUF0=
X-Google-Smtp-Source: APXvYqwP+cAgov2Lv/Km0Kd45gqctZDqhITi9FE+8G+wJU7Xj+jePJhogxyk7XN3R5IIeLoyr484rg==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr14337691wmb.116.1566705741664;
        Sat, 24 Aug 2019 21:02:21 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:21 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/7] arm64: dts: meson-g12b-odroid-n2: add rc-odroid keymap
Date:   Sun, 25 Aug 2019 08:01:22 +0400
Message-Id: <1566705688-18442-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the rc-odroid keymap to the ir node

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 81780ff..35cef76 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -314,6 +314,7 @@
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
 	pinctrl-names = "default";
+	linux,rc-map-name = "rc-odroid";
 };
 
 /* SD card */
-- 
2.7.4

