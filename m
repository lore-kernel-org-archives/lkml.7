Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E9C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4402173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UFwnonZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfGPPYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:24:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44652 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfGPPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:24:01 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so40463479iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N195P2f0us9phWu08NVADmmlZekvAMPF8Z5SqipHjkU=;
        b=UFwnonZ/cfc25F4c3cAbdHC6solwqR0l8lLv7BAeP9Ozczdhg8nGvZUpzg5Y37od+t
         Xhq8oFbJNiKcY8wa+O3h0pLxMIMjaTMb+94vSFlm1z9xCPzC3a2dp42DZuExmajJeSnW
         lHIQNUWp4FqhJHcTAgwX2SLv1lo8pDeq5vp5Eg3CjBTBMnXmqEQ0W8RPbRkISSlIthCk
         jv1bxEzIfW+XBKdww/YOIQsrxjtyP7J43c47tngACpodJTHHOHj9jg6CwatIOqGsKEw9
         V8lbFN9aabPXiEZIackgQeu3hBNIzDEGxgIEPFReyyll+Je2q4zQp8hV3c4jJUWOT+UL
         qPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N195P2f0us9phWu08NVADmmlZekvAMPF8Z5SqipHjkU=;
        b=V8F8VyeXzBBd4aa4JzYE0EXBVqqi0hqTXMEvt6hcujwR+1vIVjRkyAe8oLB9/j2FOl
         iseBGjyZw364tf5bT4oqHw8T8YNeDMWSKpY0TaON1eeLtnBXdfE7F4ma+828jxRtvL82
         fxk6x6oZhkHXB0HV6JLxbD2f1IQlBPK98jQjSbXafBYhTRQM3EhgW5x+Mn4LsEcRumAn
         1lo29t4v9d8ic7yL7Qk5vxNjQTGbtUnx5ZVS9cZdUCjzzr4eU48rBTo/G0AebXclOgAm
         cJ52Df433k6eM31qjowDxZHpGmF4LnktheKj5Jg1u9QdRTIEIYIdCh8PV7Bnz5GiU/Bc
         obXQ==
X-Gm-Message-State: APjAAAVHEBZ5AuFsEFJeDu00/anJYxEjsIfs3tL29PSPrEZPlJ6MfcLH
        eSQOrAB47tdCh7u75jdBOTIpBc7Wfss=
X-Google-Smtp-Source: APXvYqyOxSJGHpDH9ZiCTa86Ja+vjoynyZSZ7MI6Nczc+lsODPXjGQ+sZHWd7xEI9cd/16JKEWBCQA==
X-Received: by 2002:a5e:9701:: with SMTP id w1mr32235289ioj.294.1563290640716;
        Tue, 16 Jul 2019 08:24:00 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id t133sm29445698iof.21.2019.07.16.08.23.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 08:24:00 -0700 (PDT)
Date:   Tue, 16 Jul 2019 08:23:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: riscv: Limit cpus schema to only check
 RiscV 'cpu' nodes
In-Reply-To: <CAL_JsqKmovGLxZj5jOLgXLtYD1cRHjtrQZm27Nk8cRQR9tsidg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1907160823330.16470@viisi.sifive.com>
References: <20190626235759.3615-1-robh@kernel.org> <CAL_JsqKmovGLxZj5jOLgXLtYD1cRHjtrQZm27Nk8cRQR9tsidg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019, Rob Herring wrote:

> On Wed, Jun 26, 2019 at 6:00 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Matching on the 'cpus' node was a bad choice because the schema is
> > incorrectly applied to non-RiscV cpus nodes. As we now have a common cpus
> > schema which checks the general structure, it is also redundant to do so
> > in the Risc-V CPU schema.
> >
> > The downside is one could conceivably mix different architecture's cpu
> > nodes or have typos in the compatible string. The latter problem pretty
> > much exists for every schema.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/riscv/cpus.yaml       | 143 ++++++++----------
> >  1 file changed, 61 insertions(+), 82 deletions(-)
> 
> Paul, do you plan to apply this? I have several fixes to send to Linus
> if you want me to include this.

Please go ahead:

Acked-by: Paul Walmsley <paul.walmsley@sifive.com>

and thanks for asking.


- Paul
