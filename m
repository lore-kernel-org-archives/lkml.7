Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28121C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCFC20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIt+RkQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGOLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:11:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:11:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so11364190pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9LeTIkdxMwZvglFvizWchN+b3CkwK+5wg9lYTOOyRLw=;
        b=BIt+RkQP7xn4VMu5EZCLcF4/fAcyOjxDJ/caPi6v0qVmX3X7V867du25cUTqhfXAPQ
         Uz3cXlWyGrl7B0616/obZ5oxFNHM1XmRNMTbS4k9ThhHepyV/gJbRvuWHCUB+dSTGcnH
         iYiOkT+GM8DbJlevNF2UUvC9US5Fzw78hxXzHUfZk3nDZyD9QT/PlGeWMwy7rsx/SizT
         johES3WqgNLfs1RQ2cbzlqe/0s9w3pCuwLS0/4j+Hg6kCXtFsHiinQy/oIJlIenPQxU9
         RvEvQpokwfVBN0FKDmxBSSW9dWarSOWrkJIKzAD02a+jeGQTTQOQ/ZPg2BiXBJ1dFWhI
         H3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9LeTIkdxMwZvglFvizWchN+b3CkwK+5wg9lYTOOyRLw=;
        b=iQ57tK/JyeuYqi8Qn5NMT73l2b9mEgk0eI8BgUiz6sATF0cQTX6zbQ1JkjHFtLUz28
         3AQAimY6ya6s9nvgy2SUMu8rHQsBSCx15ntBaZwG2Cq9h5WAmCAsWxJKTFZfGrlQL6tL
         EpnS1je6OmAKDASQFhvQYBR8qpy6sI3lOcMwP2BVBYJOB5ZVB2zhWcfARHf1ueyKbesu
         IRwToAA0FN6kcLGLTXb25RY+YSW19gLRFdghZ7pZGrUW30EO1gyHXlj+MZzY3QdnQZgl
         scfPX2MXYWj4sM73RsaUojGrewaPP9J0XULcxuk4nAHCbN/Ky6wg4G8wNKxJK41lOrMg
         UBxg==
X-Gm-Message-State: APjAAAWoK4BA550ydjUf7vH6IiSid8PU5xNU1A9IC7PRu7ehhHhDFr7l
        fOLYfP0bcTaG+VTwJAvB7tY=
X-Google-Smtp-Source: APXvYqz5TcqtUPkAid/VyGs5g12QymmVgaWrtbhvtXvjtoF8haf/JDiLPIRDtWGga+IvXJw/q25SLg==
X-Received: by 2002:a63:43:: with SMTP id 64mr11521398pga.64.1551967906120;
        Thu, 07 Mar 2019 06:11:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1sm7704690pfn.26.2019.03.07.06.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 06:11:45 -0800 (PST)
Date:   Thu, 7 Mar 2019 06:11:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/10] powerpc/6xx: Store PGDIR physical address in a
 SPRG
Message-ID: <20190307141143.GA26761@roeck-us.net>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
 <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 21, 2019 at 10:37:55AM +0000, Christophe Leroy wrote:
> Use SPRN_SPRG2 to store the current thread PGDIR and
> avoid reading thread_struct.pgdir at every TLB miss.
> 
This patch causes a number of silent (no crash) qemu boot stalls
in -next. See
https://kerneltests.org/builders/qemu-ppc-next/builds/1080/steps/qemubuildcommand/logs/stdio
for an example.

Unfortunately, it is not possible to revert the patch due to subsequent
patches, so I was unable to test a revert.

Bisect log is attached.

Guenter

---
# bad: [cf08baa29613dd899954089e7cc7dba1d478b365] Add linux-next specific files for 20190306
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect start 'HEAD' 'v5.0'
# bad: [6cc8f3499ec8d31904ab9083980a91736512cb37] Merge remote-tracking branch 'vfs/for-next'
git bisect bad 6cc8f3499ec8d31904ab9083980a91736512cb37
# good: [63bdf4284c38a48af21745ceb148a087b190cd21] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 63bdf4284c38a48af21745ceb148a087b190cd21
# good: [520b5fc601ab760fee7ea0c403b42d04e8ebfd93] Merge remote-tracking branch 'arm-soc/for-next'
git bisect good 520b5fc601ab760fee7ea0c403b42d04e8ebfd93
# bad: [d7f54e4e0d4e90f5df78da8d6a830bafad3b535a] Merge remote-tracking branch 'xtensa/xtensa-for-next'
git bisect bad d7f54e4e0d4e90f5df78da8d6a830bafad3b535a
# good: [0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f] Merge remote-tracking branch 'clk/clk-next'
git bisect good 0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f
# bad: [fb0b0a73b223fc113e961b1d921322844e9c30d9] powerpc: Enable kcov
git bisect bad fb0b0a73b223fc113e961b1d921322844e9c30d9
# good: [d0055df0c9c1471c389197a69f43e300185a75aa] Merge branch 'topic/dma' into next
git bisect good d0055df0c9c1471c389197a69f43e300185a75aa
# good: [0df977eafc792a5365a7f81d8d5920132e03afad] powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
git bisect good 0df977eafc792a5365a7f81d8d5920132e03afad
# bad: [665bed2386e5dc29844ad78c7ef1464664b103ec] powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
git bisect bad 665bed2386e5dc29844ad78c7ef1464664b103ec
# bad: [78ca1108b10927b3d068c8da91352b0f4cd01fc5] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
git bisect bad 78ca1108b10927b3d068c8da91352b0f4cd01fc5
# bad: [a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee] powerpc/603: Don't handle kernel page TLB misses when not need
git bisect bad a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee
# bad: [2c12393f577396a51b7e0537bd3eb29dcc26dc1b] powerpc/603: use physical address directly in TLB miss handlers.
git bisect bad 2c12393f577396a51b7e0537bd3eb29dcc26dc1b
# bad: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
git bisect bad 93c4a162b014d238a287f8264adb25c009c79e61
# first bad commit: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
