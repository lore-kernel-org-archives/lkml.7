Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90FDC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FF02173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MAG7Kwt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfEQVyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:54:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33626 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfEQVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:54:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so9821011qtf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=MAG7Kwt56YLXgGpHlSwF6peeLCFWoe9w9yw1/4MNfZedRugiM5L9tJph4Z0qIqbysQ
         MQa00cOfj0ilwkOa8A4nZtTqACZDP70GVXMoFcppyNW6lFn1r8367ZG5q+tQtiGSR5mv
         QW2I+pdoS9IGt4WkV3+HceuXhZGG1MyYkpAD57R+twSBkhOqG+AEgv14CPl/X5joRCH/
         4Fu0gWVewSN9wTffe2BpgeBjoHryPvlUQAiajnV/yBfZ8fLU4J6TKSjKSAJu+0zFO3CM
         DYCy9YBFL8fXrbOMGGU+IeIiyzKMEGD2okiZG3r35R7oCY0l5vm2B9D5QUI1zTTygD27
         nSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=JDK9iLJ0xpUkYQ0oSjvYpB18QunZljfN46Xelcm70ezt3uIwQP1ob+e4SyEFGU65Lf
         mNeIMV979WLGmYmVchNpqAPDXFL6MxeZcfukZCNBrNSnrfh8mWDFqnsKDpg2kNWN11qK
         iTYQh5VMTYODnkFWPabYAfZ0+2sbBLyBP0hulAZTk/D21l5pulVT+CEY879Rdd30ERMJ
         qOV1I/lmb1NLOwrGhdgKlTnAee6rNeOqSqL72Kuord/4s5lrxo5XXZRwfRRx8Z/pEWI/
         F4jAQ2wIS+6goaOWGyV4u7UEdkr9Uw8/5GhRPiu7jjL2SvoyM2RNW75eyVxoVjO/hAWJ
         mtAA==
X-Gm-Message-State: APjAAAXTmV6PC0LLkHc72UVto0xhNCS6s27aD6aEoTSs21mxN0HqxU5c
        shzaGrODWwVbXLngtciSMUjuYw==
X-Google-Smtp-Source: APXvYqzgOTJEZbvtrTHUCsU4W9MY9QwY+/vt23cg4Q1By0cu8+zJHQ1zc5/kIujRbiw57m5j08mTsQ==
X-Received: by 2002:aed:35c4:: with SMTP id d4mr50747244qte.311.1558130082975;
        Fri, 17 May 2019 14:54:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n36sm6599813qtk.9.2019.05.17.14.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:54:42 -0700 (PDT)
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
Subject: [v6 1/3] device-dax: fix memory and resource leak if hotplug fails
Date:   Fri, 17 May 2019 17:54:36 -0400
Message-Id: <20190517215438.6487-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517215438.6487-1-pasha.tatashin@soleen.com>
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
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

