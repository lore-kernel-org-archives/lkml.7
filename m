Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45394C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB15222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640149;
	bh=0JRoVYLfjOMsUG7MhhFLuHdAGeIoBdfg1ZglyG3ftgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vp8nPe+/7MRZjqlPGTFEYrQRCEr+2OdvitCoHjC4aGYUkaSgil0DAsGvPLB5mEY6R
	 PQbcGBIbHrvurIJqQisGZgw0YpKYqGnacY8ivh7fzcCnUgFLV1Z+YHeZxl8enGITjf
	 fhCbt76XqjctpcxlUdmBKNEHC0wKrJETZLXMiy+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfL2RW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfL2RWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:22:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B0D21D7E;
        Sun, 29 Dec 2019 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640143;
        bh=0JRoVYLfjOMsUG7MhhFLuHdAGeIoBdfg1ZglyG3ftgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyX8keT2fFZcEIulljVIY4eHOdth9w7v6fNfR1YFBJDeIiZBBJpeybufvlMpC8dar
         4Ethm69GOSCL9C8LFbPLXKteqNBL2MHGblIRMI4LteKgCxixDMRybxpjk1f/DsxgzU
         VYooUUos1HZ/WrJi6JtO9YpUDuuycZLdqfYCNjDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/161] tools/power/cpupower: Fix initializer override in hsw_ext_cstates
Date:   Sun, 29 Dec 2019 18:18:03 +0100
Message-Id: <20191229162409.296910978@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 7e5705c635ecfccde559ebbbe1eaf05b5cc60529 ]

When building cpupower with clang, the following warning appears:

 utils/idle_monitor/hsw_ext_idle.c:42:16: warning: initializer overrides
 prior initialization of this subobject [-Winitializer-overrides]
                 .desc                   = N_("Processor Package C2"),
                                              ^~~~~~~~~~~~~~~~~~~~~~
 ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
 #define N_(String) gettext_noop(String)
                                 ^~~~~~
 ./utils/helpers/helpers.h:23:30: note: expanded from macro
 'gettext_noop'
 #define gettext_noop(String) String
                              ^~~~~~
 utils/idle_monitor/hsw_ext_idle.c:41:16: note: previous initialization
 is here
                 .desc                   = N_("Processor Package C9"),
                                              ^~~~~~~~~~~~~~~~~~~~~~
 ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
 #define N_(String) gettext_noop(String)
                                 ^~~~~~
 ./utils/helpers/helpers.h:23:30: note: expanded from macro
 'gettext_noop'
 #define gettext_noop(String) String
                             ^~~~~~
 1 warning generated.

This appears to be a copy and paste or merge mistake because the name
and id fields both have PC9 in them, not PC2. Remove the second
assignment to fix the warning.

Fixes: 7ee767b69b68 ("cpupower: Add Haswell family 0x45 specific idle monitor to show PC8,9,10 states")
Link: https://github.com/ClangBuiltLinux/linux/issues/718
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index f794d6bbb7e9..3e4ff4a1cdf4 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -40,7 +40,6 @@ static cstate_t hsw_ext_cstates[HSW_EXT_CSTATE_COUNT] = {
 	{
 		.name			= "PC9",
 		.desc			= N_("Processor Package C9"),
-		.desc			= N_("Processor Package C2"),
 		.id			= PC9,
 		.range			= RANGE_PACKAGE,
 		.get_count_percent	= hsw_ext_get_count_percent,
-- 
2.20.1



