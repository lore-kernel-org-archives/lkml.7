Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D01C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462BA21873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfGSA7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34618 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGSA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so14761140plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjgylcrTL5oyKrI42SHzoTCEiC3xG7heV6oUteyqMZI=;
        b=PhXkjIWGqizFBW8n8mO4IkpTSwz7iFtzWPInC6vYyRmE8AWrQtRyqWX+2kY2SWui/J
         3LXxAhaE/5dMdky/GE01h6txLsmbcgsjPc1WM/jTpCL7RVH4a132t2DzFIunz3Ln5ru8
         mGmuPgV/y/O0P5/Ublvinc/bqUVP9tst1dLQYOk1ft68ylwJyXEsKQKN6anKMwN5aiPk
         Ga+H0A6wC/YdN3OEnwSEwXT7FD+YleRNDAo1naOmBt7/iUNKKwrg7hQR17y+e2jh12V/
         9JaNz+EonnMUsfA+TWgiP1CaO6ChQ5TxOilKbCZldW8E//Hd49ToY8fW7AizF+/92rfQ
         borA==
X-Gm-Message-State: APjAAAUjenTazAmnFt7sPeJvVI+SP51cH0TP7+sgs9Iv95gr1BAY9ZxL
        3hticjYfl03zw54CWMqrRxc=
X-Google-Smtp-Source: APXvYqz8sRHkEKr4xyktWcX8xbiOG0ipAuM46YJNReRMzbdes97/0EuivmL3uKlfTmZcDJ/s7j+YDQ==
X-Received: by 2002:a17:902:744c:: with SMTP id e12mr53133801plt.287.1563497948205;
        Thu, 18 Jul 2019 17:59:08 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:07 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 7/9] cpumask: Mark functions as pure
Date:   Thu, 18 Jul 2019 17:58:35 -0700
Message-Id: <20190719005837.4150-8-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_next_and() and cpumask_any_but() are pure, and marking them as
such seems to generate different and presumably better code for
native_flush_tlb_multi().

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 0c7db5efe66c..6d57e6372b9d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -211,7 +211,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
@@ -228,8 +228,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
 	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
 }
 
-int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
-int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
+int __pure cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
+int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 unsigned int cpumask_local_spread(unsigned int i, int node);
 
 /**
-- 
2.20.1

