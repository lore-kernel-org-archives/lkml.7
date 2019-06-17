Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF1C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCC62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfFQOXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:23:44 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:59192 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:23:44 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id RqPP2000J3XaVaC01qPP2r; Mon, 17 Jun 2019 16:23:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsXZ-0002FM-Vp; Mon, 17 Jun 2019 16:23:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsXZ-0000ld-Tm; Mon, 17 Jun 2019 16:23:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joe Perches <joe@perches.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [RFC] get_maintainer: Really limit regex patterns to words
Date:   Mon, 17 Jun 2019 16:23:20 +0200
Message-Id: <20190617142320.2830-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit file and directory regex matching to paths that contain the
pattern as a word, i.e. that contain word boundaries before and after
the pattern.  This helps avoiding false positives.

Without this, e.g. "scripts/get_maintainer.pl -f
tools/perf/pmu-events/arch/x86/westmereex" lists the STM32 maintainers,
due to the presence of "stm" in the middle of a word in the path name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What to do with drivers/pwm/pwm-stmpe.c, which is no longer caught?
Add a new pattern to MAINTAINERS?
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420e68a..a34057d87a56492f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -884,7 +884,7 @@ sub get_maintainers {
 				}
 			    }
 			} elsif ($type eq 'N') {
-			    if ($file =~ m/$value/x) {
+			    if ($file =~ m/\b$value\b/x) {
 				$hash{$tvi} = 0;
 			    }
 			}
-- 
2.17.1

