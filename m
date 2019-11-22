Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D060C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C320707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419007;
	bh=p/RmlmT67lAOqkWvbQoRuTpPBUPePImcyuLhOl2dT7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rKJjdTwgMcsQn0L7Ehjkw0Xv5rQwNPivlLMJUBjsfb5oA90rlzoLOpUQFD7kCbpbi
	 G9T7eRwNBKc3DsNtH/uVtlYwjwdVyfES/yNKl2gv9hE6KhuX9KD3q1rksyzUWcfOLx
	 P9EtWwO9a4xyTVWuas9w4YjdG//wrfN382G3prOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfKVKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbfKVKgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:36:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176EA20707;
        Fri, 22 Nov 2019 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419003;
        bh=p/RmlmT67lAOqkWvbQoRuTpPBUPePImcyuLhOl2dT7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uM3cNSV58/NKgnpciMCpEOYpoVh5FClMzjY/7qGTF5+RC2re5uLjFFULXWNWA7Le1
         j7kzrYaNtYCd+eKe65bCb5PPk1fisr2he31hfHiUdtnVl3ZerSpsyno9CIAo8nLHbr
         nnw+9KVXCYB7lI4trOFG0LnRjQrUAJL9BO8j09cw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 080/159] media: davinci: Fix implicit enum conversion warning
Date:   Fri, 22 Nov 2019 11:27:51 +0100
Message-Id: <20191122100803.241665428@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 4158757395b300b6eb308fc20b96d1d231484413 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/media/platform/davinci/vpbe_display.c:524:24: warning: implicit
conversion from enumeration type 'enum osd_v_exp_ratio' to different
enumeration type 'enum osd_h_exp_ratio' [-Wenum-conversion]
                        layer_info->h_exp = V_EXP_6_OVER_5;
                                          ~ ^~~~~~~~~~~~~~
1 warning generated.

This appears to be a copy and paste error judging from the couple of
lines directly above this statement and the way that height is handled
in the if block above this one.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index 6d91422c4e4c7..a9cd8c7a7b347 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -520,7 +520,7 @@ vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
 		else if (v_scale == 4)
 			layer_info->v_zoom = ZOOM_X4;
 		if (v_exp)
-			layer_info->h_exp = V_EXP_6_OVER_5;
+			layer_info->v_exp = V_EXP_6_OVER_5;
 	} else {
 		/* no scaling, only cropping. Set display area to crop area */
 		cfg->ysize = expected_ysize;
-- 
2.20.1



