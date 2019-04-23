Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC890C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F4F218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqY4f2Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDWWth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35418 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfDWWtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so14996575ljc.2;
        Tue, 23 Apr 2019 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXXFjDICVLHmB6TL7TDcc/fdg+nH2204TOTWUCRzYEg=;
        b=OqY4f2Qg+SvkuiMeosJuX95MfMFGoTNriaI6utt3x8o3I6xwPow4OO7gqYv/+llykL
         62HjAu16vB65YXYjKFjdPf/DmuBCMoLS6fZPZucgFGZbfZ8w+OZJIbJyLjZBJ9M0Flqo
         wZJozoEXaNTEeUhOf5XZGkARNprGInv5w6NeCH90mU2x84vuL84AWFKovn32gRREPw5v
         7TbODywdIAZKBO9sILxrnRAun/ziRqOa9jzv+7bAgtNtzkkmOHr3tKjo1i/c4TzDUCNk
         ZUT/WeIDla1x/uce1uLJUPf4gKMV7eu7Uzs66t5ExJGBOibFl6sp/N+yqKEGnsa+ec93
         py3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXXFjDICVLHmB6TL7TDcc/fdg+nH2204TOTWUCRzYEg=;
        b=J6l10NFoO8PR4FhzjV6w8V+31ywocCCphnQlFum8IU0unsydH3ztBaMGmFjwDIWI4c
         C2A8OC0LQ/OxtKW6zCOEyb873r2TpYXB9AkSKl9mBqD6rZrgnIMSsrE7N/25Ntwgajbb
         ZIfcuS1rIQXz4yD+itg/wlRYqeNJWW/4TRPu3emcGuJbpVctQ48AWxJ91d3T1niZAFTq
         i0BVRB2KuqodWVZmUeI8kai6fRWuxdVOvIyEQNQGAjROJGXR2IFRRed1fKb88aYlgXX+
         dvHHpVX1LY3xsWnP9AZ28qyz4+h2wjMungjl8Tr/kz1v3cqj4Df/+IMlNWlKHMwLGEde
         vB8g==
X-Gm-Message-State: APjAAAX6lQ2VekfofDYo0cHfriII7PRnKRJ+v6/86u3tgsHLPTUyAmzg
        e2hU0Z1DzEiAitYm+mPvpdQ=
X-Google-Smtp-Source: APXvYqwP+pmsbapZQ/k9VBR241gD0yNb1W4SFh7e0nH6MQ44QpDjHkhfpt87rwY36NhY6fwyyhqqkg==
X-Received: by 2002:a2e:8057:: with SMTP id p23mr4560923ljg.33.1556059771521;
        Tue, 23 Apr 2019 15:49:31 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:30 -0700 (PDT)
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
Subject: [PATCH 06/12] mips: Use memblock to reserve the __nosave memory range
Date:   Wed, 24 Apr 2019 01:47:42 +0300
Message-Id: <20190423224748.3765-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally before legacy bootmem was removed, the memory for the range was
correctly reserved by reserve_bootmem_region(). But since memblock has been
selected for early memory allocation the function can be utilized only
after paging is fully initialized (as it is done by memblock_free_all()
function). So calling it from arch_mem_init() method is prone to errors,
and at this stage we need to reserve the memory in the memblock allocator.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2ae6b02b948f..3a5140943f54 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -814,8 +814,9 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
-	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
-			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
+	/* Reserve for hibernation. */
+	memblock_reserve(__pa_symbol(&__nosave_begin),
+		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
 }
 
 static void __init resource_init(void)
-- 
2.21.0

