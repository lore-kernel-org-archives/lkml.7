Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9DAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78944218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788093;
	bh=CapMQcwz8Xsl+NfwobmOyBqf7rfL3JT1Ov3A4rA6++E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1GdNDsSebxBPAtosskxDmuRyH+E//HNa6cjwOvoo6H5bm5fFIW35FAj2rcSFwl4Q
	 VufySQ6Ep0RU0Gr+HAv3rWkPZi8+hA4D8BhVdkmufyiN/hjt6QQCVxQ4acb3lkEbaI
	 CdOfjVXXcwEOOZFLhre7tUrnd7NHuxgrVpXgcogU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfIRG14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbfIRG1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:27:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6D721924;
        Wed, 18 Sep 2019 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788069;
        bh=CapMQcwz8Xsl+NfwobmOyBqf7rfL3JT1Ov3A4rA6++E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5QvFyFBDWOhTxtIFcdPuiUI3Qd1TJ2fsg7jH49Ir3UqYBO19E364GYL+Oa5zoBhn
         ueCyzehsRvM1sf2Yjbxg6fb3Fa2iaGBgKwNe0wCamtjVfMxuzG/+8hiX2nJNPzwFMm
         NH40EfiX7c3iI6P8R+SHClLuhzaS6zkQTbyDEP0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregg Leventhal <gleventhal@janestreet.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 5.2 38/85] ixgbe: Prevent u8 wrapping of ITR value to something less than 10us
Date:   Wed, 18 Sep 2019 08:18:56 +0200
Message-Id: <20190918061235.347046644@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

commit 377228accbbb8b9738f615d791aa803f41c067e0 upstream.

There were a couple cases where the ITR value generated via the adaptive
ITR scheme could exceed 126. This resulted in the value becoming either 0
or something less than 10. Switching back and forth between a value less
than 10 and a value greater than 10 can cause issues as certain hardware
features such as RSC to not function well when the ITR value has dropped
that low.

CC: stable@vger.kernel.org
Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2622,7 +2622,7 @@ adjust_by_size:
 		/* 16K ints/sec to 9.2K ints/sec */
 		avg_wire_size *= 15;
 		avg_wire_size += 11452;
-	} else if (avg_wire_size <= 1980) {
+	} else if (avg_wire_size < 1968) {
 		/* 9.2K ints/sec to 8K ints/sec */
 		avg_wire_size *= 5;
 		avg_wire_size += 22420;
@@ -2655,6 +2655,8 @@ adjust_by_size:
 	case IXGBE_LINK_SPEED_2_5GB_FULL:
 	case IXGBE_LINK_SPEED_1GB_FULL:
 	case IXGBE_LINK_SPEED_10_FULL:
+		if (avg_wire_size > 8064)
+			avg_wire_size = 8064;
 		itr += DIV_ROUND_UP(avg_wire_size,
 				    IXGBE_ITR_ADAPTIVE_MIN_INC * 64) *
 		       IXGBE_ITR_ADAPTIVE_MIN_INC;


