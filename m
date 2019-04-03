Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SowecZhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDCC6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:58:41 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:55300 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCC6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:58:41 -0400
Received: by mail-it1-f176.google.com with SMTP id z126so8698670itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDAlw57SiOhCqoHDQpobUVdPGLSt30DBZUBllkvzPEw=;
        b=SowecZhSxDaI5B+UH8e7HZ0QxnBjbsD8p43QAGMTIgEeUbPDoEif8nGW3Wj1fLQFRp
         u7Z1SiAnqpP1YFWJWmstSpse9Ssosy8bdU5grGrm9rHImZHpPNt1DD2FMngiljkG5scA
         5aVDi+GKxaJheC5+XWGtFBo7XSQAdKfX7Givr2tNDWC+2r+WS/cbjUzSE0xEJaF1tGfl
         vhOj7qHFQ29RNMwgYJmscgBPFKCN0XpPFwwSINysR0w4ZYiP48wS6mhAhsEcTpJtsp0u
         QTyk1SKJIgOynEwJiA5LEchR0Wc+yhSF9VZTtQTO7uFXf7gLzVE6ukU8Hdx3Gw94bHSX
         wIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDAlw57SiOhCqoHDQpobUVdPGLSt30DBZUBllkvzPEw=;
        b=HgbXHE28bWhscF+KXXqU7XabxggCzFqYJ1936iqEB4kuxZ2ywrI0sWezwABlSchkT+
         65S8ri/aCosShKRaWnC6ZWPt1U7aczpGDAW0SjTtHjjuyDSxC1TBcA+OtUYhNNre13ar
         k75w4f+YCCx/I7Tmy/4e+jgphCTeZyek/wTYm1JMkeW0RN9WA1nGUb+rEWxG7cvDSBnh
         ddUSYZxrjNCuon2Yjuvw24K/zPiLRYz9bG33HY9emo1LriW0PThMIL1TM8c5j41Vut27
         YLHd3aB8V92YAVUhsHgAOi2L9K0u0dGj+GR8/2YPkpLpYRFLhbpxGd/jYHLco/gO9+IB
         40Sg==
X-Gm-Message-State: APjAAAXKGiRh0HtYnkbkXvD4ZoH+47hRfXcyfOhljVEAEnoUW5SGYy2B
        Wn6y1K8nSGsYLByzVWHHDhrTunDJuZnda/ki1g==
X-Google-Smtp-Source: APXvYqzoi+rBjVVEIoA3EuddeaHKg8I3We5VfmXj2d+aezVVkSVtRsGvdwq9/DcZI9+QcPyaygd4frU6xRSsgTpCeGs=
X-Received: by 2002:a02:ac14:: with SMTP id a20mr55863492jao.130.1554260319988;
 Tue, 02 Apr 2019 19:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com> <20190402080811.GO7627@MiWiFi-R3L-srv>
In-Reply-To: <20190402080811.GO7627@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 3 Apr 2019 10:58:28 +0800
Message-ID: <CAFgQCTtYLVS8Mfztg8=PWEn8cxDm9Lm1p=zXDR1YG8Oo0MLx0Q@mail.gmail.com>
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 4:08 PM Baoquan He <bhe@redhat.com> wrote:
>
> > +/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> > +static void mem_avoid_specified_crashkernel_region(char *option)
> > +{
> > +     unsigned long long crash_size, crash_base = 0;
> > +     char    *first_colon, *first_space, *cur = option;
> > +
>
> Another thing which need be noticed is that you may only need to handle
> when '@' is found. Otherwise just let it go. Right?
>
According to kernel's behavior, only the last "crashkernel=" option
takes effect. Hence if no '@', then clearing mem_avoid

> > +     first_colon = strchr(option, ':');
> > +     first_space = strchr(option, ' ');
> > +     /* if contain ":" */
> > +     if (first_colon && (!first_space || first_colon < first_space)) {
> > +             int i;
> > +             u64 total_sz = 0;
> > +             struct boot_e820_entry *entry;
> > +
> > +             for (i = 0; i < boot_params->e820_entries; i++) {
> > +                     entry = &boot_params->e820_table[i];
> > +                     /* Skip non-RAM entries. */
> > +                     if (entry->type != E820_TYPE_RAM)
> > +                             continue;
> > +                     total_sz += entry->size;
> > +             }
> > +             handle_crashkernel_mem(option, total_sz, &crash_size,
> > +                     &crash_base);
> > +     } else {
> > +             crash_size = memparse(option, &cur);
> > +             if (option == cur)
> > +                     return;
> > +             while (*cur && *cur != ' ' && *cur != '@')
> > +                     cur++;
> > +             if (*cur == '@') {
> > +                     option = cur + 1;
> > +                     crash_base = memparse(option, &cur);
> > +             }
> > +     }
> > +     if (crash_base) {
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > +     } else {
> > +             /*
> > +              * Clearing mem_avoid if no offset is given. This is consistent
> > +              * with kernel, which uses the last crashkernel= option.
> > +              */
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> > +     }
> > +}
