Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B52C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AC32087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eruK4Wf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCMWt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:49:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34428 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:49:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so3259039wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sVDFBaIQhzREzD4UMOpyS3ufb1/45XxaV18h6y6nQA=;
        b=eruK4Wf27cRmeMabnfyvDcUhCW0XWq21wj1xjH+Ywtb4g4YbsqevTP+AJc1uZCa2AS
         Wf0FwcRcPXea+31Xe65mjVAmyefsYkQAu/oWUoVDV/kbCJIaDusqm8ldw4pLs0Tac6tS
         IS13rSAgMD9OTCCzmfrGhATxSYOVrfW9CIsoJf3VqDMgtkhR1LmMl1x+1AmPgiK0wHAG
         imxIayDtbAr4v8LyGAsWo5eeA5GQt0NfyFcyt/Ibkv6wbJlbKb26vSIoVu9WYaMBo8Xw
         G/rdSybsH+UKCUQbDXgA5+2MA/0zF7XnijwtccYtUBE1Ho1+r8tjkCwbSZxHNq16l8jV
         nN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sVDFBaIQhzREzD4UMOpyS3ufb1/45XxaV18h6y6nQA=;
        b=cZTUK9akydMnBwF80dLkR51otGSQX1fehz5BrlrCauThKEPgttiuCO9QtAsg8ksN3n
         uM+ncR26gif2zp1dK3Cu7ZiWCNNCWAjP+Kp+xaEDJBiOj3au0rAH+TgdsY0d0hEfWVpT
         Lmv9rivgcnqmwed6fefTUM12kPe71gKBkpi1FKTpG7F/v6epbklDbmsd4CwJXtFA8rZl
         ozBbijxzQVyyy3Q5FEITD8E2sTqnediuigXkPA0NYeuHYYmWAG17SVZh5xmUHI6i0tEm
         laY9aFbpTpi6Qagvy8ac7OALkBQ+QFf/AaFtYpVozXRVK1kCEoy/ki+2AGB3oByoXy1R
         68NA==
X-Gm-Message-State: APjAAAVp3HxUYx1pflrLqB8o2sZ8H+0Pq3zRxnrvpPSXXNM4FsPLlbPF
        oAnSReDuulIX9dKyPZ9IwGYYLwVlY9mphzHz7bRQYQ==
X-Google-Smtp-Source: APXvYqwBo0pXWCoadO898OyK5lWEDGoogD89kc2FXgG55wCxjBUujFUKlRctYSfgj62tq2XFb+x2KUapMqClR/+qEoE=
X-Received: by 2002:adf:a2cc:: with SMTP id t12mr29668241wra.253.1552517365925;
 Wed, 13 Mar 2019 15:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-4-git-send-email-john.stultz@linaro.org> <alpine.DEB.2.10.1903131318300.5023@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1903131318300.5023@lmark-linux.qualcomm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Mar 2019 15:49:13 -0700
Message-ID: <CALAqxLU35HJJYukMzYuHpPpPToeKs=ceCR7mGBNj9bnSwcJzMg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf heaps
To:     Liam Mark <lmark@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Marissa Wall <marissaw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 1:20 PM Liam Mark <lmark@codeaurora.org> wrote:
> On Tue, 5 Mar 2019, John Stultz wrote:
> > +
> > +             page = alloc_page(GFP_KERNEL);
>
> Need to zero the allocation (add __GFP_ZERO)

Ah! Thanks! Fixed now.

> > +             if (!page)
> > +                     goto err2;
> > +             sg_set_page(sg, page, PAGE_SIZE, 0);
> > +     }
> > +
>
> Can always be done later, but it may be helpful to also move this common
> code from here (and from the cma heap) to the heap helpers file as it
> reduces code but will also make it easier to introduce future debug
> features such as making the dma buf names unique
> to help make it easier to track down the source of memory leaks.

I think this is a good suggestion, but I do want to be careful to try
to make sure we add debugging tools to the larger dmabuf
infrastructure, rather then just the heap code (though having some
heap specific usage info would still be good). I think there's a
separate patchset to dmabufs originally from Greg Hackmann that
provides names that is supposed to help with what your suggesting.
  https://lists.freedesktop.org/archives/dri-devel/2019-February/208759.html

thanks!
-john
