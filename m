Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84982C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C59620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nnn9sNge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEFTBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:01:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfEFTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5TMyYRHgzNlyFc2iFg5V9iQsMZ2X4aG50vUoYbZ7Chs=; b=Nnn9sNgeJMf5Z4m5Fs+d34HxFv
        g723CsTM1OAwh8Hp6L93uy371AkHkPNghnvwY/3r8iTFTmwGPN0dNVhAiQh0esHuHBf5ZiU6h2dYY
        ZD1qHZBtcDHoeYgm3IFHeOzpBYdR3xkoSfXyVzXd5H/Cp24Y8qFF07yWe2VI/H3jtGIqMo2NS1DtZ
        qaImJu5w06Um2cdrROUrm9i14CdiQn8dFEx+JPb/z6Y+21Z3TCYx4rEK+mi819WCCPS+rr2Pe3vXO
        vWDRXpqXJHx49LNOZadPwConBqr98CF6byPqLZhSJQJmnMwS1s8QMpAvX79y+E4O6vhYju/SPh13K
        dnJyH4KA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNirv-0007ul-Pl; Mon, 06 May 2019 19:01:43 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: sound/soc/sof/: fix kconfig dependency warning
Message-ID: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
Date:   Mon, 6 May 2019 12:01:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for unmet dependency for IOSF_MBI when
PCI is not set/enabled.  Fixes this warning:

WARNING: unmet direct dependencies detected for IOSF_MBI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - SND_SOC_SOF_ACPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && X86 [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190506.orig/sound/soc/sof/Kconfig
+++ linux-next-20190506/sound/soc/sof/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_SOF_ACPI
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
-	select IOSF_MBI if X86
+	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for ACPI enumeration. This option is required
 	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices


