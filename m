Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CCC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD182077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgizClqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:06:37 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53251 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfLMKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:06:36 -0500
Received: by mail-wm1-f49.google.com with SMTP id w8so2443324wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+rlYMc2KNlfCSipz87Dx8MOlcEdyV+FRCGwdwiR89S4=;
        b=QgizClqgcNBhg3DZ/gMdJJkxWs2yA5uP2gr/yfHfDOMbiAFxcpx66IDlM6ZlX9xcQi
         YdZ55rDYt/pOaz7wAcI8xzyrADkzJ6PmAubTqrXTmIqnt2umpFnmsmWW+MbVYINoFTOG
         oC817GMS6eP2oJsLda/C8+0rempJCK82fR5Ciu+4RJS4hSa8AfCEtKauRXi23bSgSttZ
         FwUC13O8m3XhSUVW/Mc0gYp1RjlQwLbuEIvVg9X2I8V5W4iKwiCwIC5k0FVYo6SddFmf
         ZA+dGfBzVZaFx1BinOxKXzm2/2ZrRDsoPAbl63WpCP95vZiO3K/UmscU8QQT3HO2qa52
         4HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+rlYMc2KNlfCSipz87Dx8MOlcEdyV+FRCGwdwiR89S4=;
        b=Od0kxKIay+0JZV/UVfNeNJceQDXzzTYwyfBuVPCeGAOnWlkIU7A5Nv9ci+4+QQ+aLy
         jLnB4uD8lKewvtw85PGGN5Xfb6qT+Y9juVeWfA0S3p+B29iZEypb8mMAWD2OhmaRt8eV
         UuzgKK5Oy8VoHj2kS+EQpTlMNgapBicqNswMxAiZiqASB8X0tKWd3C4l+KjACNy5AnsB
         GSq6Gh0uuC0jeo/D9YOc6BNkvvyZcUWrW6Dqx+CThuzI2dmbTOaMiVTAr7pmDlwk8/ea
         sqhHw0+gJuFhCO8mP/QHV0jdj1fcMwgXGGmN2LH1VQc66xCdwh0De9FpTL9jTHs8z6xW
         3m/Q==
X-Gm-Message-State: APjAAAVNCji8egLM+JrKqph+N89QSB8S7IvuG3FBMKyrb3OyzMbW4sSf
        ih9LrpKtPSRF1+Fa66VZWVkdX5x2ZVuMBS4vxt/V/g==
X-Google-Smtp-Source: APXvYqwhfie7yC2WSB/tzR5vda3NKYmism85YFihHtBgln1Ispzm2hSfZeOIN1+Zeio5jvnuK+pMGPjhUB6ChsQodp8=
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr3641271wme.148.1576231594029;
 Fri, 13 Dec 2019 02:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20191212222305.GA10385@rani.riverdale.lan>
In-Reply-To: <20191212222305.GA10385@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Dec 2019 10:06:32 +0000
Message-ID: <CAKv+Gu-t9pUNG8KuRn=O=2q6McvKYHF_5EYzdh4bYKksqxab-g@mail.gmail.com>
Subject: Re: efi/gop: do we need to check ConOut any more?
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Eugene Cohen <eugene@hp.com>,
        Matthew Garrett <mjg59@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 23:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Since commit 38cb5ef4473c ("X86: Improve GOP detection in the EFI boot
> stub") we check for a GOP device that implements ConOut protocol to find
> our primary output device. The commit log says that this was done to
> avoid problems with the ConSplitter device, which exports a virtual GOP
> interface. The original version by Matt Fleming checked for PCIIO
> protocol, with a note that says there are some Apple machines have GOPs
> without hardware, I assume that that was the same case, GOPs from
> ConSplitter.
>
> However, since commit 540f4c0e894f ("efi/libstub: Skip GOP with
> PIXEL_BLT_ONLY format") we skip GOP's that don't have a framebuffer.
>
> Looking at the EDK2 implementation of ConSplitter, the virtual GOP will
> advertise a framebuffer iff it is attached to exactly one GOP device, in
> which case it passes through all the information. If it is attached to a
> UGA device or to more than one GOP, it will show as a non-framebuffer
> GOP, so we will skip it anyway in those cases.
>
> Given that, is it still necessary to check for conout at all, or would
> it be enough to rely on the framebuffer check?
>

If it doesn't hurt to check, I'd prefer to keep it in. UEFI is a can
of worms, given how many buggy implementations exist in the field.
