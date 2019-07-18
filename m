Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761CC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D082053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419847;
	bh=EdpDdCKpJwhfwadGbuJJvnlYR0dYIPidS6Tp8+xxjjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vG+Wy3CCcbNK2vWBnRtX5GofEmR/dD33roOg1Z4TIbhnXwQc6QU5bU8UqVzNXNu6E
	 cXdr6d8BXjfe0qh4MNzmpYmDsk/9bSVAWi+vCYL2gGaP24a+THLpUtxgM/G9PqSHlJ
	 wC7L5eGpwavBDhOQdWZ3YGxihhLA4/2UNNazSuPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391705AbfGRDR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391838AbfGRDOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:34 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B335A21851;
        Thu, 18 Jul 2019 03:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419674;
        bh=EdpDdCKpJwhfwadGbuJJvnlYR0dYIPidS6Tp8+xxjjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fk2OZXK+PO6dDnU7aNo9QLOfQ7FE/GJcE/3JmmX4NE9EEZOvbWG2WaDrWLKod1Lj/
         rl93Yxbz5b+MjtiM43V2uISa4EabUADQ3wdAj1vKjhtNBOqZCLuutOCBsE9OLx8LnO
         J/hHAaVaNs/Dt8ot7tIisenIVMM9CZX8NvOn9HIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 15/40] mwifiex: Abort at too short BSS descriptor element
Date:   Thu, 18 Jul 2019 12:02:11 +0900
Message-Id: <20190718030043.977427734@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 685c9b7750bfacd6fc1db50d86579980593b7869 upstream.

Currently mwifiex_update_bss_desc_with_ie() implicitly assumes that
the source descriptor entries contain the enough size for each type
and performs copying without checking the source size.  This may lead
to read over boundary.

Fix this by putting the source size check in appropriate places.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mwifiex/scan.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/wireless/mwifiex/scan.c
+++ b/drivers/net/wireless/mwifiex/scan.c
@@ -1241,6 +1241,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_FH_PARAMS:
+			if (element_len + 2 < sizeof(*fh_param_set))
+				return -EINVAL;
 			fh_param_set =
 				(struct ieee_types_fh_param_set *) current_ptr;
 			memcpy(&bss_entry->phy_param_set.fh_param_set,
@@ -1249,6 +1251,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_DS_PARAMS:
+			if (element_len + 2 < sizeof(*ds_param_set))
+				return -EINVAL;
 			ds_param_set =
 				(struct ieee_types_ds_param_set *) current_ptr;
 
@@ -1260,6 +1264,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_CF_PARAMS:
+			if (element_len + 2 < sizeof(*cf_param_set))
+				return -EINVAL;
 			cf_param_set =
 				(struct ieee_types_cf_param_set *) current_ptr;
 			memcpy(&bss_entry->ss_param_set.cf_param_set,
@@ -1268,6 +1274,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_IBSS_PARAMS:
+			if (element_len + 2 < sizeof(*ibss_param_set))
+				return -EINVAL;
 			ibss_param_set =
 				(struct ieee_types_ibss_param_set *)
 				current_ptr;
@@ -1277,10 +1285,14 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_ERP_INFO:
+			if (!element_len)
+				return -EINVAL;
 			bss_entry->erp_flags = *(current_ptr + 2);
 			break;
 
 		case WLAN_EID_PWR_CONSTRAINT:
+			if (!element_len)
+				return -EINVAL;
 			bss_entry->local_constraint = *(current_ptr + 2);
 			bss_entry->sensed_11h = true;
 			break;
@@ -1320,6 +1332,9 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
+				return -EINVAL;
+
 			vendor_ie = (struct ieee_types_vendor_specific *)
 					current_ptr;
 


