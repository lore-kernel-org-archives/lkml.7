Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCE0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4442073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfG2JfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:35:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37292 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2JfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:35:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so52790846wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKfg/YzZ/kKbAR+g0cMsbALxccH9iNlGfj4yCp09JRM=;
        b=jx+K60Pwb9enSQvH8d/GfIx5Zy/NDD351QXPLfQjsxcbxj+VlBt8zhLuCLBtxZs2eE
         cJIyIALtxDfSwJwOx7doVIAU1Y2q58PibmnNmXvUWu6WnX3YZ+3Lh01XORrym/R3qV+W
         nyhqr/Yvz6YK+1DlxBIBUdfDwHdSqrWcUju4S/neJLUKPJotX/iDSlSfPNY7KqzWQjAI
         rp1Tr03iRTf2xrVv+qEkWb/IL7YlJtYPbBQxpS/UmKINrx/8R+u/x7dh4chtfqiXQb5B
         scetkVrUZDDJ0xvzr9imkNiyt/OaGQNygfYbBXOokb0XT22VzW63+mhiU5Higi6BkLRt
         iVgw==
X-Gm-Message-State: APjAAAVCEQI3lrz/Tqcg6YQZ9mmsoh1zdhyNnoLTPTbBbO9erWtd1TZo
        olwiJe8T9LTDFSZxgrCrEvrZwVRCMRzbl0cRcMA=
X-Google-Smtp-Source: APXvYqz/OhYicCcLtqkQnzQNoMEjcNe01xTQFKFL+dXyjIV5Vkz8OVN7FY7Cnac437nPx2UKb/3LUE/T0yzmDxN6SUY=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr100128923wme.146.1564392907896;
 Mon, 29 Jul 2019 02:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190722141133.3116-1-mark.rutland@arm.com>
In-Reply-To: <20190722141133.3116-1-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 11:34:56 +0200
Message-ID: <CAMuHMdWdSeRRSQJFDXh=_rzWuPkqt0aa=grvdyHdBYtYYkP-ow@mail.gmail.com>
Subject: Re: [PATCHv2] mm: treewide: Clarify pgtable_page_{ctor,dtor}() naming
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 7:27 PM Mark Rutland <mark.rutland@arm.com> wrote:
> The naming of pgtable_page_{ctor,dtor}() seems to have confused a few
> people, and until recently arm64 used these erroneously/pointlessly for
> other levels of page table.
>
> To make it incredibly clear that these only apply to the PTE level, and
> to align with the naming of pgtable_pmd_page_{ctor,dtor}(), let's rename
> them to pgtable_pte_page_{ctor,dtor}().
>
> These changes were generated with the following shell script:
>
> ----

Using "---" here might lead to the loss of everything below, including
your SoB.

> git grep -lw 'pgtable_page_.tor' | while read FILE; do
>     sed -i '{s/pgtable_page_ctor/pgtable_pte_page_ctor/}' $FILE;
>     sed -i '{s/pgtable_page_dtor/pgtable_pte_page_dtor/}' $FILE;
> done
> ----
>
> ... with the documentation re-flowed to remain under 80 columns, and
> whitespace fixed up in macros to keep backslashes aligned.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

[...]

>  arch/m68k/include/asm/mcf_pgalloc.h        |  6 +++---
>  arch/m68k/include/asm/motorola_pgalloc.h   |  6 +++---
>  arch/m68k/include/asm/sun3_pgalloc.h       |  2 +-

For the m68k changes:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
