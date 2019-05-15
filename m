Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E875520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919597;
	bh=aMXqOInozZ644Gqg7arfG9d601anbcRvdiTfGF7h3IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LyoEEGyUhMxVh8QABsHQ1RSNosKMm8te9k5gYEoGG5ZO0k0URzCTKfodBzSTPoTyB
	 B4fQy3t4LsMG4N/f50WLEaRZXtmP58Lw6TKrWEiycI014URI7vrQ5YulsOvV+oSbox
	 0rhdt990BVhvQX5URm9nVeaatdQhwx3cOkKdi7W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfEOL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731691AbfEOL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:26:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F80A206BF;
        Wed, 15 May 2019 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919588;
        bh=aMXqOInozZ644Gqg7arfG9d601anbcRvdiTfGF7h3IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQpkkVl2fS+35RsCv8Y+82kCIIq5YmkB+rd4/EkpagWOJGWen58fbnux8PKyx70hb
         iN+IlfKMeaLhKEuYMbjDYCpY2neoFEvkjsWd0uJVepw+gggDdtZH9J7DsRpu6VRni8
         pkIHkPJt9Jn88zFdlmXZApiNylo0j5zuO6LrZJgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 019/137] libnvdimm/btt: Fix a kmemdup failure check
Date:   Wed, 15 May 2019 12:55:00 +0200
Message-Id: <20190515090654.683353136@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 486fa92df4707b5df58d6508728bdb9321a59766 ]

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/btt_devs.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 795ad4ff35caf..e341498876cad 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -190,14 +190,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 
 	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
-	if (nd_btt->id < 0) {
-		kfree(nd_btt);
-		return NULL;
-	}
+	if (nd_btt->id < 0)
+		goto out_nd_btt;
 
 	nd_btt->lbasize = lbasize;
-	if (uuid)
+	if (uuid) {
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
+		if (!uuid)
+			goto out_put_id;
+	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
@@ -212,6 +213,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 	}
 	return dev;
+
+out_put_id:
+	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
+
+out_nd_btt:
+	kfree(nd_btt);
+	return NULL;
 }
 
 struct device *nd_btt_create(struct nd_region *nd_region)
-- 
2.20.1



