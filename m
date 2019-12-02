Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F276420833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LDvW5+gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfLBIMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:12:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42412 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:12:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so27151535lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RXvQHsZsmW6pXP8cWlKu2oB3ye6J64yetODPCUShQls=;
        b=LDvW5+gU93ELdFLgK+qT5nVScnz7JgrgQhRNku/wapYS8SJVJ0DJqOui367w/7mQxq
         Au7P5C7DLMSuDtkf/MWrkqjx3ggt2cjLRCY1veJ07zT9Q1Eu1LPn5x1JVqaSg1XnhMZM
         3wHW/8HPkLuPc9XfhNEKM5So4ssvUYGcLRkL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXvQHsZsmW6pXP8cWlKu2oB3ye6J64yetODPCUShQls=;
        b=WVU+i9k2wNg21NWn2sf1pMlRnh7zfyII4pU+swOpjR6hlVcYaLa64y4shcQi+g+ewM
         /mxXCUXucntWIxDEPiVxxUZ7kBbMbLz28+sT8/EX4C/YfbuRpmWvhNyKmKYmYExLupZw
         XqLyI7JYdSTgZPhDaJb3HCcEDms9KSYF5F0WCG9K7maw0VqgqYqvIJ7sNtJrVxzwTJpX
         4/diRCsDRUxQVwpfoS9Wqgj3/IgFX21SpMf7lnEXhSMKx02f9kdDEac+x8rjGLcskWz8
         152rYbvD5EV6weEKU8e/lf0msmhETVvsTGbf1qCjXAlme1LvLjEQ/Lu2WI7eLm4F3Vme
         vnrw==
X-Gm-Message-State: APjAAAXAHaO6X2upL4qeYPu8exvbNLYZnP+dqqYm1txNr/PgjwHjrep8
        yALGYO2WiQEU5iYDtoe84N4mdg==
X-Google-Smtp-Source: APXvYqwlkkFrnJatLGMhg+Y85fDnQNQBGUSaNwCgj8pT5xNS23TPmswcOte86uiWZSUfoOuJ8nIa5g==
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr29043163lfl.62.1575274363744;
        Mon, 02 Dec 2019 00:12:43 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t6sm5445106lji.17.2019.12.02.00.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 00:12:42 -0800 (PST)
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
To:     Timur Tabi <timur@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
 <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fb810251-f444-bd5d-54e3-774d2e1ccdb9@rasmusvillemoes.dk>
Date:   Mon, 2 Dec 2019 09:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2019 17.10, Timur Tabi wrote:
> On 11/28/19 8:55 AM, Rasmus Villemoes wrote:
>> There have been several attempts in the past few years to allow
>> building the QUICC engine drivers for platforms other than PPC32. This
>> is yet another attempt.
>>
>> v5 can be found
>> here:https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/
>>
> 
> If it helps:
> 
> Entire series:
> Acked-by: Timur Tabi <timur@kernel.org>

Thanks. I'll leave it to Li Yang whether to apply that - they already
all (except for the last-minute build fix) have your R-b.

Li Yang, any chance you could pick up these patches so they have plenty
of time in -next until 5.6?

Thanks,
Rasmus
