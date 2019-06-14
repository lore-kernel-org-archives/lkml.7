Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F4DC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32B92184C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534799;
	bh=G5goqhyF7jpMUVmyMbckYW0KIfHJ01SZCgELiSXvJiM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SrEzzWPkpntPMn9lmFAblUPbP5mN+/YH1yzh8MgTVrngKau6YRso1BKkVPokh748Z
	 KoHG54iPK1/ZdgXfnAC98xrvUya6pw1kurMPjXdQrd65e18tE8l29kp5ZWbG1/wSsy
	 gZbsmyE2rZVZiLlm7w8Vkubt91ZQdz9LsNhp9EfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfFNRwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C0W3exYft1KrUqFyOJUCPkgo7W6ZH/A+goYD/OL6mwQ=; b=XbR2pPbkWupU9wSy235pIngyj
        w8ihDUcQfCxiy9ZmKtW+eKdu1ujaV83+ZZG85GMTTQD0XeYMxQnF/yqH4OQNjta7byrOQrVoe45ry
        yhtieTkPeAdw2wZnSs08p8/PfuWpZRw2FP4j7QtoRu2rXCMRMXTlWy5qQ/KqMierhkRA9G+qvCW5j
        ahUctCEciLduTBycBl7MAn+mygZqTL+r7u+ytRP7oJlFPlEDPAXIBwpujXBKnrZRFNFdHPWX/Kl9C
        XYjWsQXRHrb4x9ZvO13SsUgO8vNnp2osAU0LTFohVXQBeUztHRAa0Y46v9+6RTHwsL23vNGeySbFR
        IFscEwugA==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000PW-JU; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002OT-MW; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 01/16] ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
Date:   Fri, 14 Jun 2019 14:52:15 -0300
Message-Id: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According with Documentation/ABI/, the right tag to describe
an ABI symbol is "What:", and not "Where:".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index 4b0318c99507..ff229d71961c 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -9,7 +9,7 @@ errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
 saw any problems).
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
+What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -31,7 +31,7 @@ Header Log Overflow 0
 TOTAL_ERR_COR 2
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -62,7 +62,7 @@ TLP Prefix Blocked Error 0
 TOTAL_ERR_FATAL 0
 -------------------------------------------------------------------------
 
-Where:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
+What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
@@ -103,19 +103,19 @@ collectors) that are AER capable. These indicate the number of error messages as
 device, so these counters include them and are thus cumulative of all the error
 messages on the PCI hierarchy originating at that root port.
 
-Where:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
+What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
-Where:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
+What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
 Date:		July 2018
 Kernel Version: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
-- 
2.21.0

