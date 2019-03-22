Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B7821939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253616;
	bh=1nyKJ0iNx/0QYhmKvE+tO4riQz98k5/A/nZZNhOychI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJgUrITPp4E9MZZnET1orIDHBKYLkCT8m997fgMq581dpiRDGp3fwbCoMnn0pZaUC
	 TqQrSXNVjSBUX0rPeCK2Q+nKgDb4hdMQX/QQhqHByESz0IU8xnPjRZblHIJwS1broJ
	 1c3nP31UADbTZlDC7VCgaLB1VBSW0BWnc/8xvl1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfCVLUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfCVLTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:19:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96F5218A2;
        Fri, 22 Mar 2019 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253591;
        bh=1nyKJ0iNx/0QYhmKvE+tO4riQz98k5/A/nZZNhOychI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2lxRQv0PV3MtW6snyW7MyPR5KFxxS4kWmVlCFo7hgLciC/TEiHtmMZHJOLB4/dlr
         v/0eCvHQHPk8sxDGGl/gWli5aZZrF2UiA1G/HGK7sMyFDJ6cINKrtWKYhf+SYxf2D6
         k2bmV5QJU5ojCTAcktkqT71mi6hdLsAxnOyMRkRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 015/134] atm: he: fix sign-extension overflow on large shift
Date:   Fri, 22 Mar 2019 12:13:48 +0100
Message-Id: <20190322111211.142913103@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cb12d72b27a6f41325ae23a11033cf5fedfa1b97 ]

Shifting the 1 by exp by an int can lead to sign-extension overlow when
exp is 31 since 1 is an signed int and sign-extending this result to an
unsigned long long will set the upper 32 bits.  Fix this by shifting an
unsigned long.

Detected by cppcheck:
(warning) Shifting signed 32-bit value by 31 bits is undefined behaviour

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/he.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index c39702bc279d4..937f54ccbe6b5 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -717,7 +717,7 @@ static int he_init_cs_block_rcm(struct he_dev *he_dev)
 			instead of '/ 512', use '>> 9' to prevent a call
 			to divdu3 on x86 platforms
 		*/
-		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
+		rate_cps = (unsigned long long) (1UL << exp) * (man + 512) >> 9;
 
 		if (rate_cps < 10)
 			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
-- 
2.19.1



