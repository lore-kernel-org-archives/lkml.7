Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC7CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBEB214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210253;
	bh=uMocm4+Idqizp2zaiVTkONT4tZfh/ZwZSSAhrI2oUFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kZTA+6ujFm66M6+gGxQMiHcaznU/t0JlttG01k2zh1TR3IPhKRZQVFgcl2MgTN0ib
	 B3VwVw8GF19F+mkWJJomweiysZFY1PsoYT36KPcv246MDHERAoLKCPRHrhB8E7vW4H
	 Gg5Twcy2JRUMxMS70Go5XU+sQBIo4Rhfrlu7Qco8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfJ0VEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfJ0VEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:08 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A2220B7C;
        Sun, 27 Oct 2019 21:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210248;
        bh=uMocm4+Idqizp2zaiVTkONT4tZfh/ZwZSSAhrI2oUFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYfl1NfNfQxdZigvbs9Vm6iprtWv0Z4N3j8t7PG12EB/vbyXIp53zAo/+8cRqBwdT
         44GnGNdf2YVS9VO3XFNANkmRBhArYNlewBLcf5U6yrE7wZTmBBQfcQ5qnc/yF4Y/DD
         xOKnsfgZbtNmY0OeVIfDfyXMAZvirP5JYz98BmSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicolas Waisman <nico@semmle.com>,
        Will Deacon <will@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 28/41] mac80211: Reject malformed SSID elements
Date:   Sun, 27 Oct 2019 22:01:06 +0100
Message-Id: <20191027203123.346468408@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 4152561f5da3fca92af7179dd538ea89e248f9d0 upstream.

Although this shouldn't occur in practice, it's a good idea to bounds
check the length field of the SSID element prior to using it for things
like allocations or memcpy operations.

Cc: <stable@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191004095132.15777-1-will@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/mlme.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2431,7 +2431,8 @@ struct sk_buff *ieee80211_ap_probereq_ge
 
 	rcu_read_lock();
 	ssid = ieee80211_bss_get_ie(cbss, WLAN_EID_SSID);
-	if (WARN_ON_ONCE(ssid == NULL))
+	if (WARN_ONCE(!ssid || ssid[1] > IEEE80211_MAX_SSID_LEN,
+		      "invalid SSID element (len=%d)", ssid ? ssid[1] : -1))
 		ssid_len = 0;
 	else
 		ssid_len = ssid[1];
@@ -4669,7 +4670,7 @@ int ieee80211_mgd_assoc(struct ieee80211
 
 	rcu_read_lock();
 	ssidie = ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
-	if (!ssidie) {
+	if (!ssidie || ssidie[1] > sizeof(assoc_data->ssid)) {
 		rcu_read_unlock();
 		kfree(assoc_data);
 		return -EINVAL;


