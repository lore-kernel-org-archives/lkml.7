Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C732C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B9206EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ykJu8gvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLTXvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:51:10 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:34947 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfLTXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:51:10 -0500
Received: by mail-pj1-f41.google.com with SMTP id s7so4816559pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKQ9URZBMeV3OPseAAh2Xx7y2pXyxLatIKtNl8iLvXQ=;
        b=ykJu8gvYo2ySI4MYq3KAx12I/84YrqF+Q/U5WMmy9QswF5KWC7Km1ht1FtGvNaAqEP
         O5N9mcr7Ry87YOOCeMm9G9FT4U2Eg8KXvUxER0cexg2PiLXMO8kzbyibp6yHj99A0BwQ
         azvWMwgMPEzz53V3OcaFGUZMscgQ49MExbyF4PTQYnrMpJNaDUSPsxshj/pv3lDgiSEa
         V6iwl5I4A5vmr+Ob3uN9MzIuG2rz8qbK9VqN9mLJejdnI3ZW3+2VKhK3LRj+FC/uePhi
         Swb8KNcr8jc974+Q3z6dOxdd6nhs7IAAlnnRfXigkKsfolnY0ljiBl0xJMN8YmjPXtYj
         1Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKQ9URZBMeV3OPseAAh2Xx7y2pXyxLatIKtNl8iLvXQ=;
        b=meUg0OvpWtKmCWaGky42KJf8DOeXWSL568UcxHyoTlJhUWvVjPXNR/OsJEG87ipsBT
         B/K770QTQxYqFogm7UgpfWSAR4o944PT4pBEltGNzoJMQblZGe03MN66mOp/jfkzm218
         w9haOVHVjFffemk4NyKkRHKtIvFZmW1TKo4qIVVlLa/JjT38HfgCiIqyJBQmSPpoZ3oR
         kAGC1jRcMR5944+H+ur/LZf/xbDTtl3ocgqevsBZhRBBldgOWNcSsGjUVxXL7dV7YuM6
         0f+EjkmARm2Hg0iTPVTYVs9iCZD8Q7t9D9KKja5G3amSaFXNTGeSZqPH2vQpYbLx+VLo
         GC9A==
X-Gm-Message-State: APjAAAVcFBS1k8xUYZBbsVFA+BToXmeoJh+e+oAY1ff5zbGUut/7V6qF
        vCki7ELeCOjaiy9s0X+9OUHhRHB55YgADQ==
X-Google-Smtp-Source: APXvYqzmkZWiV7MicyHExsLOg3UvxPLhXwAkPmhB5mHQM5D5YzarwPE7bcTHy/sqhKiuGY4VEVe9RA==
X-Received: by 2002:a17:902:76c9:: with SMTP id j9mr8890271plt.21.1576885852697;
        Fri, 20 Dec 2019 15:50:52 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w38sm13024578pgk.45.2019.12.20.15.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:50:52 -0800 (PST)
Subject: Re: [PATCH][next] io_uring: fix missing error return when
 percpu_ref_init fails
To:     Colin Ian King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191220233322.13599-1-colin.king@canonical.com>
 <398f514a-e2ce-8b4f-16cf-4edeec5fa1e7@kernel.dk>
 <cf270359-fd06-3175-d0ef-ec2adc628235@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1a36f72-50ff-9cce-bcde-6639f7ab6406@kernel.dk>
Date:   Fri, 20 Dec 2019 16:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cf270359-fd06-3175-d0ef-ec2adc628235@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/19 4:49 PM, Colin Ian King wrote:
> On 20/12/2019 23:48, Jens Axboe wrote:
>> On 12/20/19 4:33 PM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently when the call to percpu_ref_init fails ctx->file_data is
>>> set to null and because there is a missing return statement the
>>> following statement dereferences this null pointer causing an oops.
>>> Fix this by adding the missing -ENOMEM return to avoid the oops.
>>
>> Nice, thanks! I'm guessing I didn't have the necessary magic debug
>> options to allow failure injection for failing.
> 
> Fortunately we have Coverity to the rescue :-)

Indeed!

-- 
Jens Axboe

