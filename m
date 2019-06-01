Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B12C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488862764C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396435;
	bh=qDTHW3V/7qE9KwP69AnCsB8AhB++Ec/yyyT8YyDxTM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQrP0yL11jtw2ixG7WtagNnqKJFo2LYp+7etauaN7LRheZ20CmWpR7C/wfb613JjR
	 9IodOAHXc4ALDNo5/Cj2EZVL8+vKMDNAK+xuIbfb4wRt3DYL/63E+Ud7qn5rGAPi45
	 SgtZOf1uJ20RiWoUffucT5sXYC6kBJ86N1Pib3JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfFANke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbfFANUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:20:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A42272E4;
        Sat,  1 Jun 2019 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395243;
        bh=qDTHW3V/7qE9KwP69AnCsB8AhB++Ec/yyyT8YyDxTM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtY3gLlcWCPNZC5BQiSlmtFCnZ4r3uJ3cwgVGdTUrZXguuGNeG0OAwPi9gb1oaJXz
         Lpdjb6lQbplvQFd24AF8Bb+fcSWlchXYGx+TjKs1AXFyZi5PVwA27TUKkc4rvn/3LP
         /pwe0QS2xF3a0VvINVErXueANZbclMv1LsdPTxtM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 021/173] kernel/sys.c: prctl: fix false positive in validate_prctl_map()
Date:   Sat,  1 Jun 2019 09:16:53 -0400
Message-Id: <20190601131934.25053-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrill Gorcunov <gorcunov@gmail.com>

[ Upstream commit a9e73998f9d705c94a8dca9687633adc0f24a19a ]

While validating new map we require the @start_data to be strictly less
than @end_data, which is fine for regular applications (this is why this
nit didn't trigger for that long).  These members are set from executable
loaders such as elf handers, still it is pretty valid to have a loadable
data section with zero size in file, in such case the start_data is equal
to end_data once kernel loader finishes.

As a result when we're trying to restore such programs the procedure fails
and the kernel returns -EINVAL.  From the image dump of a program:

 | "mm_start_code": "0x400000",
 | "mm_end_code": "0x8f5fb4",
 | "mm_start_data": "0xf1bfb0",
 | "mm_end_data": "0xf1bfb0",

Thus we need to change validate_prctl_map from strictly less to less or
equal operator use.

Link: http://lkml.kernel.org/r/20190408143554.GY1421@uranus.lan
Fixes: f606b77f1a9e3 ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Andrey Vagin <avagin@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb243..82ba11e6d2e50 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1923,7 +1923,7 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 	((unsigned long)prctl_map->__m1 __op				\
 	 (unsigned long)prctl_map->__m2) ? 0 : -EINVAL
 	error  = __prctl_check_order(start_code, <, end_code);
-	error |= __prctl_check_order(start_data, <, end_data);
+	error |= __prctl_check_order(start_data,<=, end_data);
 	error |= __prctl_check_order(start_brk, <=, brk);
 	error |= __prctl_check_order(arg_start, <=, arg_end);
 	error |= __prctl_check_order(env_start, <=, env_end);
-- 
2.20.1

