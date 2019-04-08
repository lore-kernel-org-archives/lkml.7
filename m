Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10316C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11DA20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708671;
	bh=FjoJknlPr1qwJ5xICgd3EHIPOiGxx4t5Tj7zvzW8NHI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KKi1mRBCZDLeYSJUZAVxGsgqph75IUupnXEesesbUQYmr7oJO6b/jm+YqY4UE7ZAx
	 2elXANwr4BMvmOLQf8bh/2cGGVSoEAJoajxi0e3ntfiXR30/t69l2b5IexXOtiGvWq
	 QX05Fgta6w7J9O3qxaXAy6Rr14wrqdZUqpD2OcVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfDHHbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:31:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+KI9tYfIMh+7suFHxCnx1xXtMrkPvZE1aBidoCQQUDw=; b=NY+1Enae4DzP
        CwMxHmCxTZDDdMRa+WYODtmRS7LweDI+ODVdHRdoyRtMPgt3UZ4BKp6xkkerdXfX6JlNAKzFHw/nm
        QJafq5psHUqDJ7fynCWBHin5TFm7K7/fwpPe4Sij27prQ5/sgG0099779WUqZ7Qd7gkpM1GAUD6iB
        /mB6Q=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOkD-0003vo-Pt; Mon, 08 Apr 2019 07:31:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1B101441D3B; Mon,  8 Apr 2019 14:30:56 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Nicholas Mc Guire <hofrat@opentech.at>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "ASoC: ab8500: add range to usleep_range" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190408073056.1B101441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:30:56 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ab8500: add range to usleep_range

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 45a310136b3ed52267e757c57e835f583140aa5f Mon Sep 17 00:00:00 2001
From: Nicholas Mc Guire <hofrat@opentech.at>
Date: Sun, 7 Apr 2019 04:59:34 +0200
Subject: [PATCH] ASoC: ab8500: add range to usleep_range

Providing a range for usleep_range() allows the hrtimer subsystem to
coalesce timers - as this delay has no upper limit anyway (interrupts
or context switch is possible) it should not hurt to extend this
from 2 to 2-4 milliseconds.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 03bbbcd3b6c1..dac207dc5b65 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1062,10 +1062,10 @@ static void anc_iir(struct snd_soc_component *component, unsigned int bnk,
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT),
 					BIT(AB8500_ANCCONF1_ANCIIRINIT));
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT), 0);
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 		} else {
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRUPDATE),
-- 
2.20.1

