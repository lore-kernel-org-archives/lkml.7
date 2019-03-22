Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAC9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCB521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257254;
	bh=RYHMf7WX0iXms8ZqZym7qPuxHcQNE7URlg8T/qPPS4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoU613GRHYPvmUYB5PWvA2QKw2Fsa6NhzcnlLQD2mmrp8R3naky3zYud+rRZcrsrE
	 t4XDCX5/86AHhABgqFFg2An8IMdh1QjrtL2VcX/ulkzBG73x7o54eMc+FSN6qr5NuI
	 L8q4lLmWFNLLibtcvNL6SW1de4HnaX5ADLwfiimU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbfCVMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390357AbfCVMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:20:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037E7218A1;
        Fri, 22 Mar 2019 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257249;
        bh=RYHMf7WX0iXms8ZqZym7qPuxHcQNE7URlg8T/qPPS4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTidU50YhXGhVuumtmBRtpPrp9mB4J4BP9rzA13hAyYWTHrStfx+Qz638Md56glG7
         MQ8jR2wwURDrYzWVkdseKpt7l8ipnojIFFZDIeEWU5N4mMFymq9At19ZBT3C8ivsD0
         yC5K3fX9oMb3+vPqVgGwTcsAtURDInzezLEjuTQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Niethe <jniethe5@gmail.com>,
        Stewart Smith <stewart@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 158/238] powerpc/powernv: Make opal log only readable by root
Date:   Fri, 22 Mar 2019 12:16:17 +0100
Message-Id: <20190322111307.617971480@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -98,7 +98,7 @@ static ssize_t opal_msglog_read(struct f
 }
 
 static struct bin_attribute opal_msglog_attr = {
-	.attr = {.name = "msglog", .mode = 0444},
+	.attr = {.name = "msglog", .mode = 0400},
 	.read = opal_msglog_read
 };
 


