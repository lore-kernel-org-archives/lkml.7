Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3176C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B1C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRYl5FA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfDOOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43835 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfDOOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so15946861lja.10;
        Mon, 15 Apr 2019 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8HWSyi3PygSX+JPDCLdXZ2LpUmvO6eJiuWIhGQlNkaw=;
        b=ZRYl5FA1pSu4iIsJ5SzUWdQ8Ynz5lQuFwx0ZfeKpfXlDJg1Vgnv1eVLmy/gf7iS8L+
         IhHCBkKjoGwS0kgxc3xAgcj+8kQpiE5a70ne4WZmGF9ZzHSethWa7X9agVmVMkXm6VS1
         WzSDOfiyEfjJr8tiX70I+fFSuWD5XsKXAXVpDbbdXIDXHUBPkY4/ldDeeB379SXYf7vr
         xhDPc5nhtdAQf2CyaS14Rq3LFPyIRwvpwlL2a4O3aGrTjc68SH7FWRqFZefKN1BBHTmn
         QI7xcE4WRMEugjtG2Gtu2Ax8n4y0Wr1ciuuWX0tt78fTZxZ3cqO4YCzFQWAA5Vqt47Oq
         Ms2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HWSyi3PygSX+JPDCLdXZ2LpUmvO6eJiuWIhGQlNkaw=;
        b=WrV3hezmpqMDoYmy/9xBI9SxnFmgUrmTBNHeHsLtGhWb4Dh7c2EapuPmYDKvviG5mB
         kZdeepYAdwxw9GoiTtPaTEz3Rtr/CnJKaGTnoBfgUtQ8i6j6mA+gK2tW/nVFIB2EobQe
         ll8OjjolyUrLYRNARIgKPqB7UNyDk01CaNpakOPA1vRqLXcbKshv8UBgb2gs7yoMvKKT
         MDTlf7dGJ5Y8oyiT2dnqqX/EqPWFosOCF9bmN+dbKbvZJ99loQ9bBJZ4nqXLNEmnio9l
         55nSRs4dKt23sCwwzK7FF6AIuLnbIqysGmx6UDAcSmLlBKVnbl2IpXClTPiGL9pV4TBo
         C24w==
X-Gm-Message-State: APjAAAVeWC89S9qG2sGyVz3AZ0S1Cjnn3juaiLcVZEyijbgjQr9xybxc
        mrzGuDzFMx2aZwvD94ZXHsuZIzRE
X-Google-Smtp-Source: APXvYqyXTWmS6raMlWH3PGMIX7x+F2XzxCBYLhFTJOSUHiShFgAWdeTZFVSUNxx+L7tIUxVxnX/4vw==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr40133233ljj.142.1555340141485;
        Mon, 15 Apr 2019 07:55:41 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking on devfreq initialization failure
Date:   Mon, 15 Apr 2019 17:54:52 +0300
Message-Id: <20190415145505.18397-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code doesn't check for devfreq initialization failure, fix it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f0f0d78f6cbf..aa0478464b35 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -707,6 +707,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 						 &tegra_devfreq_profile,
 						 "tegra_actmon",
 						 NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.21.0

