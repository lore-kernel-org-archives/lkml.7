Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B9E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780988;
	bh=cogc0FukY8/3EVaRPufi7VD8ZbhSDT10BfN6/bzVrd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCamJ5IN1kb3DPDqk4VkNfB7HgsdHr9SXO6mIOWZ+8//3tDps44e38Fgdy25vepyS
	 PGU3uX7mVvdVm+kbrf4jAKu/FWdxOUw52ObLGXF/Z7i+cekM4vIjw9XHCp2/MCdysh
	 ukMHc81N7KsSBqbaDkFYHcSKLShrNit8RA+JX0cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfLSSnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:43:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbfLSSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:43:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F11222C2;
        Thu, 19 Dec 2019 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780982;
        bh=cogc0FukY8/3EVaRPufi7VD8ZbhSDT10BfN6/bzVrd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKc8bXfINoxtk4GCMZxqD4n2KvSaWrERakOQc5Sy090i/yxUbMTZIpZcbom1IDn6Z
         1yAhmWcr3zSIRKQ0sr524vPP43pa361Mtp4Rxyo9rJkvfWNstBZAs3udrLgANDpKGO
         7WgyGgmdu6/eLHajDcsGiYHfN0MsqBb67oz2PhxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 033/199] math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
Date:   Thu, 19 Dec 2019 19:31:55 +0100
Message-Id: <20191219183216.728995131@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincentc@andestech.com>

[ Upstream commit 83312f1b7ae205dca647bf52bbe2d51303cdedfb ]

_FP_ROUND_ZERO is defined as 0 and used as a statemente in macro
_FP_ROUND. This generates "error: statement with no effect
[-Werror=unused-value]" from gcc. Defining _FP_ROUND_ZERO as (void)0 to
fix it.

This modification is quoted from glibc 'commit <In libc/:>
(8ed1e7d5894000c155acbd06f)'

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/math-emu/soft-fp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 3f284bc031809..5650c16283830 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -138,7 +138,7 @@ do {							\
       _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
 } while (0)
 
-#define _FP_ROUND_ZERO(wc, X)		0
+#define _FP_ROUND_ZERO(wc, X)		(void)0
 
 #define _FP_ROUND_PINF(wc, X)				\
 do {							\
-- 
2.20.1



