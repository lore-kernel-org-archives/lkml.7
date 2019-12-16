Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1937C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD44520726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519420;
	bh=zr40ijXVMEOd8x6/Kipd24NfEl4lgp/N8U1A6J9z/vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ynPAnHu3iQM+SxvuuA2GOYyvXjc4Ga62KU3YEZGLBLqa3JDzNnwtA/l3O4VflU7sr
	 8YU2wECOcuM7sjdj5sRkxZz+2VOztNTUvL/feOcJUUItWjIEF8zerR8D4phYn5yyqC
	 lOP+Bxp8PoeVlpmT9K/SwM1rycotQOVp6nkbAPBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfLPSDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfLPSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB0520733;
        Mon, 16 Dec 2019 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519414;
        bh=zr40ijXVMEOd8x6/Kipd24NfEl4lgp/N8U1A6J9z/vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVp5f+tKESyqbN94VLOemAZoDz5HtyvT3VEiDJ9niEfmIjK66BFTqG04U/f6XYFTs
         fpxXAGipiqWQ1muzQSOSqxmfGeqpPTcgFgzZLRZUdvMJhIcXCR+SgKTVg4ypdbfTPP
         S/Asag+b/cDDS94J2154Cxif8R3J3aWlNBkghcvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawel Harlozinski <pawel.harlozinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 057/140] ASoC: Jack: Fix NULL pointer dereference in snd_soc_jack_report
Date:   Mon, 16 Dec 2019 18:48:45 +0100
Message-Id: <20191216174803.777135697@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>

commit 8f157d4ff039e03e2ed4cb602eeed2fd4687a58f upstream.

Check for existance of jack before tracing.
NULL pointer dereference has been reported by KASAN while unloading
machine driver (snd_soc_cnl_rt274).

Signed-off-by: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
Link: https://lore.kernel.org/r/20191112130237.10141-1-pawel.harlozinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-jack.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -100,10 +100,9 @@ void snd_soc_jack_report(struct snd_soc_
 	unsigned int sync = 0;
 	int enable;
 
-	trace_snd_soc_jack_report(jack, mask, status);
-
 	if (!jack)
 		return;
+	trace_snd_soc_jack_report(jack, mask, status);
 
 	dapm = &jack->card->dapm;
 


