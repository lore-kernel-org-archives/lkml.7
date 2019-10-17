Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE520640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqdxRMLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbfJQRRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:17:20 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40585 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:17:20 -0400
Received: by mail-yw1-f66.google.com with SMTP id e205so1129686ywc.7;
        Thu, 17 Oct 2019 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9eX1MUum3PI76hS1tjfDJ+ZIzB1yDgtmV+ggxFwwtM=;
        b=UqdxRMLrEuLlz104kxAuC02Xt4KZmxvTPqnrgdjPr3YmWGZWEKl65qYYythlichA2B
         dJ8dklOzPysvkU/8dOHZNxY+gE8w6cIaTSjBYYQThc91zXHF4gOhKTyYoQeXSrPzruaW
         zjyNq+gysxpvZIHvRXQhhWRdPud6Oq0VssWufPdQ+fuQjuQaO7SZYeiNrhW+Pep7Svwb
         EgY1i2A/KHtDDdj+I3m4sd7g3DVHNwfKE1j8ECxieeHOcwYGYUbEvZBYZB/oMuNYWyja
         ldoiJs3YmN+ogZvUMjjops8qRL43FAU9e3Dk8Zup/BFyJ+iwrjJZhpc8f7vXNZSXI3gF
         GR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9eX1MUum3PI76hS1tjfDJ+ZIzB1yDgtmV+ggxFwwtM=;
        b=bLv9ruVNOie8aNmLOgYtvXkO4e86cy2XRUx6HDm08FB0EXoKRbYSwBydhPnF6ldQX3
         5tqLVfiARarV3ioP/afNrpHMoPv3cvR3V3P+5H0IlDrtyXqciKK9czwGlWW2UbAG79Tb
         l6Vcz3bNLSEqe21TxaEiS1fj6DVJF1Y1oMSz8Q3ESh1kmexoDbE+Orz9IiHaWmEMgV8J
         9n0q710MyP+Ij8IJnfITViykI1fan8L7vndoE8OPEDTDpbgARDabaGiFel8OolL9ZACu
         h9h/zObjUbxL0q0QwI/tkYmLPQnJksLgatzkpGWqtVmOUR3rBy4hGWhUjWEJYrYT+PIq
         NNsw==
X-Gm-Message-State: APjAAAVBTUZsHXd6GI/8wQLCuDOUjiw7y0DahLJUp27DOEJtiFpTHdt8
        ruu81sjVnr/o6t6V8BM54pAsEGEs
X-Google-Smtp-Source: APXvYqxuximjpgYnrT1kXVim7da4XtaRKQh6Mifj1K/sRgrxcX24CukW4NLVJ/umqwBBgieYtyk8tw==
X-Received: by 2002:a81:a485:: with SMTP id b127mr3381626ywh.184.1571332639579;
        Thu, 17 Oct 2019 10:17:19 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id y67sm792211ywd.63.2019.10.17.10.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:17:19 -0700 (PDT)
Subject: Re: [PATCH] of: unittest: Use platform_get_irq_optional() for
 non-existing interrupt
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191016143142.28854-1-geert+renesas@glider.be>
 <5da7a675.1c69fb81.a888.0911@mx.google.com>
 <CAMuHMdXnTOaM+4SUkzpYXNeFbJtaG_kRzFLJRhVPCVNcOUB0qA@mail.gmail.com>
 <CAL_JsqL9YPowxntVPax868hi+sN3vgCa2aSSySzjg==--c7aDA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d4b336ab-3a80-be4b-7a56-88cf98eb19aa@gmail.com>
Date:   Thu, 17 Oct 2019 12:17:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL9YPowxntVPax868hi+sN3vgCa2aSSySzjg==--c7aDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2019 07:51, Rob Herring wrote:
> On Thu, Oct 17, 2019 at 1:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Stephen,
>>
>> On Thu, Oct 17, 2019 at 1:23 AM Stephen Boyd <swboyd@chromium.org> wrote:
>>> Quoting Geert Uytterhoeven (2019-10-16 07:31:42)
>>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>>> index 9efae29722588a35..34da22f8b0660989 100644
>>>> --- a/drivers/of/unittest.c
>>>> +++ b/drivers/of/unittest.c
>>>> @@ -1121,7 +1121,7 @@ static void __init of_unittest_platform_populate(void)
>>>>                 np = of_find_node_by_path("/testcase-data/testcase-device2");
>>>>                 pdev = of_find_device_by_node(np);
>>>>                 unittest(pdev, "device 2 creation failed\n");
>>>> -               irq = platform_get_irq(pdev, 0);
>>>> +               irq = platform_get_irq_optional(pdev, 0);
>>>>                 unittest(irq < 0 && irq != -EPROBE_DEFER,
>>>
>>> This is a test to make sure that irq failure doesn't return probe defer.
>>> Do we want to silence the error message that we're expecting to see?

No, we do not want to silence an error message that we are expecting to see.


>>
>> I think so.  We're not interested in error messages for expected failures,
>> only in error messages for unittest() failures.

platform_get_irq() is precisely the function that we are trying to test here.


> 
> The unittests start with a warning that error messages will be seen.
> OTOH, we didn't get a message here before.
Getting error messages from places outside of unittest.c is just the
nature of the devicetree selftest beast.

-Frank

> 
> Rob
> 

