Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043D02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901420;
	bh=9kQ6HOeyD2H6qsaYinfpovhWXY6TQ9mJID5vVpXXplA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7YH8JQf4R1TjZVxopCl6QY/8omYv11PV6nFJL/SNtA6A/V6uV3BMEylogz7XC9sj
	 mIFwUYtSzItSGhUB4O9DvkJe1idj9wVknxgnbZa7rZ55DT7NdXBFgywU/b8KRRpkKE
	 pTudB2KdMIAWfvNodWF89xT6V3D1UjS6Cn+eBmow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfCRJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbfCRJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:17 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06CB2214AF;
        Mon, 18 Mar 2019 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901416;
        bh=9kQ6HOeyD2H6qsaYinfpovhWXY6TQ9mJID5vVpXXplA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7rgzbbMoOJu5+wA2TXjKA94ztx28mATQh3wn+268dPMsdJmvxP/yJdNWlhBul7ye
         //KXoSjnFvHA4rP9PtulHYoCC/HKUXNvTcxl/hBPPH9PW4LgTWmBCyEzsU0sOhQ/+5
         wAuK7bzRrsz00oy5pk4YlzIbpCMS25Eoem/s5j+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 37/52] net/smc: fix smc_poll in SMC_INIT state
Date:   Mon, 18 Mar 2019 10:25:24 +0100
Message-Id: <20190318083847.666498466@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit d7cf4a3bf3a83c977a29055e1c4ffada7697b31f ]

smc_poll() returns with mask bit EPOLLPRI if the connection urg_state
is SMC_URG_VALID. Since SMC_URG_VALID is zero, smc_poll signals
EPOLLPRI errorneously if called in state SMC_INIT before the connection
is created, for instance in a non-blocking connect scenario.

This patch switches to non-zero values for the urg states.

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Fixes: de8474eb9d50 ("net/smc: urgent data support")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -113,9 +113,9 @@ struct smc_host_cdc_msg {		/* Connection
 } __aligned(8);
 
 enum smc_urg_state {
-	SMC_URG_VALID,			/* data present */
-	SMC_URG_NOTYET,			/* data pending */
-	SMC_URG_READ			/* data was already read */
+	SMC_URG_VALID	= 1,			/* data present */
+	SMC_URG_NOTYET	= 2,			/* data pending */
+	SMC_URG_READ	= 3,			/* data was already read */
 };
 
 struct smc_connection {


