Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD40C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3298A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="L2GNazUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfH2RsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:48:11 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.130]:28316 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfH2RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:48:10 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 2CF7657D57
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:29:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3OEZiOJGn3Qi03OEZi3QAG; Thu, 29 Aug 2019 12:29:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aJiyb7UI2K/+R2F5a3fw1EU55SbvNGjQFMYnPqg0Gq4=; b=L2GNazUZvM+5uFV9vAPkne/b+V
        VCYDR6dk/keOSuL7t2Ng6N1LuKCPYSDSgz3Q29kbR5AbTVVHhqfnlixvTZ+l59IE2T416t9h/2Ehk
        dPWLzEDR/sdRSe9+UUwp0iqG3rq7WkiU4O+jzUngKmVQBTcJJRyzPtGdmEh1gxVcjkRKtibbxpHau
        Yq7XwKT+IRk9FTtAs0NtZfp1/0KuvasEG9iEbH5p8OxCYHbRZmiP+3OYkVrz104HNV+n16cLndP9Z
        aaG3M/FVu/869oXP0fQ22APe6+XNNVUntMVC+DCeeU0zhbSW/WBIXLvwCkVT49oyH6kRqq3A0xjFk
        ec85EGXA==;
Received: from [189.152.216.116] (port=41274 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i3OEX-000tZz-V9; Thu, 29 Aug 2019 12:29:18 -0500
Date:   Thu, 29 Aug 2019 12:29:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ima: ima_api: Use struct_size() in kzalloc()
Message-ID: <20190829172916.GA10261@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3OEX-000tZz-V9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:41274
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct ima_template_entry {
	...
        struct ima_field_data template_data[0]; /* template related data */
};

instance = kzalloc(sizeof(struct ima_template_entry) + count * sizeof(struct ima_field_data), GFP_NOFS);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_NOFS);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 65224474675b..610759fe63b8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -45,8 +45,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	else
 		template_desc = ima_template_desc_current();
 
-	*entry = kzalloc(sizeof(**entry) + template_desc->num_fields *
-			 sizeof(struct ima_field_data), GFP_NOFS);
+	*entry = kzalloc(struct_size(*entry, template_data,
+				     template_desc->num_fields), GFP_NOFS);
 	if (!*entry)
 		return -ENOMEM;
 
-- 
2.23.0

