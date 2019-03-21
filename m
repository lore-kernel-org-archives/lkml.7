Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DDB2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjax+DrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCUHTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:19:32 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:33583 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:19:31 -0400
Received: by mail-lf1-f46.google.com with SMTP id v14so3863434lfi.0;
        Thu, 21 Mar 2019 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/aUTYxlxE4zrbGtIzm28ianJShkMJuQ0KS08IX7SfA=;
        b=Gjax+DrQhiX6f3wOdHbbR4fYI0e2GBK7aUehJmDcJWoXiMHF7KhMf4hkJLTEIv4XYq
         xnUHby5HCh36etsRjrh56LbbkkwfWuXwSBOxTGF1PHjVoX5QS7DA3x4wlYTml/P20EhM
         78aKOUj1oSrNZnTAWxj1UHQ4UkCLpaCdx2M3JQZbvs4UAqLx5f7SJIwiFlWbbplMmZX+
         /aOxgjocUj+rczWEowvom7xtMwWNFJCkI/Ilx1fD4GXdGQpNxKeqxy/en0b6TnalUg+w
         y09GhjzMz+ulxizn7fY7IrVSwvtWfN/7ygpZtjiedEpgcqMrBw51alL2T/DIyoebzHT4
         6Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/aUTYxlxE4zrbGtIzm28ianJShkMJuQ0KS08IX7SfA=;
        b=svL5x785z47M16XqbxuIFNLMDwyWPz1GqorDAjAF8BGdvi0JqN9EemUmxr6dHLhYQW
         1+d/kgfboX1bhorH7lc6wT1yZxSz2dmyHtDG5ZYSTYRvYdwuH+BTE7KvGD6/29jcWPAo
         UzH2O1kv+ii3S35YmnGPdvykwpnj6sCb+PwmPPuO0sx3p/ytOFviKXZ7lwvGIH4t1Rhb
         qLMX7aVGW0YRXbXdjhOIR4vY7uBs+bMYXJ61Rcqqz77RsGDwTPSTbZClfFIqqU8Ww30y
         SJgoYPH894hMrMDj1M2x9/rLdv8sCOYfjcQhXBKUArPUI0meU1ZkxeinvgPafM+pBGJJ
         jMDg==
X-Gm-Message-State: APjAAAWzUKEyIIjNjmHFk0fpNZbgI3F4kgwwnxuu3t2UWhG+yiEe/yzl
        hpFVVwTDDp9Qy11S78o1mE0=
X-Google-Smtp-Source: APXvYqxm0M8LdvnuBxOPeDYB4qT98VtoN7b6NZxcH2D+PC+eUNFhhVDxVRwdK75Bv5Q/07O8kJU2/g==
X-Received: by 2002:ac2:5581:: with SMTP id v1mr1102352lfg.92.1553152768972;
        Thu, 21 Mar 2019 00:19:28 -0700 (PDT)
Received: from [192.168.0.140] (rev-10.ethnet.com.pl. [87.204.29.10])
        by smtp.gmail.com with ESMTPSA id x6sm801119lfe.67.2019.03.21.00.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:19:28 -0700 (PDT)
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <CGME20190308205332epcas1p181370b12f611fd746d333a557a1ddb48@epcas1p1.samsung.com>
 <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
 <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com>
 <CALAqxLV2tWWNuo5UWq8UqDsUDbT4CQX5GVXiBRkHRb+322ys_w@mail.gmail.com>
 <CALAqxLW_6rMG3Bh9tR8=_Zw2y4XkMAsBCnZ6WC89tc7-2kKgHw@mail.gmail.com>
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Message-ID: <2ee85d78-cc76-b43d-5787-72986c0ffb69@gmail.com>
Date:   Thu, 21 Mar 2019 08:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLW_6rMG3Bh9tR8=_Zw2y4XkMAsBCnZ6WC89tc7-2kKgHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,


W dniu 20.03.2019 o 21:17, John Stultz pisze:
> On Mon, Mar 11, 2019 at 9:50 AM John Stultz <john.stultz@linaro.org> wrote:
>> On Mon, Mar 11, 2019 at 3:15 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> On 2019-03-08 21:53, John Stultz wrote:

<snip>

>>> I've CCed new Andrzej's email.
>>>
>>> Could you tell a bit more how to reproduce this issue? Which USB
>>> function are you running on the target system? I've noticed that you are
>>> using functionfs. Is is possible to get access to the usb function
>>> daemon to reproduce the problem here? Which version of HiKey board are
>>> you using?
>>

Can you please apply this patch:

https://www.spinics.net/lists/linux-usb/msg178195.html

and see if this helps?

Andrzej
