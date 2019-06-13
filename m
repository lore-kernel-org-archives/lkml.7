Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B26C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6586F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442104;
	bh=UXoZFXbmAYWVKUlLCYdPj49jM/V8bst94dDdbenuEZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lt5/hW7eC4E0I/WOHudlYOYx8w7d3BYQbjqyNeKzl79SptQNOD0k66DBqhATpog2w
	 7K5kHtqDRXF03a5zLOeWDPdKqMf2oQ/LMdaLWq2GFYgFh1kRHtwAl7cUhXpPC1/fTq
	 xO1i3a4sXKg76AWW5a8tTH75tWzgL7j8n1GPyON8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbfFMQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbfFMIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10A72173C;
        Thu, 13 Jun 2019 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415501;
        bh=UXoZFXbmAYWVKUlLCYdPj49jM/V8bst94dDdbenuEZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3CkTmsZKB2rFVeU5hnnbGCLUdZf3gZS5kNFqrMx9aXhs5xt4Ybp/VPF/8BTIvaFh
         GbGYcglL9Hal7CZOOxXY5e301ZeFXcn14fjP4Cz+x+wZyrq7/F0ZJDCmPTXoyevzpQ
         h09uRS11wEzqW0PeFiGJjzB3lc9nYPqMttftMBYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 024/155] kernel/sys.c: prctl: fix false positive in validate_prctl_map()
Date:   Thu, 13 Jun 2019 10:32:16 +0200
Message-Id: <20190613075654.152661327@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 12df0e5434b8..bdbfe8d37418 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1924,7 +1924,7 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
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



