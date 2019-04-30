Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89029C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8321783
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657790;
	bh=cswAH8piR186qX5Q/UwSXpa5mdv6VwG7eAXaXEayPgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=JjP85CRaoluC98BHQi/yb7H9EvsnQdisZGrGkCXyr6Md7IJ20G9GK66yv2D4S7CCK
	 7RrWHLafONC8U9dl8WPN2gXEGMpzi3IYtsxoCFX2q0f2moknYrQvFEawgRYlPPHKB5
	 +jWvuwxhPoapAqxC9zJGNoQirkbks5KZ+oyvt6OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfD3U42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36777 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfD3U40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:26 -0400
Received: by mail-io1-f66.google.com with SMTP id d19so13464790ioc.3;
        Tue, 30 Apr 2019 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=abQyrtu2XYmVNHO2X0NIVqAbhmsckr4xlCEmJzmH/z4=;
        b=Piw5Tk8ptKxWeyfSnNqND4W1ZLCmf/QRRiFsJwjTrPfavO+TZfQgljO8HJdAZnMlMI
         5Q/YGeKAdZu6D8a9Ka1/KbclotrrVVFyxpZsNwIaFlg771lltZL9IpCHOvUFsPLAUDtx
         tC1Wp2JBT7P0DXO2aRhtTySGvxgvTaa35riCajFG38K9XV5EBdLjBDFAKne/XHG0QnFZ
         PvD3otf7fYECDuMe7cRg6T6G2ZQwCaP4Hrb6pUMUqbEPhZyKkGZ3/N45+FLRr4F462E+
         vRtsqdBWpGJJtOC9xyCaPJATfNOyXL1TEx0LdacPpNpZawgouc9PdDtuyDiI2cC0lXFB
         lvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=abQyrtu2XYmVNHO2X0NIVqAbhmsckr4xlCEmJzmH/z4=;
        b=QU5WWBGyv1C9+57D2KT/pAf/Srq0Jt61xCkyMAhze4reKKjYTPzsNygAIdfpAP2M2f
         RzDlKXkyeCYm2VXU2uD2lPExZ1rQsD7U6zPdwzxliNrNu2Ae6FasXhqKzCrbDEQdcHM0
         KttBzm1lnyJs8+IOigIn0tP/lAZRfbSoWoA5xwMRuPxDmV0oziY+vsbHvXd6DFQoujoS
         cJ2/VzXVnpEknbkfm2wCF+3C1mUuDqtl9XfRYlR39pa37niSDFD/5LyIA8hqgyKPK0uN
         3jUoMDxZMAOCJ5+y+w3Y1XS//twu9E+8AF2DkSL2m+a+i9QDRiNYrrcJCL4HmNybO+Lz
         tRIw==
X-Gm-Message-State: APjAAAVwLUv5lVuNon11aCPbilbhdOlFBUkTpB+arRbzNoKkl2heTWks
        1SgeiH69fxobYsu8ZupeLD7rZgGm
X-Google-Smtp-Source: APXvYqws5VogsgiSz4UfzwldTiopefgbo/AlCB1zHwLDIE9btgxJ1Huxe9LPHVPNz02pHR0+lC5fnw==
X-Received: by 2002:a6b:38c3:: with SMTP id f186mr23549869ioa.100.1556657786065;
        Tue, 30 Apr 2019 13:56:26 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:25 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 09/14] powercap/intel_rapl: Support multi-die/package
Date:   Tue, 30 Apr 2019 16:55:54 -0400
Message-Id: <62505b44d2610872542b6602fda9273815db595d.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

On the new dual-die/package systems, the RAPL MSR becomes die-scope.
Thus instead of one powercap device per physical package, now there
should be one powercap device for each unique die on these systems.

This patch introduces intel_rapl driver support for new
dual-die/package systems.

On the hardwares that do not have multi-die, topology_logical_die_id()
equals topology_physical_package_id(), thus there is no functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 8b2f3631aba6..38c89db15150 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package_domain(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

