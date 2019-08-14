Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56E6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B877F2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802898;
	bh=341LqgKbRDC5iIKF4qSdeGtT563E6G4tGApkflHB3mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXT3fjbiY4ueOHHFA9DTWQQIdV96Nx/D0oi6TyHdeCNk02VfCzBb9MA9a7jyEyxUO
	 TFwi45xA2UmmLrYg2giCuGNqm+5NgfwvsRfyqDHbyiwHoVcDAqgYL2YYdF0NtEaIOK
	 2dFQ8iT+7lRdcLttUtUh1d6Ukm/GiGMa85IWvOtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfHNRO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbfHNROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01862084D;
        Wed, 14 Aug 2019 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802894;
        bh=341LqgKbRDC5iIKF4qSdeGtT563E6G4tGApkflHB3mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDSEzdXqoSfqzH8UjPJdSPAD5eWhNmWaTACvKED7ea1rYGAYtWuENlHSlfRIwMXIt
         7lb1rcNYU2exk55HGPel1CwXNx215TSPQtBDB5s8tmawybwlOEQwUkRvWlP9Z32W2+
         uBSgP/HFqSaQPNDVSJz/KgbtXhuoOMZYqtuNOZ+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 67/69] iwlwifi: mvm: fix an out-of-bound access
Date:   Wed, 14 Aug 2019 19:02:05 +0200
Message-Id: <20190814165750.502514489@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit ba3224db78034435e9ff0247277cce7c7bb1756c upstream.

The index for the elements of the ACPI object we dereference
was static. This means that if we called the function twice
we wouldn't start from 3 again, but rather from the latest
index we reached in the previous call.
This was dutifully reported by KASAN.

Fix this.

Cc: stable@vger.kernel.org
Fixes: 6996490501ed ("iwlwifi: mvm: add support for EWRD (Dynamic SAR) ACPI table")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -778,7 +778,7 @@ static int iwl_mvm_sar_get_ewrd_table(st
 
 	for (i = 0; i < n_profiles; i++) {
 		/* the tables start at element 3 */
-		static int pos = 3;
+		int pos = 3;
 
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't


