Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C7C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F3217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAhAfA4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfELBZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36822 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfELBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:30 -0400
Received: by mail-it1-f193.google.com with SMTP id e184so2803558ite.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4mnV8n9h367f6/VUTN5uF0kUnyjJ6IcwlGv5KmdBDM=;
        b=JAhAfA4mdmRtC0N8z1ZmuFlRZqLVCZ1hZxon5/lNAiV5zNbCFeBTVMs2UYyTIAK3x4
         08sv/uYY8fHQGJPkbkgo5983E41ygMh1INe7kE2C0sphzm6DQVdMI1PpdlS96l8RJdVY
         1jb4f6PLkUiMzPnI93pUahouN4tXgT+ljfHXLreq3ByEJGWJUGsIme3/GpUWxkEiSTKK
         mgoKIF/WF3bxjzO2LcNZPtfxbaFKhvMf0g+6Ahk9vBuvqcldgGlHJE3DfHDJWnoKuzE2
         EZqLdkCuYEHQXuHNavep6WIstkQP+QyWUFNFN0rwCxW5GkJ+DkLNwzR2/GDzcT1Nfpw2
         thgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4mnV8n9h367f6/VUTN5uF0kUnyjJ6IcwlGv5KmdBDM=;
        b=Yo572R/uY4Rk+E8HADmn/knDIFJOqCA3S8TkhNDbvGkE4xTE8yPfZez7/DlSRKOmVs
         35npHx2u7pFfXvyyRuqbQ+fS1huDyN13hwYz3cHrVgqwaybTcsgse7BZO32fa/99sl0t
         El8ZOOSoJHq/cR5DAgcsXxOUYiP1atpT5kt6h42lq+CkS7V2vcOgfWyHA/XhkoVSI5me
         dFhZI34oflgneltyfC31FhlrmJdboisGXbF99x6tcOBBrVDuMRhl6C23cZQabJ8+7iiZ
         F6ibW5o8IOxeyPsW2BepUmf/i9tFC2pnWXDTPZVSIyV6+YBTIz4GGOBmcSZhJ8H4QF7F
         LsVg==
X-Gm-Message-State: APjAAAX19yyf//RbqS2KcFnZt/iou5hZxWgTLuDRktbQ3EoSuT/MqtME
        bVypdD/BVf5Dew9Wrtgd7H7ZGA==
X-Google-Smtp-Source: APXvYqwGLZ8JhuDI9d5SHcTGR62c6TjiHMWhMey2QxGtWxmfe2drs5a1+4crl+EafnterpyF6r3LFg==
X-Received: by 2002:a24:2e86:: with SMTP id i128mr12888057ita.87.1557624329029;
        Sat, 11 May 2019 18:25:29 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, kvalo@codeaurora.org,
        johannes@sipsolutions.net, andy.shevchenko@gmail.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 01/18] bitfield.h: add FIELD_MAX() and field_max()
Date:   Sat, 11 May 2019 20:24:51 -0500
Message-Id: <20190512012508.10608-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
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

