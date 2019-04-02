Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4E82070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OSP/mj/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfDBR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:57:39 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45620 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDBR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:57:39 -0400
Received: by mail-yb1-f193.google.com with SMTP id b18so5146774yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2d9K9JUUlUqo7KV2H4/IAzjMAbwM+ocor4KxdYwAt1E=;
        b=OSP/mj/Q43obVdXvQ57TjzVvFutjUvARj/fwj7KwQbAGYyhMFLmt+xaCFRQ2gFX5wH
         UolTLDXM2nO1GNy0xLGQvjSqBfxb1glIYRzt//1E+1EpDhqDFPhMpRlyHYQxJOMNgMDu
         ceXfkzEkoJp16tAo59KKj/qtDNvKX55VkTRC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2d9K9JUUlUqo7KV2H4/IAzjMAbwM+ocor4KxdYwAt1E=;
        b=RTN8Xmadj5zLHaUH7v2G3ZD6v26aUrf/KeugdN6675uo6rUqoMLDu7s3WxrPKYKAWw
         hyfKYnq9281/KrSocSJ9hLszi1V9GYKCmPifpH9rYEjShfgLVQe8rhzJzbf0AIiCcWUn
         HxPIy7IDEKNRCLLYf0foCB571U0bdfToNxBNCRszwvVvQA1ASpNxw5iukqf9S1Iz0+p0
         iwr5c0ELKCPqbpTgFBnvpO6ur3cK2avH6w8wNmgtJmD+24ZckNTwGrygqCzmCzBlW/IL
         2+vpotnz9RKumBWHsIp1k/TWZqrftwbUUINNiatWPAeuZ2Fqy6Lrv7pbG6K/CM15pSJ3
         9MMA==
X-Gm-Message-State: APjAAAVRx06/BKZ4znLbrjFBNN2N89OM3gCwIdh9K9sBavlC49cPdb0R
        1ZfuySjr99Pf1SaevhQjYEzGRA==
X-Google-Smtp-Source: APXvYqzJiMWjvkLIiSZO9C+i7oQS9V/YAY//eV4eWJhDinLcHwvY25ygiyVAQJ5RZA0V86V+Tydgjg==
X-Received: by 2002:a25:9941:: with SMTP id n1mr58710999ybo.85.1554227857972;
        Tue, 02 Apr 2019 10:57:37 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c206sm4681079ywc.71.2019.04.02.10.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 10:57:36 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-8-ray.jui@broadcom.com> <20190402102733.GD2960@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
Date:   Tue, 2 Apr 2019 10:57:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190402102733.GD2960@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2019 3:27 AM, Wolfram Sang wrote:
> 
>> +#define IDM_CTRL_DIRECT_OFFSET       0x00
> 
> And this IDM thing is also never used outside of the I2C context? In
> other words, it also doesn't need a seperate DT node?
> 
> 

That is correct. Only in the I2C context in our use case.

>> +	/* indicates no slave mode support */
>> +	bool no_slave;
> 
> I would suggest to not use a flag, but to nullify the {un}reg_slave
> callbacks in probe depending on the type. That will also tell the
> i2c-core that slave functionality is not supported. And you can use if
> (!algo->reg_slave) as a flag, too.
> 

Yes. Great idea. I'll make the change and remove reg_slave.

>> +	iproc_i2c->type =
>> +		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
> 
> No need to cast a void*.
> 

Yes will fix.

Thanks,

Ray
