Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D09CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F42070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211256;
	bh=MlG/nRE6rDHiPOrTuZonlQNH0xqLGTMOppwMOOhlxfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rh0OZWpZMgIebBooJ2ws23qRGAbek9c8Igwd/wKONvHCcW3q8MkZZMrC+NR8RfBYZ
	 Y0Gp8cX72oXmUSg1nbkdrT68/kOLYtufPh9TZQHEMMsqsdVs9HXuzARkcANfIjODNs
	 D6G7URC5QVB/yLM351iMTjArlHQ2zRtXXoni8vWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfJ0VUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731789AbfJ0VUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:20:51 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72126205C9;
        Sun, 27 Oct 2019 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211251;
        bh=MlG/nRE6rDHiPOrTuZonlQNH0xqLGTMOppwMOOhlxfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8H+DouQm4Zae8ydsBRfEYg1CzAOgxLUda8I2wagYE75I+Wkm5fFsXG5wlU7hQZWI
         5vVy2FgMR5nTHWTYA+lruCjFUC94nad5Pr8IeNVStwnrgKk7OOAkYnIBBfc92ScQBV
         4FzuWSQvV8NiW8cd5wj6GVINlo2HI87pPi/1k1aM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 083/197] net: aquantia: do not pass lro session with invalid tcp checksum
Date:   Sun, 27 Oct 2019 22:00:01 +0100
Message-Id: <20191027203356.188185690@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit d08b9a0a3ebdf71b0aabe576c7dd48e57e80e0f0 ]

Individual descriptors on LRO TCP session should be checked
for CRC errors. It was discovered that HW recalculates
L4 checksums on LRO session and does not break it up on bad L4
csum.

Thus, driver should aggregate HW LRO L4 statuses from all individual
buffers of LRO session and drop packet if one of the buffers has bad
L4 checksum.

Fixes: f38f1ee8aeb2 ("net: aquantia: check rx csum for all packets in LRO session")
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -313,6 +313,7 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 					break;
 
 				buff->is_error |= buff_->is_error;
+				buff->is_cso_err |= buff_->is_cso_err;
 
 			} while (!buff_->is_eop);
 
@@ -320,7 +321,7 @@ int aq_ring_rx_clean(struct aq_ring_s *s
 				err = 0;
 				goto err_exit;
 			}
-			if (buff->is_error) {
+			if (buff->is_error || buff->is_cso_err) {
 				buff_ = buff;
 				do {
 					next_ = buff_->next,


