Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71129C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53620857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of5yDBo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDAPAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:00:07 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34848 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:00:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id f88so3179744uaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWyYXhuJcyFsk4pSTHQ+hyKA9Klg+sOQAa4AnF4CvfI=;
        b=Of5yDBo9xHzmDeFYxaxm8uK08Et6pPLeZMYzGqbkj1LnCG9sG/HtamI3CbUdOQbHHN
         889q3ld1g7Vw9LyeqGlgLlF1oMPlDQq/9qonuoaPvSug6NbAQyW2d5YJQaiAcqr/tkQk
         OVObsM1Lfnap3dE6mYcAEJ9TWaaCtPu0ByEVIIvlzzGpe7Y9EzUaFLUcZzRMDTFXnDtv
         ilJwfz31PR9CIk87XfxjDJmiRC60YBZSiCJHKaX+Q8EksTQ4C80yconrKI8jUyLL1pfs
         UnELvBk7fB8uu98nVU1NUs3GOuqHRAWC6syZZzQdmd85Knizj4DzquBlz6B6CB52R3mY
         x7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWyYXhuJcyFsk4pSTHQ+hyKA9Klg+sOQAa4AnF4CvfI=;
        b=FFy+V2i3YhtMWp0GYxvKMSc1t+xFlCLGR92cYmbE4l3UqDCMtdJBm8bu9jj6gmQzyK
         hqV11tnVQlyoDm9xtJCR4gm+w26dNLWkQnvPaVeTI+6SFB6b35hZZ2f6d8wmOdm1bCiI
         xqfZWEmGsrf3tszsqu1FZg4r7rdKVhMXLtRdOKe+YxaJ4hKPkPOQxawNHyQdf8RXx0Jw
         v6oCRcebYpM2iIpHwzNkZuoKfJ1qsQ8j+c325PeLK1d1Ul0ShXw+JMIQNhGfewXLSKfp
         mqshl8HsZueRS3gsXQ4DZqGa34DYv1aMWDjF5PxxGSsMaVxC4qS9+2IHhCtmFG14oiMJ
         l/9g==
X-Gm-Message-State: APjAAAXwHGF1CLWikZpaO4NUtWsSRGEZyLzZ3wT+9swBVBBgwhb2OYkB
        1YVSD4vHst12cisiKPMk+OsLC+PPJYiiM5hNde6ddBKRDcI=
X-Google-Smtp-Source: APXvYqxxJVm3BhXz6/kR8UnUUGLlsxH1WR4QL0Gvwli8cNqzpZ7WQ99UhD8em8MUOyvKs7+hiA4OKR0ZXL6dp9stvfc=
X-Received: by 2002:ab0:1ec6:: with SMTP id p6mr22542001uak.2.1554130805081;
 Mon, 01 Apr 2019 08:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190314032047.15790-1-vichy.kuo@gmail.com> <20190319153114.GI59586@arrakis.emea.arm.com>
 <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
In-Reply-To: <CAOVJa8HSB34ggku=96KAb6qju3G5-uGYFxCE6O2eQRMwU4bd1A@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Mon, 1 Apr 2019 22:59:53 +0800
Message-ID: <CAOVJa8Eefs7cEneNwV0VCrr8GLVb0AweJEb0Qo4TucgXTNuNWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] initrd: move initrd_start calculate within linear
 mapping range check
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Catalin:

> > With CONFIG_RANDOMIZE_BASE we can get a further change to memstart_addr
> > after the place where you moved the initrd_{start,end} setting, which
> > would result in a different value for __phys_to_virt(phys_initrd_start).
>
> I found what you mean, since __phys_to_virt will use PHYS_OFFSET
> (memstart_addr) for calculating.
> How about moving CONFIG_RANDOMIZE_BASE part of code ahead of
> CONFIG_BLK_DEV_INITRD checking?
>
> That means below (d) moving ahead of (c)
> prvious:
> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
> if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)
> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
>
> now:
> if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) { ---(a)
> if (memory_limit != PHYS_ADDR_MAX) {}              ----------------(b)
> if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {}  --------------(d)
> if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {}  ---(c)
>

After tracing the kernel code,
is it even possible to move CONFIG_RANDOMIZE_BASE part of code ahead
of memory_limit?

that mean the flow may look like below:
now2:
if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {} ---(a)
if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {} ---(d)
if (memory_limit != PHYS_ADDR_MAX) {}            ---(b)
if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {} ---(c)

in (b), the result of __pa_symbol(_text), memory_limit,
memblock_mem_limit_remove_map and  memblock_add
are not depended on memsart_addr.
So the now2 flow can grouping modification of memstart_address, put
(a) and (d) together.

Sincerely Appreciate your comment.
