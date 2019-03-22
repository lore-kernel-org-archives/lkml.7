Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C130C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254390;
	bh=qB7X62S+n+I0+Z6hZB+HGjvHp3rHVUDi2zeceQjyY2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5gk3gED6wzkri3mjVE5G0coSj8IGZc6GazuuK3MjylIudEMiBW9Z62fgm9sbHL61
	 OYRnutfV1sb2GTK0lWxdNgeTARnA2qFXsL0VZyzUsYEopMbS6oN1YvNnRU1MLh23G6
	 G+j9iICer75JU15Ed18XekUYnIJeX7HXm109Z5Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCVLdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbfCVLdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2143F2183E;
        Fri, 22 Mar 2019 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254385;
        bh=qB7X62S+n+I0+Z6hZB+HGjvHp3rHVUDi2zeceQjyY2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aG3RHx3OYWFFCkk64e7lnertUOjO9noMHPxW62cdhVWLjJ+HsYCpuW3IvQvMEkDuF
         gLmiiVf19ZYoaxu/osfF9kfQKzIP01wUau2Xz8/nTDiROmrzwK5ILUzgI/i/lN6Hbs
         DMH/woDAQwRtXlF/VLCTmsLjbe7K18STF0xzFWps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 105/230] ARM: pxa: ssp: unneeded to free devm_ allocated data
Date:   Fri, 22 Mar 2019 12:14:03 +0100
Message-Id: <20190322111243.960918784@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ba16adeb346387eb2d1ada69003588be96f098fa ]

devm_ allocated data will be automatically freed. The free
of devm_ allocated data is invalid.

Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
[title's prefix changed]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-pxa/ssp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index daa1a65f2eb7..6748827c2ec8 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -238,8 +238,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	if (ssp == NULL)
 		return -ENODEV;
 
-	iounmap(ssp->mmio_base);
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
@@ -249,7 +247,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
 	list_del(&ssp->node);
 	mutex_unlock(&ssp_lock);
 
-	kfree(ssp);
 	return 0;
 }
 
-- 
2.19.1



