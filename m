Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9620BC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633E321855
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stV/qm9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfGXXPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:15:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39067 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfGXXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:15:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so17684705pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXbvlGcsLXDRlzCNhQWh1dqxoz1sQFBznCCX79YHCDM=;
        b=stV/qm9TLz5ZykNYfa2/VWBhvh9KuZ2fGyYhB0yBhK4ewV9oO5e9OxWKH0NFhK6eTl
         IpvLsZGRH6XSw4RXK235BmihF7G6q5HvagKdjHMXxm14F7eC0SJqnIc0RcThKnNNJYWR
         H000iVHYNgTLW8AvNc+ksHK3xObYTrKZRwqyk/FVDHOJ+gVnFDfascolUS1y0MB+2x+m
         KsEmGXoypl0PGaFtRXw3fnT3j/WgHXM5W9EAjSd3ccSL/l3wzS9UeF3ygmfADQjFFimj
         d6MCRitBYzwP/gel+Mipg/yIIqOMN4kXJKhWKjDXUoTTKS8K0HN1aadl1facC66UQX3x
         4ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXbvlGcsLXDRlzCNhQWh1dqxoz1sQFBznCCX79YHCDM=;
        b=j08neLu+zu5oSabdjy+Jm64WIuZuToqz4sgIScB/myrJyEeSegVuODKfSxY500hsxO
         T8CXqHDQ0lWgASFgWg7VhYMkohAdf5yUDPtuYxA6gF1QHqb3dPdjmIxcdMaEEdyhsrSA
         rgoo4QpWQQhsZwU/49E/gnE8+Xk3CwqRFZrfPsb+9PtRwVX4oVfEAp56xpups6q9CvyW
         x75rCldf95hvjIDqljvEOvgjQV3SIWMsuItfbjzq3elOC4T5jqzhemS+ZA6HUBlQjZSB
         EmYieGIRtceY2eiDi0tVOln0np9cVxVt4Dguytb+QUAyswWVS1lIU2M1Z2I869/GshSo
         0XnA==
X-Gm-Message-State: APjAAAXgzUkopOvjrr2jgfdSSupj5zQZgeChj83eLGESBNacHa60/S10
        4Y8PWsuvkqUCy4Gv442I/Ue2DnHS
X-Google-Smtp-Source: APXvYqyfIx/NOj+Cfi1J0PhID1ZUhHU4V62rnjerjmLK1RBq1y1Fw+Ig6Xbtlu6c1y53LrZhxSsYrg==
X-Received: by 2002:a62:64d4:: with SMTP id y203mr13559656pfb.91.1564010131930;
        Wed, 24 Jul 2019 16:15:31 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x67sm50275523pfb.21.2019.07.24.16.15.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 16:15:31 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     "H . Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] x86/boot: clear some fields explicitly
Date:   Wed, 24 Jul 2019 16:15:27 -0700
Message-Id: <20190724231528.32381-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

I just ran across this on the latest (well, any -rc1) linux.git, while
working on something else. It generates an ugly multiline warning:

In file included from arch/x86/kernel/head64.c:35:
In function ?sanitize_boot_params?,
    inlined from ?copy_bootdata? at arch/x86/kernel/head64.c:391:2:
./arch/x86/include/asm/bootparam_utils.h:40:3: warning:
?memset? offset [197, 448] from the object at ?boot_params? is out
of the bounds of referenced subobject ?ext_ramdisk_image? with type
?unsigned int? at offset 192 [-Warray-bounds]
   40 |   memset(&boot_params->ext_ramdisk_image, 0,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |          (char *)&boot_params->efi_info -
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |    (char *)&boot_params->ext_ramdisk_image);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/bootparam_utils.h:43:3: warning: ?memset?
offset [493, 497] from the object at ?boot_params? is out of the
bounds of referenced subobject ?kbd_status? with type
?unsigned char? at offset 491 [-Warray-bounds]
   43 |   memset(&boot_params->kbd_status, 0,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |          (char *)&boot_params->hdr -
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |          (char *)&boot_params->kbd_status);
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It looks like this hasn't been touched since 2013, so maybe gcc is
just getting more agressive about warnings. Well, we know it is, actually.

Because struct boot_params is __packed__, normal variable
variable assignment will work just as well as a memset here.
Change three u32 fields to be cleared to zero that way, and
just memset the _pad4 field.

This clears up the build warnings for me.

Testing: just did a basic boot test on my x86_64 machine, no problems
seen. Not that that tests much, but it's something.

John Hubbard (1):
  x86/boot: clear some fields explicitly

 arch/x86/include/asm/bootparam_utils.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.22.0

