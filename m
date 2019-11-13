Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B2C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E82053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610423;
	bh=uPqAL7yy9auhhcmmWvGPsA0w0sPseh05Du9m9H55Qlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K6k6pdKgTJ7ogEE6+l+NZtuLsSgWrFv5oW5TyQTtsPQkGNeOI5WOq75TmvYHZsPeB
	 zHs7aUJ7cc2aa0HzaJQoalCcB2cZ/9+7fqdds/M6yzYtmVferfbDRrbQ57tpEwQsYv
	 oEtaNR8+BuaqJVYuAyqdpBl8OFd0AKNY8gakhUyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfKMCAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbfKMCAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:00:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18982245A;
        Wed, 13 Nov 2019 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610415;
        bh=uPqAL7yy9auhhcmmWvGPsA0w0sPseh05Du9m9H55Qlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up4va7JQhMM2qMN7BT8qdEI4Gf1tFxRRV6TLII3dxjqGZqxU43Y6KiQTfxDadEMDV
         mwUeNOFPVPuKnhSOcbntOdJxrYIRmSbKvWqNOSHyCbmLFYDAe+3RwmlqwhcRbWpYmO
         X6clxvXD44OoauGbqKBysv5bpJsujMP2UJTmF690=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 27/68] media: pxa_camera: Fix check for pdev->dev.of_node
Date:   Tue, 12 Nov 2019 20:58:51 -0500
Message-Id: <20191113015932.12655-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 390d708c807a0..3fab9f776afa7 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2334,7 +2334,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	pcdev->res = res;
 
 	pcdev->pdata = pdev->dev.platform_data;
-	if (&pdev->dev.of_node && !pcdev->pdata) {
+	if (pdev->dev.of_node && !pcdev->pdata) {
 		err = pxa_camera_pdata_from_dt(&pdev->dev, pcdev, &pcdev->asd);
 	} else {
 		pcdev->platform_flags = pcdev->pdata->flags;
-- 
2.20.1

