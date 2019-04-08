Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF70C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9962087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VPT2JGmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDHMSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:18:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34658 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDHMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:18:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so16153851wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=VPT2JGmAYDF+yKPBVoIfnd/yg4NoU7YOxGEtNRNMEJFQm5vmwcxcD8snhRCJFbidRY
         hNG1lDS1IuqXMGJjyeKTZx5+rI1ZszXaVAAcJOli39iy/jyx/CuUtITccCk8TxqgAoMm
         FXL2RV9cQMl/IWPE1Ni/7ops6y4N3zzr6QnD6ruvvpyqRTDQ86BRIxqbvlxJQ3ETYTem
         dHuLKzwmoHqmgp4lnsjHxvAFW+Y3HvWxQeGcc4oX39Pii/BT0xMCTkQgqT5SYP7EcrDa
         QOdGSV61WYncnZmhDh9RMHfIDiiI5RY+Q8Sst4JevH/13wrDfG6EedmJmwv/BcnrDfYe
         6l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=M+RHIc68YprHwaUza0TpQ9mtC03Tw5EEaJYhkE1VWMBahhoGIb6ulXVI5wMwvy8oUN
         6URCpMFZDiSd2FnbDl6enIn5lxCQXLwL0yZmu+Tj8aGvzV0SgV4tj7/a7YmHGMpIo/cu
         as279JubYyDaalS4xId5U2BBr47SUa3T3w39yGg6k0ix8FGREt6rbJqWSb9FSre8gwW6
         BmWQoeOrmYuuyu7iRPf/ijg04TngFdvFAZRDFNl/Yfc4we9S5b8Qn6H46sYruYKqL1q6
         YSqx3bcg5JPFEhrX6twtm+0ds4/c57Jgq9vWR6E8Sl5qpOPnYtXZYwEvt3fNWBGriZws
         BVug==
X-Gm-Message-State: APjAAAVBH7WZ7wj1Oa3SD1JMI+d2CsfbKY+QMOL6rR+fnE/VVlTmrOrY
        zbVLBa7dTHyG53tjHtAYHHicZg==
X-Google-Smtp-Source: APXvYqwyt7lc1mSGIiZXyDGsPcskW6ZeR7K7ew061RPI21s6se9xOTay+n2VdA9Vkz4v3sJgtq7RYw==
X-Received: by 2002:adf:b458:: with SMTP id v24mr18407625wrd.46.1554725890968;
        Mon, 08 Apr 2019 05:18:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e1sm52865103wrw.66.2019.04.08.05.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 05:18:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] MAINTAINERS: Update AO CEC with ao-cec-g12a driver
Date:   Mon,  8 Apr 2019 14:18:05 +0200
Message-Id: <20190408121805.2870-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408121805.2870-1-narmstrong@baylibre.com>
References: <20190408121805.2870-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MAINTAINERS entry with the new AO-CEC driver for G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..bbad8f3ee3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10046,6 +10046,7 @@ L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/media/platform/meson/ao-cec.c
+F:	drivers/media/platform/meson/ao-cec-g12a.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
-- 
2.21.0

