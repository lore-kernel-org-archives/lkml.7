Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EC9C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9A6222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782772;
	bh=cogc0FukY8/3EVaRPufi7VD8ZbhSDT10BfN6/bzVrd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fygCJh251m69dlA/K9TklIGpJPUZvgwBovGqpxpdOkYLaIZC6Bgp8X0XAV5slJ6HK
	 lZuTO4S2Ty6hf8SxMFdOPZDWD5npLi1dFKtsksRP1tmAVHMbxSTKrdGaGrqtTTb/OK
	 Szq2JkbUovcwqXQInr9H5negJsTUiNQ291AtVm0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLSSgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfLSSgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411332467B;
        Thu, 19 Dec 2019 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780566;
        bh=cogc0FukY8/3EVaRPufi7VD8ZbhSDT10BfN6/bzVrd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2gT9hpdfHuY+VjYeiUWdQjcY5b46zFzJOSF3ktlRWr+pblatk7ZUljkuB6mv/4XV
         x7W9PIfRtT2qcZWqEMKQcSdMJ3yzy5z74kJg5AZibjoTfwAMC9g6NB8EsBGxpRQVbx
         /nRlH9p8EcIjqyiLZoIllKq39954m65MIJ5VDQRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 026/162] math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
Date:   Thu, 19 Dec 2019 19:32:14 +0100
Message-Id: <20191219183209.122498924@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
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



