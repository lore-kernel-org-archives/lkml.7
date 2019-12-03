Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E35BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0F720674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I6Dkus0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLCCwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:52:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34337 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCCwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:52:44 -0500
Received: by mail-il1-f194.google.com with SMTP id w13so1786744ilo.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9a59J4/n1AJmUmJtyY3EBK1ZgWP2sXRGZlKEO7TjHDg=;
        b=I6Dkus0A1zcyC8FpvqgYiEao4PzOUVJlmjTTAsd1NtiEZqneNsKmScNe6EqHdHAuET
         bQXoNsbEGQ6hdZEjPM4mu8zezeb9Q3DQTlZ52rNeVa8BIet8kOK/6RGtHN6LMuymwtmV
         4+pGxAnjd9wF2WlYBZV1gnpXFxtHzhY6lv0ompiHJvXmzsZk0UmUJjfIJtqvHOvIuriB
         9lCZckZlU3YdvZ7OjFU9KRdyZ4c0lpBr4k8erJwrbyUKPHAq8brfome60EvGwb0h4ctB
         F12TUkNkTIYmE87hwRP4RNKqVsG+mbov1/CyAp3uhwlhHu7kzL9Y5C8qnMySKEc07ZwT
         XmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9a59J4/n1AJmUmJtyY3EBK1ZgWP2sXRGZlKEO7TjHDg=;
        b=itQwNPRi+twVwi/xvdFRsDxic/PtP2u8693UZrFgRdLdfrBBNoLYnUAEBEjnzoYvcP
         MvuRH4BnVVzsYalCF295IdjwuwbmldLhrWj8HqCDSZFhalpZ4AwRmZOHkfNLzmAdVVXr
         eoIGBRemk8jUqIz06+Hh+tgDIz+FgmZo2SMtKKKfcXfg3e95IxxU39qrE93aNEPFIx7f
         aBqLyOnzW7JgaXRip8/9kKrW9VXR36qJMx35sZNCcEuQCPOOqhFqeuo3u7RMqZVHkNKL
         0NQKoVyyqgBudJmJSCzdmqrdqE7aAS+YJxlChW3XDux1Emd0t6fbBYunf44gf6PUZAVn
         br0g==
X-Gm-Message-State: APjAAAX0oDtN+Klu2/2vPhPZUT4VEPA2I8VagkJPMQvhrGcx12nXt+wP
        Wf4U88I93rfFbSwCtfNijPyZStS2I9c=
X-Google-Smtp-Source: APXvYqyGxEOgv+6aRdE/einrQivQppOfpe5EoSs6xxHHdyb4nYkSN49ooLQSRZuOSBM9l73NBR15dA==
X-Received: by 2002:a92:601:: with SMTP id x1mr2530261ilg.35.1575341563259;
        Mon, 02 Dec 2019 18:52:43 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id q3sm406923ilk.15.2019.12.02.18.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 18:52:42 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:52:42 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] generic ioremap for 5.5
In-Reply-To: <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912021851400.56420@viisi.sifive.com>
References: <20191125192758.GA13913@infradead.org> <CAHk-=whpKDQze+kcCw5e-TK2J4T9-qACQ_o7XAtTO+dD+FJOsw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Linus Torvalds wrote:

> On Mon, Nov 25, 2019 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > There are two conflicts with the riscv tree - one is a trivial makefile
> > context one with the nommu support, and the other is the split of the
> > riscv <asm/io.h> which means that the removals in this pull request need
> > to be applied to the new location that they were moved to in the riscv
> > tree.
> 
> The conflict was trivial to fix up, but since I don't do RISC-V
> cross-builds, I'd like PaulW to please check that there weren't any
> surprising semantic issues too - or that I didn't mess up.
> 
> Paul? (It's not actually pushed out yet, it's still building, but the
> ioremap merge should be there in a moment)

Looks good to me, and passes basic tests with both QEMU and hardware.  

thanks,

- Paul
