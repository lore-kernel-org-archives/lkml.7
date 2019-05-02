Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A15C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56A217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ln6d07+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfEBSnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:43:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37834 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:43:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so2135487qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=Ln6d07+pCYwbOjMFJVcdvs72qSgpRQCxY10mk5EhNLZCCmdMu75C3Wt5remthzgW67
         V4y5TmsCpIkhCATiM5w4PnSDvo+2ad76snqHZ1BlD/WCqdONPaNhAwrZFGW7OAb2V9sj
         evPR4Ort8jUgIJ58yqKrItZUPn32mS83xIUWpb8GYaC/nJNhKZfZFK2fc9lv+R9s3DTG
         rK2ZAUdIL3A7/jl4Mu2oUqA6qXaATfKDsG8ix3Umce3pVsoYEm7Xh9DaPp/mD9BhTRUD
         bFZMZj89CQS8F/ao/RoBvjb13qg+71zc3NWtzG51TmtvQZg+zD8u9n/dnSikt9j6kBv5
         Etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=flmsNr1GGl8Fn6NHzruRgRfmMVMTq/0LcOwmYS1cmSkqEdyktMkTl6kYbTKAKVd4P4
         y2FDU9tJbgBJxfhnkgfpcKkqeVY1tNddM6pBlkaka0XgctVT5HRxi1iCSImmS5f9ftBN
         /1xJpELw01NMGPhj/ZkPObj1MMOEi+D1jwNJBQWbC4cTOtCHMhaPJkYGTVr6mGh9oTnt
         z11eRANhqIbfME51Fs8i4ffZCjV5IGNmb0lUvSAh3n69KSvVU5PpBhVdWDN1BqZYPDjb
         hpQ2FhMNay5yV/T5emNUG+2eFqx+MAtW8zBG0gArerheRbkTjqo5RugFuNJkJTblsxO4
         pNuQ==
X-Gm-Message-State: APjAAAXavsg5SeCqwGKltr1iqzoRyfW39+JOH8w3cECg1tM8cVT7oSxv
        BfTSYc4zm+Q5Vi8L1wFnX4vKOA==
X-Google-Smtp-Source: APXvYqwuy9FOxLCdwhhUyWDJtB7mrIu4/W4cCEop6zwbua1nKA58RqCKUegUOS0f+XcEcCAv92SrIA==
X-Received: by 2002:a37:4247:: with SMTP id p68mr2794611qka.89.1556822622604;
        Thu, 02 May 2019 11:43:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 8sm25355751qtr.32.2019.05.02.11.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:43:40 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v5 1/3] device-dax: fix memory and resource leak if hotplug fails
Date:   Thu,  2 May 2019 14:43:35 -0400
Message-Id: <20190502184337.20538-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502184337.20538-1-pasha.tatashin@soleen.com>
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
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

