Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B821C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A71214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QtqpZJIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfCLRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:40:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14598 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbfCLRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:40:28 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190312174024epoutp030557a6a0e2b8ea05f71caea9d67d7af2~LRuAIOUhF2128321283epoutp03b;
        Tue, 12 Mar 2019 17:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190312174024epoutp030557a6a0e2b8ea05f71caea9d67d7af2~LRuAIOUhF2128321283epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552412424;
        bh=CvIWIPw2q6Sbq8KzQUZymMcT3if/BXDwLPRSYwHf9ro=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QtqpZJItnwp/Wcvpz4IyVfnnITIHVDytHAwAKwqq1IIchQsaPDxbSqH9XqmqmqKON
         3QsXKtexEMjfq+tN4k+DK/lYzU3aRNc7c3mXKs9NA1pqo51f3ScTui7bMEkoF/ljLv
         ZwvWDiq7MRkq6zv0xjIGO8+yQXqZ+y+9wyLjLsqw=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190312174024epcas1p49f13a2adc59c082f695c31e1cf23831d~LRt-qv5570911009110epcas1p4K;
        Tue, 12 Mar 2019 17:40:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.E0.04108.70FE78C5; Wed, 13 Mar 2019 02:40:23 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190312174023epcas1p32bc468e295974dadc7c6e510e467e665~LRt-FYPbM2724127241epcas1p3A;
        Tue, 12 Mar 2019 17:40:23 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-37-5c87ef07168b
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.4B.03598.70FE78C5; Wed, 13 Mar 2019 02:40:23 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PO9000EIL30EK60@mmp1.samsung.com>; Wed, 13 Mar 2019
        02:40:23 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     sbkim73@samsung.com, krzk@kernel.org, jcsing.lee@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Fix clock configuration for 44100
 sample rate
Date:   Tue, 12 Mar 2019 18:40:06 +0100
Message-id: <20190312174006.32174-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCmni77+/YYg93nbCyuXDzEZLFxxnpW
        i6kPn7BZvN3fzWxx/vwGdotvVzqYLC7vmsNmMeP8PiaLtUfuslscftPOanFxxRcmB26PDZ+b
        2Dx2zrrL7rFpVSebR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXs2vqLteAAT8XDSxsZGxin
        cXUxcnJICJhItB8+z9rFyMUhJLCDUWLp7Q4mCOc7o8SHq60sMFUHZ9xih0jsZpSYPO09I4Tz
        i1Fi/pJtYFVsAoYSvUf7GEFsEQFtiTk3O9hAipgFWpkk3m+fzQ6SEBYIl+jasQnMZhFQlTh5
        dTJYA6+AtcTCjoNMEOvkJVZvOMAM0iwhMIFNouPfEjaIhIvE7+a5QNs4gGxpiUtHbSFqmhkl
        djy/xg7VwCgxYc5kqAZricPHL7KC2MwCfBLvvvawQjTzSnS0CUGUeEicb3gNtlhIIFaicf07
        1gmM4gsYGVYxiqUWFOempxYbFpjqFSfmFpfmpesl5+duYgRHnpblDsZj53wOMQpwMCrx8DJs
        ao8RYk0sK67MPcQowcGsJMJrkQMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrvewTlGSCA9sSQ1
        OzW1ILUIJsvEwSnVwHjwWLLbqlVhoQ9c21Or3PmYJpUKV83sz89z5WOIWjZDPfRXTM0S99VF
        Kz8UJ5nPmbwjyepeRpxerqKqVtpc5Sct4bXpuVKzYiVX/pjL6Gi7O7RDsvTzn8v1F3gjPy/6
        Fnz5YshB9YKF5+NXnm+Ndlu5MLPlaYnQfdcLPgobZy244sIdvVntqhJLcUaioRZzUXEiABcs
        WM64AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkluLIzCtJLcpLzFFi42I5/e+xgC77+/YYg4dfJCyuXDzEZLFxxnpW
        i6kPn7BZvN3fzWxx/vwGdotvVzqYLC7vmsNmMeP8PiaLtUfuslscftPOanFxxRcmB26PDZ+b
        2Dx2zrrL7rFpVSebR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXs2vqLteAAT8XDSxsZGxin
        cXUxcnJICJhIHJxxi72LkYtDSGAno8S5yWdYIJxfjBLvb3SxglSxCRhK9B7tYwSxRQS0Jebc
        7GADKWIWaGWSeL98E1iRsEC4RNeOTewgNouAqsTJq5PBGngFrCUWdhxkglgnL7F6wwHmCYxc
        CxgZVjFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBAbQtsNafTsY7y+JP8QowMGoxMOb
        sLs9Rog1say4MvcQowQHs5IIr0UOUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGAK+ESdlWTv1hgXtfflzAsc77WYSYzfF2496t4vtfblFe8KJoquuN
        6Y9OO7sWWmiGJVw+W5J/sr7zhPRXFXfjoMvLWPNFq3W5rx1RTlgtsFWbz+e8dADLsxMXJRbw
        +95/n9Ba7vqycHJq567vATdenZFiqmbpus99SfTLldWNa82rrXi5HYOUWIozEg21mIuKEwHs
        ydQwHAIAAA==
X-CMS-MailID: 20190312174023epcas1p32bc468e295974dadc7c6e510e467e665
CMS-TYPE: 101P
X-CMS-RootMailID: 20190312174023epcas1p32bc468e295974dadc7c6e510e467e665
References: <CGME20190312174023epcas1p32bc468e295974dadc7c6e510e467e665@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate
handling") the audio root clock frequency is configured improperly for
44100 sample rate. Due to clock rate rounding it's 20070401 Hz instead
of 22579000 Hz. This results in a too low value of the PSR clock divider
in the CPU DAI driver and too fast actual sample rate for fs=44100. E.g.
1 kHz tone has actual 1780 Hz frequency (1 kHz * 20070401/22579000 * 2).

Fix this by increasing the correction passed to clk_set_rate() to take
into account inaccuracy of the EPLL frequency properly.

Fixes: fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate handling")
Reported-by: JaeChul Lee <jcsing.lee@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/odroid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 694512f980fd..1dc54c4206f0 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -91,11 +91,11 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/*
-	 *  We add 1 to the rclk_freq value in order to avoid too low clock
+	 *  We add 2 to the rclk_freq value in order to avoid too low clock
 	 *  frequency values due to the EPLL output frequency not being exact
 	 *  multiple of the audio sampling rate.
 	 */
-	rclk_freq = params_rate(params) * rfs + 1;
+	rclk_freq = params_rate(params) * rfs + 2;
 
 	ret = clk_set_rate(priv->sclk_i2s, rclk_freq);
 	if (ret < 0)
-- 
2.17.1

