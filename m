Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926CCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CCD2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420609;
	bh=iORbwAUQT32YOs7L6orzyi2v9UCPskwpAZJBMgtZrms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAVC4AtaiIa7wV16oD9CTGMrqqG0Ne2EyXicg+Pt8QIuLNnqGzhRd5C1RP3U0OgTl
	 Emchen7ZbjdbxgFP8Ea4KRWdaGmyDFLZGHn+lYvG937e9d/Hsd8OmUvypshc6o9wbw
	 2Nsvci5kuSqmRgq4X4saXuQeoLk0jah5Irwa9A7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfKVLD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbfKVLDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE182075E;
        Fri, 22 Nov 2019 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420591;
        bh=iORbwAUQT32YOs7L6orzyi2v9UCPskwpAZJBMgtZrms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1ZMlQAmLJ4WhGDxENgt6zqmwgHJPvU8OC1iW2WIBvSEsarjX9tBsa1Gi0VgKWfR+
         PLS8tTTp1OYloslvoB1VmjNLMDtd2RYMFJIP3TPJx/s6naKWgh1WFyzEhJZZkNSaE8
         pJv9l92XxsXJz8deRK3ioG92avT4kOlFdm0VOLrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 158/220] platform/x86: mlx-platform: Properly use mlxplat_mlxcpld_msn201x_items
Date:   Fri, 22 Nov 2019 11:28:43 +0100
Message-Id: <20191122100924.075147228@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8289c4b6f2e53750de78bd38cecb6bce4d7a988c ]

Clang warns that mlxplat_mlxcpld_msn201x_items is not going to be
emitted in the final assembly because it's only used in ARRAY_SIZE right
now, which is a compile time evaluation since the array's size is known.

drivers/platform/x86/mlx-platform.c:555:32: warning: variable
'mlxplat_mlxcpld_msn201x_items' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static struct mlxreg_core_item mlxplat_mlxcpld_msn201x_items[] = {
                               ^
1 warning generated.

It appears this was a copy and paste mistake from when this item was
first added. Use the definition in mlxplat_mlxcpld_msn201x_data so that
Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/141
Fixes: a49a41482f61 ("platform/x86: mlx-platform: Add support for new msn201x system type")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/mlx-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 742a0c2179256..d17db140cb1fc 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -575,7 +575,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_msn201x_items[] = {
 
 static
 struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data = {
-	.items = mlxplat_mlxcpld_msn21xx_items,
+	.items = mlxplat_mlxcpld_msn201x_items,
 	.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn201x_items),
 	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
 	.mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
-- 
2.20.1



