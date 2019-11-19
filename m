Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69507C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428EE2231D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574140949;
	bh=KgLFUxqiQqCPOgQl8/HEsbp+YfedIZzmvbyG4jLGpcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qdu1RxmcsWitJYOIgVOtNQdCnBYJC9JuE17s5Nhk91DCcGT8nNgF+iuyDE72ALxsE
	 QibcTLNLqU52vmzUqLEZjPHW4LfFO4s4EjVBciddXhaqn7jkxSKKEBtjXSz51DybTm
	 jh4m+rrD0GDXa4t2H8Nj8JUMA4ePn6O/QfTU2oXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSFW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfKSFWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:22:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F80A21939;
        Tue, 19 Nov 2019 05:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574140943;
        bh=KgLFUxqiQqCPOgQl8/HEsbp+YfedIZzmvbyG4jLGpcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5+2qh30e40+uLsmSvIgwdBw2cX59dPwBFu9rHysmlf/pKlTQ9uHNDXcaq0nnZtKI
         OleKwF0fm8J9C2n8KL2lRwE0XpFAIrhcC5GUfe4Ju1STo/aECDPzslGy4QqsftMq/W
         OE1PEemTilxSyjalkCrS559siH35Jv9b9jIgMBPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Francisco Jerez <francisco.jerez.plata@intel.com>,
        Jon Bloomfield <jon.bloomfield@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Francisco Jerez <currojerez@riseup.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.3 38/48] Revert "drm/i915/ehl: Update MOCS table for EHL"
Date:   Tue, 19 Nov 2019 06:19:58 +0100
Message-Id: <20191119051019.893089107@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119050946.745015350@linuxfoundation.org>
References: <20191119050946.745015350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Roper <matthew.d.roper@intel.com>

commit ed77d88752aea56b33731aee42e7146379b90769 upstream.

This reverts commit f4071997f1de016780ec6b79c63d90cd5886ee83.

These extra EHL entries won't behave as expected without a bit more work
on the kernel side so let's drop them until that kernel work has had a
chance to land.  Userspace trying to use these new entries won't get the
advantage of the new functionality these entries are meant to provide,
but at least it won't misbehave.

When we do add these back in the future, we'll probably want to
explicitly use separate tables for ICL and EHL so that userspace
software that mistakenly uses these entries (which are undefined on ICL)
sees the same behavior it sees with all the other undefined entries.

Cc: Francisco Jerez <francisco.jerez.plata@intel.com>
Cc: Jon Bloomfield <jon.bloomfield@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v5.3+
Fixes: f4071997f1de ("drm/i915/ehl: Update MOCS table for EHL")
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191112224757.25116-1-matthew.d.roper@intel.com
Reviewed-by: Francisco Jerez <currojerez@riseup.net>
(cherry picked from commit 046091758b50a5fff79726a31c1391614a3d84c8)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gt/intel_mocs.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/drivers/gpu/drm/i915/gt/intel_mocs.c
+++ b/drivers/gpu/drm/i915/gt/intel_mocs.c
@@ -200,14 +200,6 @@ static const struct drm_i915_mocs_entry
 	MOCS_ENTRY(15, \
 		   LE_3_WB | LE_TC_1_LLC | LE_LRUM(2) | LE_AOM(1), \
 		   L3_3_WB), \
-	/* Bypass LLC - Uncached (EHL+) */ \
-	MOCS_ENTRY(16, \
-		   LE_1_UC | LE_TC_1_LLC | LE_SCF(1), \
-		   L3_1_UC), \
-	/* Bypass LLC - L3 (Read-Only) (EHL+) */ \
-	MOCS_ENTRY(17, \
-		   LE_1_UC | LE_TC_1_LLC | LE_SCF(1), \
-		   L3_3_WB), \
 	/* Self-Snoop - L3 + LLC */ \
 	MOCS_ENTRY(18, \
 		   LE_3_WB | LE_TC_1_LLC | LE_LRUM(3) | LE_SSE(3), \


