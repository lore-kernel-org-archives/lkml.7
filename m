Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BDC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7B233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BK/+q4Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfH3IGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:06:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43810 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfH3IGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:06:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id q27so4628886lfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l6zzYJYM7QGVQzakKPo5DCouz5vaM1VLR9vr/7r0mrM=;
        b=BK/+q4KuJkEIjJTJUJ2S7jb1ppSxuJKOOTNSS6cyz88U6Z47pOdntEenfzc63oaz15
         RhJHYxyYNKu7L9f360FCRgBOJmmEJKJft+jRTezQr8KZD+J+MmlKfxdH8q2X37SZg2nH
         VF/+COeqVB08odAGg3f6mk4HNLNtCqFyY/mU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6zzYJYM7QGVQzakKPo5DCouz5vaM1VLR9vr/7r0mrM=;
        b=M+B4gkLDc3N0o3dxxV+rSO5Jd10nWghtvm0ILFTfi2ZGDa5fr5x2i/jglb34umXI1p
         H+oIEyRNj3vgL5BFsrSn7OLXuCm1Zu2BUJJyuy/QyV6C4TJmhvZLTTDhrGm9rrJEyhx4
         SpHwqMIVIw9q+Nx9Dcu9WryNv1eDdDsZJoWO5ZS1GXzWY0Ou3q2tvONUC1nkry93aQaR
         BeY8WkbVcPHBv/igQudA0DIXOR7i5r/1R65p3JYfMLfWWJIefS3k3P0WN5nOYdiRQ/af
         1trrEqAjQtoCp+Qr7ZBQPOXiFlmivGeMoN8lebQNdUhOuMAJtDRITKM00bfQ1ngGW1W4
         5p5g==
X-Gm-Message-State: APjAAAUlxHad6GqvCrYY8Dz2G83b/WNthVlmbAGTVqEL9gPGUwEtxS1/
        e5Rqkt5MgLs5x67ZgL4NU1/CDg==
X-Google-Smtp-Source: APXvYqw5wd5oass46uO/I/lDtzyCJj5XfvqCuJwWl10gZyA+cff6MM8IUly5q3mZQf/G+X2N+VQlvA==
X-Received: by 2002:a19:ae1a:: with SMTP id f26mr8442234lfc.172.1567152401476;
        Fri, 30 Aug 2019 01:06:41 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u12sm492350lfl.86.2019.08.30.01.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:06:41 -0700 (PDT)
Subject: Re: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
To:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
 <alpine.DEB.2.21.1908300842060.2184@hadrien>
 <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a327be9e-cd62-6c22-a9b0-ba0f9b295737@rasmusvillemoes.dk>
Date:   Fri, 30 Aug 2019 10:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7933d51f-5c2e-26a4-2dee-e13e61d0ac8c@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 08.56, Denis Efremov wrote:
> 
> 
> On 30.08.2019 03:42, Julia Lawall wrote:
>>
>>
>> On Thu, 29 Aug 2019, Denis Efremov wrote:
>>
>>> On 8/29/19 8:10 PM, Denis Efremov wrote:
>>>> This patch adds coccinelle script for detecting !likely and
>>>> !unlikely usage. These notations are confusing. It's better
>>>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>>>> likely(!x) for readability.
>>>
>>> I'm not sure that this rule deserves the acceptance.
>>> Just to want to be sure that "!unlikely(x)" and "!likely(x)"
>>> are hard-readable is not only my perception and that they
>>> become more clear in form "likely(!x)" and "unlikely(!x)" too.
>>
>> Is likely/unlikely even useful for anything once it is a subexpression?
>>> julia
>>
> 
> Well, as far as I understand it,

Yes, and it could in fact make sense in cases like

  if (likely(foo->bar) && unlikely(foo->bar->baz)) {
     do_stuff_with(foo->bar->baz);
     do_more_stuff();
  }

which the compiler could then compile as (of course actual code
generation is always much more complicated due to things in the
surrounding code)

load foo->bar;
test bar;
if 0 goto skip;
load bar->baz;
test baz;
if !0 goto far_away;
skip:
  ....

so in the normal flow, neither branch is taken. If instead one wrote
unlikely(foo->bar && foo->bar->baz), gcc doesn't really know why we
expect the whole conjuntion to turn out false, so it could compile this
as a jump when foo->bar turns out non-zero - i.e., in the normal case,
we'd end up jumping.

But as far as !(un)likely(), I agree that it's easier to read as a human
if the ! operator is moved inside (and the "un" prefix stripped/added).
Whether it deserves a cocci script I don't know.

Rasmus
