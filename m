Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A4CECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FDC21E6F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263189;
	bh=wrPFR4hMu8e3GqW0eIvzAndNN0lyryXQlDzQkmqeg+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KdYr2fZ3a2aNy7oUHvLT0IpvE2g8JisB5ZhUcZzMW9O3nvXkGJ6rXW/jeU9Idlfwr
	 Qvl5uN3oKlkwXS2Ea5u7TJ+TCCjjLXpC71ghOuMS1buVkf/RtLLuZeZTsQArmfKHjg
	 Ie2gbESnuPG/jrsn1Q4p4RoKUMGP/pl8HBt/KFH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438631AbfJPV7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438260AbfJPV6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:46 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD3A20872;
        Wed, 16 Oct 2019 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263126;
        bh=wrPFR4hMu8e3GqW0eIvzAndNN0lyryXQlDzQkmqeg+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4LTZGZEHo0jih5T4FHS6KfJgOXaTOajYNQyv9Kd+l4aYmI+3msZKSK/2A8smvCWh
         4xRAB0cCYyNUveRFbMxXeljc0QY/aMreSRK/hnF3pe68KfnySVgFyzpoYfjr2W7MxV
         MAxmlS0Fqi7MskByvgp50r4yPLOX3gFlyr+3g6Mc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5.3 050/112] staging: rtl8188eu: fix HighestRate check in odm_ARFBRefresh_8188E()
Date:   Wed, 16 Oct 2019 14:50:42 -0700
Message-Id: <20191016214856.566046359@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 22d67a01d8d89552b989c9651419824bb4111200 upstream.

It's incorrect to compare HighestRate with 0x0b twice in the following
manner "if (HighestRate > 0x0b) ... else if (HighestRate > 0x0b) ...". The
"else if" branch is constantly false. The second comparision should be
with 0x03 according to the max_rate_idx in ODM_RAInfo_Init().

Cc: Michael Straube <straube.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/r/20190926073138.12109-1-efremov@linux.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -409,7 +409,7 @@ static int odm_ARFBRefresh_8188E(struct
 		pRaInfo->PTModeSS = 3;
 	else if (pRaInfo->HighestRate > 0x0b)
 		pRaInfo->PTModeSS = 2;
-	else if (pRaInfo->HighestRate > 0x0b)
+	else if (pRaInfo->HighestRate > 0x03)
 		pRaInfo->PTModeSS = 1;
 	else
 		pRaInfo->PTModeSS = 0;


