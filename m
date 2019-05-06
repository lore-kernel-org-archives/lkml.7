Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9697A21655
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153456;
	bh=CKsQSdAvYcNcqiJXrGe17uJIj296AwqzVPBLKuA2Mws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lr8NNRrbiWQC7+rhT5XMYObYq6nRolPBVbHu+I/Oa0A1JmseF57vLAhfMlQJKzWRp
	 nzK6HRQaVOXz62B1mqVH+NstASwxaffFqotFslp+2j9Z1SsRlDq7npm1GB6sC/OxWA
	 gvKyXLKnB5I1HJBETqD+VVsHw7aNWQyPq/atYSkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEFOhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfEFOhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:37:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEBC206A3;
        Mon,  6 May 2019 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153450;
        bh=CKsQSdAvYcNcqiJXrGe17uJIj296AwqzVPBLKuA2Mws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cV9XKcYBwS5NmQ0ch18bpTIkPdqWW5wnxzOH0aAhu/WjQusVcewvXWmplRPUKrsCJ
         BoPrStoqgJqbxf3hZvj6xxgk3Fr/bribO2lmsqpNkEkBJiUEcT3WKulMAf72upr4IF
         uAGVChnGe1MLvy2mdkjRt1JVBdi50/1qle7xIxkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 094/122] ASoC: Intel: bytcr_rt5651: Revert "Fix DMIC map headsetmic mapping"
Date:   Mon,  6 May 2019 16:32:32 +0200
Message-Id: <20190506143103.246989208@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit aee48a9ffa5a128bf4e433c57c39e015ea5b0208 upstream.

Commit 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map
headsetmic mapping"), changed the headsetmic mapping from IN3P to IN2P,
this was based on the observation that all bytcr_rt5651 devices I have
access to (7 devices) where all using IN3P for the headsetmic. This was
an attempt to unifify / simplify the mapping, but it was wrong.

None of those devices was actually using a digital internal mic. Now I've
access to a Point of View TAB-P1006W-232 (v1.0) tabler, which does use a
DMIC and it does have its headsetmic connected to IN2P, showing that the
original mapping was correct, so this commit reverts the change changing
the mapping back to IN2P.

Fixes: 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map ... mapping")
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/bytcr_rt5651.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -266,7 +266,7 @@ static const struct snd_soc_dapm_route b
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 	{"DMIC L1", NULL, "Internal Mic"},
 	{"DMIC R1", NULL, "Internal Mic"},
-	{"IN3P", NULL, "Headset Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {


