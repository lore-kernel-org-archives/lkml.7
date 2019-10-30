Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF5020874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5//0TRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJ3PPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:15:05 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:38558 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJ3PPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:15:03 -0400
Received: by mail-wr1-f74.google.com with SMTP id p6so1518775wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1SoSUVQGtw0xqhat0J9cgyKetzE2XJjl2eMiWbfu6h8=;
        b=h5//0TRn9EKJvylW7TY1JvOZXS2ibA0DV4HxdiJVlR8UQ99rEu2e+mFCVQdObxwG8c
         9rAPJy3+G57qCyJyjMNxN0HC+P6xwYJmgpdlcoNYtOf7jvqO+JG7+muQ6+LG545oxyKp
         r6XSN9ordGxuwsAEuFb61cPh7hX6YM9CBAiEYpyyQAghYSE7SRz89svjnI8mfsXSLc9l
         beJV0kFXUt9k1y8oq2CxYAd6hp41ZnL8r0u4MTKah6oFw4co6penwmyEX7wIrj+1drQu
         NTrItd13CNheMjSU3XG7slYf+dR3n8RzoBGtILn3h9GaLmltWsEgWGztckWdHxqJDAKX
         IXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1SoSUVQGtw0xqhat0J9cgyKetzE2XJjl2eMiWbfu6h8=;
        b=i+yLB3G4MM+lUlSEHxukp5XFglXsfdb7Lrn+rkc4hHOC1vTL8JEALMLbSHInQMY0ME
         yElbN2j1sAJSAEGOOAVANrYytQpmx0pdHIJn+59cTcnvh4giU8uI5/ApwM8IwypOh+Qr
         cJZ30a3EKaectlf5PQrlal/i8/yJHlAVzK+CfYs+O6phMFQ4g86ocKsq6XWX5WB0chNB
         6c0Mf86WA88g7X+j7qsH2bxkra3T6FZZvwkI+LhXMKjMux8/BshtvXx0G1wkEKLf56hj
         TPHoUnlxmWvi+5lbUA/2Y7tPb/DUW9UuP4R03ErT91g8YLx7JagZR+De6oTpteX+D23h
         DTZA==
X-Gm-Message-State: APjAAAUi7mHHhRaEdloVDsIhad7u5xk8gcyh4qu7vBJpqb2hEXVIebMG
        Sx1+NSRCSqS6vl4xj9oIffhH9qBf8S62
X-Google-Smtp-Source: APXvYqySHRuDfYqqlCAgMra1Sxad7qU6NdrSxE7WWWgkDHIWXiSLRdq98hYpruwBtXj1XdEq1j4LhR1RhuLt
X-Received: by 2002:a5d:4491:: with SMTP id j17mr353365wrq.46.1572448500122;
 Wed, 30 Oct 2019 08:15:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:49 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-3-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 2/4] PM / EM: Declare EM data types unconditionally
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structs representing capacity states and performance domains of an
Energy Model are currently only defined for CONFIG_ENERGY_MODEL=y. That
makes it hard for code outside PM_EM to manipulate those structures
without a lot of ifdefery or stubbed accessors.

So, move the declaration of the two structs outside of the
CONFIG_ENERGY_MODEL ifdef. The client code (e.g. EAS or thermal) always
checks the return of em_cpu_get() before using it, so the exising code
is still safe to use as-is.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/energy_model.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 73f8c3cb9588..d249b88a4d5a 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -9,7 +9,6 @@
 #include <linux/sched/topology.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_ENERGY_MODEL
 /**
  * em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
@@ -40,6 +39,7 @@ struct em_perf_domain {
 	unsigned long cpus[0];
 };
 
+#ifdef CONFIG_ENERGY_MODEL
 #define EM_CPU_MAX_POWER 0xFFFF
 
 struct em_data_callback {
@@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 }
 
 #else
-struct em_perf_domain {};
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
 
-- 
2.24.0.rc0.303.g954a862665-goog

