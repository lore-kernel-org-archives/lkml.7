Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F1AC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UHpvjhj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfIFPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:41:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41511 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392245AbfIFPlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:41:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id z9so6676886edq.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/TcN7fOifPGax1Jq40PHMF0EK7SlDS08IkccSojTBY=;
        b=UHpvjhj/b+3iPmUiNVdPjXOFzdSR9u8eZg6v7FAfkypqULaESyzADB/3E0G1AkEkNR
         Lp8I3t1bftgwOcuzcW2n2byutpV5BbBWkG00d6zYMuBg0Wf4juih5hnIVQ30wERZkO42
         orJl08eujiOsHl+blX6Hkfe0UnzoOC8HeNQyn2zEw6FuD2liDmdKTiQwOCOOPWUUQUrq
         i0UfvMU0TYqLIyuRgY978I+xXrDXcSjX7hTdo9RtugdRgTB6Ij+Esu3cAjKLJTX0AxAF
         M0acuyTnKUC/IW05ASrd/FZQtsdbwbSCUpPxWnd4khMHCCnwBz2K2dMpQDeoOrFxf1IL
         qPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/TcN7fOifPGax1Jq40PHMF0EK7SlDS08IkccSojTBY=;
        b=CKN3mFgnAkuBhNRTLJ4pCSATX/kmMFwB5zmPuA4rxvvonh+2juEdxP3VF9KWRQjjZO
         s/TAnEFdYRt9UwIpxSWK7Q8z+Dhg74v29UvEg8PFP6wN9i3wl8KER49WSOFD2t/UjN6p
         pOLYea4wft/jgLJOxuIwHzLWpCRrBKamfsZp9r6gi9Z2Ja4Zb8rlx5lyVlYoKLYt15lj
         O7vo94uI73iedkQBf4pBsD0/jLLD3JDMgNX0wFxNGH3sRe5MkOo88VXb72snRzbOrlhC
         3EUE0x52Zwb05iUQrNBmM1Hll0GmxIrIz1L8NFD0CMjmcV4EWxAsKMt/pGrivJfW9rxW
         WWCw==
X-Gm-Message-State: APjAAAUGp55tRUPnDEcUYlWjBpMdg61tDDtTi9CoceFty0u8TJW49CeN
        kuUaXd6nJVdOSI3iWZ6wI7W3vqw41hfwzWKPE4v0Tg==
X-Google-Smtp-Source: APXvYqxqjBbmqD7LIj2EqKBKAdltdsP4QbI+ZnJq02VDIJPVUgUjKlLGn6euHlVgtpT+xdsUOX7pyuDO609XO9GYCmk=
X-Received: by 2002:a17:906:bb0f:: with SMTP id jz15mr7785513ejb.264.1567784474126;
 Fri, 06 Sep 2019 08:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-5-pasha.tatashin@soleen.com> <2e826560-4005-fa16-8bbb-fc0e25763dcc@arm.com>
In-Reply-To: <2e826560-4005-fa16-8bbb-fc0e25763dcc@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 11:41:03 -0400
Message-ID: <CA+CK2bDU9ZZbXsqfEzMV9JDRUq0vMRNHObpQ0q-YtwbEbq702w@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] arm64, hibernate: rename dst to page in create_safe_exec_page
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > create_safe_exec_page() allocates a safe page and maps it at a
> > specific location, also this function returns the physical address
> > of newly allocated page.
> >
> > The destination VA, and PA are specified in arguments: dst_addr,
> > phys_dst_addr
> >
> > However, within the function it uses "dst" which has unsigned long
> > type, but is actually a pointers in the current virtual space. This
> > is confusing to read.
>
> The type? There are plenty of places in the kernel that an unsigned-long is actually a
> pointer. This isn't unusual.
>
>
> > Rename dst to more appropriate page (page that is created), and also
> > change its time to "void *"
>
> If you think its clearer,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

Pasha
