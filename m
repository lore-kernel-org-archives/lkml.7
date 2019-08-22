Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03CAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495632;
	bh=4RI37Rx+sjcyo1ydJ5qrYWugcM4CsjGfUywUIGQzXhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rEEmH7n9KLRlSmhKPxuYwGFc9AMqgQLHQo1q+sx4eMi4vYx5bXwA0xDXN9fSgEdz9
	 IF4Eafj+Kq3egwkxWngsRMs9vJYRrEFl6cckBnLHAtzh7B0DRLvEYSS+0n3uBOe++L
	 jaLM+IUfKF5sJ5Nddj3PQsCcA+iRD0zxpEeuu93s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfHVRkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404065AbfHVRYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:07 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7B923400;
        Thu, 22 Aug 2019 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494646;
        bh=4RI37Rx+sjcyo1ydJ5qrYWugcM4CsjGfUywUIGQzXhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+wmAu4lfMTdI8mR4aC8EfqHlgbkfl0Jb31kS9NS35JdtsVCIFDD7heMr/+6F0qP7
         ZKS2nHcFFmb9Ryzn3adVJU0r0UFUxQcKIUbuf+ubVk2C2IYnAXDfUD3JL3doOUC8eS
         qq5dkoJsiv0LP79a4jQxuvbobUlfgX9f9vBED4uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 039/103] mwifiex: fix 802.11n/WPA detection
Date:   Thu, 22 Aug 2019 10:18:27 -0700
Message-Id: <20190822171730.389618592@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

commit df612421fe2566654047769c6852ffae1a31df16 upstream.

Commit 63d7ef36103d ("mwifiex: Don't abort on small, spec-compliant
vendor IEs") adjusted the ieee_types_vendor_header struct, which
inadvertently messed up the offsets used in
mwifiex_is_wpa_oui_present(). Add that offset back in, mirroring
mwifiex_is_rsn_oui_present().

As it stands, commit 63d7ef36103d breaks compatibility with WPA (not
WPA2) 802.11n networks, since we hit the "info: Disable 11n if AES is
not supported by AP" case in mwifiex_is_network_compatible().

Fixes: 63d7ef36103d ("mwifiex: Don't abort on small, spec-compliant vendor IEs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/main.h |    1 +
 drivers/net/wireless/marvell/mwifiex/scan.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -120,6 +120,7 @@ enum {
 
 #define MWIFIEX_MAX_TOTAL_SCAN_TIME	(MWIFIEX_TIMER_10S - MWIFIEX_TIMER_1S)
 
+#define WPA_GTK_OUI_OFFSET				2
 #define RSN_GTK_OUI_OFFSET				2
 
 #define MWIFIEX_OUI_NOT_PRESENT			0
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -181,7 +181,8 @@ mwifiex_is_wpa_oui_present(struct mwifie
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_vendor_hdr(bss_desc->bcn_wpa_ie, WLAN_EID_VENDOR_SPECIFIC)) {
-		iebody = (struct ie_body *) bss_desc->bcn_wpa_ie->data;
+		iebody = (struct ie_body *)((u8 *)bss_desc->bcn_wpa_ie->data +
+					    WPA_GTK_OUI_OFFSET);
 		oui = &mwifiex_wpa_oui[cipher][0];
 		ret = mwifiex_search_oui_in_ie(iebody, oui);
 		if (ret)


