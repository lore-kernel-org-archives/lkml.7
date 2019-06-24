Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E801C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043FC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux1gttXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFXGxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:53:47 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46020 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfFXGxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:53:47 -0400
Received: by mail-ua1-f68.google.com with SMTP id v18so5228678uad.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2gwAPWz1h5rDD6zyhzVYh+M1UssmJq3hfGAoa2j9xw=;
        b=Ux1gttXwe527yndr7Uha9yz9CVrFVSqEsU5JQn3CPwYkwVHg92QKnEMM8LDd76QSsS
         f4YMoNjHuDdtFFnzekXz+8hAIF8afhjI6iQO9419yyVw62jrbBQMExr231bO+c0Jdhj1
         YwpLVQYAyvTMo4GGejjpdvkva/ns2ME93zfEnasWiKwUHOHwArjmtE5kSINUPw0rSjAY
         Io4/eu/MNVWNnfg0Ie8mfJqzrrHjs+TSJ4ij4j4T7C6Wx1mXZdMmuzeDB55QRyrgIf6Z
         xeMDxqZQmzhjjda+uteoSNVub+sRcDt6C/DjNdpyRsK4s4Jiia5/eoQVUBrf9MN27Vvk
         j3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2gwAPWz1h5rDD6zyhzVYh+M1UssmJq3hfGAoa2j9xw=;
        b=CkIFHlFTI4c+U5sq9ko/D0A9SyXabTxh0gr0S2A1Rk+T6cVRlmUQg9dWQo0lK+Mlkd
         +PG8PFQvNPB00d3APr9l9hIHo5eCKUxFi5D7ylkVPnr1etL6i+h1f0X7tAGxxEcr3pB3
         IIeXImxjTNTLwDEpshv8yHBMrJ2g7Smnp+uO9jKq/NMRTFlO02u1MLUChDMqkSKJ8jDe
         GQ8QE1y2/ruCudZ8LyHzeCvyAvmFLW8EKnF+LMlZ8d1E0Esy9XZYChXY9kKpnbCaK0Co
         aUzMmtZ3R8HGtEVATXZm+uczKtTRQvKxOIhivJVw3uspqLwfB62dAqLTEpV6eTdurfwB
         BFFA==
X-Gm-Message-State: APjAAAVxlaq94xniarNOuQBZA5VkNk1iXwymkO/f/e4Hb5MskbDUh4rX
        /QM7+C/MwnpLlXlTrSE5ntw/YhHPtYwjjoZ2jywl4EzF
X-Google-Smtp-Source: APXvYqzJiiFbe7/YV361JC0DP6yBVMM36e87ICuhgQVPIzoIrmCBTnVvOhBFq/YDLKlvxxJGShhUghik+WIQ7ZO3f+E=
X-Received: by 2002:a9f:2372:: with SMTP id 105mr34194145uae.85.1561359226485;
 Sun, 23 Jun 2019 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com>
 <20190616095554.GA5156@infradead.org> <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
 <20190617081943.GA11274@infradead.org> <CAFCwf11y_K9oKHWkwBGQs1T_S8x+6=tyecpQ-Y7JKs8tQ6oBgA@mail.gmail.com>
In-Reply-To: <CAFCwf11y_K9oKHWkwBGQs1T_S8x+6=tyecpQ-Y7JKs8tQ6oBgA@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 24 Jun 2019 09:53:20 +0300
Message-ID: <CAFCwf108WqMPuPqy=QQ72ZVmKNAgWMQ-Nyc=Muea22kkh9E99A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Christoph Hellwig <hch@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:35 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Mon, Jun 17, 2019 at 11:19 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Jun 16, 2019 at 02:24:08PM +0300, Oded Gabbay wrote:
> > > So the alternative is that my device won't work on POWER9.
> >
> > The alternative is that we fix the powerpc code to do the right
> > thing, which already is in progress.
> Great, I agree this is the correct approach, and that's why I wrote in
> my earlier email:
>
> "I'll of course monitor the PPC code upstream and if they will manage
> to push a fix to their current DMA mask limitation (that will allow
> setting dma mask of 48 bits and without setting bit 59 in outbound
> transactions), I will modify my code accordingly and then this hack
> won't be necessary. But for now, it is what it is."
>
> So I don't get it why you object for this temporary fix in my driver.
>
> Thanks,
> Oded

Hi,
I didn't get any reply to my last email.
Can we continue this discussion ?

Thanks,
Oded
