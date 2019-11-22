Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00A72070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419944;
	bh=tmAMY+oNmxk7Nfm7KyR/BS1nrQjUL/UOu/NrN+8wWdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOnqD9v5dFpAbEoEmoB6Bi7cpRUHs59RoB0voU3kZNzVOVHkuZtwbADJiHtw80r98
	 Udag6D1HeBaHYQjsvwPMB5F1B7iP1UoLHcBEw4CQfleRBkBUi10C+8mT9mfbyNdoAU
	 ZOiiEvKnWBtYYJbWdtcUBnKtXevGuzm/amXQ51Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfKVKwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfKVKwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:52:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AE02070E;
        Fri, 22 Nov 2019 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419938;
        bh=tmAMY+oNmxk7Nfm7KyR/BS1nrQjUL/UOu/NrN+8wWdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJnezSBFgzemlQJ6Qz9/iBlEsQ3Z7WKYfVW3dr9SIJxbIDMMEpJxmpem7++XXlbsH
         9TIUQtDCOVUA4OjMp5Dl8GNzEezOJcmf61Z5VvG+vN3irHEyhlXsJ4KZ8Qy+g/WzlF
         XpYrR0QbuNFLaT4gBLL1kmDS2CwIzELI+/yTOvms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/122] media: pxa_camera: Fix check for pdev->dev.of_node
Date:   Fri, 22 Nov 2019 11:28:32 +0100
Message-Id: <20191122100803.421297043@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 44d7f1a77d8c84f8e42789b5475b74ae0e6d4758 ]

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/media/platform/pxa_camera.c:2400:17: warning: address of
'pdev->dev.of_node' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pdev->dev.of_node && !pcdev->pdata) {
             ~~~~~~~~~~^~~~~~~ ~~
1 warning generated.

Judging from the rest of the kernel, it seems like this was an error and
just the value of of_node should be checked rather than the address.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/pxa_camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index edca993c2b1f0..d270a23299cc7 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2374,7 +2374,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	pcdev->res = res;
 
 	pcdev->pdata = pdev->dev.platform_data;
-	if (&pdev->dev.of_node && !pcdev->pdata) {
+	if (pdev->dev.of_node && !pcdev->pdata) {
 		err = pxa_camera_pdata_from_dt(&pdev->dev, pcdev, &pcdev->asd);
 	} else {
 		pcdev->platform_flags = pcdev->pdata->flags;
-- 
2.20.1



