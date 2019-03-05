Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF8F20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LocR//Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfCEDim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:38:42 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44534 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCEDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:38:41 -0500
Received: by mail-pf1-f170.google.com with SMTP id a3so4564239pff.11;
        Mon, 04 Mar 2019 19:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9qe/xxRP0UGpOhS9OKN+WsEOCCaZdYPBTubkM2lUIA=;
        b=LocR//FnGNjGE8YVJqD/7NzQJtwv5k/tGx76kmWx49u14/qYExPcb0OB8OWX44ZD+q
         aQcfdSKNLKOXxYSbPPAZcltJE0+7q7hdH7eIxE78vDXWWh4Lfeyt4+tAdRrMb0MmJwEk
         QNR5g4xOMA25oYxefIPp+7aXsHmACoKASZHb5PFF7f7ZhJK86vpjtj9yZCqml6up/Qsz
         HKciW55fGOR7J9BBP3MKzRdFpGX/Q0OKZQQBFT6xa3ZflY2488+/CU1xbUS/mZL7wFfo
         itJpCmES0t7MFCKNiI0rjBSxGuKcjhj9vNNT13RM+1HBTTR5UIsQsmQ8FyPH+BKLH6uu
         ZBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9qe/xxRP0UGpOhS9OKN+WsEOCCaZdYPBTubkM2lUIA=;
        b=IzSDX6nWufOMJ0Um9tKQp905+kVnZioeoARKyvC3e+yi5xXBhYYDnyFEF/mc0bk0D3
         V0VKgPpp3QxQvXSkl2u9OfGrrsDhswr/gm/42dUiuJHBafe8PJZXpgI1sehOvn8OSpUo
         yoWZEKik9TnZntSANs1V1w4o/vgET4nGFroIr5QekC0xTsfkkEtjVqny+SaaC/dxx7Or
         RtSPzBsdEpWNxynHnwgFAx0ca0AjMwFZdgplH6G081cwEFdQpfDr7fTam66smXEC9qni
         XiYgV/rkkM5AIIA3l844zL0drqC/Z++VPI4+MHKcTHU+mtBNGxkyfZwgJwJ+Vj8mIMgZ
         bd5w==
X-Gm-Message-State: AHQUAua2lFPgOlodjbWHAQw+KXDKgPT1ZD+UBPUOa2MB0Y65J7TZTgjN
        3R5YpnDTro9BdJAbuA0Z6l4kkg0q
X-Google-Smtp-Source: AHgI3IY+szmw/tg5dDghj8s6JpMHML/DXhRdddbKA5cXhqSmCOqlJeI+21uq57OKsdU/exeXekCoNg==
X-Received: by 2002:a62:be02:: with SMTP id l2mr23649678pff.55.1551757121063;
        Mon, 04 Mar 2019 19:38:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b85sm18286608pfj.56.2019.03.04.19.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 19:38:40 -0800 (PST)
Subject: Re: [PATCH 4.14 00/52] 4.14.105-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190304081617.159014799@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4c31e85c-e186-224b-daca-a555eff0db46@roeck-us.net>
Date:   Mon, 4 Mar 2019 19:38:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 12:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.105 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:15:55 UTC 2019.
> Anything received after that time might be too late.
> 


Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
