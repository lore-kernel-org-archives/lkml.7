Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2910C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E120861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfFQLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:06:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfFQLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:06:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MF35K-1hsBX83HGi-00FX24; Mon, 17 Jun 2019 13:06:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        simon.ho@synaptics.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cx2072x: mark PM function as __maybe_unused
Date:   Mon, 17 Jun 2019 13:06:15 +0200
Message-Id: <20190617110615.2084748-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:imZ+6nmN3JNLX3mmZ/m85Tw3DUGLuQRqfp+OHv0e6v8Sna1BTqb
 Ia0NkHUM0xOVTKecq7eJVkaHlweKCwVnWwuER+8zeP2Hz09xud7svdcbfGvspIytpP3UE0k
 jm+h/cewI2Dtv5LN95ENIk3DIIcvb+9z6TkyhTyIbk9snxwrP+i48H8bY+xJzBfbU8Roz14
 FevkcIEAZMFuRlJOjH38w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UWLRdc/oTTw=:LHC1wNVDSBgYr0e7hr3Y2a
 wVXYdnSRqTmZB8VMYxiVgLIa9BL3ZZ5VZpQNxxRjyG6Mtp2EN4cVv1/pUW0gVzsHnEuArbhg0
 1rEpVDQTWwW0NDzXrt6WQRO+7vcq9mtVdskwNjKU0QYdvvjePsBHcuZ85jDWoZC/cidNj8wey
 J7yTYoAjgdMaFy3PGgJbr6ZFmaJwQt73Lo1RXqDwkvipxqs+yXqJSoDGTtBkYOb9gnPCwsZRS
 3CyZ7cVtAgNeOFfc4ksfRqPVNwojfCfhXDZOhLyktpv/S57Xhn6IPMSUuvy8i4i3WCWauIOYd
 SFoIcidvUvCcekS9JW0LXYvyMccJqESJG6kDY3vpjENpPpKREvm4Z/K2TCR4pmBIqK5D06LZr
 xgBNNQzI1C2We5i6+ow2wyvvOc7Z3wlwGxVXtuDtWpSxcRtn+NYpcpBlhPwRvt7md06RKF1tF
 GfP5pif9+vPkUrbrjBc2PuGOe8ddC8SJPUDRWSOZXcrOYvhuA46Gip4g58CZCw1H8R9K4wjSs
 D4Mh9JtLq+rALuzsOxIQMng8iNCVKdkJrC+wpbHk65C0Ac3Z/2vZD9gF7q5zlXmCAXhgUp/vj
 HVAN3ZMo2i2KZQiw7xO8UkG5aADAAnI76lSafwybmtphKuEsccFGMqjz7rkm1GYBOrrQrKAqC
 uk+C7XGnBVSySyV/sTJMEXBLzVIDXUMb+uE6AOYSkchln31VcMCFhRWMtip1bl8zvoTyljWV8
 sEWIlOh7XBBVwpoVMVL/f9/+KMyaL3JA4OMzdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the suspend function is already marked __maybe_unused,
the resume function is not, which leads to a warning when
CONFIG_PM is disabled:

sound/soc/codecs/cx2072x.c:1625:12: error: unused function 'cx2072x_runtime_resume' [-Werror,-Wunused-function]

Mark this one like the other one.

Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index f2cb35a50726..1c1ba7bea4d8 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1622,7 +1622,7 @@ static int __maybe_unused cx2072x_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cx2072x_runtime_resume(struct device *dev)
+static int __maybe_unused cx2072x_runtime_resume(struct device *dev)
 {
 	struct cx2072x_priv *cx2072x = dev_get_drvdata(dev);
 
-- 
2.20.0

