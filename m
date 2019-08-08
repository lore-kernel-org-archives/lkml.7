Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E90C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB262184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="zYJfWj4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404206AbfHHTxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44010 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404161AbfHHTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so92194611edr.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1epOGxUbthEoKZfWezIGhu9YUJF69z7IoF4WSeJeu8=;
        b=zYJfWj4U63MIad/613477f9I8zASNwjPbBzu5ktiH2bmtrw21fPLdNEO4jfqrok5Jn
         xsUbsszaYebO1URgGxozEte43404u5usAIB/L4aQyFp0eJntreXpFZMU0yYAlw18CIJu
         y4ehNutlaI/Chd2xm6uToeSDJIuhKD2v4G4GCBrx9vmsa5CIG03TRRLt90GmeQz5+cgf
         V1UYu46riBBTRIkBLjBAM7FASXUrfJY3liME0OBcBRk3luA47X6IHVPgfhkibp4pWrxS
         61bogSlWtCYywomgO05gJFcMpam81Ejd+ri8XcJKdCMcEAdezkLwVUpY1uMA/aQ58+dz
         aLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1epOGxUbthEoKZfWezIGhu9YUJF69z7IoF4WSeJeu8=;
        b=FIWGuKTtdbyRezYHlMHb1aWOyCNY7Beipb0+dFzwc/8yXLNG2Xr8FujBVQsj7BjKVZ
         DMN6X4BpzPKQCXL8qBDCR9B+7Jcf3LHKmJPxleY3FsB8tU0QnramRbD00CotdxG4VM+s
         1HR+hk/E47sQvpHT7y3+i2HNthkNWpWf62hl5JRv/RJTj89K+TPKUQhHHvAEPHB46Q+2
         mc0YuhhqNHDUK7v2EcrWTP9YE/nwGoqyslFUIbYtp1iRVwfvvMvrjXfwcroPC2h1Si8E
         AhXSnJy2oThpws/fH5PhN3i3h6mwyLYk5n43q2VShEMKqlx9LlVW75qdl+q0V0QFQIuM
         FQRA==
X-Gm-Message-State: APjAAAWKKcUTU7fenZ9Z4DOargevR9Khivzmup47l8U60gUCVDNA3Jqf
        N5VrHGtvy5o882GUYXuopKHI0Zbv/48=
X-Google-Smtp-Source: APXvYqzXHeqhDDSpP4cdq7Qnf/FI/lL5kxqUplfUp/qgZwyryzKE70Aiy+x6TSUgQplKd+89mbwHfg==
X-Received: by 2002:a50:fa42:: with SMTP id c2mr18246219edq.48.1565293984470;
        Thu, 08 Aug 2019 12:53:04 -0700 (PDT)
Received: from localhost (97e6989d.skybroadband.com. [151.230.152.157])
        by smtp.gmail.com with ESMTPSA id y12sm15475684ejq.40.2019.08.08.12.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:53:04 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com, Borislav Petkov <bp@alien8.de>,
        Thomas.Lendacky@amd.com, Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH 1/2] ia64: Make NUMA select SMP
Date:   Thu,  8 Aug 2019 20:53:00 +0100
Message-Id: <20190808195301.13222-2-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190808195301.13222-1-matt@codeblueprint.co.uk>
References: <20190808195301.13222-1-matt@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it does make sense to allow CONFIG_NUMA and !CONFIG_SMP in
theory, it doesn't make much sense in practice.

Follow other architectures and make CONFIG_NUMA select CONFIG_SMP.

The motivation for this patch is to allow a new NUMA variable to be
initialised in kernel/sched/topology.c.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/ia64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7468d8e50467..997baba02b70 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -389,6 +389,7 @@ config NUMA
 	depends on !IA64_HP_SIM && !FLATMEM
 	default y if IA64_SGI_SN2
 	select ACPI_NUMA if ACPI
+	select SMP
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option is for configuring high-end multiprocessor
-- 
2.13.7

