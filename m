Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645D02192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256127;
	bh=uJ8LOSN55WIAqoZ7LFnVSZKvV91Y04yCmXjMSpAZzjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zngd6Qy8Xo3ld4bLlp2L2XFP9u2ynfKExLAHpTjoRaawqS3ykeotaaP/j7NvMteRN
	 wOVLhf27DSHc6SkUTuNVDxTn8ICvRw3VA3hz02uxFtmTdRc1APZKTIhfQ9GD96XKTT
	 Gd7gWayCsF/l33855veAFDpT2T4KmkPTKqyqk1RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbfCVMCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbfCVMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F8C204FD;
        Fri, 22 Mar 2019 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256122;
        bh=uJ8LOSN55WIAqoZ7LFnVSZKvV91Y04yCmXjMSpAZzjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxu47VK8+Jp79wwlSMcSC+5X2SKSqYU+QjHOXmsZmX2t0p4hKGxhlMygl80tTEkdr
         /bfmwp+M/Trot1WscyyATVL2WLAiGnsy7hjcxqAJtP0SwpyJip7iBT4UEOO4eXutVA
         8E/nyWNDR2cog+3ehJdyFPa7D4x9cQlC9VFWJUM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 115/280] nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot
Date:   Fri, 22 Mar 2019 12:14:28 +0100
Message-Id: <20190322111314.163455056@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit c6c5df293bf1b488cf8459aac658aecfdccb13a9 upstream.

If query-ARS reports that ARS has stopped and requires continuation
attempt to retrieve short-ARS results before continuing the long
operation.

Fixes: bc6ba8085842 ("nfit, address-range-scrub: rework and simplify ARS...")
Cc: <stable@vger.kernel.org>
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2900,6 +2900,7 @@ static int ars_register(struct acpi_nfit
 
 	switch (acpi_nfit_query_poison(acpi_desc)) {
 	case 0:
+	case -ENOSPC:
 	case -EAGAIN:
 		rc = ars_start(acpi_desc, nfit_spa, ARS_REQ_SHORT);
 		/* shouldn't happen, try again later */
@@ -2924,7 +2925,6 @@ static int ars_register(struct acpi_nfit
 		break;
 	case -EBUSY:
 	case -ENOMEM:
-	case -ENOSPC:
 		/*
 		 * BIOS was using ARS, wait for it to complete (or
 		 * resources to become available) and then perform our


