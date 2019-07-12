Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F04C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FBB20863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfGLI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:56:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLI4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:56:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCsDe-1hd5uB1CKW-008uVX; Fri, 12 Jul 2019 10:56:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wen Yang <wen.yang99@zte.com.cn>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: audio-graph-card: fix type mismatch warning
Date:   Fri, 12 Jul 2019 10:55:53 +0200
Message-Id: <20190712085605.4062896-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hsib/dpx4KDn7gfpU/f1Eq1bfZtFdE4qTB4i+zaN8zo+qEctdR3
 RKhbz0fWRM/pmG+ONdUgpTK6N83UxgmjuGxUxS7I+VEOkD9WOzCJOk4ZXdWmO7duzQNCSei
 A5NbDsnu3Sc6uMaOzDDc1fb0aJb5+RDDmrBVPEgI2QA6jlwg3/3937dYE5w8TcKd4KK1pOZ
 deGBhKhCt9y0/q8rpEaKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9OQC5DGb9s=:T6H67ZX8mqNhVjA447wWxh
 0xlDBQb6lbn9z8MwFJsVML6VitaX0n5WZCMegYpH2Jy0StVWv8lATqy/cHcn1tV+fKPAmiRhZ
 oHt/SGJfCX5s0+doh3Nf+k7pjQ9PH4qbuyia0jUmUCgqbQDSy9gl8EFegYzMvdeIffdUZlg+s
 6Sp7mKoJ1Ib3ka35DJzEpUrBWTPTN0n/SsrjYVsfHUXSeZSv7PF0hVM1/TH1bfXHA8xus7U2b
 isWiB7dFfUrW2bmfT/wRvgUKzPh/LkI/pcx00uSfTZc8yXEZbf6VY6fIz1xZ3Y7A5kSHvBBsi
 RuNMBXRhXQ1tf9uQUbTFGKJZmqXfCAkJzridws1PtHvOf8guQ0mhwkPADX/CjxraTT6Fx/cxk
 AswHICK7T/BCJii8NKWbmbGkUoiHDEYx3kTNC7Rb9+dD3jC2N82iRhxp2upDjBuBuf02MooPu
 QhIyEwkywdDOj6PxT7gTQxEO4MPvXcuw8yp45I8IiTtFFqt+SV5YNbn9Z3DTdS32BFr3T2UXC
 +1xGHKziI8ziqs+LGMsO/tozcLt2dza/qDnNx4j8MkzgxFB15O2oZA3IZWgZ+poZrEdmoYLY4
 sHvztlc6Q8LopIyPGAGE1X2vxh+wginAcrEuHK3wh+q7fsGJmPew8aodII75QTI6Rfp5o0FYW
 69ehGjuQkxZS5E1Ordsxhvy4mIfmW0dw6ebuxgojymabC/wA87Rc8aAPZiC8pccQuKHK35sx6
 DDbKua9LRG55+5mjhlfjSZ7drvWb4qT2eFa8tA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new temporary variable is lacks a 'const' annotation:

sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *' (aka 'unsigned int *') from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c8abb86afefa..288df245b2f0 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,7 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
-	u32 *reg;
+	const u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
-- 
2.20.0

