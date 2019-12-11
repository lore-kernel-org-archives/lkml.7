Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF30C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89919208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076836;
	bh=1zkA7yqeQ2Mxa55z37h26z1TWshV0LM+nelUIVNp/Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yf2pjOF+0QD1oTlxFHz/TAWZEwUp1GqGVzQyk6SU/SSfyYRVumBTcIUNCIK97duHK
	 +cf6Bsm2UI99lidk8ZaCiSyUEkxQOysk00OIyDxmW6LahvZI2A/QSgVz+YNcW2W829
	 CCFoTlumEWSv7pHBJEG0T5F6zlnplMNgNnnna5pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfLKPHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbfLKPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:07:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82080208C3;
        Wed, 11 Dec 2019 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076835;
        bh=1zkA7yqeQ2Mxa55z37h26z1TWshV0LM+nelUIVNp/Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKmoNsP8j9BWJQ9HStwG2yxcIco5Mm6NE4Aq5cebi2pPtZNuUK0QNoKpa2jtj9KYz
         YCmIFBU4hnxjMXTnidYSMFeS1Fgtw+iqwhyJq9jjWZzn9H2ShKlbsDh6ofQ/H47vH/
         +ZVhmESIfCEZC2Im5wp9wvC2CApCLLpPjBbhLKdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 01/92] rsi: release skb if rsi_prepare_beacon fails
Date:   Wed, 11 Dec 2019 16:04:52 +0100
Message-Id: <20191211150222.272642017@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit d563131ef23cbc756026f839a82598c8445bc45f upstream.

In rsi_send_beacon, if rsi_prepare_beacon fails the allocated skb should
be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_mgmt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -1756,6 +1756,7 @@ static int rsi_send_beacon(struct rsi_co
 		skb_pull(skb, (64 - dword_align_bytes));
 	if (rsi_prepare_beacon(common, skb)) {
 		rsi_dbg(ERR_ZONE, "Failed to prepare beacon\n");
+		dev_kfree_skb(skb);
 		return -EINVAL;
 	}
 	skb_queue_tail(&common->tx_queue[MGMT_BEACON_Q], skb);


