Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D821909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126294;
	bh=4mZTfEBbLxcObbnbte3iO3ARaV9O/zq8HnfKVNttTYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w1Fv3BFWFiju3XcmP8c9+CoRVZap6deJFosMIGr8RCmHmvNv0W8toqJOC9lsx4oeg
	 lQkQhQQ6RzDNwRylPoISpwOpQOAF+C7QA4r8zQH2NQqswisWoKY6dZgatBA4pPp0Mv
	 y8Fc+EJgoYSIMA30sR756WRph0owbV17T26NJbTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfDXRSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388238AbfDXRSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:10 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6648218B0;
        Wed, 24 Apr 2019 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126289;
        bh=4mZTfEBbLxcObbnbte3iO3ARaV9O/zq8HnfKVNttTYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK9xYhH9wDkA8g3Tv6uVOfyqz6B2KGkDuAvOVDcvByY85iLPBlttUbTRhahabz+sa
         nvNROfKiTOfxVEzA73ga6dfd87AywNAIJJtPVMTCg/HG3DSdsUl24dExiudYwFQSGJ
         gSi08QWRugFZaUsJdSpo+WpRPY3cFalCUXWosGSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Buland Singh <bsingh@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 060/168] hpet: Fix missing = character in the __setup() code of hpet_mmap_enable
Date:   Wed, 24 Apr 2019 19:08:24 +0200
Message-Id: <20190424170927.345741274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 24d48a61f2666630da130cc2ec2e526eacf229e3 ]

Commit '3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for
user processes")' introduced a new kernel command line parameter hpet_mmap,
that is required to expose the memory map of the HPET registers to
user-space. Unfortunately the kernel command line parameter 'hpet_mmap' is
broken and never takes effect due to missing '=' character in the __setup()
code of hpet_mmap_enable.

Before this patch:

dmesg output with the kernel command line parameter hpet_mmap=1

[    0.204152] HPET mmap disabled

dmesg output with the kernel command line parameter hpet_mmap=0

[    0.204192] HPET mmap disabled

After this patch:

dmesg output with the kernel command line parameter hpet_mmap=1

[    0.203945] HPET mmap enabled

dmesg output with the kernel command line parameter hpet_mmap=0

[    0.204652] HPET mmap disabled

Fixes: 3d035f580699 ("drivers/char/hpet.c: allow user controlled mmap for user processes")
Signed-off-by: Buland Singh <bsingh@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 240b6cf1d97c..72e073895ed9 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -376,7 +376,7 @@ static __init int hpet_mmap_enable(char *str)
 	pr_info("HPET mmap %s\n", hpet_mmap_enabled ? "enabled" : "disabled");
 	return 1;
 }
-__setup("hpet_mmap", hpet_mmap_enable);
+__setup("hpet_mmap=", hpet_mmap_enable);
 
 static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
 {
-- 
2.19.1



