Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E191C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176A5214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FQTP/Tmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbfIFTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:06:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45029 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfIFTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:06:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id p2so6079782edx.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2omJ3/dD4U+vCtoy8H75XszRI5XH+eQMkgkdDPlArY=;
        b=FQTP/TmgHTgyC+PBU5SEyiseIy1zvJC97N+VhKG2dCvL9vAhP80LEhoKJOvzIi6bLQ
         BgVBFgf58SS8R6ppJO3IlLnneB06um+xoINkqVeAcoexAD7EM8Pa8+VTq2HkDgPCOmt1
         TOn3ZhGsy7GLjFuJ1Jsk7gydcJxrPs9xEq3rZGr9mprwu/oe6WREKg8EsucNQZWw2j6w
         J7ifMbBwHA1GZOQh8cnKXT8qN31F/vuBtp4u7YqNI+J47VPkt/zp22gNmPCRdoGMqBlZ
         nVh7RyWgx3VRI12mKbkkekJb4SMfWKAg2SUtXlgb9KFbdoDmStmdx61Q+ALcL6DiU6Eb
         OcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2omJ3/dD4U+vCtoy8H75XszRI5XH+eQMkgkdDPlArY=;
        b=MnjxcovdT1CFN+VvCuF9DO2mVptvaL+8Fv7bKqIjQjBqLqRQtionK7CMfsaqDzB/eY
         8lImY0p/0nUjdXv4zvra5Pj+kvYP3R2vwoTQsURR2/pPdioRUV0HXsP/NC1rYqGPdl5j
         mczk0xZunAcJZFAwOILDtGXWH3WvMAddWxdudTYxREuuMHR0SZeUyCfCsS+HAN9GUN8W
         S5Q/N4dGJ56pE6NtBPlVZIcTM+kYAE6i/m7wyNOs5hT5ji5kHd766Iea8eINW3kG089/
         TOwomauVsxp1NwC64Lonc+bWaYhl1F/wbiIw4GMSwjSm0D3zOTIWP7A5LYFj1iehoRmt
         nG+w==
X-Gm-Message-State: APjAAAXflFfEkRGwTdItkk/swL5tY7aXpZw7AdrfWl8S/iQE1FERMMGJ
        2BpN321CuCznqnvkz+qBb5nD91bwapkwaiRiMI1wLQ==
X-Google-Smtp-Source: APXvYqxUyzboKtZynQf94VQal3O7BvvXwmvhzJw991UoDJCeN6nT1tLn0eiUP2pwGueZpl557B6qG/MIy5a1dR+RLhA=
X-Received: by 2002:a50:9ea1:: with SMTP id a30mr11569826edf.304.1567796807172;
 Fri, 06 Sep 2019 12:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-13-pasha.tatashin@soleen.com> <d4a5bb7b-21c0-9f39-ad96-3fa43684c6c6@arm.com>
In-Reply-To: <d4a5bb7b-21c0-9f39-ad96-3fa43684c6c6@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 6 Sep 2019 15:06:36 -0400
Message-ID: <CA+CK2bDxK5DHARkAUxzodhMDqokqEy3Y12F-bgHPF9g9K496hA@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] arm64, trans_pgd: complete generalization of trans_pgds
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

On Fri, Sep 6, 2019 at 11:23 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Make the last private functions in page table copy path generlized for use
> > outside of hibernate.
> >
> > Switch to use the provided allocator, flags, and source page table. Also,
> > unify all copy function implementations to reduce the possibility of bugs.
>
> By changing it? No one has reported any problems. We're more likely to break it making
> unnecessary changes.
>
> Why is this necessary?

I tried to make it cleaner, but if you think the final version does
not make it better, I will keep the current versions.

Thank you,
Pasha
