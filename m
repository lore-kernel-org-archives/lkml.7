Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4554C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F587218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBRqseJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfDWWtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33079 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfDWWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so15031255ljc.0;
        Tue, 23 Apr 2019 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQUuLg/zS2tfsDPJ/SWrp4NtSrhhV6zRMowLIWOaos8=;
        b=ZBRqseJkYxfE/CzTHrtM2oFui4WHlgpHFxVNRrXxCKi7N8X3XTPlsNGSc4ixdgXSQL
         Ft4N3un8giuvHukO+rUIqFqg0gQrFi37NydhXvzZUYY3sYVerTDnePzuqzPJtTLFZsT9
         /RDd7oy6OmJCrxdT41pBlHXf5a4QRlDK7UhVj+HzeR4vmCoJHiI4eIolL/He31Q98u/K
         3TErh/CFzHNTVNGq5mKSfaj8nWGvk+J8dlJFoShbrWWdsl++e1FObF2V7gTXntamcVK4
         IBurUD9I0DGT57g4pVBixhVip8XowygvDGao0r7jv/60dGysobUJVkxU7zxL6rbpBfk4
         MeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQUuLg/zS2tfsDPJ/SWrp4NtSrhhV6zRMowLIWOaos8=;
        b=B4hrCaNSALucr1a/FeHK7GnIIpqOvo3auje6MAk8UP3teCS13Emih96SHFwADdllj0
         SxQMG4Xgy9ZcU6tMi7LB1QxJPz3DNdBCh+Oiq6xLwZSdoU65p4KqGyutapwf1GfFIh5y
         NyC7KF4rbF81lo0oe0j9WTFVupCQ+YAq5pyo3WqxSoaS95GqZzpmIh0vX/Diw8loH4jj
         2mrxNsd8TYQ69e1xkrOdmvEMbj4Dr2Qui/x/l/5AX3YdzWy2YwqE+QM00VDkBe3N2dwE
         L5MxL2vwBEsWjM8ddpTme24gfHsdmCg+ly3/gt1cYoAY4PcAW8U9MnfSk9NkRM19c2Vb
         Rfwg==
X-Gm-Message-State: APjAAAV407CG9p2tG0/J/JoY3zIAWXaLFu7MUTgLTVpMoUJvJD0wREXA
        zKvKoHUfFLZHbm706YV9mo4=
X-Google-Smtp-Source: APXvYqyhjnkT+9LePvjgG7sTJaXhnCTfU1OegGJVSuxkNhWhUGd6uARyyWDHWvGNqBt2JV2gzkzWhw==
X-Received: by 2002:a2e:5d94:: with SMTP id v20mr14093334lje.138.1556059775938;
        Tue, 23 Apr 2019 15:49:35 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:35 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 09/12] mips: Perform early low memory test
Date:   Wed, 24 Apr 2019 01:47:45 +0300
Message-Id: <20190423224748.3765-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock subsystem provides a method to optionally test the passed
memory region in case if it was requested via special kernel boot
argument. Lets add the function at the bottom of the arch_mem_init()
method. Testing at this point in the boot sequence should be safe since all
critical areas are now reserved and a minimum of allocations have been
done.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index ca493fdf69b0..fbd216b4e929 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -826,6 +826,8 @@ static void __init arch_mem_init(char **cmdline_p)
 		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
 
 	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
 }
 
 static void __init resource_init(void)
-- 
2.21.0

