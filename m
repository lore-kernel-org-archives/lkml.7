Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C3C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2621855
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Lx4n3eeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfDUBof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 21:44:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46264 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUBoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 21:44:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id w26so2179178qto.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CYN5iyU5BivsuLuaj0p6OjCQw7Id7vPwrKGL/YIcXb0=;
        b=Lx4n3eeQsd3DKBZFt1X+n0tHyvdxX9eMXlbGkCZXa5jPDl+R+bxvhnePCzuiVFH+jk
         di+Mp6Mfiv5tBZu3YjQsIuC9JNhQV5AoV/J9rAuT1n2Pzo9ukHrKDSQHkIHF92Mqzxql
         YvxHUk9CCjLHPwU2JfPC6Jb4K3eYzQaEOCweZDDMP3zNxsjvacM4Si4fbi0xJj8A+ZHM
         HRrrp8lKjP5UFpftK/lphzl+xQk7hG0nsmdRNOw9TAxyhOTDr3q5eE7aOoZRIevE2SJ1
         IyWD1DfUU79PI1VB99cVVKjDHJ6TbNTIQlFTSgKgHQNPdqcPC2df8BsTeVhpEsSjlzIL
         cz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYN5iyU5BivsuLuaj0p6OjCQw7Id7vPwrKGL/YIcXb0=;
        b=bV5/H8hlCYj4IKrRQoVZw81L7AsQMKUGrbQJY35neMaJiK8TEf/aNpz+2Jh39mhCr7
         N48QWO5XlwrOJCL05xQTwkfajTe98NHmbctjzN+aYQznN8ZlbS9m0PMowLykq9ycUECe
         o0Qt/yb3Hb6oUWGnIZnIHnVjWnuENFFUOs6UwaWMW3XZOQNh+SS4MQx5u5s5xKL4JUk8
         UdSW9SJkFKOzpshlFtkF6GQ/rRMrXl1NrwVLEshSuKoir04L3jUAfUc6NEWyuc7KJ+91
         noHOnMbfTrhH304kc+hvhxi4UQV8fKap/0TothGjQ46rE4F52lx78pxSKHIxD3WcGqeS
         k06w==
X-Gm-Message-State: APjAAAWZel9gLeg6vkKPUeqB4LkGuITY3WaMHI9dssbkX2FpF9Je7j0M
        EXmK2jxCFj+5UvQX8J2JEyhkAyBxO+k=
X-Google-Smtp-Source: APXvYqyGwfhqvlrszPLC8qN9m2XQDrZ+wKGZWzLF7GM7scRLtBDlMXL92I0fVQaBdczXZtyMg5jLVQ==
X-Received: by 2002:ad4:430c:: with SMTP id c12mr10017920qvs.109.1555811074063;
        Sat, 20 Apr 2019 18:44:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u1sm1385218qtj.50.2019.04.20.18.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 18:44:33 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com
Subject: [v2 1/2] device-dax: fix memory and resource leak if hotplug fails
Date:   Sat, 20 Apr 2019 21:44:28 -0400
Message-Id: <20190421014429.31206-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421014429.31206-1-pasha.tatashin@soleen.com>
References: <20190421014429.31206-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add_memory() function fails, the resource and the memory should be
freed.

Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/dax/kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a02318c6d28a..4c0131857133 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -66,8 +66,11 @@ int dev_dax_kmem_probe(struct device *dev)
 	new_res->name = dev_name(dev);
 
 	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
-	if (rc)
+	if (rc) {
+		release_resource(new_res);
+		kfree(new_res);
 		return rc;
+	}
 
 	return 0;
 }
-- 
2.21.0

