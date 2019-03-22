Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E463B21902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LG4eB5a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCVBpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:45:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35445 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:45:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id j132so581865oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzGH74VeWCDe45fBYXJn30SskmUE19w007KfbQWB29U=;
        b=LG4eB5a2Y+wQywfGoFIzNiOvDAbSXWcPmw7pjjIjcd0nJmWcVkuqvn5FuAYB/Qjjdm
         DVEnR3fXHvDceXyGRvI0d0U5j7W5lL1qMGEzDf5HgWNw40PYlsabjjA2mnH/AmzXJJ/J
         ltzNXp2Z6pKzoDTKeKzTfP2l28W2K2jCopqx/wQtkhJPcCRr61vmiK/aO+Fp/D2JtwZe
         bD2Y1SDvS2BmuCs2YsboWMtj0UxRriCia7EZgyEcPrzbI19611DrHHo4djYibGNs0G+M
         8y2g3dKN4UeuGYLkheR+NmfzX/68M7a+0lmdoOZiIyJ+sb/a9yZ4yJ2E0jCZrnXrHhEl
         ArWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzGH74VeWCDe45fBYXJn30SskmUE19w007KfbQWB29U=;
        b=S8iiSP/QuXiO7UmHS/qgukmk+RGCYv04c06O48uS1zVxlesDNiZMy9c/PRbk4JdkvC
         dV0fWftvRO9sQbwkmaTZjzq2oy+zFKh9yxDis0/2shWqH8b+NZ7x+DF3Je3kPOsJ8aPR
         EVdRHoTV58Q5WSoIg7hTMLPtp0mK18jE3HDTkdfCfGEGUqzlfOPqR/bCSQDwH80Mp8y+
         PcSDNuTR0aiPU9tf2jY+cDDZxc95ALRyMpn9kUvDGLdIHtSZb5/CJ4JEraLi54p32HzO
         j+B/Ok9R8wGXDzcO2RIv8cU1PuI6WU5wEQEgqDMhmDl9X5DH1A88KYJZRFXfZpVoUw/O
         NHzg==
X-Gm-Message-State: APjAAAVNUJdkC5rOyyJG1NLOWZ4tL4c8xTfxXVSXkjiEfFRFgesAbSBA
        PUYqWffBPLxdteIeEtSq9ENt4FztBhdBZYqsi/ohcQ==
X-Google-Smtp-Source: APXvYqx0T1a0XCzgdvDAJpl9vzYiOujWa77j1S+0TdseXoK0Oikz8KQpo5c1Jr8472pSSSosDAOg4a5y4Jd2KzREIUM=
X-Received: by 2002:aca:f594:: with SMTP id t142mr227338oih.100.1553219119345;
 Thu, 21 Mar 2019 18:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-17-brendanhiggins@google.com> <dd0c4033-183b-9e77-1dee-7c88f62771fa@gmail.com>
In-Reply-To: <dd0c4033-183b-9e77-1dee-7c88f62771fa@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 18:45:08 -0700
Message-ID: <CAFd5g45QnvgyoAGcSQe0E3P1U=qsrRe4uCqXTNCroobmbUH0ng@mail.gmail.com>
Subject: Re: [RFC v4 16/17] of: unittest: split out a couple of test cases
 from unittest
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Split out a couple of test cases that these features in base.c from the
> > unittest.c monolith. The intention is that we will eventually split out
> > all test cases and group them together based on what portion of device
> > tree they test.
>
> I still object to this patch.  I do not want this code scattered into
> additional files.

Sure, no problem. I will remove this from future revisions.
