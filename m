Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE668C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A96A218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFDhkYGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfDWWuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:50:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39491 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfDWWtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so15003296ljg.6;
        Tue, 23 Apr 2019 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ki42UVersVgO0drl3EkT6trUyKrYAuiSL6uO+XLp8qo=;
        b=LFDhkYGwUUcKL70nD/YT5mltsCFyWgMDGN3Dn/2DwKPy0rQeT4DQXnHKUyxY8HsTBK
         yi1BLa1BXycY5hqy/YfoP8PWDEMR0JBFm/R41nYasE3vRzPGEhOD4oFH/RyoPiNU3Ep6
         LV+XmZ76hfjGidRj8XI5hMBbLqT22GkpkTR62BD9cJ1lJ2D37k6xCG7b5p2RCj5Qhcxp
         mf27AX0S0mBWIe5Gg+f6iGOAAqRwXwIVFqe+dPDl3sCOdDtRlQJHhEMy8eV91Ym7WjRs
         rEXk2bWeymhIQjFimpFfWuaxOhNwjid9g4l/TAt4tlMD3rHHR0T3r84qX60wXGqrfa2X
         r/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ki42UVersVgO0drl3EkT6trUyKrYAuiSL6uO+XLp8qo=;
        b=pI4xo3W8JLXLhJQ+L0oWxb1nNgO7avU0d4Z/ZYiq3ofmK8eIzi6R10Jdv0Vv9aamk1
         YzOaF6DKR3hCgi1TaqLWdCIvIALsWInuhn9ym1Ijcx67uxSEij469p24tZPjdXCvJCcs
         XTFn3znvQMb/JnW3cjlFZBKZClJqjs/4pMgf0CtQnWTa13j31cidptRptq+LzV2ym2jT
         UsHOIYITAzP4nXeJSVn5sBTkOvAFQcWOkqA2+DyG6BhiTRjoWcSmWxLmfIJWMOX2ePSQ
         qKTm/9n2QKQGSC2d0G0cfbFA836hAKVe7yrJMg1wnB0osEYrTkR3nLH85+TcOLsXcy19
         I9ew==
X-Gm-Message-State: APjAAAX/XJSKqm2+CFQMk8VFuGM0RPRpBEDHKA+i00pyJZko4U1VMujT
        MI8IxeUGJg8X30MXiWFDZXM=
X-Google-Smtp-Source: APXvYqwHm2THQU6zCobvLE+tKU93UaRP+BFZTKpIkqXcvxv+kqV5eZ2b+FyYUwvDUdgWsuiU9GZM9Q==
X-Received: by 2002:a2e:7e0f:: with SMTP id z15mr15308271ljc.122.1556059774454;
        Tue, 23 Apr 2019 15:49:34 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:33 -0700 (PDT)
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
Subject: [PATCH 08/12] mips: Dump memblock regions for debugging
Date:   Wed, 24 Apr 2019 01:47:44 +0300
Message-Id: <20190423224748.3765-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to have the whole memblock memory space printed to console
when basic memlock initializations are done. It can be performed by
ready-to-use method memblock_dump_all(), which prints the available
and reserved memory spaces if MEMBLOCK_DEBUG config is enabled.
Lets call it at the very end of arch_mem_init() function, when
all memblock memory and reserved regions are defined, but before
any serious allocation is performed.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2a1b2e7a1bc9..ca493fdf69b0 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -824,6 +824,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Reserve for hibernation. */
 	memblock_reserve(__pa_symbol(&__nosave_begin),
 		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
+
+	memblock_dump_all();
 }
 
 static void __init resource_init(void)
-- 
2.21.0

