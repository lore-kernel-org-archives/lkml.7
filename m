Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8765C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F292087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901661;
	bh=mf1sE9iSj2d1ziRFJzgB9dLl5KDPY/dNlG+hIdK8/XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oRcN410dY5iPGyNi2WSdg6c1/wCy6xAUhoVUmnQqSC4PKvUiaLGja8AZBDKIAC1el
	 mom54cYrqLYKO4M9ZGcY2eCb5UhFt+d73G1PQwqYuJvL77xTKvRZlFPcjKqtzoXJLM
	 E5TPrFOZJSUQ+Yhn+PHpr24nILGql27+nyR+RCKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfCRJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbfCRJeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:17 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5952E2064A;
        Mon, 18 Mar 2019 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901656;
        bh=mf1sE9iSj2d1ziRFJzgB9dLl5KDPY/dNlG+hIdK8/XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7UICeX+gdtTN2fcRcxysL8+B59G7LNVh73ZC+o9edP1u9OPTXey/IMA8fGyFuk38
         bfVT+NpSdaSzYxMGaaDeKyhPG9IGvPHajxsUVnMh1u71dzsOf0uDhOlIVl4jCjaAFS
         UMLAJZwobu8qaAAnDJiBlbNojoI6zbY12dYsrW2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 4.14 01/34] ACPICA: Reference Counts: increase max to 0x4000 for large servers
Date:   Mon, 18 Mar 2019 10:25:25 +0100
Message-Id: <20190318084144.840998639@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

commit 8b23570ab001c1982c8a068cde468ff067255314 upstream.

Increase the reference count limit to 0x4000 as the current one is
not sufficient for some large server systems.

Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Tested-by: Russ Anderson <russ.anderson@hpe.com>
Reported-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/acpi/acconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -123,7 +123,7 @@
 
 /* Maximum object reference count (detects object deletion issues) */
 
-#define ACPI_MAX_REFERENCE_COUNT        0x1000
+#define ACPI_MAX_REFERENCE_COUNT        0x4000
 
 /* Default page size for use in mapping memory for operation regions */
 


