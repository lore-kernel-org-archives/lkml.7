Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4B3C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A59920878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FZF6nEOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfDYRyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:54:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41019 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:54:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id f25so1078339qtc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CYN5iyU5BivsuLuaj0p6OjCQw7Id7vPwrKGL/YIcXb0=;
        b=FZF6nEOvkk6GoKEHPSU8yrNVtWp+shOUoe4UO+Y1QVavbdMeJb3pHS4V1kVzPNRy52
         pIE4K7PHtduBmym5C1oosmQLKmA858ULLvcXnDc3JTaocoXb9gymmInDKT40sPGkotwB
         M1k8gEB/FW/fye4lxsAR621vCULoQid5fCPik0riLL/6Kkg4Ni5oKxA0zuM14Fbe1ZAR
         d87kNRHFK4jS0G7UBb3QgNtiCdqS+MTyz//EWd8P5HzdPPbLRHjUjqm3a/sU4shQ8s88
         w7NRw7F6mjTKfgF6KS9Y1q6Ge6xEOnLvvRDedjZm3B0QNiRUSIfSPjmMg3sOyK6XDnnL
         Ia9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYN5iyU5BivsuLuaj0p6OjCQw7Id7vPwrKGL/YIcXb0=;
        b=XnhlXPWxQp2oP/BHy3V4l154oa5+13t6VMHKU8SY0DC976qRgTzWenPc6BoX0DJ9wh
         lzu8sSvepQctDhPS6UUZGtotBYD/IWM+7ipxp524nZQ8j40VG8DJZezjmVFGJobS8/SN
         p4J4IUS3Wm/ZcDG/OvP2FQE6WaVWLxCD2S0NTYwt5i8o370VgQGS9rIpvgsKCM2wW5qe
         pI1BoiqqvdNhfOmkiRDt3T9O5QfPeWHRjXJDIAC3uxkITJtbw/vZwvuZMrpCWVd8Srzk
         FdYG/Joi6uLzvYYSRBEOrYXVeklMItvlpi+9KYAX8SkIq8nJdQfnJmezg+srTt2+Xj6F
         2QZw==
X-Gm-Message-State: APjAAAVTB+rukEI8z5jBjJqJ0Hklx4IUmqAq9TfuR15QXXIY8dd1vNin
        7EvHcZsFZv0+3W6DMqZ6jYUlDw==
X-Google-Smtp-Source: APXvYqx2mPAlBtDSrF5sJjLTFal+jWlqEJk8hh+f4IJY5XWUWach/YSh/trqMViUk4u3RPlpVSemfA==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr33151776qtp.274.1556214884917;
        Thu, 25 Apr 2019 10:54:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 7sm5950641qtx.20.2019.04.25.10.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:54:44 -0700 (PDT)
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
Subject: [v3 1/2] device-dax: fix memory and resource leak if hotplug fails
Date:   Thu, 25 Apr 2019 13:54:39 -0400
Message-Id: <20190425175440.9354-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425175440.9354-1-pasha.tatashin@soleen.com>
References: <20190425175440.9354-1-pasha.tatashin@soleen.com>
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

