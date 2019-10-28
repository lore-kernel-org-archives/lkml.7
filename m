Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A5CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7F20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1YV3b4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfJ1UDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:03:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43792 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfJ1UDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:03:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id s5so6979230oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlJXOfNrar9cSMwsMokP9HFTFFdfu93s0cpnQ48Gezs=;
        b=X1YV3b4J8TxKUrgQ/8l0Q+Zyy4NSj2OyLTW8TY5W4OzAQC1RTbtjAOSKbCHdpa7PdV
         v9/cdxxYjFZNMLDHcqBF5fvXbCcpiWTOD9M12PJmlpAdzh4TtT0Y6k1HCaARZ++NGEe1
         +PKEkOT979vbQsxeNGy/RVsXCvVa3Ab9QOG63dvf+dWGDwonJH/tOHg4tchxu08KelCk
         oS5pMjeLlrJ/t1zNr52xcnQP3TmhiehLueWB93/kha6bBwCWRQ/z/uFaLVtq/OL0TEpw
         lLrLCUeHFVuhKy++M+q8gFyNMVnJmGVKtA+KYQqqahdohNVuSOTbdwZe7tiR74+jnE0f
         pj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlJXOfNrar9cSMwsMokP9HFTFFdfu93s0cpnQ48Gezs=;
        b=tpdpDS/mL6v2mDsGPeK3NTGX7ihEvXfWqMOY5qFip0RAKs5ENc85028FEvuYYptwSq
         TzO4m60Hz4+HvWKZB7RTVbpvK0iiCMDn3eBltUXPcOTbzgMAkRehn2PK9vNX5WOwwKGC
         yIWA5/vLop6FmY1mrF4aNEs7NeWo+X2DcQOteisanH+q08evoH6lnlNaJ0s6+TbJOZ6z
         U01+0CVrSuwHjxViko7QrUSz0UmgLdnvufxia5bKGVVj2HSJNZT+euOmgFRRCP6qT9HA
         ZkH6F5KNSKA0Lo+wpByI7rRu9znVdVUX/wZQYkDhs/nhXcb4K/cpIzPFWZuU5AV6jm4d
         20Og==
X-Gm-Message-State: APjAAAUFbXrNFf3PWlzLY3ok40pFjJusZvmtZ8Rv5PfALFRxb1YKwAch
        YXZ1t4Q9wymR+fPp640uI31Xm5nu/QrQp3EBPBNyuQ==
X-Google-Smtp-Source: APXvYqxBOm9fQjYmZRso/7PDZ+WJx2Nc87EvRCW7FgWuw1UjJKhCz3MGX1e4aqRxLVZC4qNDZIWrS3MYoSgdXDBBmoU=
X-Received: by 2002:aca:58c2:: with SMTP id m185mr894309oib.128.1572292996724;
 Mon, 28 Oct 2019 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org> <20191028191231.GJ125958@google.com>
In-Reply-To: <20191028191231.GJ125958@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 28 Oct 2019 13:03:05 -0700
Message-ID: <CALAqxLVEwTjNe6y9xLLv9ib8qnp6hFXsT+XS2bJT0jRTzZVdsg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a module
To:     Sandeep Patil <sspatil@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chenbo Feng <fengc@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>, Yue Hu <huyue2@yulong.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:12 PM <sspatil@google.com> wrote:
> On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -31,6 +31,7 @@
> >  #endif
> >
> >  struct cma *dma_contiguous_default_area;
> > +EXPORT_SYMBOL(dma_contiguous_default_area);
>
> I didn't need to do this for the (out-of-tree) ion cma heap [1].
> Any reason why you had to?

Its likely due to the changes I made in the separate
non-default-CMA-region patch set. Earlier I had gotten away with just
your change, but in testing before I sent this series, I hit the build
error and quickly added the export before sending.

I'll revise and respin this. Mostly just wanting to get initial
feedback on the dmabuf-heaps-as-modules bit, so I didn't take as much
care as I should have with the exports here.

thanks
-john
