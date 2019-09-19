Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADEC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FED21920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931683;
	bh=wnITQ2KXJYh9SLVeKmbRzzeu15XPQTUn5t2r+rTvR54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2lKrhFt8Vtu1/dPd3tp/lVdBPa8A9RiIDrCejrm2RQMOYHGFpZDKSigIDFY0a4Sb
	 miUcC02yiK2V6WKvE/9CcnRo/GtlJvmv4KdwaBWmdNCad347FlI1am4ATTjYX6lJG8
	 uC2pb5En/tPjqMgaHwhVUDufdWUfJCuoPRwbfMtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406717AbfISWVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406704AbfISWVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE66E21907;
        Thu, 19 Sep 2019 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931678;
        bh=wnITQ2KXJYh9SLVeKmbRzzeu15XPQTUn5t2r+rTvR54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyZixq5H3Q6ZeMRt+ZBhh/YfY+K5wFMUH+JG3Pcx7zKMoElwmeBmaDs5mzN2skObd
         8/TRwoAh/m6W2jYMbHLyRVqor1gkS8WTTIFKZcioLdzLg0u8xMnwGW6XiZ9XrvgB9A
         7N8zW8udSFzaUubuMmT729G8qwsfzEz+KjirC5bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.9 38/74] x86/boot: Add missing bootparam that breaks boot on some platforms
Date:   Fri, 20 Sep 2019 00:03:51 +0200
Message-Id: <20190919214808.643870604@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Change

  a90118c445cc x86/boot: Save fields explicitly, zero out everything else

modified the way boot parameters were saved on x86.  When this was
backported, e820_table didn't exists, and that change was dropped.
Unfortunately, e820_table did exist, it was just named e820_map
in this kernel version.

This was breaking booting on a Supermicro Super Server/A2SDi-2C-HLN4F
with a Denverton CPU.  Adding e820_map to the saved boot params table
fixes the issue.

Cc: <stable@vger.kernel.org> # 4.9.x, 4.4.x
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bootparam_utils.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -71,6 +71,7 @@ static void sanitize_boot_params(struct
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
 			BOOT_PARAM_PRESERVE(hdr),
+			BOOT_PARAM_PRESERVE(e820_map),
 			BOOT_PARAM_PRESERVE(eddbuf),
 		};
 


