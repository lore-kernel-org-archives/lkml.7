Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC4320578
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfHYVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 17:06:42 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38267 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHYVGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 17:06:41 -0400
Received: by mail-lf1-f44.google.com with SMTP id f21so5784595lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 14:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ze71kdozTeXZmdb5xg2E70/uVH1FbtMCT0+dhgmaPo4=;
        b=B7PvI1jsPe3JCmdUb75NNd1QWW2IBTvexvdiEuGxDN4a7ctfocdoDoPRwsZa2U+CtK
         i6X1efssspE14iQ88S6/s7lZstJLcvbc5IUXeAJOgFu+i/XXedNincLv6NfoVwVm1Ldh
         T6PqXtQySzwoKuy0znBFBt07fBtuoA7vDELBfPtxXdl9Y8hklIswsv441kuzGPS02Rl9
         5LD56Qgz71t6EDMguOLzXnideADnzg68zTi19ZAHa0s1NiMUwv0ja9WVPa/ghwECpp3u
         iMHIECCrbiF0desD4Rcb/+QkQuny0KiJVCkSffKxnMG9PB/1zGl9ZSmmbB7CNK+sNXzL
         jubQ==
X-Gm-Message-State: APjAAAXJSMvTLdpTIqZsYZos2hL5R1y4H1Y+drNTqUFjhtszDd8Y1LB8
        +G9ItnMtbsDHlmgRYwTu/PN65SwN
X-Google-Smtp-Source: APXvYqzasJjTWfsNjIYLK2ChPJjRnvxbT7HoEarG3rDGObQcy0/wl9MGRQPsGMz/PXEUzipG59+jCA==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr3826696lfa.69.1566767199754;
        Sun, 25 Aug 2019 14:06:39 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id z2sm1776716lfh.97.2019.08.25.14.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 14:06:39 -0700 (PDT)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Markus Elfring <Markus.Elfring@web.de>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org
References: <20190825130536.14683-1-efremov@linux.com>
 <e87c12f2-40ab-69b7-2f55-f1fcc980e784@web.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <23dfc168-5ad2-8bd8-0059-091bb814f2e6@linux.com>
Date:   Mon, 26 Aug 2019 00:06:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e87c12f2-40ab-69b7-2f55-f1fcc980e784@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2019 18:30, Markus Elfring wrote:
>> +(
>> +* !likely(E)
>> +|
>> +* !unlikely(E)
>> +)
> 
> Can the following code variant be nicer?
> 
> +*! \( likely \| unlikely \) (E)
> 
> 
>> +(
>> +-!likely(E)
>> ++unlikely(E)
>> +|
>> +-!unlikely(E)
>> ++likely(E)
>> +)
> 
> I would find the following SmPL change specification more succinct.
> 
> +(
> +-!likely
> ++unlikely
> +|
> +-!unlikely
> ++likely
> +)(E)
> 
> 
>> +coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")
> …
>> +msg="WARNING: Use unlikely instead of !likely"
>> +coccilib.report.print_report(p[0], msg)
> 
> 1. I find such a message construction nicer without the extra variable “msg”.
> 
> 2. I recommend to make the provided information unique.
>    * How do you think about to split the SmPL disjunction in the rule “r”
>      for this purpose?
> 
>    * Should the transformation become clearer?

Thank you for the review, I will prepare v2.

> 
> Regards,
> Markus
> 
