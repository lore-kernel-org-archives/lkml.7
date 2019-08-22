Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500F92343C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494627;
	bh=B1oks3VphFC6eY+dHHTJW0whY8yniblTcnUEBpNvQcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2yVR9UvysfWdA8ES3AdeFRhK32RQbjA6a+ArjEFyjc+0Ec/O/bWJQIXqRlw0dZ/a
	 S9GLgbEOEBmftTFeYoGO0ieagddf/EGNB+mbbBHwaAlcWgEGTb9mO1scuBcPaaNTvP
	 XVXs8ZC3zg93tLJLF1APikXnjXb9KVK3Usd7ptkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391624AbfHVRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391489AbfHVRXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:30 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2812341B;
        Thu, 22 Aug 2019 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494610;
        bh=B1oks3VphFC6eY+dHHTJW0whY8yniblTcnUEBpNvQcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+Ki9OYt0lTkF+jf0bkOksDYHE2sBl0DW+n3lG+XfVRK/CW+xSNr45YiSW91bgJl9
         NHVgWeX8OPSCJp3L5qYo4C06yHXpjrKiDrJ1uSRXGuS4Zzax4rhQSv0llhxtMCkQcj
         TfPsEyWnjlxDWTq8TJgzCUW1duRaGFYkOcB4S+So=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4.9 004/103] x86/mm: Check for pfn instead of page in vmalloc_sync_one()
Date:   Thu, 22 Aug 2019 10:17:52 -0700
Message-Id: <20190822171728.769271248@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
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
@@ -279,7 +279,7 @@ static inline pmd_t *vmalloc_sync_one(pg
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }


