Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D65720673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121822;
	bh=3ihiTb+MDk2eBc5GTPJ9ff6AiF3Ns4X+mQayjR3/jQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/IV/HCJgfoKSbVQI9AVHGW9l9XL3kVQLBy+SnsJ0zPFClTb9dDwcc5J6cmL5Xuww
	 +bEYuJZwy1oLwU0ucAm2BGEV1wu7yweVjK/zdTfRkYMzBi2pifzWUC627ypKazljV2
	 u/XpiJB4ycpHk1AdRJ8Zkjh+QBPWwjq/vykQ9Hyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406055AbfJCQ5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405427AbfJCQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B693C20867;
        Thu,  3 Oct 2019 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121429;
        bh=3ihiTb+MDk2eBc5GTPJ9ff6AiF3Ns4X+mQayjR3/jQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1qFtHbEiW1s43VPboc5kb3LFZWsevCew44H4y2eu55KnJ7IgKH4Cu8ZLIKbOcCr7
         7o2WX0anYP7s8kAJsgCXy/HPqBzc5Erd92nlOXy0vDplEIYFHS6mT2KrUQFFxDapGt
         +3J74L5bJh2zzgEIuPzdqXT7LfqdfE8gUodnDdfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 276/344] ASoC: Intel: NHLT: Fix debug print format
Date:   Thu,  3 Oct 2019 17:54:01 +0200
Message-Id: <20191003154607.349245989@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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
 


