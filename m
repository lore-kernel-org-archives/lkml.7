Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBDBC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BFB204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355994;
	bh=AJzAOBfK+W+9PiPw6Q1YZyS50a4r863se8XmdD4S8UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sClQpAOVnzZd+JlkgXJ8OSM4E8FxKHjzDliIeihoOB2P1P4R9RlOu6aiKTqHE3LuF
	 ds5PJ0gc2EASAdjebla58bMLzSDOLT4pP0IBIFAfSa3jDl3R6I0m5WFsCAxBH8OTuz
	 8JshPoYFFHi7Xc1+jTMKnLYn0iaBJZe1fYbQhSPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbfETMd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390699AbfETMdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:33:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5286204FD;
        Mon, 20 May 2019 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355602;
        bh=AJzAOBfK+W+9PiPw6Q1YZyS50a4r863se8XmdD4S8UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gte1eeV+gbuOB0sxWb0dOrsGy++xES1DxIXz+ms/JLfk/rno1ZugYpU9lz0tEznJz
         istxJkDPyhHmMmVzBvuK4kYm97axjWb/jfFix0SaYpIGSXAGlhyBRFt8Nkldmey00T
         HW4t+6NzJ+Yh2dok/zt4t1pF8xcpLll9KFNi4u7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.1 056/128] ASoC: fsl_esai: Fix missing break in switch statement
Date:   Mon, 20 May 2019 14:14:03 +0200
Message-Id: <20190520115253.575225378@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: S.j. Wang <shengjiu.wang@nxp.com>

commit 903c220b1ece12f17c868e43f2243b8f81ff2d4c upstream.

case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
independent of each other, so replace fall-through with break.

Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/fsl/fsl_esai.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struc
 		break;
 	case ESAI_HCKT_EXTAL:
 		ecr |= ESAI_ECR_ETI;
-		/* fall through */
+		break;
 	case ESAI_HCKR_EXTAL:
 		ecr |= ESAI_ECR_ERI;
 		break;


