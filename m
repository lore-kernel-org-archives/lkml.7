Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB19CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E0D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXbZOCmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEUJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:02:35 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44820 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:02:35 -0400
Received: by mail-wr1-f54.google.com with SMTP id w13so6867901wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vXRpcR8hUy/z236jHDc62nRnBJfz6oPwUw/X75saOc=;
        b=aXbZOCmdi0RuzZZYueJKuRuzHc9qm6+e8qV7RidheapqjMsHvZ+WEt2p5bqrquTIVh
         iF7mj9TJ1vHbYR9Iy8zIfIcroqjGd+yWWiuXOi8A/tvDh7EMByRwz4RWNQU8uucMtkTm
         91DeVuszQAd9D7JpcEQETJC6205zorp0zrito0Mn7RYRggKVuVRXZi7POCFm1CrdD2Jz
         BztcP0cTLDmN9hWJokghJizBOXif4kCobFcHHsli8dn3VDQQl78IaIycZql0hMj9avW9
         oOJALNTgfkX4+xiad4VNprAjvJyF7s5+pObDUfEANfYGqKg8IbD6RD1p+8dLXEQjVoD0
         3YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vXRpcR8hUy/z236jHDc62nRnBJfz6oPwUw/X75saOc=;
        b=GJnGgK0BBM7cW17aADLFWVM1YjZdUKsQlbdUL+raJfACIYvssKGHlopWY0GbLUoZAd
         s100zef3OjvQ095+1gBp2Q5s3YBcaNKuvkkpzpd0kKzhqtI3o5xJ5Tb/GOqym6qMH0Gs
         AV4H2ON8AjaX+9qk87KAvIyEaxSyXGy6VLCKiiYJwJ6xsBCY6IEgklJAmLC8Tjm8msRU
         N/K9ms0/E32LWwJehh8YhRZWjbNi42f1qPpykJag50dowKqQPoTgpEssFjRm+uj4Oq3o
         7oHkoUHkpb5soWsfLc2s5489QW3Z9wUtLgbcnUsgkidMZbDZuk8eMNUdkf5/RaHbZEqC
         zzdg==
X-Gm-Message-State: APjAAAVledi8f8G0C4tbETwSAr0MNv7OWiTaRWMVno/rLvslyM1V1u0y
        Dw+41LbtgvC9tnzQWzCtis4kMA==
X-Google-Smtp-Source: APXvYqwHbKy6XrNMrf0bXWw/znNxyjKmOYV/fT85nkOTssBGYNlZ75SwruRwpJ6LEmr0CwrFTNRKEg==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr4275934wrs.84.1558429354138;
        Tue, 21 May 2019 02:02:34 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 20sm3143604wmj.36.2019.05.21.02.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 02:02:33 -0700 (PDT)
Subject: Re: nvmem creates multiple devices with the same name
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, linux-mtd@lists.infradead.org
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
Date:   Tue, 21 May 2019 10:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2019 09:56, Sascha Hauer wrote:
> . Are there any suggestions how to register the nvmem devices
> with a different name?

struct nvmem_config provides id field for this purpose, this will be 
used by nvmem to set the device name space along with name field.

--srini
