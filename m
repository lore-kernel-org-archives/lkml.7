Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F267EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DB220855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUzAt9fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDHF7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:59:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHF7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:59:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so6946816pfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6BBEC2zVpmMlNwmKPyEXFY8QzHHQ1ZNppH8hn0EcEZo=;
        b=lUzAt9fdBSZTKQKR3nnrvMzGPqZT29nLLJXv7WxljYHtj20/KSAEU29OTt9qTvUOPG
         kQsCa6LIo85LUTBW0zajPDKegRy+Ueg9X2vGW/WSbW9554+iSEc7PyuMMUAwANxStlHV
         1/k/rFeagja1V8ps58MYWR4LQzY4FvnvO6C6NzC6ObCjGntf1k3tQj6I6nUV0v6pGEYq
         FA9AlTLfvJU/rLozMAvTjreAH+rSvL3sSufHbXsd6fPtG09I9d6Hm2rZvRqFsbh/KqFW
         PzINm1AgTnUHJaMEw52Hissoe9cK3snEg2qovM1W2IbjRh6qSEbFy2JQ4fR0a0SGKJpg
         /Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6BBEC2zVpmMlNwmKPyEXFY8QzHHQ1ZNppH8hn0EcEZo=;
        b=qL+HVrlGmqW6L11vTOjKhHvlDReqrjhuIn7Atixq/6z8ZqhmkqquC3ci6YKOFRgbMl
         aKz+X38FudsaKtkja8uxXqHPJcwM0nxzydeUPhlCjY1YIZmmXggXkqT6jSd93NrPkR2P
         LYV/93sYmyyutv6aGSaowGdsN7gERgASKhSlOYbCvTa7nUg7N/2aKgjKOuk4CKc5ELEr
         kpF7PI81okjTP7nQOpNFc/Hgyoqi7/S3eWawuaX1dfTeUdBv44m2JD3u/2bxI+Kex3ep
         dKE9R/dExjy7SswdjOmIGviPz+qEUfHQ/5vYvwSPWIo+cLlg3i00daH3PU34/V2V8wWg
         0vYQ==
X-Gm-Message-State: APjAAAXtFg7GJJzvWmbnG0xf6G0UBknTfZJ5s3XdmWFtv0RPwlaLKbHK
        k2coBfn7J4/fM557zWONu7ZZ6r2GWQ==
X-Google-Smtp-Source: APXvYqxxr4lB+ix4TyKAG4dkGchYeG6PzNU9nIfKAKgsrUD+z53aae3S6LqkREwsK3cSmT2xOF46gA==
X-Received: by 2002:a63:c046:: with SMTP id z6mr25023306pgi.81.1554703153518;
        Sun, 07 Apr 2019 22:59:13 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e1sm34389658pfn.187.2019.04.07.22.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:59:12 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2]  x86/boot/KASLR: skip the specified crashkernel region
Date:   Mon,  8 Apr 2019 13:58:33 +0800
Message-Id: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
fail to reserve the required memory region if KASLR puts kernel into the
region. To avoid this uncertainty, asking KASLR to skip the required
region.
And the parsing routine can be re-used at this early boot stage.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
v3 -> v4:
  reuse the parse_crashkernel_xx routines

Pingfan Liu (2):
  kernel/crash_core: separate the parsing routines to
    lib/parse_crashkernel.c
  x86/boot/KASLR: skip the specified crashkernel region

 arch/x86/boot/compressed/kaslr.c |  40 ++++++
 kernel/crash_core.c              | 273 ------------------------------------
 lib/Makefile                     |   2 +
 lib/parse_crashkernel.c          | 289 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 273 deletions(-)
 create mode 100644 lib/parse_crashkernel.c

-- 
2.7.4

