Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D0B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902155;
	bh=tq5iZWyflAn9zGy5vUV2i+XbU4jKdwovWIMTKITsYHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0meCjjgymXACtbGR8VlBkaackzyQcO4KVSTaHeYr1uqIhb34mZU4b4qtP6RuWGK3O
	 DfrSyFns44cXE3HfUXwx17UhKOinZbacYdx4RvAH1sDnzJv5MXSfWAx1plLHVlSZ7m
	 swLl7VmsvKeKRklFgmenp7Z+m/QyFI+24utyKLsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCRJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbfCRJcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE502075C;
        Mon, 18 Mar 2019 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901574;
        bh=tq5iZWyflAn9zGy5vUV2i+XbU4jKdwovWIMTKITsYHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQop8p93x7OoyZQXrCSr+yAXb4LwVh8AHxkXCzox2WB2M/ziwA8MIroPuoy+7WDPA
         UOqyRG8SxuCzlyULyAfWhhLAjor+VAoi0HR5NAxw7xjV/H/BIWvQrJ8eKJ0TV4ZNqn
         166Ox+N9UXCTthsASkDS6zSc5mhd1OyltB7B3zsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 34/52] net/smc: fix smc_poll in SMC_INIT state
Date:   Mon, 18 Mar 2019 10:25:31 +0100
Message-Id: <20190318084017.548538447@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


