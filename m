Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47BC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF39206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fupIWZnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfLMAQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:16:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40838 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbfLMAQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:16:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so403869pfh.7;
        Thu, 12 Dec 2019 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rz7Ap8NSB2+QwfjX22YVS15g9RA3g1APMaXnf9JhgX4=;
        b=fupIWZnf7eC60SsffWCDQxq7sVQjLX+ADuUuuTBkjb4ABWmcvAP2GHPLRqVZ0+F8Iv
         uWw+yx8PmsgmYRt+vtwN1Q6mUCVOu7e9cr4zSUYWKlYB8pZDh5b7zOesGEYijm/rs6x/
         OlTapLIoOeZjI3ggnXYKUUGg9/cpyLJT6Y5c17WWbTnJYc0pB6E1eKeQ2hVUXqAKmFFF
         9YaH6qa+4dI8Nag0NJCvLJ5oH28ZtFzBvHW32RVplML1GZyU6Licl6RwNH82jTXK7DIU
         8TDwao8t/HM20lrTlgmc5DU+oWmXvIn0Y2lBdtMz4ehXmY+uwugJyLhgUmlNstyuvoJY
         Ostg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rz7Ap8NSB2+QwfjX22YVS15g9RA3g1APMaXnf9JhgX4=;
        b=hoQ1rzfohtRtV7fIJ05isKbqEosheLCd7kIHUFi4M3IYTwKuY/VWXCPPLIxucazYan
         v6dbmAn/VYbdmNKMGQKlr8rPS0oQ8ijhFpsK+qNw2ecNK5xOCi9DJdSOo04adwyGhLgO
         qwZUMN7T2z8tffz2x8R4Q5aE0dQ39sJD97fht1JUuy0XyUwnfOUQrsD5ALBSG/HxfG6O
         Fh3yYxEijVW6E053/sNOP7EU3jhH0QDr2FcKoA51oH4XfGp9gSXjiSr+UlnMG9OU7nKU
         xFA1RkSMpG0AduLFOml0cIDyLx17q0LN87VCyEkqLHlNZNR3+JbHdBKw9NM0eMnW8Y41
         bT+A==
X-Gm-Message-State: APjAAAXMj+HvC443DB1wQUEOsnDg9kZ2njw0qXxbc6j85hsJEs7jndVP
        FGExRJHaw4b3EHRAB0kbef4=
X-Google-Smtp-Source: APXvYqzdi9TTVeyNm4GDapF0tocbS/2DKfHDlMK1xI+DX6Yv8E32E2ylfND+lyJY/Mep/9YSafcUWA==
X-Received: by 2002:a62:ed0b:: with SMTP id u11mr12700624pfh.46.1576196191905;
        Thu, 12 Dec 2019 16:16:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c8sm8711705pfo.163.2019.12.12.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:16:31 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:16:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191213001628.GF101194@dtor-ws>
References: <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
 <6a647c20-c2fa-f14c-256d-6516d0ad03b0@free.fr>
 <6ce49a67-8065-277b-5f80-ed47011e50d6@arm.com>
 <20191212191002.GA101194@dtor-ws>
 <3ce51e0b-f4eb-707d-c55d-0eaf4ac72c5a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce51e0b-f4eb-707d-c55d-0eaf4ac72c5a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:08:04PM +0000, Robin Murphy wrote:
