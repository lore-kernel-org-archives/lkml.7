Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEACC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7A922312
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141240;
	bh=z42NMZtRegQyAv3PPGmyHQ/taWk4UXkfZVgfVcUHReg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StNGmI7PKYB3yl+Jc7x0sT9Aro7gK5afAZ85HvXz0MMXpL5Qyadm/Dph5jSOlHM48
	 zbFeSJFk5PRjF2XCHCXqoBNX7CEHPE22jLWj+yK37LbQfIH/OcVS6fvbk0aDWkxkJh
	 U4qGf9cOluChtWnpX+g2jQeELkPUvmyja9vi+dQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfKSF1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfKSF1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:27:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6730C222DC;
        Tue, 19 Nov 2019 05:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141236;
        bh=z42NMZtRegQyAv3PPGmyHQ/taWk4UXkfZVgfVcUHReg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gXEQXTse9GG4IABhaSv7hxCctrk/FtDCqoPSrmiBMNuse4AL1FNhLaWilRyROrW9
         yAeWfay2eTfJ1NeAdfwK7xuTrrcy2+6OLxYNJ8nvR9lViOv0wc5kC3HukbVgqZnIEM
         +uiGbVnrS9nyfA8m3Gq1t/z4IJeje+l9wGyzNC6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/422] media: vicodec: fix out-of-range values when decoding
Date:   Tue, 19 Nov 2019 06:14:48 +0100
Message-Id: <20191119051405.266973350@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit be5a1509af8dd8a78fea24a35fe4a82d4cd0ae70 ]

While decoding you need to make sure you do not get values < 0
or > 255. Note that since this code will also be used in userspace
utilities the clamp macro isn't used since that is kernel-only.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vicodec/vicodec-codec.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-codec.c b/drivers/media/platform/vicodec/vicodec-codec.c
index 2d047646f6147..d854b2344f12b 100644
--- a/drivers/media/platform/vicodec/vicodec-codec.c
+++ b/drivers/media/platform/vicodec/vicodec-codec.c
@@ -588,8 +588,14 @@ static void fill_decoder_block(u8 *dst, const s16 *input, int stride)
 	int i, j;
 
 	for (i = 0; i < 8; i++) {
-		for (j = 0; j < 8; j++)
-			*dst++ = *input++;
+		for (j = 0; j < 8; j++, input++, dst++) {
+			if (*input < 0)
+				*dst = 0;
+			else if (*input > 255)
+				*dst = 255;
+			else
+				*dst = *input;
+		}
 		dst += stride - 8;
 	}
 }
-- 
2.20.1



