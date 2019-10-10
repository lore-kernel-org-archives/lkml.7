Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30341C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D9821A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697395;
	bh=Yhhc+Dgashloh3oz5wixN5SOY5Qb/eNUcE8b8BhrcDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nKgIUfrF8V4Kdu/3H6kTXQVOuydLuNmXLfjFnJRiqNy4kJdh93O2IkN4RDwUYmsx0
	 Xn4LSr3flHy50qAou634SwgPQxQTDDkblCh/if4H/Bbmfmx4gNYsp1PRZE3b7aolbj
	 01JHAmpCn65ERY3ciqFz7goI/enF6T1k3SSHQe/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbfJJItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389859AbfJJItu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:49:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 160B822473;
        Thu, 10 Oct 2019 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697389;
        bh=Yhhc+Dgashloh3oz5wixN5SOY5Qb/eNUcE8b8BhrcDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dykGMrGFdKZF/HYePE04D5lj9Yr0H1tj3s8MXatKq5EdT0f4rhVdAXu93oJALRxPH
         brJlffDX7r+xu778NVsiiWeUDVEou0sP7QiYadiM/VZspetL59IOlUsD5mbK9Dd0Pk
         X9MNr3XEh7Fjxubd3ko8L06S4MHlYgE2fD5iHMpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH 4.14 10/61] powerpc/powernv: Restrict OPAL symbol map to only be readable by root
Date:   Thu, 10 Oct 2019 10:36:35 +0200
Message-Id: <20191010083455.271171053@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Donnellan <ajd@linux.ibm.com>

commit e7de4f7b64c23e503a8c42af98d56f2a7462bd6d upstream.

Currently the OPAL symbol map is globally readable, which seems bad as
it contains physical addresses.

Restrict it to root.

Fixes: c8742f85125d ("powerpc/powernv: Expose OPAL firmware symbol map")
Cc: stable@vger.kernel.org # v3.19+
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190503075253.22798-1-ajd@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -617,7 +617,10 @@ static ssize_t symbol_map_read(struct fi
 				       bin_attr->size);
 }
 
-static BIN_ATTR_RO(symbol_map, 0);
+static struct bin_attribute symbol_map_attr = {
+	.attr = {.name = "symbol_map", .mode = 0400},
+	.read = symbol_map_read
+};
 
 static void opal_export_symmap(void)
 {
@@ -634,10 +637,10 @@ static void opal_export_symmap(void)
 		return;
 
 	/* Setup attributes */
-	bin_attr_symbol_map.private = __va(be64_to_cpu(syms[0]));
-	bin_attr_symbol_map.size = be64_to_cpu(syms[1]);
+	symbol_map_attr.private = __va(be64_to_cpu(syms[0]));
+	symbol_map_attr.size = be64_to_cpu(syms[1]);
 
-	rc = sysfs_create_bin_file(opal_kobj, &bin_attr_symbol_map);
+	rc = sysfs_create_bin_file(opal_kobj, &symbol_map_attr);
 	if (rc)
 		pr_warn("Error %d creating OPAL symbols file\n", rc);
 }


