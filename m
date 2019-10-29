Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF9CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A272086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RB8kpGeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfJ2Ine (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:43:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39441 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfJ2Ind (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:43:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so14328947ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HGXd6rlxFLbtpjrAQ8G1Qtj9aAnpBTx6NO8SjG7PtjI=;
        b=RB8kpGegZFDbX4ehO3+DnkUXso3PSM4ypigva4bxla2UhzbfYW3VFanbaz6VAqTIp9
         vC4VW/N/DNc5sYKbDVzBAZWHMwSNqKbSozM7z9NZGI9mkDa0OXo0Om0mCpyDwNoaV8lk
         b3mRrhW7uAmiDR3MvGYepqftbS6Qixnz1xrt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGXd6rlxFLbtpjrAQ8G1Qtj9aAnpBTx6NO8SjG7PtjI=;
        b=Ztu7BaaksRHls9mnFr4C2X/U6PHgwVe4ZwDNPKW4atmTVoi4Lk09Y6IF96niTfosPE
         /cQP6i25lnAm91LqWM969g9G2a8vlhOtkjA1IpUSOAl3ggGoZwxg78xFUfLL9cq9kEpQ
         wkYGQhrgo4W/6zc+NAqHc2WMKGVyowCegtM22MgtieUmjwvkMdRGd5XJzTnKOPIKiNuL
         MgsOXvJMZp2UeKZgBT0jp1cpun2qhVTjjmwF793hfpSPL5Dvt7Kmygal0T4DI3Lnyo3w
         kVrI7eENwGgSFBj4z/o5sZTs6DeZrJGfZGM9oJgre8HggkEEZeungO5JJ6NnQEVtmn99
         +utQ==
X-Gm-Message-State: APjAAAUOKQFymZmEBD24ogf3SYaD5lJRIhVSoIRJZJ8L6o4jotd0j3US
        P+V2Db0gnqZEJBuPR0u1iBD5Fs2m2sirXvY6
X-Google-Smtp-Source: APXvYqzEDMxdj01ErGn8mE4rCnBBCxTZ6HkGNRiI9Uh8UyBsOyPj0DTCwoKDupc4z5w1cSudjzX3Qg==
X-Received: by 2002:a2e:4751:: with SMTP id u78mr1617787lja.210.1572338611332;
        Tue, 29 Oct 2019 01:43:31 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 77sm13198495lfj.41.2019.10.29.01.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 01:43:30 -0700 (PDT)
Subject: ppc: inlining iowrite32be and friends (was: Re: [PATCH v2 03/23] soc:
 fsl: qe: avoid ppc-specific io accessors)
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-4-linux@rasmusvillemoes.dk>
 <886d5218-6d6b-824c-3ab9-63aafe41ff40@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <02a8a449-e421-f70f-4bf9-50a94324834b@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 09:43:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <886d5218-6d6b-824c-3ab9-63aafe41ff40@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 08.43, Christophe Leroy wrote:
> 
> 
> Le 25/10/2019 à 14:40, Rasmus Villemoes a écrit :
>> In preparation for allowing to build QE support for architectures
>> other than PPC, replace the ppc-specific io accessors. Done via
>>
>> $ spatch --sp-file io.cocci --in-place drivers/soc/fsl/qe/
>>

> As discussed already, this patch changes io accesors from inline to
> outline, this has a performance impact on powerpc32 like 83xx.
> 
> Could you please include in your series before this patch a patch to
> change generic io accessors to inline on powerpc ?

Well, it's complicated. I was hoping someone could explain why those are
OOL in the first place. The history of arch/powerpc/kernel/iomap.c and
the makefile fragment including it is a bit messy - first of all, the
file itself talks about "ppc64 implementation" but is obviously used for
all ppc32 (while the ppc64 platforms that set PPC_INDIRECT_PIO also get
GENERIC_IOMAP, i.e. lib/iomap.c).

So, what I wanted to do was to make the accessors inline when
!PPC_INDIRECT_PIO && !PPC_INDIRECT_MMIO. But then I need to avoid
including asm-generic/iomap.h, because that declares these as extern.
OTOH, I think I do need some of the declarations from that file, e.g. at
least pci_iounmap, and perhaps also the *_rep versions, unless they
should also be inlined.

I'm happy to give it a try, but I think that belongs in a separate
series. The first few attempts are almost certain to generate some 0day
reports.

Question for powerpc maintainers: Is there a fundamental reason
iowrite32be and friends are out-of-line on PPC32 (more generally, the
PPC platforms that set neither PPC_INDIRECT_PIO or PPC_INDIRECT_MMIO)?
If so, there's no point trying to make them inline, and I'd have to
address Christophe's concern by introducing private qe_iowrite32be()
etc. wrappers.

Thanks,
Rasmus
