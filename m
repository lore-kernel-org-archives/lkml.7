Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CEC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E7206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfFvEtaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfHUCFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:05:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35499 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfHUCFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:05:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so450029oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aECHzRB/hHOnNhkyg0hcP6TqPV/BPLJX25nl4/kfLns=;
        b=LfFvEtaKz/MgOTqdRv1rJkql8UwyYbQOxvJXvNoK3Mn+wHkFi3tb0YRdooiH2LPpAB
         3pBMrvenzf40kj3c0bGPkhTLVNeINDXo6CefSOdqnKyDsHU++6XPJNT/vAZWyo2CUPuT
         8YDoSTk+MZzGCsuhRV1DWXQJfXgwSZKdaSkyaQmex9jTZLxznZN+FjEe6reMpf7p70cN
         BO8vfPBxytYygI9qgBFg5RnA/ccKzXfp+UJr/FP17pk0s0MWazS2ttN/Ik2vDTmDFLU8
         wrmfSMny9atqcMuw5998c1t9x3PC7WzMfdC1lZ2uOjRtQ3nOQJMahW7VCrsfQDTftA2G
         yluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aECHzRB/hHOnNhkyg0hcP6TqPV/BPLJX25nl4/kfLns=;
        b=NzTRSq22jrIbfCVv9VJ+c5RITfvSkqsmeaRT5+AVxt+4XJ+XGZ+jXAPdX0N02u/o3n
         Vz3TJCgTo53u4P+cjYsaLh8fe3hFU6SC1eh3pGCQU5Da06nFD5gevtlMhakm1wUffkkn
         IoQtKlIhqkxDqEFJZc3BMScwjZ5sO22zKo1BZM506F53mubQI1lZhlH0bzsfJDTx2Ixn
         KmswQc+JLPOkaKfLlEOolQnWa3pIZfJMe2NbCNOeY7nGG6jxgZ2a2nueZUpo0AZOuzyo
         3mR4rt+f6lVJlqGu7G87dcjTFWMkgMCqKWGxHt4+zne+TMqdErkqtWspBbc1PHxahJZY
         4VYQ==
X-Gm-Message-State: APjAAAW74I1FyYUj12DFeJX5ttYSEUADunBKuFwnXXAShiLB+QCrdwnP
        Fw8vp6xXinUnqagdPDMnEPWMTkiWW4Ite62YTqHtSg==
X-Google-Smtp-Source: APXvYqwjAc4xDxKyNYNWOg9299FUKrDuYN3O2kRVASRSQmeY0y3XYLMcOLMmDqyOpj3sjogsk08EhELKlu5sxmSS2xI=
X-Received: by 2002:aca:cc81:: with SMTP id c123mr2269211oig.30.1566353131286;
 Tue, 20 Aug 2019 19:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com> <20190724001100.133423-2-saravanak@google.com>
 <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com> <CAGETcx8Q27+Jnz+rHtt33muMV6U+S3cmKh02Ok_Ds_ZzfBqhrg@mail.gmail.com>
 <522e8375-5070-f579-6509-3e44fe66768e@gmail.com> <CAGETcx-9Bera+nU-3=ZNpHqdqKxO0TmNuVUsCMQ-yDm1VXn5zA@mail.gmail.com>
 <a4c139c1-c9d1-3e5a-f47f-cd790b42da1f@gmail.com> <CAGETcx-J7+d3pcArMZvO5zQbUhAhRW+1=FUf7C1fV9-QhkckBw@mail.gmail.com>
 <6028b35b-a4ca-18de-84c6-4a22dbd987c9@gmail.com> <20190821015647.GA12237@kroah.com>
In-Reply-To: <20190821015647.GA12237@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 20 Aug 2019 19:04:55 -0700
Message-ID: <CAGETcx9fB7FuubqR-hNeCjrE3Far+xu6avqpT8egHMUFHPH8PQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 6:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 20, 2019 at 06:06:55PM -0700, Frank Rowand wrote:
> > On 8/20/19 3:10 PM, Saravana Kannan wrote:
> > > On Mon, Aug 19, 2019 at 9:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>
> > >> On 8/19/19 5:00 PM, Saravana Kannan wrote:
> > >>> On Sun, Aug 18, 2019 at 8:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>>>
> > >>>> On 8/15/19 6:50 PM, Saravana Kannan wrote:
> > >>>>> On Wed, Aug 7, 2019 at 7:04 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>>>>>
> > >>>>>>> Date: Tue, 23 Jul 2019 17:10:54 -0700
> > >>>>>>> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
> > >>>>>>>  device addition
> > >>>>>>> From: Saravana Kannan <saravanak@google.com>
>
> This is a "fun" thread :(
>
> You two should get together in person this week and talk.  I think you
> both will be at ELC, can we do this tomorrow or Thursday so we can hash
> it out in a way that doesn't end up talking past each other, like I feel
> is happening here right now?
>

Resending again due to HTML (Sorry, was a mobile reply)

That would be great. Wednesday would be better for me. I might not
make it to ELC on Thursday. Let us know Frank.

Thanks,
Saravana
