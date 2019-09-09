Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CAB21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391546AbfIITwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:52:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731163AbfIITwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:52:11 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1x2P-1iIZj622rR-012H2S; Mon, 09 Sep 2019 21:52:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Evan Green <evgreen@chromium.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: work around snd_hdac_aligned_read link failure
Date:   Mon,  9 Sep 2019 21:51:43 +0200
Message-Id: <20190909195159.3326134-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gapkT++dW/u0T3Hv/dXCemLrT+qeHLxTRC7Df4YYvlCWiLXXb89
 Z9FHg4c/nG9ra4DLNXZ0PcJkJ7cnzAgDLI6ZwLI2is1EJmyHtbzJ3bvrf9t7OAGaA1Xn95Q
 +47ZpbYw45l5GBldArJvAbecHUuaQrpMktX/zG9Oevaff1iVX4FBt2UzsNtCup/0u7N+0+S
 pB2ej5Z3stbRaf0bHVyaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5We9ZmG2fbc=:bEn6ODlb9DT5uU5/ve/uek
 jLpamsrcMYhJNidVceg3twMkEVGkFUVfweyUIBg9ZjGWYw0KFGjM9oqjtjVEoU49fBkoBK2ar
 cGn49aGt6XSME7QBKqMW0DZniDdBTMlReapev877tM6J1bfFRsDTIW97rXmCwV2AARRX/5iY/
 XS+FjfaVDqJIBs8jNX6zd8sczJtRsEErVhwgWiq37BSVsFPfX65neuWJpFRhngDztD6MkziWd
 0XWXSIPcqcA8tjRybiYT+wZZVqGXgT6usyiGu+06UWY5pYL162znoOSEkLyYbLlXrZrmchloG
 HKjT58PqGoPurmn7/cGfYjpc2aLBQQvSaRPBHLUMsXmyS/6S4wK2HD3tIvl0JVr89HxIRBq4L
 PtvTyJhM6esx3WeQ/YpBhZ05IdQqC2o3mdgbarzPtD+KcPg4hdR1dI17NsuCOhNI6ZNYxSR4J
 DyK7Vy5/9K0Lf7QRW8Av3VyEByNCql4GkifPCvW/JHCWebRJRcIrCnfN+PkzQ5kRMg1dzeIMR
 gHqVFJ6gaHYT9xmqjt6iHqFrZdUDy0dUb3l1gk+AW2OpjZhawPPNIbpf7Lakvedm6TqL9sCK+
 6Vy5I7r6Ej40l2jlxkLSIZ5hexbkIhux9dX2fyWt/z1sIzDXNImJEXFXnoDTL0cOFUfY8ocSs
 z831na6maxRBhKU/61FRzwoOSmWuLZ/qBTsDjLhiVJYFz61WkOslDA0j/EeEi3wjJq+zo/b7O
 h7vPC8XdHnbLotL9o/RrE7BK4Mqg9fuupc7KB4/aMQM5/vFlk3mKByAIBFcBE3pEHHmED9YED
 fBURvS36QpmMJaVD4SiLx8cfQOllWS04/4z7SCHagt7PzHHSs8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SND_HDA_ALIGNED_MMIO is selected by another driver
(i.e. Tegra) that selects CONFIG_SND_HDA_CORE as a loadable
module, but SND_SOC_SOF_HDA_COMMON is built-in, we get a
link failure from some functions that access the hda register:

sound/soc/sof/intel/hda.o: In function `hda_ipc_irq_dump':
hda.c:(.text+0x784): undefined reference to `snd_hdac_aligned_read'
sound/soc/sof/intel/hda-stream.o: In function `hda_dsp_stream_threaded_handler':
hda-stream.c:(.text+0x12e4): undefined reference to `snd_hdac_aligned_read'
hda-stream.c:(.text+0x12f8): undefined reference to `snd_hdac_aligned_write'

Add an explicit 'select' statement as a workaround. This is
not a great solution, but it's the easiest way I could come
up with.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 479ba249e219..9180184026e1 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -248,6 +248,7 @@ config SND_SOC_SOF_HDA_COMMON
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_HDA_LINK_BASELINE
+	select SND_HDA_CORE if SND_HDA_ALIGNED_MMIO
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
-- 
2.20.0