> On 2019-12-12 7:10 pm, Dmitry Torokhov wrote:
> > On Thu, Dec 12, 2019 at 06:15:16PM +0000, Robin Murphy wrote:
> > > On 12/12/2019 4:59 pm, Marc Gonzalez wrote:
> > > > On 12/12/2019 15:47, Robin Murphy wrote:
> > > > 
> > > > > On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
> > > > > 
> > > > > > On 11/12/2019 23:28, Dmitry Torokhov wrote:
> > > > > > 
> > > > > > > On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
> > > > > > > 
> > > > > > > > What is the rationale for the devm_add_action API?
> > > > > > > 
> > > > > > > For one-off and maybe complex unwind actions in drivers that wish to use
> > > > > > > devm API (as mixing devm and manual release is verboten). Also is often
> > > > > > > used when some core subsystem does not provide enough devm APIs.
> > > > > > 
> > > > > > Thanks for the insight, Dmitry. Thanks to Robin too.
> > > > > > 
> > > > > > This is what I understand so far:
> > > > > > 
> > > > > > devm_add_action() is nice because it hides/factorizes the complexity
> > > > > > of the devres API, but it incurs a small storage overhead of one
> > > > > > pointer per call, which makes it unfit for frequently used actions,
> > > > > > such as clk_get.
> > > > > > 
> > > > > > Is that correct?
> > > > > > 
> > > > > > My question is: why not design the API without the small overhead?
> > > > > 
> > > > > Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at
> > > > > least as big as two pointers anyway, so this "overhead" should mostly be
> > > > > free in practice. Plus the devres API is almost entirely about being
> > > > > able to write simple robust code, rather than absolute efficiency - I
> > > > > mean, struct devres itself is already 5 pointers large at the absolute
> > > > > minimum ;)
> > > > 
> > > > (3 pointers: 1 list_head + 1 function pointer)
> > > 
> > > Ah yes, I failed to mentally preprocess the debug config :)
> > > 
> > > > I'm confused. The first patch was criticized for potentially adding
> > > > an extra pointer for every devm_clk_get (e.g. 800 bytes on a 64-bit
> > > > platform with 100 clocks).
> > > 
> > > I'm not sure it was a criticism so much as an observation of an aspect that
> > > deserved consideration (certainly it was on my part, and I read Dmitry's "It
> > > might still, ..." as implying the same). I'd say by this point it has been
> > > thoroughly considered, and personally I'm now happy with the conclusion that
> > > the kind of embedded platforms that will have many dozens of clocks are also
> > > the kind that will tend to have enough padding to make it moot, and thus the
> > > code simplification probably is worthwhile overall.
> > 
> > I wonder if we could actually avoid allocating the data with
> > ARCH_KMALLOC_MINALIGN in all the cases. It is definitely needed for the
> > devm_k*alloc() group of functions as they are direct replacement for
> > k*alloc() APIs that give users aligned memory, but for other data
> > structures (clocks, regulators, etc, etc) it is not required.
> 
> That's a very good point - perhaps something like this (only done properly)?

Yes, but it has to be done carefully.

> 
> Robin.
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 0bbb328bd17f..2382f963abbe 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -26,14 +26,7 @@ struct devres_node {
> 
>  struct devres {
>         struct devres_node              node;
> -       /*
> -        * Some archs want to perform DMA into kmalloc caches
> -        * and need a guaranteed alignment larger than
> -        * the alignment of a 64-bit integer.
> -        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> -        * buffer alignment as if it was allocated by plain kmalloc().
> -        */
> -       u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> +       u8                              data[];
>  };
> 
>  struct devres_group {
> @@ -810,6 +803,17 @@ static int devm_kmalloc_match(struct device *dev, void
> *res, void *data)
>  void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>  {
>         struct devres *dr;
> +       size_t align;
> +
> +       /*
> +        * Some archs want to perform DMA into kmalloc caches
> +        * and need a guaranteed alignment larger than
> +        * the alignment of a 64-bit integer.
> +        * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> +        * buffer alignment as if it was allocated by plain kmalloc().
> +        */
> +       align = (ARCH_KMALLOC_MINALIGN - sizeof(*dr)) %
> ARCH_KMALLOC_MINALIGN;
> +       size += align;
> 
>         /* use raw alloc_dr for kmalloc caller tracing */
>         dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
> @@ -822,7 +826,7 @@ void * devm_kmalloc(struct device *dev, size_t size,
> gfp_t gfp)
>          */
>         set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
>         devres_add(dev, dr->data);

I think it has to be "devres_add(dev, dr->data + align);" here, as match
function checks the pointer passed to devm_kfree() with one stored in
devres structure.

> -       return dr->data;
> +       return dr->data + align;
>  }
>  EXPORT_SYMBOL_GPL(devm_kmalloc);

Thanks.

-- 
Dmitry
