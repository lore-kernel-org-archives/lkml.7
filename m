Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC80CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303EE20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="V6fRNYMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfJaHjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:39:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44595 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfJaHi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:38:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4so5478791lja.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYiEiAeXhzSNlTeZVtybpT8lclKkW3XtSx+iKVkW34s=;
        b=V6fRNYMgoB8Pzl1XrdHlLWkDp21wb/ZAO1KlZ7rzpLCgOKB+cLTIKkhzxBjKnpaTRq
         wg/s5Fs8T97v4nps20HK5RGnMMQyCoRPJTQ1WSk7qZGXAWoSpTN1wt/mdQcRW0iqvpyg
         dx5JXOcfg8IV2iczVB2WVlj1Lz68hY/phZ2co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYiEiAeXhzSNlTeZVtybpT8lclKkW3XtSx+iKVkW34s=;
        b=CYYR+bbnTMvVx34mlYnmQFOMBaJVILE6x6Muozwe8XxBWfjnhFQ1Nr1nGePfPgo6V+
         x0fYxrt7gpxR8RBUocLf93I5WBwqEt/tQWDh5RwA/lxjikM41qDq0pBNmoeSHYZruBF4
         5xygs5Y7voR6JPLwo1orROuENvDFhO93Mrrobyl4t+OwjgNlukeYIgmbFLSWSSd1hFuy
         OH+BCNUHTwB+rLQy5r07hrzO+Cr3RMLNQnCFmcjuACrdwVFs4umrqYpzp796LkgLg9Fq
         jXaeGemT6y578101pa2UPWCi7WsU2vEWPOspkNqCq9IXjRQIBcPhMrmwoPCGXnBXoFjR
         UHig==
X-Gm-Message-State: APjAAAVHgDdQiOO8wkbDXa/4MwwUfI9vMaz8Dt8oz5HwfbgROzIYb6lf
        Pf/BRh3fevsAHC+pMPFlcSTYSlOiI12gvoAU
X-Google-Smtp-Source: APXvYqxT3T6cYOhnMq3nmTYG/Ls910R5ah/jwnD3vDOz9VZu/fzXJoKKzY8NQwSmVmS5/uHcXqfAmA==
X-Received: by 2002:a2e:7815:: with SMTP id t21mr2927502ljc.149.1572507537180;
        Thu, 31 Oct 2019 00:38:57 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n11sm1422892lfd.88.2019.10.31.00.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 00:38:56 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
Date:   Thu, 31 Oct 2019 08:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2019 01.31, Rasmus Villemoes wrote:

> At first I tried something that wouldn't need to touch anything
> outside arch/powerpc/, but I ended up with conditional inclusion of
> asm-generic headers and/or duplicating a lot of their contents.

Urrgh, this is much worse than I feared. Already 1/5 is broken because
asm-generic.h includes asm-generic/iomap.h conditionally, but
asm-generic/pci_iomap.h unconditionally, so now users of io.h with
CONFIG_PCI and !CONFIG_GENERIC_IOMAP get an external declaration of
pci_iounmap they didn't use to, in addition to the static inline defined
in io.h.

And I didn't think 2/5 could break anything - on the premise that if
somebody already have a non-trivial define of ioread16, they couldn't
possibly also include asm-generic/iomap.h. alpha proves me wrong; as
long as one doesn't define ioread16 until after iomap.h has been parsed,
there's no problem (well, except of course if some static inline that
uses ioread16 got parsed between the compiler seeing the extern
declaration and alpha then defining the ioread16 macro, but apparently
that doesn't happen).

So sorry for the noise. Maybe I'll just have to bite the bullet and
introduce private qe_iowrite32be etc. and define them based on $ARCH.
Any better ideas would be much appreciated.

Thanks,
Rasmus
