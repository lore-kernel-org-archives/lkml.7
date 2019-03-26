Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82892087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbw3ccyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfCZW1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:27:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39090 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfCZW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:27:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so12605554ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MY6geL1C4e1zi1eCmJeExb/Ee8HRUHJ9waYR3/unZU=;
        b=Pbw3ccyh3V3o3JDVt0w7NoTp68sq1FJ9PffEoRtUfZhlOu5noOHPPinBsaRtBka1Jz
         iGe1JYKXPXLNvJa606IfQLp1kKcubeeRsu/bdVW0ZNEspB+Pz3SYL2JMlFVAxDO82VkX
         6haorFxk/nekxvaxjp8ZBmlHVTSJM+Z/AzU2S3rqMc//37qXLO0PiCpQ2EblNRLMCfCd
         t7bWzyqS3IHfGymisr+N12V5celmXhq3OBSeiU/wcHy5aNdExb3PgrT3R5PirqNO+RQl
         7wEj7yVZ10emVccmOVXWNUxYfEdDOgRZ/v6QdFe9OZ5uPI5xNaVtvmdwI1lpFjsG/PaE
         sUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MY6geL1C4e1zi1eCmJeExb/Ee8HRUHJ9waYR3/unZU=;
        b=FQ9J+xvagcGOhODhICVPKlDoUyd1DmUrqGJWZeo5LRMr/7Ldwd0Dsn/DH+jWCIgl9N
         SS9kM/B9SOYm5W5u7eHK99oFLdJAyg5R1f+i5B4envCZYQNXnU9ns781Wp9Pjl9LrxGC
         7DtFaH/uaIwWvjobJ8D1Nrr2FqI35pirahSvN2TjpI2RZAJGHaOaiWkJ1r3NqLzQhV/3
         mPoU8fby3HMPzI9eVnnmeGJan9lC5PlSS98KgFbqAUKQpqJjk5Cpni1bdtgwYwJiwSXZ
         SYLOECXghuoWK82vXhyLnjpaCjzJC7sI8zK/t4yJ8O4dej5CWnTBzrXVYikPoWXnUgGK
         OsTQ==
X-Gm-Message-State: APjAAAVi9KCboyzmxCz0fRdjIbZrDoiJ6lWKAJ8EYycVQxr9V8FvCSo4
        EolIYemQ4U9Vgq9cSRXAzK+OgD5uQimh41rwT2E=
X-Google-Smtp-Source: APXvYqzHFG3NGRGQYlGcWMPL14ZLjEt2wy8ksup8izCm8OJZoqsDyovqYQ7660IS7Tt6Oq9CqbF7xvcYnTSayvi4hBw=
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr17271116ljj.128.1553639259897;
 Tue, 26 Mar 2019 15:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190320223853.1209-1-alistair.francis@wdc.com>
 <20190320234858.GA5304@infradead.org> <CAKmqyKPsoi7F_NNLKcm269=VAgdvsUV7HdF3dtkpMBzaKbHhtA@mail.gmail.com>
 <20190322132748.GD19263@infradead.org>
In-Reply-To: <20190322132748.GD19263@infradead.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 26 Mar 2019 15:26:20 -0700
Message-ID: <CAKmqyKPipi860QSD5ZDHZa-ZOFXnYyq4cy6uYH8acMt_X5sLdw@mail.gmail.com>
Subject: Re: [PATCH] irqchip: plic: Fix priority base offset
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 6:27 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Mar 20, 2019 at 05:04:58PM -0700, Alistair Francis wrote:
> > > Well, it starts at 0x00, but the first one is reserved.  If you think
> > > that is too confusing I'd rather throw in a comment explaining this
> > > fact rather than making the calculating more complicated.
> >
> > It doesn't mention that it starts at 0 when you look here:
> > https://sifive.cdn.prismic.io/sifive%2F834354f0-08e6-423c-bf1f-0cb58ef14061_fu540-c000-v1.0.pdf
>
> It doesn't say that.  But it is completely obvious from the map,
> and from how everything else works.  In this case I think the
> documentation is simply written in a confusing way, and we need to fix
> it once we have an official riscv spec level documentation of this
> hardware.

I agree that the documentation is written in a confusing way. In
saying that we make it even more confusing by not following the
documentation and doing something different, which is what we are
doing now.

If the documentation changes in the future we can update the code to
make the new documentation but at the moment I think it makes more
sense to match the documentation. It makes it a lot easier to compare
the code and the documentation when they match. Hopefully that can
avoid and off-by-one index issues as we have seen recently.

Alistair
