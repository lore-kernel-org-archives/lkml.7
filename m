Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9966DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE6726334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQ5CqKcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEaDx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:53:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54168 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEaDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:53:57 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so13576024ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4mnV8n9h367f6/VUTN5uF0kUnyjJ6IcwlGv5KmdBDM=;
        b=uQ5CqKcdh/yUYawzZpJbRZ12LMQNtmodArP5AWBWD9vjKgkFac6xjrmwQsM1TNxDlB
         /afVEpVlc6yUnyDL44O6VpMUSZbGnJz5vY8t2TzIRYBTxXyfrA/opbRkuMh/s0FMDa10
         Yaj82guuMR8LL9IGBSM7Ugvz2Mbl6If5nbkrkAzZQCD2ne7/fQngLuOUEnSSt3p2AKCj
         T+Fle7a7mKUJ7KN0nHLDILNV5TdkKzxqJsbbO43z/DfarwmzWVJXOuJ4Nt4wxRBxM6/R
         /OIbcj6WOO07tz9PONxo9f6wd/jt6IerZF/L3gWS9w39N8TbRAm7kbZpma7Age9p10+Y
         yCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4mnV8n9h367f6/VUTN5uF0kUnyjJ6IcwlGv5KmdBDM=;
        b=psVjhK1TkFXm2ZTYkct4OgDK6Prx+bksGXRBUtdPEkF0qmS9Hei1XQ5V8GqSUBYjJq
         sqyv8NyKMOCPkuV8PYabFWe+rXJ7ua+4qv+gMfEaC69cYw6FARWtR+nf3fXCmIcsbEUp
         yAb6Ldxw/2P3EDghkJGqsjMiswYQNcBbDgPuuYdnlNZsM0sBXxXGgSpG4Eq+qXAYzVhd
         EObi/+CX9o+Yo6aV39ZaTROpnDfwmwuu49L2KOdCtAcunh7ORVFbahxiaYg3bMlsSVMo
         jsuXwaNNaXiyyCNeDZypHxitvznBpm0C+we/G2CRYyLi4qerH88AJIwfk/0y/+rcKpYm
         Me5A==
X-Gm-Message-State: APjAAAUIUcyr1d+7QBkhvvsVAAbdE6q/W5OXO8a2OAAn8+mUhEracPWC
        TRPvF6WB2M8fpkpii4VhW4agsw==
X-Google-Smtp-Source: APXvYqwO6awYQhmpOv3yi4OxH66vN6iPJ0929GOj5GH4pyJJakg8VatINo8iNHYSqyTX8R1QdVMheQ==
X-Received: by 2002:a24:b07:: with SMTP id 7mr2381324itd.59.1559274836720;
        Thu, 30 May 2019 20:53:56 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id q15sm1626947ioi.15.2019.05.30.20.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:53:56 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 01/17] bitfield.h: add FIELD_MAX() and field_max()
Date:   Thu, 30 May 2019 22:53:32 -0500
Message-Id: <20190531035348.7194-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
References: <20190531035348.7194-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define FIELD_MAX(), which supplies the maximum value that can be
represented by a field value.  Define field_max() as well, to go
along with the lower-case forms of the field mask functions.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 include/linux/bitfield.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3f1ef4450a7c..cf4f06774520 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -63,6 +63,19 @@
 					      (1ULL << __bf_shf(_mask))); \
 	})
 
+/**
+ * FIELD_MAX() - produce the maximum value representable by a field
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * FIELD_MAX() returns the maximum value that can be held in the field
+ * specified by @_mask.
+ */
+#define FIELD_MAX(_mask)						\
+	({								\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+	})
+
 /**
  * FIELD_FIT() - check if value fits in the field
  * @_mask: shifted mask defining the field's length and position
@@ -118,6 +131,7 @@ static __always_inline u64 field_mask(u64 field)
 {
 	return field / field_multiplier(field);
 }
+#define field_max(field)	((typeof(field))field_mask(field))
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
-- 
2.20.1

