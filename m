Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7632166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rNAgDbmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfGIGHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:07:04 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56225 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGIGHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:07:04 -0400
Received: by mail-wm1-f53.google.com with SMTP id a15so1703790wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5r7j4jcC3kETlGar58okHQ/hAZ22Gk6JgZUxbgvrRnk=;
        b=rNAgDbmuKgNJZMynFbdggadet2LTtPAbaBIVeGU3d6qB9AsDBtuSA+WkzkGaN1VURm
         rzKCHrxqPXHUZBbAzvytljp//FHhLpd2ATAbCrCDili2x5WOTMmE9psmF10wFwX27iVc
         bmIb+HulS/ulHRjnz119s2vNPHcC+vopgpJbe5Qzu73c1R+HdiJogKlelAdFd2JZEEhC
         AV93CS62fW1Fimf5OhwJQqt4wXZ0avXQCvfiT0MT22TRADM8+SSqc7RAXqrzUrJv+vy+
         TGg7ld1wGFd8ViLHES0p3e6aOBCLzE0IppWsvpdSQ2we7M3I2eq5ptKv5J+IAYX+Hnv0
         RWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5r7j4jcC3kETlGar58okHQ/hAZ22Gk6JgZUxbgvrRnk=;
        b=k5N8LyI1wC5O56q9Ln6rvsdwIU/k4b0y+04/zv8uuFHGGkQQqhLwiWT0QD/ozfKB1X
         vR75IomoJv89TM4aJ8DLrPDmfbUEfPp2RjZPTAu6AmhISuNTyXGG3b4aPDlo2XU4+07J
         POfBoxaqTLva1MLpTUz29Ss/qwIycDfbeJt4iX1U1w+zly8lxr3jOz6TBm883fPytKwr
         iePZCQ8KPZ4TO0o/J3qTKdWCyo2z1mw9z78FmmE98kAI+89sdWg1NJ5vpna3zkWokkhc
         +nOnq3IGQa2azj0k/mg+8wvB9TBYk67fLfOJdpKIRE7/aSoUMJPhdXkYzGUSvgGezcMs
         9oSg==
X-Gm-Message-State: APjAAAUOmshUzitRasv8nP5ZBabqH8L/z1VHWKRGPcr5YfWkpfBfCuA8
        CnJ5iRh2uzItgkR/wYbbBey4X0bm
X-Google-Smtp-Source: APXvYqwvCleyOiwvTzur+ReFglm/fTj9nl+DjhubmesC7MQGjCOkskRAN2yIHeCqEBngA1moTaRh4w==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20608500wmh.141.1562652421414;
        Mon, 08 Jul 2019 23:07:01 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.212.45])
        by smtp.googlemail.com with ESMTPSA id b186sm647263wmb.3.2019.07.08.23.07.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 23:07:00 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Warnings whilst building 5.2.0+
Message-ID: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
Date:   Tue, 9 Jul 2019 07:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've pulled Linus' tree this morning and, after running 'make oldconfig', tried a build. During that build I got the
following warnings, which look to me like they should be fixed. 'git describe' shows v5.2-915-g5ad18b2e60b7 and my
compiler is the 20190706 snapshot of gcc 9.

In file included from arch/x86/kernel/head64.c:35:
In function 'sanitize_boot_params',
    inlined from 'copy_bootdata' at arch/x86/kernel/head64.c:391:2:
./arch/x86/include/asm/bootparam_utils.h:40:3: warning: 'memset' offset [197, 448] from the object at 'boot_params' is
out of the bounds of referenced subobject 'ext_ramdisk_image' with type 'unsigned int' at offset 192 [-Warray-bounds]
   40 |   memset(&boot_params->ext_ramdisk_image, 0,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   41 |          (char *)&boot_params->efi_info -
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   42 |    (char *)&boot_params->ext_ramdisk_image);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/bootparam_utils.h:43:3: warning: 'memset' offset [493, 497] from the object at 'boot_params' is
out of the bounds of referenced subobject 'kbd_status' with type 'unsigned char' at offset 491 [-Warray-bounds]
   43 |   memset(&boot_params->kbd_status, 0,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |          (char *)&boot_params->hdr -
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   45 |          (char *)&boot_params->kbd_status);
      |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Happy to test any patches, but please cc me as I'm not subscribed to LKML.

Chris
