Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A282EC73C65
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3962064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oIRaXzcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGJBQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:16:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39902 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGJBQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:16:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so641070qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tyS5k/4QJCxPGcV91OLPh8wYVhK9QVlUZJPQN7ARXzo=;
        b=oIRaXzcBKN21PrMZxpFfBUUbAE7wF/UfbZoNG2Bo81kTMfH1jkYTY98GTIENUsItos
         V/WX4vpB1ciXEijN9rOhXuZxWeYIPcAwTN7nY6AcOWXL/QBUJIZ3udoI5EgSSrYP/v6Z
         n5zMxjMJN0LyV1nPiAgnF9KWNaXCjsqQ1RA2g69lzwit3bTSsd3CTb+ZpP8Yt1JHTAk+
         7mMvv1dHPucOHLPxqVU9EeLk6XkScChSXpj10FLFNDhUBRW4PeMiFSAEMN4izsN74QLv
         hSem2wQeYJr4YYe7fdf7Rk+3Py/i9ot4l52CQSRsBrhnyLj311qazIkAWg8uhCACaTgT
         L9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyS5k/4QJCxPGcV91OLPh8wYVhK9QVlUZJPQN7ARXzo=;
        b=cBW30nwsoo+2LIyjD0DSzw3KwiDPBMyGZnqhBI8ueb4U2kTWDmcKTP8atnE9lFweaV
         UIo5sg62mHH+tvX5nER5WdWo6Q8Nbrb5RevDia8WN0GgvTfa/a5MN3hvxysyr/Syt6yy
         rSX2kohlPNvQtAGqlgIQQwwShNG9pLoB30eTIvxaYQQoLL3A0ekrITMbnDhgnoFCMgw6
         SjuDaLkK3irI0fLWUTl3KHxBeIqewd79VZv2RvaCgSHeBElrsE0G/U4T9iei5mmiXz9R
         lWVdECew3tiPF1rHF8AOnKgF5eAqtEk/+mQR7ah1vZ6PP5Luxg9X/5AAF9bWHaHXdRab
         AkGw==
X-Gm-Message-State: APjAAAVgAq6kDBIaqHWDOujNAx67cBh8wI8aM9rh5AFuv2iKbaLO580f
        4crXPmObfXM8dqh056fBIxfPsQ==
X-Google-Smtp-Source: APXvYqzSbKGKdJu9YdO8wNTJ5v/G3QEIGSQCvwnfWWheykUuMY8FrLDyWCW6hyyPO85S9nAUTrUtAw==
X-Received: by 2002:a37:bac2:: with SMTP id k185mr20774793qkf.211.1562721411119;
        Tue, 09 Jul 2019 18:16:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:16:50 -0700 (PDT)
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
Subject: [v7 1/3] device-dax: fix memory and resource leak if hotplug fails
Date:   Tue,  9 Jul 2019 21:16:45 -0400
Message-Id: <20190710011647.10944-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710011647.10944-1-pasha.tatashin@soleen.com>
References: <20190710011647.10944-1-pasha.tatashin@soleen.com>
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
2.22.0

