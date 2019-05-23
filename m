Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BECC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8362175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfEWUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:36:40 -0400
Received: from gateway36.websitewelcome.com ([50.116.126.2]:13640 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387533AbfEWUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:36:40 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id D0CF3400CA8DB
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:56:45 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TuS6hkbv5iQerTuS6hMAUo; Thu, 23 May 2019 15:36:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=35004 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTuS5-000Pmx-UO; Thu, 23 May 2019 15:36:38 -0500
Date:   Thu, 23 May 2019 15:36:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: dapm: Use struct_size() in krealloc()
Message-ID: <20190523203637.GA14197@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTuS5-000Pmx-UO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:35004
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding the
size of a structure that has a zero-sized array at the end, along with
memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = krealloc(instance, sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, use the new
struct_size() helper:

instance = krealloc(instance, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b71ddaca70e5..511ed84b147b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -487,7 +487,8 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 		n = 1;
 
 	new_wlist = krealloc(data->wlist,
-			sizeof(*new_wlist) + sizeof(widget) * n, GFP_KERNEL);
+			     struct_size(new_wlist, widgets, n),
+			     GFP_KERNEL);
 	if (!new_wlist)
 		return -ENOMEM;
 
-- 
2.21.0

