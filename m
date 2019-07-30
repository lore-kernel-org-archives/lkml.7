Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A6AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7947B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeNn2Nb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfG3MZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:25:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfG3MZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:25:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so29768014pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdO7TiN1GZWaQttAvLZ44/neyJcGu5j8j3RhNT+Sui8=;
        b=oeNn2Nb/KW67tK/SQYA3SwA0z1uQndtVJSRu+PDEjP72OlO8KmCMDtWBV5wq5bXjh9
         hS9nOcAhh0rZcgj0RAfW0XRibChG2g3/3zWkiH4hkx8VgHfmHWA4aM6qvQRMCbMGDSOp
         Bo53QaBP5OkWQzpZYWoNrCGtD3zIF2iH9bYNCt0o/ZLVt1XE+gTFteVw0X0p801KmcMi
         mIumz0AGK/+0LiHxAWX/nfQoS8Y1yP7gHMEixVeHFMyQ1tqGa9Tnh5U41MsKDVNf5llv
         RVYHfmDG2keihY0FTtTRGgzTF4IdgXDe5G/ve9Nji1Pbk27WKRIn6biY+aN2+F66OH/R
         oz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdO7TiN1GZWaQttAvLZ44/neyJcGu5j8j3RhNT+Sui8=;
        b=WnRcT40OIL3ce8gQsDW0n3Pm+ltFyVl0pE4FG4SjjmlOZBlhJBvpIWF+Shc/KaYWz+
         FXgzQELp6aph0Ze6+3cenew0AggKq1VNwsKq25PkrxrTC8XrbNStIet66CaO4lGHF+ge
         fhaFCklYB+KE95dIT9MYJgH24y2WhK/3ba5KnqzSrD3t6DzsGdp5Zx6p7XW+zyitDxtd
         7FY0Vb/2RNNDryisoPT6BMXxd0e7RjUAJH1QaZ/GrqlD7ldPkntuULFYmlbAenUCKzhC
         LXpyL++mBMpAyfMkNE0dVwqOhgHWoAd+QjG9M7NE3L6Dl0YFKQ9q9fZpnud7Sv5arFdF
         RF6A==
X-Gm-Message-State: APjAAAUZpn3X/FW8rfSUScksNdfaQyJO2vSW0SSXpS/D9G57EWkWicoO
        eETMEvehYjyKF4tauORzd1VboA==
X-Google-Smtp-Source: APXvYqwiIFZ1Lpnf1zrtvEq7BSLgYRy9SXqV38k99nAfJbSJqZuysqZ14yG/NTWJNUvb4F6Bw3cxBw==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr106671104pgf.67.1564489515198;
        Tue, 30 Jul 2019 05:25:15 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:25:14 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 6/6] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Tue, 30 Jul 2019 17:53:40 +0530
Message-Id: <1564489420-677-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce06877..0b61ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8930,6 +8930,15 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	security/keys/trusted.h
 
+KEYS-TEE-TRUSTED
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	Documentation/security/keys/tee-trusted.rst
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted-tee.c
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings@vger.kernel.org
-- 
2.7.4

