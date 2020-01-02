Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E56C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA87220863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004127;
	bh=dpgVr1QVj+B+LzMWGayZ6JEGYI7stkUsUlNTDoGhtTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tXCB5lebK38Zdn3xGAOkRu9zJBZmvxqgD2WCsrPQ36bOta3Layh5B5QrkQTbp6MT1
	 I7Kp3h0EQA2J+ZxyrgpJos6lGn9Wro/0EMuUNsegI3LrQ3XuRP1tAkek3/W2/giNkR
	 htCjKR2YA1nXbYNhyTiYNfzdk4mddcHw8T96H/aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgABW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgABW2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:28:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74FD920863;
        Thu,  2 Jan 2020 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004123;
        bh=dpgVr1QVj+B+LzMWGayZ6JEGYI7stkUsUlNTDoGhtTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0O751zAgl7YQs/LYFwSS5M/USUw/8jKMDGnteMF4lrKyg1dtlLBBlQSZLtn/dWMlQ
         b7SQa+IYEBfzd21EfsBkxlhqwBI2ZwXLICVyT42hJ+ugyHJe7JZlkFfNwPRopzRnT+
         DPxbzvPdCgBqrPXoHXrPEpnJc1Z+bL3opQc+kjZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 020/171] tools/power/cpupower: Fix initializer override in hsw_ext_cstates
Date:   Thu,  2 Jan 2020 23:05:51 +0100
Message-Id: <20200102220549.839553799@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
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
index ebeaba6571a3..475e18e04318 100644
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



