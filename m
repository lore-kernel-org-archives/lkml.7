Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E2C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED74206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn03DCxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKMUax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:30:53 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45175 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:30:52 -0500
Received: by mail-yb1-f194.google.com with SMTP id i7so1486982ybk.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhUJSPQDvSVcW6lExUu0Aos25QWc66JPMYbcEiKuXrc=;
        b=Nn03DCxiI7YI0L9xwwcV+FWANHJyX0Nosiah9C9ZEYM6RrUknHizEw0/Ycd051SlK3
         p+Abqia/sM7br2NF1iq6mgg7c3AqnCya0VFzL+xCg6m/DvN2uAaXNdeI+hA1pF0mlLm7
         lajPR7C6kVPLXfNzWmevC8ueutQUsmor9IfCJkTa6m9g1VjBQ0cCm0ROz3JWUfbpI+eB
         PiOheiqaWiP9+CJ6BJaOZOv4+4gGvcJ41Un+Wqvod2rKcV1KbUYOz4xORFCqDAbJgbQQ
         562C+TZg0L8TjWX3oLB+QWrwC15uulzsY5TV58YDTkSLEnYd9pPzqLJ2FvpCLH1ZoccY
         jJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhUJSPQDvSVcW6lExUu0Aos25QWc66JPMYbcEiKuXrc=;
        b=iWZH0zWqLnXNXQIMbihKB54SQ0iEJp9s6ysyHE2uDL/CdFluk0SRGkaDBbdmb1G3mM
         Uxq4Odp9F9mRRMc5phNXrLDsp7eDrg/rqbCFBfNJUCwkWWRN9mV8KAylEUavIHJl0V4v
         Wex93vteoxva9G7raGOKXey/4W5ERbOiMeMo283b9cw7LFYJrR4ItoR/KqO5oYMjhwfl
         J6SidmD0fecQLL2Syf/u+jYph4SrS9FIwssos+lbXmo/Csu3NQOzh8Nq55+OUpIm3BS0
         k2+cLRgfLllFLOruM68uyuahNzRJFG+fShMnWW0lgweh+hFvboS70As/mD6P4/j6lfxJ
         KJtw==
X-Gm-Message-State: APjAAAX3eFZAoptRPbVKBmieHGrahKSc2Dmrw9nFxw9arVp+BVyMJddo
        AfxQqTVw1iN/Y4gJ/LMNNCgAtbIU4feDOgV1gEc=
X-Google-Smtp-Source: APXvYqxtTDE1DuX7odfSWA32rCc5N/jNL04v+VM3rGUIhjMW0FCHmUvG7BWWqqzfvcrhoqFMyCvgmEKAHAX+rTFSN4k=
X-Received: by 2002:a25:768d:: with SMTP id r135mr3778035ybc.25.1573677051679;
 Wed, 13 Nov 2019 12:30:51 -0800 (PST)
MIME-Version: 1.0
References: <1572964400-16542-1-git-send-email-rppt@kernel.org> <1572964400-16542-3-git-send-email-rppt@kernel.org>
In-Reply-To: <1572964400-16542-3-git-send-email-rppt@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 13 Nov 2019 12:30:39 -0800
Message-ID: <CAMo8BfLpdy4biZ4UvE4PDhscCFOj75nHWTwO+HFXpWx1qQOmEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: get rid of __ARCH_USE_5LEVEL_HACK
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Nov 5, 2019 at 6:33 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> xtensa has 2-level page tables and already uses pgtable-nopmd for page
> table folding.
>
> Add walks of p4d level where appropriate and drop usage of
> __ARCH_USE_5LEVEL_HACK.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/xtensa/include/asm/pgtable.h |  1 -
>  arch/xtensa/mm/fault.c            | 10 ++++++++--
>  arch/xtensa/mm/kasan_init.c       |  6 ++++--
>  arch/xtensa/mm/mmu.c              |  3 ++-
>  arch/xtensa/mm/tlb.c              |  5 ++++-
>  5 files changed, 18 insertions(+), 7 deletions(-)

This change missed a spot in arch/xtensa/include/asm/fixmap.h.
I've added the following hunk and queued both patches to the xtensa tree:

diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index 7e25c1b50ac0..cfb8696917e9 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -78,8 +78,10 @@ static inline unsigned long virt_to_fix(const
unsigned long vaddr)

 #define kmap_get_fixmap_pte(vaddr) \
        pte_offset_kernel( \
-               pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), \
-               (vaddr) \
-       )
+               pmd_offset(pud_offset(p4d_offset(pgd_offset_k(vaddr), \
+                                                (vaddr)), \
+                                     (vaddr)), \
+                          (vaddr)), \
+               (vaddr))

 #endif


-- 
Thanks.
-- Max
