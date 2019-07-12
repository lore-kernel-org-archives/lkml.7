Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45422C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D39D2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934601;
	bh=RVgPEGVOeNx+ij6xhozVkER82F9/IjUOHeJY0SL9jbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pnGDut8puBheXTBnHKJeuU1Z8o+se8DSFbmliCmkq5oLI6e3hQzOv6L9rL/7fUwv9
	 E71YnDhRIn+zfu147jSu13NNgjwq0pvfFDMo6/foEp0XJYHBwhvike+HrFKFW44WXA
	 PuMCjDa+Ac2hCwyOrndr8DCUQp+NklXpKTU/8hUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfGLM37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfGLM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:29:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C3E21019;
        Fri, 12 Jul 2019 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934595;
        bh=RVgPEGVOeNx+ij6xhozVkER82F9/IjUOHeJY0SL9jbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhXOtz2fkhWIcdW9b3FUibUV9kmVVpad9QNrXhtGodD1j6K47fXHMUPsgkvxFyLCh
         qRDlX5CmHGVkPa3GtnxmMxdwvACs3ZNlHvyRGL9yuAaSOTedOOkdBezc+3SQfg3t/T
         W2F+LVu/CoN26Ee4MHbIoew9qICvpnbXcF4nCNRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.1 106/138] mwifiex: Abort at too short BSS descriptor element
Date:   Fri, 12 Jul 2019 14:19:30 +0200
Message-Id: <20190712121632.831241159@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
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
 drivers/net/wireless/marvell/mwifiex/scan.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1269,6 +1269,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_FH_PARAMS:
+			if (element_len + 2 < sizeof(*fh_param_set))
+				return -EINVAL;
 			fh_param_set =
 				(struct ieee_types_fh_param_set *) current_ptr;
 			memcpy(&bss_entry->phy_param_set.fh_param_set,
@@ -1277,6 +1279,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_DS_PARAMS:
+			if (element_len + 2 < sizeof(*ds_param_set))
+				return -EINVAL;
 			ds_param_set =
 				(struct ieee_types_ds_param_set *) current_ptr;
 
@@ -1288,6 +1292,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_CF_PARAMS:
+			if (element_len + 2 < sizeof(*cf_param_set))
+				return -EINVAL;
 			cf_param_set =
 				(struct ieee_types_cf_param_set *) current_ptr;
 			memcpy(&bss_entry->ss_param_set.cf_param_set,
@@ -1296,6 +1302,8 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_IBSS_PARAMS:
+			if (element_len + 2 < sizeof(*ibss_param_set))
+				return -EINVAL;
 			ibss_param_set =
 				(struct ieee_types_ibss_param_set *)
 				current_ptr;
@@ -1305,10 +1313,14 @@ int mwifiex_update_bss_desc_with_ie(stru
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
@@ -1349,6 +1361,9 @@ int mwifiex_update_bss_desc_with_ie(stru
 			break;
 
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (element_len + 2 < sizeof(vendor_ie->vend_hdr))
+				return -EINVAL;
+
 			vendor_ie = (struct ieee_types_vendor_specific *)
 					current_ptr;
 


