Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28593C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FD420665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WNBYaC+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfGXOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:55:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfGXOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:55:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6OEtF0G579724
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Jul 2019 07:55:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6OEtF0G579724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563980115;
        bh=czaAyftdzYGM87gAElXTv8Urfe6FzV++B6O8rlgO1zM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WNBYaC+as56hn7DXQ5quSInGR4bz7CYwX6EUjFCJazM5iHovj1DamyekOK2viNGGS
         lc6vsZJ5C90Z7LRDYDuftjYkG8WaTZIFqbeSQxs4JL3/qQnel8/yaO8226CXDcWsQO
         WOQAKFDy98jRnpNE7Yvblv03M63W8m9Vz16MKTxP44Lh5HHByb8ri2pIgLyhJBQrHl
         yNIgpC/o1n5gvvvQL7bfDyXJVZxDXs6ELlGqH6Wes7adLgMz9E6F9/jL2whZjmaXHg
         Gc65Nss4zbQhHKbf6Iw8DyuotI/SaTy1+rQ7aMXiFW6icZe0YU9nHhYcayHGKSpf/3
         /37vknFmOHyPA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6OEtEJl579721;
        Wed, 24 Jul 2019 07:55:14 -0700
Date:   Wed, 24 Jul 2019 07:55:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nikolas Nyby <tipbot@zytor.com>
Message-ID: <tip-4599c6671b8119ed5455e4ed6b967b461c27a9f7@git.kernel.org>
Cc:     nikolas@gnu.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, nikolas@gnu.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190724041337.8346-1-nikolas@gnu.org>
References: <20190724041337.8346-1-nikolas@gnu.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/crash: Remove unnecessary comparison
Git-Commit-ID: 4599c6671b8119ed5455e4ed6b967b461c27a9f7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4599c6671b8119ed5455e4ed6b967b461c27a9f7
Gitweb:     https://git.kernel.org/tip/4599c6671b8119ed5455e4ed6b967b461c27a9f7
Author:     Nikolas Nyby <nikolas@gnu.org>
AuthorDate: Wed, 24 Jul 2019 00:13:37 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 24 Jul 2019 16:50:15 +0200

x86/crash: Remove unnecessary comparison

The ret comparison and return are unnecessary as of commit f296f2634920
("x86/kexec: Remove walk_iomem_res() call with GART type")

elf_header_exclude_ranges() returns ret in any case, with or without this
comparison.

[ tglx: Use a proper commit reference instead of full SHA ]

Signed-off-by: Nikolas Nyby <nikolas@gnu.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190724041337.8346-1-nikolas@gnu.org

---
 arch/x86/kernel/crash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2bf70a2fed90..eb651fbde92a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -225,8 +225,6 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (crashk_low_res.end) {
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
 							crashk_low_res.end);
-		if (ret)
-			return ret;
 	}
 
 	return ret;
