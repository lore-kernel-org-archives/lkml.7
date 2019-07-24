Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B37BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B32173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo26VlqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfGXSdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:33:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfGXSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:33:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so48003586wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TO0xjqiTQO/p7K9jnlDraXQQotZEfPR7wy4JzLU7jqY=;
        b=Yo26VlqENppPcL21btDGMJSfZXIPsg4ehEMup6rkX/CRFX8w3sb3v231Yu8ecIR3rg
         8w+NRrE0YQMLWfhQ52BPzCIjw2Z9WEwVKWRNd4b5fZf+8AenTE6PhmmsZyz+6iDXIyQ5
         d17VrFe8j2krN6DKIfXWvzESrye8Kc3uYQYJ/mXPtAm6RVwq0BTvaTyJB7BoxpKoF6RR
         JsgoBSxHnDyrzNEw5qrlvlGtcDxB9tcheyAU6gMSIl+d7uYKM5lFVdhiB06YibCGBGkI
         bVkMszlYH0io5yoVdB7y7mIHwEsL9OYNL+ehosyRTGPC+2VBOgH2GO8QWjAcCEZiorWq
         KN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TO0xjqiTQO/p7K9jnlDraXQQotZEfPR7wy4JzLU7jqY=;
        b=CWOSNZ9lRFXLqeFYV3y8J//iV/XmlKowEwr/boqq7Cp0UcONxO6ae0WblOgvkWZSNw
         a4B8MT487VcQwPpZXt+yEA++G0cn9kp1tyAX1TcS6yKiZoszgbAeo1W2tKOqWViOEOw0
         HKLvE72mqEAGf4Ar05OEZjM+YurcGpjC2FG/pPrRaES9Y4FgwVZ5VOSXhOaGBFMRqens
         xYnRcYbudrUz3/SRsExyrY9PXOxPxb1OBoC7UAr57PgYlCCPNV18NgY1Gj+GZ/OLRP7T
         avMrvtEGC8+znyct9Tk5hSTv8F0jNlYmolNzaQUkNOhc+fcpUTiU2DfFrhOja2WCBvmX
         k2bA==
X-Gm-Message-State: APjAAAVfRvhPoY9zN2pb21KDofthCkxegTIOzzr6eFCKnUNQVsjao4pc
        YRjrXMAge0maEprrFbRzZLihkrU=
X-Google-Smtp-Source: APXvYqznmWIF+Lt9jF0RO9uuoFfEFBqg32aKX1M6kw3bCBGtBaybT9Y7I9dS8tQP/wyko6h3xKa8Kg==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr1004330wro.284.1563993233213;
        Wed, 24 Jul 2019 11:33:53 -0700 (PDT)
Received: from avx2 ([46.53.248.54])
        by smtp.gmail.com with ESMTPSA id e19sm63167455wra.71.2019.07.24.11.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 11:33:52 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:33:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: nicer for_each_cpumask_and() signature
Message-ID: <20190724183350.GA15041@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask arguments can be swapped without changing anything.
Make arguments names reflect that:

	#define for_each_cpu_and(cpu, mask1, mask2)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/cpumask.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -184,8 +184,8 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_wrap(cpu, mask, start)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
-#define for_each_cpu_and(cpu, mask, and)	\
-	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
+#define for_each_cpu_and(cpu, mask1, mask2)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask1, (void)mask2)
 #else
 /**
  * cpumask_first - get the first cpu in a cpumask
@@ -274,20 +274,20 @@ extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool
 /**
  * for_each_cpu_and - iterate over every cpu in both masks
  * @cpu: the (optionally unsigned) integer iterator
- * @mask: the first cpumask pointer
- * @and: the second cpumask pointer
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
  *
  * This saves a temporary CPU mask in many places.  It is equivalent to:
  *	struct cpumask tmp;
- *	cpumask_and(&tmp, &mask, &and);
+ *	cpumask_and(&tmp, &mask1, &mask2);
  *	for_each_cpu(cpu, &tmp)
  *		...
  *
  * After the loop, cpu is >= nr_cpu_ids.
  */
-#define for_each_cpu_and(cpu, mask, and)				\
+#define for_each_cpu_and(cpu, mask1, mask2)				\
 	for ((cpu) = -1;						\
-		(cpu) = cpumask_next_and((cpu), (mask), (and)),		\
+		(cpu) = cpumask_next_and((cpu), (mask1), (mask2)),	\
 		(cpu) < nr_cpu_ids;)
 #endif /* SMP */
 
