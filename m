Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B50C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5B72054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155179;
	bh=qV1uPx44c/lDnu2VPvoFyoVq2I1KcqlgPo8CaBaqsCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZSZMS6OG04OTMCwyfH5uHP15WE+JoU0s9bqSoxVyAfS0/ebNtrF7knzLl35/oslNN
	 I34BzdQooctEfPNle6AT0vJjkogPBHoOJlFsThYVPFOErx8wEc+P+UJNm87QYddr5l
	 VRzEP/OHv3l8lF3hPep4tMDD/UC45HsZLki4CtVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfGZPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389568AbfGZPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:32:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAD2205F4;
        Fri, 26 Jul 2019 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155172;
        bh=qV1uPx44c/lDnu2VPvoFyoVq2I1KcqlgPo8CaBaqsCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4cTWVDRQiWSj1dmW7q1sPCmB3PrYb7g2HG1KLNfPoY3X7YL4Mg7/O3paLk0mWF/e
         16n4fhP/WhZcblLzL20h7BvtaqHOh55S184SiNOsL4wxIakHFQAIXUePk9y+ZaKClr
         Ca4BB4jl11Uve7XakTS7gsc02Yh2V/hUMZ4nzguo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 26/50] macsec: fix checksumming after decryption
Date:   Fri, 26 Jul 2019 17:25:01 +0200
Message-Id: <20190726152303.316120842@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Steinmetz <ast@domdv.de>

[ Upstream commit 7d8b16b9facb0dd81d1469808dd9a575fa1d525a ]

Fix checksumming after decryption.

Signed-off-by: Andreas Steinmetz <ast@domdv.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -869,6 +869,7 @@ static void macsec_reset_skb(struct sk_b
 
 static void macsec_finalize_skb(struct sk_buff *skb, u8 icv_len, u8 hdr_len)
 {
+	skb->ip_summed = CHECKSUM_NONE;
 	memmove(skb->data + hdr_len, skb->data, 2 * ETH_ALEN);
 	skb_pull(skb, hdr_len);
 	pskb_trim_unique(skb, skb->len - icv_len);


