Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE97C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA821928
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkyWCxmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKKJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:44:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:44:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12504996wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyGmHFPAq5MfFWdVpHAlD4EbsOFVG2Efcfbi4EJCxA8=;
        b=lkyWCxmvKBof7iItTmaB71uyz6oqJTFW2bQpJkvXn0WLVrdk8YZuLe53ZZTjEqgq5k
         W1kwPabkfEkTtnIHzP0gE2Cxr3Vc8YribXNSLbcB4drD+v8g/8jGORCoxVmrhrcwmcE8
         tYMG0SImcnIlqhl68380xL/ubgLmb80IJole32NOhZV67G5eM/CuvBIWajhFHhfeRYgH
         tJKNjhSBQludY+eABLZp9qdgNM5PeStR2XGg9gMzKQublYnZufw8tqIyN5u2PpR5/5Dj
         Y4RX5dAvqKga6OEvdIZM4bRFLccaElKZ0pqgvGwLDRqJJ+1VdF++h8nx5OCeitYE0KGq
         6rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyGmHFPAq5MfFWdVpHAlD4EbsOFVG2Efcfbi4EJCxA8=;
        b=oDBt2/4Ayz+3B2hwMzxbaVx+sfdFLHBwrP4AsDLujkyp8eng11ZLVUYykpWcQ0kCyS
         48gJgn3W9QCoXLIBiEnhPfYANZmWutAfQTaahdU7FVGy++JTIXPGMkSiF0Ma5+gQNNKX
         E8tm/ex1qO2xhOm/sl6OdBeN9denLBE4WBLtqBILKDD/NUiC8rKCx3ZXq0mQn4Ep68af
         a9iD09LLRZu8IbhvRkL6+SrRqSGBJv6HZp5qGqIiczgbqghNDtqdnuJ2WFznxFJwP2YG
         tuoajO/HZzUsYQqDBQruLiFOapD4T8s9f8F0FaxQCHXYVBSzrYbzyeopQsaGRGKfJcJy
         fDbw==
X-Gm-Message-State: APjAAAWGgVj8Yet7c1FEZBbrIGOBMAAPGB9Wm7u8b337ErWSSwfDzUte
        8xfPeLcFf+m296tpmEOOt3NJ95HsPbW6yaNovtPFDg==
X-Google-Smtp-Source: APXvYqxrlb7SP7eTmE5hQeLx53eyUjf5tTLurh+KzNkL06pAbGV4qk3tTWVeJmJ5824+3L3yDLMiJHa9NY31q7nWnww=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr18115743wmb.136.1573465456652;
 Mon, 11 Nov 2019 01:44:16 -0800 (PST)
MIME-Version: 1.0
References: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com> <dcca9d9b-449a-1a97-c792-467966d8eec2@arm.com>
In-Reply-To: <dcca9d9b-449a-1a97-c792-467966d8eec2@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Nov 2019 09:44:05 +0000
Message-ID: <CAKv+Gu90hqAefaWyXVb7CMGv8JF4nniVKVNNtUg-KOFPdNcOXg@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 at 05:27, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 11/11/2019 10:43 AM, Anshuman Khandual wrote:
> > A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
> > error rather than 0") changed the return type from EFI_RESERVED_TYPE to
> > -EINVAL when the searched physical address is not present in any memory
> > descriptor. But the comment preceding the function never changed. Lets
> > change the comment now to reflect the new return type -EINVAL.
>
> In the subject line, s/PATCH/PATCH V2/. Not sending yet another patch just
> to fix this (in order to reduce spam). But please let me know in case that
> will be essential.
>

No worries, I can queue it like this.

Thanks,

> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: linux-efi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > Changes in V2:
> >
> > - Changed comment for efi_mem_type() instead of the return type per Ard
> >
> > V1: (https://lore.kernel.org/patchwork/patch/1149002/)
> >
> >  drivers/firmware/efi/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 77ca52d86e30..47b0bf7a2b7f 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
> >   *
> >   * Search in the EFI memory map for the region covering @phys_addr.
> >   * Returns the EFI memory type if the region was found in the memory
> > - * map, EFI_RESERVED_TYPE (zero) otherwise.
> > + * map, -EINVAL otherwise.
> >   */
> >  int efi_mem_type(unsigned long phys_addr)
> >  {
> >
