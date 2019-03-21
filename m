Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477BE218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BOoXzi1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfCUURr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:17:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46959 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:17:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id c18so6556291otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/wxyUvtToomdZ+5Q9o+FQ/M8e4o6ylXXt1G7gXDkthY=;
        b=BOoXzi1TLXiHBJG+1HwL+ID2AnLv3oZT6PlJ1aORSU6oRHSSgjPMihc1eXyKPMdyD/
         AqFJYySnhXSr/0KJyrtQDtju9Fr248wnuBcTNenyPVOZ0PHV8QNzp2jvcn1CbBa6l+An
         GMsEqyRqcPt8vX6qgUAu9wZb5RYF6Ezu+PIvFDfPlByy+bkmb4Blb0cd9dqhuxowHTZn
         MTjTD4Bg8pQ9Q9xgazplzVmi36XlNjsp/avPctiTShRqAN8PfMdK3maZbLpXpzZCOXP9
         hrNEmNbrANp5WxgBJCzg9g832X4/sb7Ijvgq0pfVeoOJ2/arzBW23a2dvX/XrfcOvwke
         sHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/wxyUvtToomdZ+5Q9o+FQ/M8e4o6ylXXt1G7gXDkthY=;
        b=uRLGd58GnGMUMKbJ3z6uIC0LlayX6idpGn/6d+6VYoGpEkNoYn8sVumjyGY1PU/dYy
         MJVa/nm8lm2GkkIQ73EuWPUG4jJH1oyKO/13jqVn+K6su92erwVuMOana9tmldZOwhNz
         4PC3ZC+4IeC3KxbemvLcTEzn8jDYDhABMwW+wXFX+FcsDQ7aRwUWfkIZdKvgsatLZdzC
         ENw0djumGOLwq74obIIROZGWWJDtB3Y3MsWVMMYPYUHC2M0HvcbOajRBrb8Zs7+QafXy
         M0QjEwfTyjJQZANzW+lEm8DWSYtz1yTbJYy6XIVsoyXGwwnaNHG4U4mFIQYlzkOjkVWn
         LAQA==
X-Gm-Message-State: APjAAAXPA5MDmn6VKSI29+xJLwQRkf2vkPww8WdNUSoWjzskocdR6Qdr
        +4tZ7WcbTWDzRDG84TYVpj3zPL77RVApsV3O2HQ=
X-Google-Smtp-Source: APXvYqwUYsousOMTeeL8c+A2HnTXT2l2mWYx2JCiWrVy/yAmVWlPJppOWrh94pnxO/J9vbn6442DXbT8N9OeaM9xXRs=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr3932876oti.348.1553199465574;
 Thu, 21 Mar 2019 13:17:45 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 21 Mar 2019 21:17:34 +0100
Message-ID: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
Subject: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, willy@infradead.org,
        rppt@linux.ibm.com, linux-amlogic@lists.infradead.org,
        liang.yang@amlogic.com, linux@armlinux.org.uk,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am experiencing the following crash:
  ------------[ cut here ]------------
  kernel BUG at mm/slub.c:3950!
  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
  Modules linked in:
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted
5.1.0-rc1-00080-g37b8cb064293-dirty #4252
  Hardware name: Amlogic Meson platform
  PC is at kfree+0x250/0x274
  LR is at meson_nfc_exec_op+0x3b0/0x408
  ...
my goal is to add support for the 32-bit Amlogic Meson SoCs (ARM
Cortex-A5 / Cortex-A9 cores) in the meson-nand driver.

I have traced this crash to the kfree() in meson_nfc_read_buf().
my observation is as follows:
- meson_nfc_read_buf() is called 7 times without any crash, the
kzalloc() call returns 0xe9e6c600 (virtual address) / 0x29e6c600
(physical address)
- the eight time meson_nfc_read_buf() is called kzalloc() call returns
0xee39a38b (virtual address) / 0x2e39a38b (physical address) and the
final kfree() crashes
- changing the size in the kzalloc() call from PER_INFO_BYTE (= 8) to
PAGE_SIZE works around that crash
- disabling the meson-nand driver makes my board boot just fine
- Liang has tested the unmodified code on a 64-bit Amlogic SoC (ARM
Cortex-A53 cores) and he doesn't see the crash there

in case the selected SLAB allocator is relevant:
  CONFIG_SLUB=y

the following printk statement is used to print the addresses returned
by the kzalloc() call in meson_nfc_read_buf():
  printk("%s 0x%px 0x%08x\n", __func__, info, virt_to_phys(info));

my questions are:
- why does kzalloc() return an unaligned address 0xee39a38b (virtual
address) / 0x2e39a38b (physical address)?
- how can further analyze this issue?
- (I don't know where to start analyzing: in mm/, arch/arm/mm, the
meson-nand driver seems to work fine on the 64-bit SoCs but that
doesn't fully rule it out, ...)


Regards
Martin
