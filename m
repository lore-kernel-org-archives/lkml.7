Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38668C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0976F20652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm+TYCHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLJTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:41:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33315 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:41:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so9390014pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7uMkuzgbyQCsMvQ/Drlo2S75EdUCH9EK+Z+tjRJbaA=;
        b=Bm+TYCHKBSAH8K+fKTnL9a1dcnPWa4StCeoZZbpjrtWso2LXEnvjf7DhlY0NIPH6jX
         CfPzw+9mih/7H1Bgl3mlZYAAxWQRfJHCZyO8R+W3ysmWWLa9BVKy2nnJrvJmTKu9mneZ
         Vqruzr72JK1B039hmgsV1AuoLBYG7rQtfAoE/4UJESaC2lmlyZrpqotcq6RAX+0X8f6E
         JH4GEoERwORLmPYBez7uOrEbet2gJA4PU8uRX+68IMpwhS7RsFV5MCe0R1PVwSoMSam9
         xsPrq2vMs8l0GxBOrqfzvQETxeYztP5IH/0vzxwb+28vnGB4HREp36lcSTcJVw6Hd8bi
         mdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7uMkuzgbyQCsMvQ/Drlo2S75EdUCH9EK+Z+tjRJbaA=;
        b=psaIU3aGD3yHT3np6pkRPc65lgbTaNDEOv70ZtteuvwqVugnXxnuCi0lsAjtEyDdeP
         DmVsNKm/fimabHw2xho6vH3WIrflEcG5Gube5ZgCG+PE1Pje1TjVt7Dq1KRTolPyjfg9
         3IR5GaH6RvZ5rh1f1x+sFQVduO6QRs3jPZz/eZUohEnQBwzOxq5Qj6/kO5ajMvjuN+Hx
         HcJz+AU7aUqUAcUEc+kevUi8w8XIgAXhdWsbKztCiLZSLMhreYd2d+uFcqqJPxYY7bVZ
         +FfkZ65Jq6anzzxN5hmcFYPQD84GvTtmSh/CRfkwcSh4BSxDjL2WByZUq+83kwswaPm4
         5tfA==
X-Gm-Message-State: APjAAAXt57Qs/miJSCCH+Yi4b7SHvRTU8aYBVDFCkM4SmUVwh86YKuTX
        2nZ+vET7QA2X0uBcxsxwBIDaUh3FpdoqT0lpSDxyyw==
X-Google-Smtp-Source: APXvYqyUGDua4OibHU6JIXr930bB4AxU+ZMFicxGlWEwKH9Ll7TkiEUXUCiO2nanSfeQ5wIjK6r71neTEsVhSgRBCwk=
X-Received: by 2002:a63:480f:: with SMTP id v15mr26099811pga.201.1576006886546;
 Tue, 10 Dec 2019 11:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at> <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com> <7da5a054f533eabf2ffa110c236f011bf9d23954.camel@sipsolutions.net>
 <f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com>
In-Reply-To: <f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Dec 2019 11:41:14 -0800
Message-ID: <CAFd5g46aCzJqpcj3mjCy3O7iSfUz3VBaPzivq-CVZ6fJs+Ybug@mail.gmail.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:54 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 10/12/2019 08:28, Johannes Berg wrote:
> > On Tue, 2019-12-10 at 07:34 +0000, Anton Ivanov wrote:
> >
> >>> Further to this - any properly written piece of networking code which
> >>> uses the newer functions for name/service resolution will have the same
> >>> problem. You can be static only if you do everything "manually" the old
> >>> way.
> >>
> >> The offending piece of code is the glibc implementation of getaddrinfo().
> >>
> >> If you use it and link static the resulting binary is not really static.
> >
> > However, this (getaddrinfo) really only applies if you use the vector
> > network driver, if you e.g. use only virtio then this particular problem
> > isn't present.
> >
> > Note sure if we implicitly call getaddrinfo from libpcap, but again,
> > that's just a single driver.
> >
> > IOW, we could just make CONFIG_STATIC_LINK depend on !VECTOR && !PCAP?
>
> +1
>
> We also need to add VDE (wonder if anyone still uses that).
>
> We will need to add XDP when I finish it. If memory servces me right,
> libelf or libbpf has the same lovely features as NSS.
>
> This is not just NSS - it is creeping in with a lot of new libraries.
> Sometimes the libc guys fix that. For example, librt was like that when
> I started working on epoll and vector IO.
>
> Sometimes (as in the NSS case) they don't. So the static build
> containing those will be broken and we are better off making it conflict
> for those options.

No strong opinions from me. I am more than happy to submit a new patch
that adds the negative dependencies.
