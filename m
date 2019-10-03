Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2C20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120623;
	bh=3ihiTb+MDk2eBc5GTPJ9ff6AiF3Ns4X+mQayjR3/jQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyPWv2viG13GOouk/DY6DlpRsypNSaUOAIU1U1H3gyYUkdYz0BDjq4v/vZE0Jwjw0
	 Ps1CyAnsZJcrZq7xZuNHh9Z3jIMQBVx2AKs1d02JD01XqIQhRL7qBnUpc3HLidbb53
	 +fx172Tez9eUH24KOY5v+VF6PEtWVoWlabW2yN5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392243AbfJCQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404515AbfJCQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C8C2086A;
        Thu,  3 Oct 2019 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120618;
        bh=3ihiTb+MDk2eBc5GTPJ9ff6AiF3Ns4X+mQayjR3/jQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFBq2jpgnoxEM3d7QSssWfbkVDfF7jTgyLYJiKn4KkgvQDYdsiQ9+SVSykziQ9luc
         lHqmFANKFncfCv67XyyEfJtt839GHcZvO380eA8AepzUZYIP6xhJqvalHN3QqkPeS+
         zF6sS5mCwP0U491DZ6e4jw4TX1XrxcHvc/s4htN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.2 251/313] ASoC: Intel: NHLT: Fix debug print format
Date:   Thu,  3 Oct 2019 17:53:49 +0200
Message-Id: <20191003154557.773017960@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

commit 855a06da37a773fd073d51023ac9d07988c87da8 upstream.

oem_table_id is 8 chars long, so we need to limit it, otherwise it
may print some unprintable characters into dmesg.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
Link: https://lore.kernel.org/r/20190827141712.21015-7-amadeuszx.slawinski@linux.intel.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/skylake/skl-nhlt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -225,7 +225,7 @@ int skl_nhlt_update_topology_bin(struct
 	struct hdac_bus *bus = skl_to_bus(skl);
 	struct device *dev = bus->dev;
 
-	dev_dbg(dev, "oem_id %.6s, oem_table_id %8s oem_revision %d\n",
+	dev_dbg(dev, "oem_id %.6s, oem_table_id %.8s oem_revision %d\n",
 		nhlt->header.oem_id, nhlt->header.oem_table_id,
 		nhlt->header.oem_revision);
 


