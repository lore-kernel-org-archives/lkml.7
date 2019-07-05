Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F4C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B7D21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="edsyrJE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfGEKv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:51:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37380 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfGEKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:51:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so4286859lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VwGkRG58YJWXqfMjPdvMJBfTTw2kDvU56q8LoW9OQ0M=;
        b=edsyrJE6LKExWpqlURip/OecvNiJ0TVs8OBgeHboE3kcE5CZklSjXsT8o+y3oU/fBj
         M6eW4NKXPvXuudi3L1dT8HxSSlPYBV0l6y7l1KZ2la0+OdW0+l9Wt0Ne7aA/Csh0Nv+B
         pACq2URaS8/vcfMcwIZlZziweXou+WugEsNKcZMCrjDazv1j2zvxfLkfUFcfCaNYH1/g
         Ne8G8rAMzFqFBmrKhF/S93f0sgOnov2Etd93Uhp7UI95iy0dxA+VNeNB1mJbSJ4wZDl9
         64TS8liUwmt2jkCZr8B7rA5fXMGsij+XpXi4jlLWY7mU/vNYp0QcAUVrFnetA7d7Mpf1
         BFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VwGkRG58YJWXqfMjPdvMJBfTTw2kDvU56q8LoW9OQ0M=;
        b=R0U9IVct/uQF9JyY/va09ZRTNO71d4nBYQxHPn/GXKDjbD99ExFcbRC4mebEupAUvB
         NVK90Os+Nq2gTJTBCuVoiO+oMggV4FAoe3yoe6+SFmqOoq4uObfLb3dxYKvtLsPwEMbT
         Wef+awFNz8LapzgXeM9N9MZMVAhRslNgRrUmNI9Wv7tjH3EPBwnCQni1EkwYTHiOYFmE
         7fFOX7HPdqJ6xiKNO4GLoXn7RmXeuWp97osLGlYZbUzWEEqMbaaXeAOLAQ+sV9zwrFE8
         +MmKfwyxOWpkbT2N/mXsR/UkXgC9OzgzXEGeH8Jci0P/BSmMCFmibeo3Xfa9l7uS40zF
         kbLA==
X-Gm-Message-State: APjAAAWsUAEACKr7oK05n/SXnFlbFRCzmOsIZQH02be7SE2Jb5fdqDNv
        mLYpviBY+1tIqSDr2ACnKQpKoeD+3o8FLw==
X-Google-Smtp-Source: APXvYqzqsZ2siwTv0SZ25QHM3z8b+2e8nmY5KGt7/399QR/9911RNhaynjvWUTgno+kO1378QiWopw==
X-Received: by 2002:ac2:4c3c:: with SMTP id u28mr1734061lfq.136.1562323914982;
        Fri, 05 Jul 2019 03:51:54 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4863:dea5:8b6b:ab5a:b1b5:6435])
        by smtp.gmail.com with ESMTPSA id a18sm1734290ljf.35.2019.07.05.03.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:51:54 -0700 (PDT)
Subject: Re: [PATCH][next] ubifs: remove redundant assignment to pointer fname
To:     Colin Ian King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704222803.4328-1-colin.king@canonical.com>
 <b5e7709b-3494-d415-b36c-b19939a15fb5@cogentembedded.com>
 <4741f358-7c21-f721-e9fd-59d73876c62c@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e97cc68c-c59a-1f5f-6580-40868bf16e90@cogentembedded.com>
Date:   Fri, 5 Jul 2019 13:51:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4741f358-7c21-f721-e9fd-59d73876c62c@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2019 11:31 AM, Colin Ian King wrote:

>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The pointer fname rc is being assigned with a value that is never
>>
>>    rc?
> 
> Oops, cut'n'paste error. Do you want me to resend to can this be fixed
> when it's applied?

   That's the question to the maintainers...

MBR, Sergei

