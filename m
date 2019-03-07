Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68515C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF4920835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCGKMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:12:37 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:12:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpDRv-1gjnOl0S9X-00qi2m; Thu, 07 Mar 2019 11:11:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tony Lindgren <tony@atomide.com>,
        Kees Cook <keescook@chromium.org>,
        Vishal Thanki <vishalthanki@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM
Date:   Thu,  7 Mar 2019 11:11:30 +0100
Message-Id: <20190307101145.636705-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k4DDxjibd8u11zOsPD7lZAVg/Zeo4oJO0PYetGd3gbXntL9v0Hc
 AYtFbBGvYEPhSGEF457096RqdOSZCEXJSDK9RIET+JNa1sOOrp1M/Ai9XyzwTqSEhx0mhKR
 7Qpt40zFtoHG0j1rIpitct4VODtmyMd2xy5FChig9UsOOf0e62GXl7TsyuFHDtIWDBTST6A
 7Ym+9KSwolmfdC7krcf0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aUhG0xnewKU=:uMK/tCaRRGiBWJ22FZMROg
 mUaoGPAR2iN9yXx0MVBRtC7A3d8qiEgyCY4chbEok1tZrhqgt38+94ydS1uRsTmfM9TKR3a+8
 CE90Pr42BbHOzx3RngXMighOOetzJcA+l3oHqnFP0O6sKQwyn3kVUFmE48OlapO59DOYEEfA+
 IFn2cNK/UbrrE/iltMMfzpszLUlJRgXCFPIBrtGKgybzhScpwQ+SWDtvWAJXSY+x0SXPJgksk
 d6u9L6QrWdH0vL9GujyHbM5HCpeEP/4mfE6zvmb4KF3JmSM1jYjNC3RWmdeOHwir7xuWPhZNR
 0azzbsFMJg+QSlzF9JPkRxy6YZc/6cP8BimW+PMAmkBuh37s9R4OVw9XvqeLMnIcOXCbGLJ8g
 rpsEMOMxxkzIn46wJt+2v7xYAPuYZ8EVl4PzNLOnE3RUGFEieIN2CLI0CTv+7R2Fp26P9uxaI
 5DoXMe1pTkxPYeDr3nDANmfNDnIc3ea27i1KhVpYLAyCDoUx2GiYwlPt+UscNvFs5ybCFFqCW
 mpg9y9j1GZeybeygtK+N1tq69JSpkH8o+ff6dDJPOaXrKb1DrHoUAdtvy4V5F4RaEYwrd0cvL
 EU1tIDpwyXKC1bHyGnaxB6WC2z7sdkDwgRUQy5pjp126kXaNqP/I9BwjNr5WCvgVLTeSYo3i0
 M+CPXekxc5aBbB/uPZed50KW0UhcJjdZl9pKngxqJ3Q2+qDRUZAO1QM/E9DmQwS590S7DV9wL
 A9aVHX9iVYOKXodCV6+lJudSK8cI66xkTWkn7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with clang shows a variable that is only used by the
suspend/resume functions but defined outside of their #ifdef block:

sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted

We commonly fix these by marking the PM functions as __maybe_unused,
but here that would grow the davinci_mcasp structure, so instead
add another #ifdef here.

Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/ti/davinci-mcasp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a3a67a8f0f54..9fbc759fdefe 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -45,6 +45,7 @@
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
+#ifdef CONFIG_PM
 static u32 context_regs[] = {
 	DAVINCI_MCASP_TXFMCTL_REG,
 	DAVINCI_MCASP_RXFMCTL_REG,
@@ -68,6 +69,7 @@ struct davinci_mcasp_context {
 	u32	*xrsr_regs; /* for serializer configuration */
 	bool	pm_state;
 };
+#endif
 
 struct davinci_mcasp_ruledata {
 	struct davinci_mcasp *mcasp;
-- 
2.20.0

