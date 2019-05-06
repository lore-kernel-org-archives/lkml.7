Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A43E21530
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153759;
	bh=kHPUHyvhntNx/u4JJbUbu/sAkYPFW0akYta476j60QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cEPIaR45syoAcW1SVN2GYagbxxhq71qPgsTDDQM6UlW0OCQACnKhrsHWL5FjJH+Dc
	 TitneZrA+OvW4ZCXqRANdEwFO6mqH9gDtkLrRf76LQ9NQTni02rOj9yVXwRqp6Vz7x
	 x+WZgvQk12sW5DHrTyLmMeNVpofo/gZAPe3XntSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfEFOmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfEFOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B6C20C01;
        Mon,  6 May 2019 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153755;
        bh=kHPUHyvhntNx/u4JJbUbu/sAkYPFW0akYta476j60QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dakampvHBn1zlDV6dvx4JEBuqLuNnRU2YG+1Crj06n6ffKJZxxd9purkivlcXqV5+
         Ja/HxxheUwyg4IerBhF/jOEU87ZYR+nYtiYhj6ZMhgPmBdqoEIKGWyYCN2z7dCxJC9
         0fZTX1LYVHFMBr3ZCDJfRDszNYC8+j/TdXsAIi9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 84/99] IB/core: Fix potential memory leak while creating MAD agents
Date:   Mon,  6 May 2019 16:32:57 +0200
Message-Id: <20190506143101.610098947@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

commit 6e88e672b69f0e627acdae74a527b730ea224b6b upstream.

If the MAD agents isn't allowed to manage the subnet, or fails to register
for the LSM notifier, the security context is leaked. Free the context in
these cases.

Fixes: 47a2b338fe63 ("IB/core: Enforce security on management datagrams")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Reported-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/security.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -711,16 +711,20 @@ int ib_mad_agent_security_setup(struct i
 						agent->device->name,
 						agent->port_num);
 	if (ret)
-		return ret;
+		goto free_security;
 
 	agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
 	ret = register_lsm_notifier(&agent->lsm_nb);
 	if (ret)
-		return ret;
+		goto free_security;
 
 	agent->smp_allowed = true;
 	agent->lsm_nb_reg = true;
 	return 0;
+
+free_security:
+	security_ib_free_security(agent->security);
+	return ret;
 }
 
 void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)


