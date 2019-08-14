Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3209EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34B920665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802831;
	bh=2YBuIsDcMpoL0U/IBSf8khny7Yz77o+fjErHr9vIHBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnO1m0LxfuN7/cKA2GTcGn9KLWXhI8xTGm3FhcJQv79tzSBRAufYxVOfcFr5R6oSY
	 wFxLlErLT0k/RCDhmhVojTt9J5sy3ovVT2+XybHT/DUf3/TlS0KIDPN2+n3ZDiE14u
	 kX+CDmDwzVy35eekifuPYPKPk3cI88eqAbEDWkf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfHNRNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfHNRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0CA2133F;
        Wed, 14 Aug 2019 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802828;
        bh=2YBuIsDcMpoL0U/IBSf8khny7Yz77o+fjErHr9vIHBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nh98G+MfpEpEbXPehZ44xm8x5A8fAaujT09W69QOjckNPjA5Om+0rA8vZeEtXqHKs
         xt6ttBkyAIORd8t+dC/eGXSHugON74nddwCQZNEKXQHB5rWxzXTZM03G9i2aEssgzs
         Vb38A5uaGLd5YGS8/L3wFCG1OcJuqNf2dMJhSRuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4.14 15/69] x86/mm: Check for pfn instead of page in vmalloc_sync_one()
Date:   Wed, 14 Aug 2019 19:01:13 +0200
Message-Id: <20190814165746.553852707@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0 upstream.

Do not require a struct page for the mapped memory location because it
might not exist. This can happen when an ioremapped region is mapped with
2MB pages.

Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-2-joro@8bytes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -266,7 +266,7 @@ static inline pmd_t *vmalloc_sync_one(pg
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }


