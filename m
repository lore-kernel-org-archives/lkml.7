Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D8BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E714E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+M9IpjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH1WpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:45:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1WpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:45:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so607505plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPbPzi8DJAAO/y+OeuN5vBbTcuT9S0RWHExziJUIWRs=;
        b=I+M9IpjEi2c7+HO8wuU8859y4LphVsN+QPPqN690BbGElE+72ftFGGLPPj1JCusSKT
         qujvZep9+8ndJjEvCEl2I8lN5EZXrhu3qMAt4W2Slp+bj3F2ZeIx8XCodzcjH+rYW/sN
         Qr+xajyVcs6034Dv62n5kj4ywTFL+UqSnrvB0E+wKWX6aubGNs3wAY7xR2z8LCg2ckeG
         3cUJT3eNMCpKGE1EkRGO09HR1VOKrsPczPXG8S1eit7GHIchRfJwt5wf5nVBABybSRer
         jCRvT4eY3Ot8YJ6q5JIcauarHcC4DwslXKVUDPLqFy4OXe1HPm5xJ2g32ApG0jzGBDnw
         1EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPbPzi8DJAAO/y+OeuN5vBbTcuT9S0RWHExziJUIWRs=;
        b=DbEEH1LDnB2w1jWk6sSiIqI7n1IjW/hFZ8HQJOgm1+eJMyXM32wueBjgXA8humhrc7
         bynyuurTImkC6eHkIFdbRIjxpoZ8Yh+nLuNn3E2vgRxyn+45TAuSVc7q43+tH+4dEld7
         gnMQD9yd0ADyYbBJzWBQ697n1tzLP8HhnN3Me/EP8Su8tKmtWd1C/Rov7rxVS5tjudZr
         A5XQPKat99EAEkPGZTUTe9AxmOP2F9jSbBT/VhlW5QRDHZex+GzSIC4FFUMxE37NlOg+
         wdDOX87sJmtrxFiEo5B8REvIKKVZIxWiljHa2Ju7KZhGTBYJugtEaetH885HM+cM8Efl
         2sOg==
X-Gm-Message-State: APjAAAVQcrDAX2hZeW8zqEuSgd10GPXARzGtMlbRlYBAkJdOwQ7ce9g8
        HziKQAhTFsqv7FGH6zZ3EAamnYvF4FEV8rauaroygQ==
X-Google-Smtp-Source: APXvYqxquwEwH8LScYMriBEm5ULJ4c1c1DFJ0JIRgv5EbkhLd7rjDuHDOAZAMS6OKpRisSxNQ6OOMCofwnlQMO+5x1M=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr6645214plo.223.1567032310538;
 Wed, 28 Aug 2019 15:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com> <e8851ba7888c433dac2ffa5d80f3289cd05940a3.camel@perches.com>
In-Reply-To: <e8851ba7888c433dac2ffa5d80f3289cd05940a3.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:44:59 -0700
Message-ID: <CAKwvOdn6N_hmuFYS0NS1jLkY5m-C591Kouh-aNbceTUjt33N2w@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from compiler_attributes.h
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 7:47 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-08-27 at 13:39 -0700, Nick Desaulniers wrote:
> > GCC unescapes escaped string section names while Clang does not. Because
> > __section uses the `#` stringification operator for the section name, it
> > doesn't need to be escaped.
> >
> > This fixes an Oops observed in distro's that use systemd and not
> > net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.
> >
> > Instead, we should:
> > 1. Prefer __section(.section_name_no_quotes).
> > 2. Only use __attribute__((__section(".section"))) when creating the
>
> Please use __ before and after section
>
> i.e. __attribute__((__section__("<section_name>")))
>
>

*explitive*!!!
-- 
Thanks,
~Nick Desaulniers
