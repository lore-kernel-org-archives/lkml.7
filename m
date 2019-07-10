Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1BC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2122064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGJH3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:29:10 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:64506 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfGJH3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:29:10 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id B55A27F94F288FAB2B71;
        Wed, 10 Jul 2019 15:29:08 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6A7RUab070756;
        Wed, 10 Jul 2019 15:27:30 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071015275036-2237130 ;
          Wed, 10 Jul 2019 15:27:50 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/4] Fix some use-after-free problems in sound/soc/generic
Date:   Wed, 10 Jul 2019 15:25:05 +0800
Message-Id: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-10 15:27:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-10 15:27:33,
        Serialize complete at 2019-07-10 15:27:33
X-MAIL: mse-fl2.zte.com.cn x6A7RUab070756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We developed a coccinelle SmPL to detect sound/sooc/generic code and
found some use-after-free problems.
This patch series fixes those problems.

Wen Yang (4):
  ASoC: simple-card: fix an use-after-free in simple_dai_link_of_dpcm()
  ASoC: simple-card: fix an use-after-free in simple_for_each_link()
  ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()
  ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()

 sound/soc/generic/audio-graph-card.c | 30 ++++++++++++++++--------------
 sound/soc/generic/simple-card.c      | 26 +++++++++++++-------------
 2 files changed, 29 insertions(+), 27 deletions(-)

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

-- 
2.9.5

