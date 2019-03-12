Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04329214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LaQ/m0r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfCLIPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:15:38 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47578 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:15:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 15149B5C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pkvbLE6kC99g for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 03:15:35 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id DDF20B3D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:15:35 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id p143so1232157iod.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D52gZKic/kaXc1i1hUThp3TEp/h/NmLMpSvJunvUEZw=;
        b=LaQ/m0r8sDi26ETNVkiPDhcpxYotjlJesrU9Y9Nv/2cSxiN6NmdeobHZtZKb2JeKoR
         f49xGy7BfgfZX3nu7gWXRI9SpSTQchlQ3Nj4xnsMOzBjQ83bt/Y+DtQyooCdTDQIcoHs
         tCQJ+2fbSL1nf3gnOvmeWdiPDjOGEagAFtHq2JQlqZhAibIIlCb6UiY6j1DHXYOKneKj
         yCiPljolxWgBc7XJt7bUdLbsfvUnGGVBJwk4TzkdL6kBSsUox3a6KpksqYTzCqjU70Ep
         uCdWyeB+44gCjXnEFVrYBCfE8BtXBOKdMxV+5d826FbKtzxQSkb3zrxqP1WaZFM1jCkG
         rkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D52gZKic/kaXc1i1hUThp3TEp/h/NmLMpSvJunvUEZw=;
        b=rdIG2t7cSKN952D4LmDUX/hlljziBKIHqdOiKC/VwWrzUkpyoGWdR/WLPVu27ZkW5k
         0H1mrgLPFlmsqRkqdEl0bACHIEtFj0APffPe2Z34VeyU1MLVeZS9l0OsKhaGpJd/inSD
         kVpQrmhKaowvXNgnu7wJgTpslZbY5gJc35TTyQMv3TK0VJ3HyyZdWs9pxS84KGcfpuSk
         VMPBv1c6en9cmavx220SUrW140bZl4EUSw1lbyuTiaHoUwrrKhO3uh4c0mOLQ9FrTnM4
         oOjW1uV7JjmWStGnZSHjQFvgphFbFF1z4szL/hrjDg9pypAcLkdcU/aZLip8q/k/DR5J
         TV7A==
X-Gm-Message-State: APjAAAU8XaT2C3K+17FiB/fMd0cH+BeFrflpd6SaJ84H0jQ/TkRTZSVf
        zXDx+sLfhoVXnr5YvX+TYKEjzW5LiY2/vLkQ1gku7DenJicqvwTjaQJkKlglWlg0TdPiBLQzpyR
        Tjuvy1mPpEYyfbRYfHY4XjV2YzjKL
X-Received: by 2002:a24:3ac5:: with SMTP id m188mr1238456itm.109.1552378535386;
        Tue, 12 Mar 2019 01:15:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyR42N2k5Bx5GvyqkcRoP2BgeZvHfzqloKG6zHV23b+KTF+R7ReuZI34beY/yRk53/KQy2bg==
X-Received: by 2002:a24:3ac5:: with SMTP id m188mr1238445itm.109.1552378535113;
        Tue, 12 Mar 2019 01:15:35 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z24sm3238862ioi.67.2019.03.12.01.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 01:15:34 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a memory leak
Date:   Tue, 12 Mar 2019 03:15:29 -0500
Message-Id: <20190312081529.4889-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.
Also, the error paths in the following code should release
resources to avoid memory leaks.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/nvdimm/btt_devs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 795ad4ff35ca..565ea0b6f765 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -196,8 +196,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 	}
 
 	nd_btt->lbasize = lbasize;
-	if (uuid)
+	if (uuid) {
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
+		if (!uuid) {
+			kfree(nd_btt);
+			return NULL;
+		}
+	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
@@ -209,6 +214,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
 				dev_name(ndns->claim));
 		put_device(dev);
+		kfree(uuid);
 		return NULL;
 	}
 	return dev;
-- 
2.17.1

