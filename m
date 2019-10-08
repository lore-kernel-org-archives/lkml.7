Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E24C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B62220673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Wq+k9y3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:02:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43006 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfJHKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:02:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so16840757lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GqzTqyowvPAvUQbXgGnvR7I0v85sKzoqVofmPdE4wrQ=;
        b=Wq+k9y3cqefVkZ1tL1Y6xqcaD3CqIz8/tHswdPC7vEhgEGm1vMawqMRWqG0DJywGT4
         8fmOpR2baz2OYprCPC1aEY2/tk0YjGKyKnNmrKJqXnyYPhOuLyW9yuN/Nl6uxfwS4oBi
         k7PN8yNJCpnN5dt7uymncpWz1kmBiGAfGidf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GqzTqyowvPAvUQbXgGnvR7I0v85sKzoqVofmPdE4wrQ=;
        b=W4JOP3K4gYvWRuMtVoFsmVAa9cB/uxGC1FQ1atulLQ8D5k8NNpnFs/IEiv/cgra41b
         9K2ubODsy+wAi5/Tl0iXUEARs9dCF5ttF6YeVrnZUjwor+lnKvMeaNiddrmU96FjEzcQ
         C8Sbv/eaCtQXVQOjLgmkTSPTHZye1SbxNHh/8xWkjNnjnEuOcGPVCrd3MOsZKV2pxqWT
         0jo+fwJwsVU0GEGP+EMz7N1KB4PKU4nj0fFmy4T2VumD/peYFdEJt3hE78eFgdCYjGYm
         SC7uHaU4MU9cr5Gyx/FTyA44wRKsHd4ERqViRifDDKsIPy2YWkTi3LAbxbYJNd+BZtPF
         zE7A==
X-Gm-Message-State: APjAAAW9I5HHeWlhaJPptLTtRyFuqVfY9ElGmLwhN+BkP7JzBFqNtHst
        FrjYFn839rPaEtbazBDqg/7ShJkLPJ0fC09U
X-Google-Smtp-Source: APXvYqwvUV0ApYMZHzivst3YYWRXTTQ6OC4spgiYQAFuQFqWZDioKWemwjZ7KV+AIcEc9czHUR3KkQ==
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr15734325ljc.210.1570528929703;
        Tue, 08 Oct 2019 03:02:09 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f21sm4366420lfm.90.2019.10.08.03.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:02:09 -0700 (PDT)
Subject: Re: [PATCH 3/5] backlight: pwm_bl: drop use of int_pow()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-3-linux@rasmusvillemoes.dk>
 <20191007152800.3nhbf7h7knumriz4@holly.lan>
 <5f19e307-29c4-f077-568d-b2bd6ae74608@rasmusvillemoes.dk>
 <20191008093145.kgx6ytkbycmmkist@holly.lan>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9bf6baf9-46be-771c-7e26-527b117c998a@rasmusvillemoes.dk>
Date:   Tue, 8 Oct 2019 12:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008093145.kgx6ytkbycmmkist@holly.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2019 11.31, Daniel Thompson wrote:
> On Mon, Oct 07, 2019 at 08:43:31PM +0200, Rasmus Villemoes wrote:
>> On 07/10/2019 17.28, Daniel Thompson wrote:
>>> On Thu, Sep 19, 2019 at 04:06:18PM +0200, Rasmus Villemoes wrote:
>>>
>>> It feels like there is some rationale missing in the description here.
>>>
>>
>> Apart from the function call overhead (and resulting register pressure
>> etc.), using int_pow is less efficient (for an exponent of 3, it ends up
>> doing four 64x64 multiplications instead of just two). But feel free to
>> drop it, I'm not going to pursue it further - it just seemed like a
>> sensible thing to do while I was optimizing the code anyway.
>>
>> [At the time I wrote the patch, this was also the only user of int_pow
>> in the tree, so it also allowed removing int_pow altogether.]
> 
> To be honest the change is fine but the patch description doesn't make
> sense if the only current purpose of the patch is as a optimization.

Agreed. Do you want me to resend the series with patch 3 updated to read

"For a fixed small exponent of 3, it is more efficient to simply use two
explicit multiplications rather than calling the int_pow() library
function: Aside from the function call overhead, its implementation
using repeated squaring means it ends up doing four 64x64 multiplications."

(and obviously patch 5 dropped)?

Rasmus
