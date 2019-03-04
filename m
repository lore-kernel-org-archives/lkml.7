Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1491C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7520675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iwOmvDFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCDOJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:09:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45543 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCDOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:09:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so5209802qtg.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XeUZ0bSuaagpODDaNgkebhSpO4mdjSfmcYJ84JIvp08=;
        b=iwOmvDFJyslQ30B84EdbQ9EcU0e9z0nlF7veasjUif1D/2vlMYSgIj9v/R4afuGm66
         wCCf6sJ25kH2fJMu3lsfy6eAZm1KlksFQih5qpltw+Qr8dshZKnHMCFEs/Esu3jMh+sH
         nGUFsAVx5cBV11ddc0bK/Q99QD0unMqIVe0ZaxbglNDwwjg9YOW/YBCRD76CseCKJhkN
         FvmVTKEPJF5GRRemIlvy8WaDd61LFbb3WBUm1yc6hXH+Wsa8u4iMROz9FF+p3J39PPMT
         dnPjt4HVnZGB90xEwwgOM/6+M+5ckD7AKD2KV1U1Lt7nVlbuMLMJGMjpyGF0n1VWGGAz
         58bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XeUZ0bSuaagpODDaNgkebhSpO4mdjSfmcYJ84JIvp08=;
        b=hpbFOeSzhLA3/iclEciHIuMxOLUpHaBrTBfPVKuwv+RYbGS90A8zEQaFm5Qsp3S3xi
         V0CUkaaCF97xixhlqe0EJGy6faJsvrVKE/3pTN3ZHFUTMZJ3+vdXUdCy0gzJM901rtnu
         LllLhSchFMESZAvW8oupfH2r70G2VCZIVfimSbpsZ+VyALIid2IqMpVUvhK8kceICNHH
         Ly0cncWEpCUHTMoIZl/y6tEC2TOmiNzaxmLchSv6DUuZKyYfa+RKcVnOiDUM4CD5K+T7
         uY+vLn2OFXYKoUScaiTCycmLf/PVDlJAn/dxzD1oheNu5pkKc1Le/ULDa+W5l3xABqhu
         bKdQ==
X-Gm-Message-State: APjAAAW8JRNADRMfLB/EJD4jFcM9nA4gVmCFjQkWoqLP0bScFtmqlD8P
        f0QEosvl0ljfMur51cTNSoeBVLwihE4=
X-Google-Smtp-Source: APXvYqxebk4cygCw66b8m5/eWF71BIN2+jlrN1rpbLDw4AjriPIoka3S/L5IeqOWgi//Y9xk4xIwzw==
X-Received: by 2002:ac8:67ca:: with SMTP id r10mr14668266qtp.134.1551708554226;
        Mon, 04 Mar 2019 06:09:14 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x25sm4186313qtx.71.2019.03.04.06.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:09:13 -0800 (PST)
Subject: Re: [PATCH v2] mm/hugepages: fix "orig_pud" set but not used
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <20190301221956.97493-1-cai@lca.pw>
 <CAFqt6zZr8ZCM6_7QDzDEf=5gH=+EkaumXk86X35dGTdn_SLvvA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <935fc484-70e3-ed7a-ed82-329529e0e280@lca.pw>
Date:   Mon, 4 Mar 2019 09:09:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZr8ZCM6_7QDzDEf=5gH=+EkaumXk86X35dGTdn_SLvvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/19 7:02 AM, Souptick Joarder wrote:
> On Sat, Mar 2, 2019 at 3:50 AM Qian Cai <cai@lca.pw> wrote:
>>
>> The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
>> hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
>> its return code. In order to not diverge from
>> pmdp_huge_get_and_clear_full(), just change zap_huge_pud() to not assign
>> the return value from pudp_huge_get_and_clear_full().
>>
>> mm/huge_memory.c: In function 'zap_huge_pud':
>> mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
>> [-Wunused-but-set-variable]
>>   pud_t orig_pud;
>>         ^~~~~~~~
>>
> 
> 4th argument passed to pudp_huge_get_and_clear_full() is not used.
> Is it fine to remove *int full * in  pudp_huge_get_and_clear_full() if
> there is no plan to use it in future ?
> 
> This is applicable to below functions as well -
> pmdp_huge_get_and_clear_full()
> ptep_get_and_clear_full()
> pte_clear_not_present_full()

I suppose arches may override those that could make use of "int full".
