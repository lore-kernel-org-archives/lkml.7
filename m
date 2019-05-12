Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28AC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7152173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMmeY2xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfELRqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33102 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfELRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so4345974wrx.0;
        Sun, 12 May 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpFKiSt85cZObJXkqM+4NINsxlg/dnFUO7/fP7CyTZ0=;
        b=iMmeY2xPP9Gkz4hrehGXNo2bjZMgTBYhInSPHslK0abKhJynkPsYjC0Q6H1xlqV7ux
         INxX22Cir+VWX1qCXokJ6pP3rd+Upeq2WH/Ioyba0ng+aA3q0dNwJrbCfqJZJrbDdsCq
         BUm9j/kb4b+47ifOlPJIyYuM6/qdfyRQxaJ3PxI8x9jwVBhOoSvF+h9wMbfCKLh404iE
         6DOEaCILT+OL+uDUpfdsmbX+1pXB196Kkq7QUCkoyu0YCa8TDj+XonhZRx9f9yNxPfAL
         M6JI3n5NxNiE9zbvD/UGmmQehA3YDbwjg+wjTNkfj3/69pl2nCwXVA9B9ojgrIoKVEyE
         rQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpFKiSt85cZObJXkqM+4NINsxlg/dnFUO7/fP7CyTZ0=;
        b=Chgm9P/xeQKNQS6gdT7ah2Cl5yqMKNLebPoqDft5U89OyuCn5LWM0zE6yUfFKt45G/
         98oschqWNGLE+uKKqUogl7nR4+8hBxXMLoeasfdptJMWxmhhGqiG7SzUvNJNxMmPWVch
         5i+jV/CCJFIDLQOBixqxNzTOwmHWxp4aU9lhZa48ctEos6De8dn3GsXB3I2HBqIoRWd/
         Opea46h6u0b93xqZndfiM5ITxBYvFZA93yNmQMVmzmm96p9hFy6mwLbzQoK6d5ihl9ul
         eXoRe48o7Vkk5BjQ8VI0PlYBPlP3Jh+cbjtLUwGKMIYmB1sm/hjHNLJL5zKzBZaja+Xp
         +MXw==
X-Gm-Message-State: APjAAAWqv1Ne9jB7Ai2eo+fPYHDGA2Ihht6pBF78zLuy86hu6KNrfnAa
        3dtDPuLQIlpk/e7r/r4QCpE=
X-Google-Smtp-Source: APXvYqyQ4hsYAZCq/NBC97ZKDgZwacx09DQv3e6Ca9hA1rxZqrgnHiF+a99dzDlj9/3v8toWPtdO8A==
X-Received: by 2002:adf:e2c3:: with SMTP id d3mr14927414wrj.189.1557683181084;
        Sun, 12 May 2019 10:46:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:20 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 5/8] arm64: dts: allwinner: Add mali GPU supply for Pine H64
Date:   Sun, 12 May 2019 19:46:05 +0200
Message-Id: <20190512174608.10083-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

Enable and add supply to the Mali GPU node on the
Pine H64 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 4802902e128f..e16a8c6738f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -85,6 +85,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.17.1

