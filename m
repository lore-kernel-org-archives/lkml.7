Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9036AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556035596;
	bh=pQ1A/TDFFWD/UmdtE+s6ETqITKHgvg/WqC5V7Ct7SOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WrbX30QB8znbCTWesagDX3oH2YgazE0fKoaUrSlDkZrFLK5ZjFneonctnH9BVVZ2s
	 3gqtQsX3nAh8cmzaygmpOuBceYQWGs+q1MSZYvbKR32WqmJtecQMSqXoKkfhg78ogv
	 fPv/r/MEy7FYovS6Hf53+G9IGOlxEWx2Z/heai+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDWQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:06:35 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:33408 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfDWQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:06:34 -0400
Received: by mail-lj1-f171.google.com with SMTP id f23so14070500ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhckMePRJRIMKUNlCIkx3VHe63IXH0bZ3S6Gwqv5tdM=;
        b=CZonqEvKRryr7I9kZkzaMOwuQF50UFC0DuXrN+A5A6rDj20MPF13Loj640HKBDdB/S
         wli9FxRhQ1OX9jSEjTEapHcc+guN8oU7kWxmO0cu6zjBUv5QhZecKO1iE405PwB0TBDs
         hqJUvZk6OvySvehOwaartA/mM+abp7YvVEyVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhckMePRJRIMKUNlCIkx3VHe63IXH0bZ3S6Gwqv5tdM=;
        b=WahginSwGbFyqLt0aJb4g0b/ccGYnZAqucbEhH1M1ZuGaYzho54wZx1NmBTzLupdXG
         t8zm85EG2Pag5uhwXiPMxyHQcxJ2rrgt0Ji8wzpa7/zTbKrlygQ9+GA6Dxdi/STSxNP1
         HdvyuKRfoh3s7xtD3SlfeXneKdJf7IRfaW/o6XG2FZDv5mZuZjMb/fxjHJR2XNMcOsvy
         KspKYbSPayqXrku2LUqjn/QP/WkNKeaE0ZC3faLaiCWiq1iZJpkOQbFi4qKumR41k8aU
         S0n1CzKBRJFf0GY2KDsq6knSiLS+4ro9p2sro3oVPg2ejoIQ7CJJj9OvJ4//yp2l+hyt
         FIQg==
X-Gm-Message-State: APjAAAVMfoGeScq2bt8Eb94zyOmpqb2eGO/J6GwW7+kAM3M1Uf1Ivisg
        oWAi4ol6ztVc/UZJUaPFA20GqZzlaAg=
X-Google-Smtp-Source: APXvYqxOh5k9sPwmnHQdSO/EbVJkxiawPQltCudpA88rU9I3w7AP1HsvbukDM3g/BwI/Va0Nwv51iA==
X-Received: by 2002:a2e:8057:: with SMTP id p23mr3569962ljg.33.1556035592214;
        Tue, 23 Apr 2019 09:06:32 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s3sm3824040lfc.25.2019.04.23.09.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:06:31 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h21so14008318ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:06:30 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr12853071ljj.79.1556035590337;
 Tue, 23 Apr 2019 09:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1> <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1> <20190419153307.4f2911b5@mschwideX1>
 <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com> <20190423173859.42d5ba8b@mschwideX1>
In-Reply-To: <20190423173859.42d5ba8b@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 09:06:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCwe7Uk0P6zJnTPqz_BvkELBbnocS-0qdWxVgq9qebjg@mail.gmail.com>
Message-ID: <CAHk-=wiCwe7Uk0P6zJnTPqz_BvkELBbnocS-0qdWxVgq9qebjg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 8:39 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Ok, I added two patches for my s390/linux:features branch
>
> Martin Schwidefsky (2):
>       s390/mm: make the pxd_offset functions more robust
>       s390/mm: convert to the generic get_user_pages_fast code
>
> All code changes are inside arch/s390, I plan to include these patches with
> the next merge window. That gives us a little bit of time to run our tests.

Sounds good. Thanks for looking into this all.

Now I slightly wonder about all the other random architectures that
don't use the HAVE_GENERIC_GUP config option, but at least we'll have
all of arm, powerpc, x86 and s390 using the generic code..

                    Linus
