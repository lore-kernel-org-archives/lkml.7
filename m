Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883FD2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392806AbfFMQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:41:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42251 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfFMGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:49:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so7676051plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9jaRDhy0GBwgyVjvnzwc8N26QAnkrBpLEwTplkGWe4=;
        b=aX9/KM89WG6R+0vdMxbohlEYAMTnyamyLUW96oXRP+BZcjt09Ndom5/pYHRgUOFfAl
         Eye6hnFwYlZ6yXr73W0n61g8oPlWfx2cJR38VwHL7AD+QbcGfxsQM1dnwQLRmKgDUQXb
         3gaNzqlmoaY7dQyHrJBt7VpG6YWgdMn6RCzA26QGDV4SAB1g2ir7DxUHKxc/C1IdTViL
         zZZD3eDpCdOkTTAi3UEyq4VqwvBRkTIh/MsvqwRvIdn7oPBlKEJhsupmr+kx58u2Ebdn
         81L78zx25l2h9j7G8h7KBkx9I9n2HfHdyV7qnNSKg2aVW1SE8zxwJzkpyz2+yFKbIAi2
         JJzQ==
X-Gm-Message-State: APjAAAWDMwayAhrbDcZ1d/zxCFsZX4YElA/tVPuIBjBApfhIl0QvNYDY
        qNl9oyvrjKNzLwt1j7Lbp7w=
X-Google-Smtp-Source: APXvYqz9BDdymN8GHvIItiPZjQjyeRU5VzVnw1Hmnz9oQZpDmHeJN6SQK+VNLAAS2X0km1llz16Tzw==
X-Received: by 2002:a17:902:4181:: with SMTP id f1mr82878144pld.22.1560408573419;
        Wed, 12 Jun 2019 23:49:33 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.49.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:49:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/9] smp: Do not mark call_function_data as shared
Date:   Wed, 12 Jun 2019 23:48:11 -0700
Message-Id: <20190613064813.8102-8-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfd_data is marked as shared, but although it hold pointers to shared
data structures, it is private per core.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d9189e4d6464..d5d8dee8e3f3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -34,7 +34,7 @@ struct call_function_data {
 	cpumask_var_t		cpumask_ipi;
 };
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_function_data, cfd_data);
+static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
-- 
2.20.1

