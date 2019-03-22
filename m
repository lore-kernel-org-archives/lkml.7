Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5809BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECE8213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259928;
	bh=AQGno6FFahfXjv8C4j5ic3LTiFCQOxD+We5G9aAm0C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oPPkdOYoC8nYyGvdxMC6WDK4SVPSUlJQ+Bgcdq1OGZTOBZftnjLBXrpagsSGFG56B
	 ufQI+o45gYbC9EZ7i9d2AURfTHF2J22hYFUpbTL/q7KzZrhw8KrcAtHPUC9eH+0FX0
	 BSjTG/I19x7UlYRNLKSAWJg2nlvH6bdCOa+WhjdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfCVNF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfCVLjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:39:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6763204FD;
        Fri, 22 Mar 2019 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254742;
        bh=AQGno6FFahfXjv8C4j5ic3LTiFCQOxD+We5G9aAm0C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUFG0tFe8r5XF/lSsDzOs/IXbhByfFH8IJU3ko45mvQHjqruq9A1pE1eyghcSvBOi
         Hj7N+UAgvCW8fEm2mTy0oI7ZANdvszbQI7oOR8ANJ/684BkWTtNxh3hEBRX8btfcTL
         ++1RvrRLHHc9hY5brRsyVN2Bxq1TP/2L2Gw8ss/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
        Stewart Smith <stewart@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 211/230] powerpc/powernv: Make opal log only readable by root
Date:   Fri, 22 Mar 2019 12:15:49 +0100
Message-Id: <20190322111251.705142056@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordan Niethe <jniethe5@gmail.com>

commit 7b62f9bd2246b7d3d086e571397c14ba52645ef1 upstream.

Currently the opal log is globally readable. It is kernel policy to
limit the visibility of physical addresses / kernel pointers to root.
Given this and the fact the opal log may contain this information it
would be better to limit the readability to root.

Fixes: bfc36894a48b ("powerpc/powernv: Add OPAL message log interface")
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
Reviewed-by: Stewart Smith <stewart@linux.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-msglog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -92,7 +92,7 @@ out:
 }
 
 static struct bin_attribute opal_msglog_attr = {
-	.attr = {.name = "msglog", .mode = 0444},
+	.attr = {.name = "msglog", .mode = 0400},
 	.read = opal_msglog_read
 };
 


