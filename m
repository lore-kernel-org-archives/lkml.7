Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D83C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135B20657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922574;
	bh=QsYZ9HZpUUYKJYJT/QDNZdU6WI+ataWXCsOdcchD/+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ly5JpdGLWnkavdpnQ5yH/kWYpaizH06ZyD0GfOD7muywqGCiSJL9fMyMRnO0E+Kzw
	 7eflL67/zZTco9orDhI4TuahqNRjPKcDPEZLBe9XChmOZiM5s9xSO2RbpYOHjLg1FV
	 e3UdgIcQeD2293/723Nh4JGKXoz5ORDW8E2bqh7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfFGPtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731965AbfFGPtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:49:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732FB20657;
        Fri,  7 Jun 2019 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922570;
        bh=QsYZ9HZpUUYKJYJT/QDNZdU6WI+ataWXCsOdcchD/+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzKDjRaC3TFAcXdObj6jSJRfBB6PrlsFhOo4b71nEYRjXV7ycsgumtpkTA0E4skwg
         O8787JUr0zZet0Bfr+ezMRCm4L0jq0FX/8SBpDxgJV0xg+zmRcc5hwaTiuZVvTIG0h
         JvAQPGfs8FeOINOQz9Prr9AOYG92NrvpbHlmve+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.1 59/85] ima: fix wrong signed policy requirement when not appraising
Date:   Fri,  7 Jun 2019 17:39:44 +0200
Message-Id: <20190607153856.007058193@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Vorel <pvorel@suse.cz>

commit f40019475bbbe9b455e7fd4385fcf13896c492ca upstream.

Kernel booted just with ima_policy=tcb (not with
ima_policy=appraise_tcb) shouldn't require signed policy.

Regression found with LTP test ima_policy.sh.

Fixes: c52657d93b05 ("ima: refactor ima_init_policy()")
Cc: stable@vger.kernel.org  (linux-5.0)
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_policy.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -498,10 +498,11 @@ static void add_rules(struct ima_rule_en
 
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
-		if (entries[i].action == APPRAISE)
+		if (entries[i].action == APPRAISE) {
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-		if (entries[i].func == POLICY_CHECK)
-			temp_ima_appraise |= IMA_APPRAISE_POLICY;
+			if (entries[i].func == POLICY_CHECK)
+				temp_ima_appraise |= IMA_APPRAISE_POLICY;
+		}
 	}
 }
 


