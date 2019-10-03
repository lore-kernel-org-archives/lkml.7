Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0ACC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8CD215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118715;
	bh=eAw4+2mAf06f/+AlDZAKYlg+1ZJzQSKthPZycniYQAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2FF16M5NouJ5OT7TNmQmThTLGq4v2cCBljhmJil4pXWhIfw1TDn+X0gvSdlHj4Nmt
	 6tA367fuXWigYx9adlKSF363MFN0XpWFjjoZTfDgfUEhtQJ2MTG00gqQTraQR7Jnh8
	 Uz4KBOlVVnUUSJSoyY/ID0qb6xyQI4bFVbFydohk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfJCQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfJCQFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:05:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92C621D81;
        Thu,  3 Oct 2019 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118710;
        bh=eAw4+2mAf06f/+AlDZAKYlg+1ZJzQSKthPZycniYQAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9tUT/21DINflDwSO8kciVso5SACdzLdKWliXiYOVkZ6BAg4Pan7S5cTz7p/rVAYZ
         Ji6uuU+n45MZ/+0mkUJeF82P67s7T2PRA0N+p+1FgEXPF8mg5hHqHra93zjV8GUwju
         K7rb8hTKKmxvuQLrQhb5xE6Sr0np4CSIPsF3aaEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 109/129] ASoC: Intel: NHLT: Fix debug print format
Date:   Thu,  3 Oct 2019 17:53:52 +0200
Message-Id: <20191003154408.980857876@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
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
@@ -211,7 +211,7 @@ int skl_nhlt_update_topology_bin(struct
 	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
 	struct device *dev = bus->dev;
 
-	dev_dbg(dev, "oem_id %.6s, oem_table_id %8s oem_revision %d\n",
+	dev_dbg(dev, "oem_id %.6s, oem_table_id %.8s oem_revision %d\n",
 		nhlt->header.oem_id, nhlt->header.oem_table_id,
 		nhlt->header.oem_revision);
 


