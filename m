Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mv4MgHak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfJJSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:35:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33724 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:34:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so5779175otu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=r4XAjDc0xfpf5vzfo/i7Ws66r6JtB7Z+yeiV1OLT15o=;
        b=Mv4MgHakwlbkZi54pRbq6rETPbooTcIqnnEmLH++AM/dbjJdkhLvcNrXOW6IsB/pgz
         d3BRPjAYgQBUlrZUnlPimOcZM56EUiNxYWXroi33EWcAq5Fahw8qTgF6f72D6D5a6YWU
         7q+yiS2BlxAegJ+W9jG3+epyOA7gnmnpBJPqvF325FE5RJDugDklSWrk6RcuPRm8gboS
         NTLPeYmYJHcKWhneSddbCJX/CvCvSPdD+dJPI1kA6LYqbcEzzn6/LZmG47mjRo0eR6jX
         EBgk0m7BwCElwY/08rYUe0cf8VTuxLShCP1sxj18C0SXkFF458ooK8/QtW7p1Ueg0kBu
         IevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=r4XAjDc0xfpf5vzfo/i7Ws66r6JtB7Z+yeiV1OLT15o=;
        b=gD1SYeBJqNJORYAJzED49/uuS7kywxugUJvLISxcJky/otp21z/ayMBrSLKXjGnYXP
         U3veDSgtM6vNTyE8Bae/hMxgxPMVQLA2dxouClOSnY+J3Aou2TWSbqSWI5ZmMcsEwfP3
         vK1d0yqq5cyTe2Ev4zjupW8skxaoexnnUaS6i7aNDX54Jh9iEMCIf+EUcvZQU8ByIeME
         xIAesj9FZzzhilH14ydpC99atO/x7roTxF5pVhkH4Bd42DJL6MCkG5DHASbv7ynIxO3i
         I0OSkL8kp7RU+Lzz20BT0mCnVRIFuGENmDoNdwImUw6gw9eOZbowuTGr2osCwL7t+Ht5
         Vcng==
X-Gm-Message-State: APjAAAXEw0nomry0SkeMhPDaZdLU0jNZaiiXgUg+Fru0ndGNf6KxKiw0
        pewrBQ0LwcjDc5YDB2Y0medfsQ==
X-Google-Smtp-Source: APXvYqxflYfMilSfm+EF8uvVn9CW8v2d/Bajx2LYtYV1/X7fPOeBeGReXzuA/f5bw8ZARuEpamC1jg==
X-Received: by 2002:a9d:3675:: with SMTP id w108mr6677517otb.81.1570732498705;
        Thu, 10 Oct 2019 11:34:58 -0700 (PDT)
Received: from localhost ([2600:100e:b04d:43d4:f34c:fed9:3a80:e86d])
        by smtp.gmail.com with ESMTPSA id w25sm1914021oth.39.2019.10.10.11.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:34:58 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:34:55 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
In-Reply-To: <CAL_JsqK==+6QPrx3NDobYfWQwRg9m-t0LZgL=KzqfhAfbu+xTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910101132440.4464@viisi.sifive.com>
References: <20191009234648.2271-1-robh@kernel.org> <alpine.DEB.2.21.9999.1910091657240.11044@viisi.sifive.com> <CAL_JsqK==+6QPrx3NDobYfWQwRg9m-t0LZgL=KzqfhAfbu+xTg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019, Rob Herring wrote:

> On Wed, Oct 9, 2019 at 7:08 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > On Wed, 9 Oct 2019, Rob Herring wrote:
> >
> > > Fix the errors in the RiscV CPU DT schema:
> > >
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> > > Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> > >
> > > The DT spec allows for 'timebase-frequency' to be in 'cpu' or 'cpus' node
> > > and RiscV is doing nothing special with it, so just drop the definition
> > > here and don't make it required.
> >
> > The RISC-V kernel code does in fact parse it and use it, and we currently
> > rely on it being under /cpus:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/time.c#n19
> >
> > The RISC-V user ISA specification also constrains the timebase-frequency
> > to be the same across all CPUs, in section 10.1:
> >
> >   https://github.com/riscv/riscv-isa-manual/releases/download/draft-20190608-f467e5d/riscv-spec.pdf
> >
> > So the right thing is to require 'timebase-frequency' at /cpus, and forbid
> > it in the individual CPU nodes.
> 
> Yes, but this schema only deals with 'cpu' nodes and we can't check
> /cpus here. We'd need to write another schema matching on a child cpu
> node having a RiscV compatible.
> 
> I can change this to 'timebase-frequency: false' to ban it here.

Sounds good to me.  (Might catch the occasional mistake.)  With that 
change, the resulting patch would be

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv

and thanks indeed for cleaning this up.

> That doesn't add too much as any undefined name is still allowed such as 
> 'timbase-frequency'. There's a way to address this in json-schema draft8 
> with 'unevaluatedProperties', but that's not ready yet.

OK


- Paul
