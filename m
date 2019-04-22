Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0919C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA1120896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSib0CWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfDVTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:18:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39341 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfDVTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:18:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so11247536ljg.6;
        Mon, 22 Apr 2019 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=qSib0CWJSpsucT03obYyVS270O48CfqZuuwM3auib5qwOLmFAYw6jhmztQnIYeFTzV
         VNZpyRbp1SRdJpB32DUPyrBXzx83jQo3v+v5K9Y+JP/cJIJzXT2sUue81N3KOCB2W2rg
         PH6AfwwPdb7FIFoOKbM16oTPUiB4Wb9dlGnnA7aO7kqkKNggl7qx9uVoIEcvy0ctrZRt
         KjJYF+lzxOCORwmL6rTP37IFbv5rJ9MVX3lStb4AM8vTagK5zPIJMIltcR+06E44n3Za
         emYMG4VQ1PxCnDhY6jATyrdrLgYjGicdf+rZko7bQXqPd2O/EfZjhjB5/ttHQgh4zu/c
         2guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=bIFxQBza3TlA3M6/iTiACWzwaL76fss0urh5RONx2pBze3CfmLyZ2E0mzT9zsWOfrx
         arI81izFNe1Tb/ScOjOUv/4fsoPVnVA16/VibVbX9WAVJumnCXzHgoN4MloRz99euMXs
         qd87foQOPwmZjge08WOLrJBON6ezuMwD82B3iD3lXYTSWWUHz7fLLbXrzF3Wl8eoKweR
         nc0hTECN7AdhCnbTogNO1h/o79//qj9QQfv+FArTZaCQdM9//n46ca/uWrIwxc9Ne36H
         XpBX7RmaX7Th0ANWZz/Zbrn0G720lq4mWaJ3rcyp98te2SxRVjHVAoJ1Yt8QKuSCrVKw
         /vyg==
X-Gm-Message-State: APjAAAVKCeMapDFIVkfE6AHYN1TFjbjxa5X970+TEu1YQGb26YZIwaFe
        Wzbu/9FI5ba5oX7jmkedVQk=
X-Google-Smtp-Source: APXvYqwuuxi+b+rdRdYTbqRT8tyoBWv4t+DX8AcSlOweICorMx+ArN/Y84DTCP7c4x21uRzJmJqyiw==
X-Received: by 2002:a2e:3204:: with SMTP id y4mr11087630ljy.90.1555960731097;
        Mon, 22 Apr 2019 12:18:51 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
Date:   Mon, 22 Apr 2019 22:13:44 +0300
Message-Id: <20190422191350.27527-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422191350.27527-1-digetx@gmail.com>
References: <20190422191350.27527-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPS_PERIOD_MAX_US definitions are swapped for MAX20024 and MAX77620,
fix it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/mfd/max77620.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index ad2a9a852aea..b4fd5a7c2aaa 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -136,8 +136,8 @@
 #define MAX77620_FPS_PERIOD_MIN_US		40
 #define MAX20024_FPS_PERIOD_MIN_US		20
 
-#define MAX77620_FPS_PERIOD_MAX_US		2560
-#define MAX20024_FPS_PERIOD_MAX_US		5120
+#define MAX20024_FPS_PERIOD_MAX_US		2560
+#define MAX77620_FPS_PERIOD_MAX_US		5120
 
 #define MAX77620_REG_FPS_GPIO1			0x54
 #define MAX77620_REG_FPS_GPIO2			0x55
-- 
2.21.0

