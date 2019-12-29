Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254EAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0077421D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640358;
	bh=+vL5qCyh3Qu4QHvTA6KuZ8NyS0MBsGFdnV6ORna5JkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RmZVCITWcOtTpFYInmIOUznly0OSlXYxcfvqslRXt22zR/BAqtmAtDI5tFFJgshrj
	 LuhhLVG/RHEJ3DcHxw9ePGdMOWGDWDrKXuPnBrJAXKKWycyIPutVhJbco/hmQFQEyl
	 3BaJusVQrd7s2ow2DVVz+Qw8g3sFNLtqqz9ZAmaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfL2RZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbfL2RZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:25:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B7C207FF;
        Sun, 29 Dec 2019 17:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640354;
        bh=+vL5qCyh3Qu4QHvTA6KuZ8NyS0MBsGFdnV6ORna5JkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16+5oVpNAAi9NwnO+3N/irrtUFzIARQZrnnpbaUSvRjvTBH7w/vtwjXY5h5iYKWQe
         abvoQRkaGjbf1/KYUc0XrhtUnlwx/86fR9p/0iJbgkkVQmc+xykbwkssQt1tH3rM44
         4iOh7fWWELgBB+OQWPjd+RKH7XS5JqFZEjbLJtmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 085/161] media: rcar_drif: fix a memory disclosure
Date:   Sun, 29 Dec 2019 18:18:53 +0100
Message-Id: <20191229162424.957260467@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit d39083234c60519724c6ed59509a2129fd2aed41 ]

"f->fmt.sdr.reserved" is uninitialized. As other peer drivers
like msi2500 and airspy do, the fix initializes it to avoid
memory disclosures.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 522364ff0d5d..3871ed6a1fcb 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -915,6 +915,7 @@ static int rcar_drif_g_fmt_sdr_cap(struct file *file, void *priv,
 {
 	struct rcar_drif_sdr *sdr = video_drvdata(file);
 
+	memset(f->fmt.sdr.reserved, 0, sizeof(f->fmt.sdr.reserved));
 	f->fmt.sdr.pixelformat = sdr->fmt->pixelformat;
 	f->fmt.sdr.buffersize = sdr->fmt->buffersize;
 
-- 
2.20.1



