Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFB1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2185E20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904177;
	bh=pg9I1HNkHc+Ox9DH4bnOTqHT5B+4AkbZy06aP3YKRHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pwNBnW/K+cIHQg2/PCtV6zXNw4hjz+f0QXmtbr0UfKRTTLYB5eknU2p5TWNKG5rpt
	 apcnxx/I+3F+hSptdkotY3rlCy+AI30azvVBbcAJnuiofh+8vjkx0igXl4pYlGnr+c
	 S2HxQS8A4HbzoILi8BJpaNirl2gZUUNLQfyroMfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfKDVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbfKDVte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:49:34 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEDA20B7C;
        Mon,  4 Nov 2019 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904173;
        bh=pg9I1HNkHc+Ox9DH4bnOTqHT5B+4AkbZy06aP3YKRHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wnv0jktGXPaJWqF+r2clrEWH88t8Zyt+xhmCQpwrfFwTcstJ6UrFQwYS1+37j/nkb
         Ea24I846LemLf/ASFWKZCxJtjGCNIPu/VRa2Oy9EtRkrkkZ6+Zy+RX8soS0LxIakqu
         VJpUAMNSbpo8UvwfEnrbXzvzjYWZRjtIlpkWYgE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Waisman <nico@semmle.com>,
        Laura Abbott <labbott@redhat.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 38/46] rtlwifi: Fix potential overflow on P2P code
Date:   Mon,  4 Nov 2019 22:45:09 +0100
Message-Id: <20191104211911.242011465@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@redhat.com>

commit 8c55dedb795be8ec0cf488f98c03a1c2176f7fb1 upstream.

Nicolas Waisman noticed that even though noa_len is checked for
a compatible length it's still possible to overrun the buffers
of p2pinfo since there's no check on the upper bound of noa_num.
Bound noa_num against P2P_MAX_NOA_NUM.

Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/ps.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -781,6 +781,9 @@ static void rtl_p2p_noa_ie(struct ieee80
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM)
+					noa_num = P2P_MAX_NOA_NUM;
+
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
@@ -875,6 +878,9 @@ static void rtl_p2p_action_ie(struct iee
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM)
+					noa_num = P2P_MAX_NOA_NUM;
+
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==


