Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D37C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C482176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="HJ57PQOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfLRHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:01:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLRHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:01:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so674568pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 23:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BZCWkhOFV3yf2yR16aoRfXzQzGQ6DZmCFUiKpUKgtKg=;
        b=HJ57PQOLVeFDWs5pPEm8r4CDItVMeCu5KLeQ4NJI+/3RFeWqSohuCj05oj8iIksoji
         LBJWTgT0aPLaGtmuAEfWgKyhcfyHKTH7JdTgkG9ZP0bJVOaVHl4n81pUT/5kwswuxkI2
         cICePRCvQ2kUgGEW5NzFKPmykXeOTEAu3FNAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BZCWkhOFV3yf2yR16aoRfXzQzGQ6DZmCFUiKpUKgtKg=;
        b=SKr0+Svb31pF7Jw6RGmnPe8HG7HiRag82KbPAMTTE8KyTpbbN0J70p5CjGMNPrPys6
         wNkTLH1UaEuMMbmKc4kZS1ceh9XpXizKL6/+oYObU9jsnjbuktq5f5pIjR31zbyLKt9j
         takfRtJ3X2vPJLFHLvhDAnPDmAPf+A7Mkkvfdd4AyTeqzlAA/UOt+cO/yGcXp3m4Zxx8
         azsS+fduCUt+ciB/sHfQb2RZoL1Sv7HtEO1KvrGR49F64P0t32sYFanxIyf+Gkz4yf6/
         /N7Aa6XZkN5nGmHeoPHE7i+bsku37g2G95JK0kPr0xVufGW5BgrQYqlLxAifq4FD7A26
         A0uQ==
X-Gm-Message-State: APjAAAUFNnoOo8LDmF+iD96X2obK2SsYMrCB2TynOA0WxJyfE1zivdji
        WXFWlhirTtbKlhfV4DwRvaXPfaC00qk=
X-Google-Smtp-Source: APXvYqyGk7+DsmSnrPB6g5gp31sxI6sfx2J8mSWVUByqzssCbVtU40pAOxr5YrMiphHnf0wAgDdaSw==
X-Received: by 2002:a63:3484:: with SMTP id b126mr1263334pga.17.1576652499643;
        Tue, 17 Dec 2019 23:01:39 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-a084-b324-40b3-453d.static.ipv6.internode.on.net. [2001:44b8:1113:6700:a084:b324:40b3:453d])
        by smtp.gmail.com with ESMTPSA id i127sm1608577pfc.55.2019.12.17.23.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 23:01:38 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Jordan Niethe <jniethe5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <CACzsE9q1iLgoMLzVy0AYeRvWbj=kY-Ry52y84PGtWw3YXXFipA@mail.gmail.com>
References: <20191212151656.26151-1-dja@axtens.net> <20191212151656.26151-4-dja@axtens.net> <CACzsE9q1iLgoMLzVy0AYeRvWbj=kY-Ry52y84PGtWw3YXXFipA@mail.gmail.com>
Date:   Wed, 18 Dec 2019 18:01:34 +1100
Message-ID: <87y2vat8vl.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>    [For those not immersed in ppc64, in real mode, the top nibble or 2 b=
its
>>    (depending on radix/hash mmu) of the address is ignored. The linear
>>    mapping is placed at 0xc000000000000000. This means that a pointer to
>>    part of the linear mapping will work both in real mode, where it will=
 be
>>    interpreted as a physical address of the form 0x000..., and out of re=
al
>>    mode, where it will go via the linear mapping.]
>>
>
> How does hash or radix mmu mode effect how many bits are ignored in real =
mode?

Bah, you're picking on details that I picked up from random
conversations in the office rather than from reading the spec! :P

The ISA suggests that real addresses space is limited to at most 64
bits. ISAv3, Book III s5.7:

| * Host real address space size is 2^m bytes, m <=3D 60;
|   see Note 1.
| * Guest real address space size is 2 m bytes, m <=3D 60;
|   see Notes 1 and 2.
...
| Notes:
| 1. The value of m is implementation-dependent (sub-
|    ject to the maximum given above). When used to
|    address storage or to represent a guest real
|    address, the high-order 60-m bits of the =E2=80=9C60-bit=E2=80=9D
|    real address must be zeros.
| 2. The hypervisor may assign a guest real address
|    space size for each partition that uses Radix Tree
|    translation. Accesses to guest real storage out-
|    side this range but still mappable by the second
|    level Radix Tree will cause an HISI or HDSI.
|    Accesses to storage outside the mappable range
|    will have boundedly undefined results.

However, it doesn't follow from that passage that the top 4 bits are
always ignored when translations are off ('real mode'): see for example
the discussion of the HRMOR in s 5.7.3 and s 5.7.3.1.=20

I think I got the 'top 2 bits on radix' thing from the discussion of
'quadrants' in arch/powerpc/include/asm/book3s/64/radix.h, which in turn
is discussed in s 5.7.5.1. Table 20 in particular is really helpful for
understanding it. But it's not especially relevant to what I'm actually
doing here.

I think to fully understand all of what's going on I would need to spend
some serious time with the entirety of s5.7, because there a lot of
quirks about how storage works! But I think for our purposes it suffices
to say:

  The kernel installs a linear mapping at effective address
  c000... onward. This is a one-to-one mapping with physical memory from
  0000... onward. Because of how memory accesses work on powerpc 64-bit
  Book3S, a kernel pointer in the linear map accesses the same memory
  both with translations on (accessing as an 'effective address'), and
  with translations off (accessing as a 'real address'). This works in
  both guests and the hypervisor. For more details, see s5.7 of Book III
  of version 3 of the ISA, in particular the Storage Control Overview,
  s5.7.3, and s5.7.5 - noting that this KASAN implementation currently
  only supports Radix.

Thanks for your attention to detail!

Regards,
Daniel



