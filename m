Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5693D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="okLiffP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfCFKZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:25:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49161 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfCFKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:25:00 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190306102457epoutp040f3174217fb76ce4991b7f7ae3e0739a~JV6GIl8QP1357913579epoutp04t;
        Wed,  6 Mar 2019 10:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190306102457epoutp040f3174217fb76ce4991b7f7ae3e0739a~JV6GIl8QP1357913579epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551867897;
        bh=QI3oIPxTSWLrK2Hdkbt5ELX8u7Zgdw3biwK+q9omWXA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=okLiffP1ng0Q0GEzcHEFn7u48hUOp9B5xO30XvLcf90tcqNOV2mc1HT5T+rsFKv+9
         O9Vw4KKCdwHbrallWk+dmP4NP2i03jwgGDGH0Cz8wlmNHN3c9RWldNMskagWtHTZYl
         qUt2iBl4Jw3Cuky2B6vzFr3eVB1jqBWDdK4HI7eo=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190306102457epcas2p109141d364dfae40d99b88e54b7839291~JV6F172DG2610626106epcas2p1P;
        Wed,  6 Mar 2019 10:24:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.39.04134.9FF9F7C5; Wed,  6 Mar 2019 19:24:57 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190306102457epcas2p136fcb099d5635ee498eefd17979fc880~JV6FnGkQz0486304863epcas2p1k;
        Wed,  6 Mar 2019 10:24:57 +0000 (GMT)
X-AuditID: b6c32a47-8c3ff70000001026-72-5c7f9ff928ed
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.64.03689.9FF9F7C5; Wed,  6 Mar 2019 19:24:57 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PNX00K2GWXCAJ20@mmp1.samsung.com>; Wed, 06 Mar 2019
        19:24:57 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: i2s: Fix DAPM routes for capture stream
Date:   Wed, 06 Mar 2019 11:24:45 +0100
Message-id: <20190306102445.1640-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCmue7P+fUxBi83yVlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgytp54yV6wWaBi77UvLA2M+3m7GDk5
        JARMJNbdWcvaxcjFISSwg1Fi0e8vbCAJIYHvjBK33/vAFO05eYodomg3o8TBnl8sEM4vRolr
        vXMZQarYBAwleo/2gdkiAtoSc252sIEUMQu8ZZSY92wXK0hCWMBdYv3pt+wgNouAqsSrLxOZ
        QGxeASuJ6fOOMEGsk5dYveEAM0izhMAENontzadYIRIuErdOX4UqkpZ4tmojI4RdLbFrezdU
        QwejRMuF7cwQCWuJw8cvgjUzC/BJdBz+C7SZAyjOK9HRJgRhekjM358G8XKsRPfjU8wTGMUX
        MDKsYhRLLSjOTU8tNiow1itOzC0uzUvXS87P3cQIjjUt9x2M2875HGIU4GBU4uGd0FoXI8Sa
        WFZcmXuIUYKDWUmEt2lufYwQb0piZVVqUX58UWlOavEhRmkOFiVx3ofSc6OFBNITS1KzU1ML
        UotgskwcnFINjKunMyve8jm6cmFbGWO2ZYTcZJG5sp5bYto4dlxqm5fm/VzuwsRqFeu3idxH
        Vvtl8Yje+RUqvVT87SYLkaq18xT5d+pfl1zYcym9jj9R7YvUbc0w9xXtC3im8gfsulRctzu0
        Ot974/YQNu8v3exTHXt76+M/iJbsmiu7M/m5TrfX4ogzv4RnKrEUZyQaajEXFScCAD9hFK2x
        AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xgO7P+fUxBp3z+C2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZW0+8ZC/YLFCx99oXlgbG/bxdjJwc
        EgImEntOnmLvYuTiEBLYySix/9sbZpCEkMAvRok1H11BbDYBQ4neo32MILaIgLbEnJsdbCAN
        zAJvGSUazrSxgSSEBdwl1p9+yw5iswioSrz6MpEJxOYVsJKYPu8IE8Q2eYnVGw4wT2DkWsDI
        sIpRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzBoth3W6t/B+HhJ/CFGAQ5GJR7eCa11
        MUKsiWXFlbmHGCU4mJVEeJvm1scI8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCeWJKa
        nZpakFoEk2Xi4JRqYBQ+Yil38mT1vukPL+7njpy/Jv7Crgty+mFril+GCIrdOflSzYDPtlJL
        yZbhuVbyp1vPp0bP4Jn66Ubu4hVCfLzhb8JKRNR/u3rO63/+4XZ48g45G0N+qWUyMyySl1x/
        +EyDt+yWtsXWuPWvPl+ye3h1mZPC7HcH/ubpTzWcqPmpvSPkNvOjI7uVWIozEg21mIuKEwE8
        GxvTFgIAAA==
X-CMS-MailID: 20190306102457epcas2p136fcb099d5635ee498eefd17979fc880
CMS-TYPE: 102P
X-CMS-RootMailID: 20190306102457epcas2p136fcb099d5635ee498eefd17979fc880
References: <CGME20190306102457epcas2p136fcb099d5635ee498eefd17979fc880@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets missing stream_name of capture part of the DAI driver
so we can define DAPM routing properly also for the capture stream.

While at it "Playback" suffix is added to the playback stream names
to clearly identify playback/capture.

Together with related dts patch this fixes NULL pointer dereference
when opening ALSA device for recording on Odroid XU3.

Fixes: 64aba9bca5bd ("ASoC: samsung: i2s: Add widgets and routes for DPCM support")
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4231001226f4..ab471d550d17 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1130,11 +1130,11 @@ static const struct snd_soc_dapm_widget samsung_i2s_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route samsung_i2s_dapm_routes[] = {
-	{ "Playback Mixer", NULL, "Primary" },
-	{ "Playback Mixer", NULL, "Secondary" },
+	{ "Playback Mixer", NULL, "Primary Playback" },
+	{ "Playback Mixer", NULL, "Secondary Playback" },
 
 	{ "Mixer DAI TX", NULL, "Playback Mixer" },
-	{ "Playback Mixer", NULL, "Mixer DAI RX" },
+	{ "Primary Capture", NULL, "Mixer DAI RX" },
 };
 
 static const struct snd_soc_component_driver samsung_i2s_component = {
@@ -1155,7 +1155,8 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  int num_dais)
 {
 	static const char *dai_names[] = { "samsung-i2s", "samsung-i2s-sec" };
-	static const char *stream_names[] = { "Primary", "Secondary" };
+	static const char *stream_names[] = { "Primary Playback",
+					      "Secondary Playback" };
 	struct snd_soc_dai_driver *dai_drv;
 	struct i2s_dai *dai;
 	int i;
@@ -1201,6 +1202,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 	dai_drv->capture.channels_max = 2;
 	dai_drv->capture.rates = i2s_dai_data->pcm_rates;
 	dai_drv->capture.formats = SAMSUNG_I2S_FMTS;
+	dai_drv->capture.stream_name = "Primary Capture";
 
 	return 0;
 }
-- 
2.17.1

