Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DCAC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8432075B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfEYIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:22:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38218 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfEYIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:22:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so6321261pgl.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48u0PwnCDa09vr9bgebppMgyNwBGmRwi4lt0TdUJEaY=;
        b=FG1ICPGDvXvAo8Oa2I4ZBObjzMbFdcbcuP1AO6uyCv+hzeGVAxbt/6We8aE4w5CmNU
         ymqbsMkWM+GRw3UOfl6fzl4+7RsW12RlmJqxlOYvRBLo8kJFq9SANy/aG2KQixdq7JQ3
         sC0ZAikylga9SCT30ME/TZK1YZHAr1Sb/2p45JPu5QE7fF8kFsa2MV48FCw16BW3R3EK
         v2X93JksqwJhqJdqfqGCmByRiK4hmwhjxj21A7FcNaOZlE6Ba/CEPI2UhC8Nu1cV0v7H
         xE0OlqvdcVd378LknrtpDvk65UDm0z2iAthDXh9Og3CieaWs1sbFAQMWbhKEVYbczXy/
         mN4A==
X-Gm-Message-State: APjAAAUceAAsw+U4TJNTKn3I/ywICeHAcbOwBRU2Tqvj1LkZXk8cdTCF
        p9bLBOo3hM6lUccUcCKYP9NGDBkkBbE=
X-Google-Smtp-Source: APXvYqwVcdkBJUMVKFiHu69a50JwEA9lQ8zGza+WrIiMnZa1IxfWOrOmH0QrQMOtV4IDJG+c3guONw==
X-Received: by 2002:a65:418d:: with SMTP id a13mr6577149pgq.332.1558772529989;
        Sat, 25 May 2019 01:22:09 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e4sm1438505pgi.80.2019.05.25.01.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 01:22:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 2/6] cpumask: Purify cpumask_next()
Date:   Sat, 25 May 2019 01:21:59 -0700
Message-Id: <20190525082203.6531-3-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525082203.6531-1-namit@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_next() has no side-effects. Mark it as pure.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec42215..20df46705f9c 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -209,7 +209,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
 	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 }
 
-unsigned int cpumask_next(int n, const struct cpumask *srcp);
+unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
 
 /**
  * cpumask_next_zero - get the next unset cpu in a cpumask
-- 
2.20.1

