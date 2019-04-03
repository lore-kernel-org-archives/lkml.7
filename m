Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6964C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0DE20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TE4RKdrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDCBLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:11:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43245 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfDCBLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:11:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so7404134pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QEwtYD4al19eJmWhOFuud/x7kSg7UeUaV2GJDzUdjNE=;
        b=TE4RKdrZtjgSbjw1n4Ul2WCKYOh5d7QTvvpOd/hu71drRWARX94oUj4mI7OBJKbH/u
         As4XyMltc8TQLwC81RawI1kKZ3zJyRS/UqxBNesY8wmW4EP2NIhfQEVVpRd4bzwcdt0P
         j7ooTLAOS3tPhkRh5PTShsQ4lNdEzkFtG6ABU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEwtYD4al19eJmWhOFuud/x7kSg7UeUaV2GJDzUdjNE=;
        b=pXoJluHHbq8iL8NOgCT2U/jmM+Ep0miXkTIURtIHHZDS39IGwIYiWjjTF185dZaEdA
         LgyB7lGh0zWt05NAYM7Qpjv4jT5XJW3HIWu2DWEvUWt07MLmlTTmjr8dqS3IP0dQ+ljQ
         jsIFjIhHsE0QzdH79lQi84VxQpGn6dR8FKi3tyqy1z70xmD+1EtHJfTORBo2xpnDSuKJ
         MwCun3vL6gH9M0YpIhWX0vRgViHyZCmKhL7GoYQYv033eRGdmv3Py1WDib9m+4ukoUc/
         ZH+7EO9Qzz+h9AdoD8p0EHeBwJ8wB/XXdYCWD3HGWZEaKFVt13W/PastVSq6GmFTZY/H
         EzXg==
X-Gm-Message-State: APjAAAUaprdm4trOROnMAxBSa+hlHL4XZU7Afvt8MNVYiJ/d4fwyMX8V
        cd01ZuRX5rCDO54rAceT1ubJzQ==
X-Google-Smtp-Source: APXvYqwWrNkPQIGtGGR1oZaq9SQJ/P8eaERH2hWL45QQ9y9fVi+m0CUP1kjiO3V+fXyoR/3OwjKCsA==
X-Received: by 2002:a63:2747:: with SMTP id n68mr69021688pgn.317.1554253863796;
        Tue, 02 Apr 2019 18:11:03 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e1sm16507968pfn.187.2019.04.02.18.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:11:02 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] i2c: iproc: add NIC I2C support
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-8-ray.jui@broadcom.com> <20190402102733.GD2960@kunai>
 <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
Message-ID: <8a731837-b21b-c2ae-fe0f-3c8943b587e3@broadcom.com>
Date:   Tue, 2 Apr 2019 18:10:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a1a7a9c9-be4e-c582-d0d5-feccba4022ab@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2019 10:57 AM, Ray Jui wrote:
> 
> 
> On 4/2/2019 3:27 AM, Wolfram Sang wrote:

[...]

>>> +	iproc_i2c->type =
>>> +		(enum bcm_iproc_i2c_type) of_device_get_match_data(&pdev->dev);
>>
>> No need to cast a void*.
>>

In fact, we do need to type cast here since 'iproc_i2c->type' is NOT a
pointer:

drivers/i2c/busses/i2c-bcm-iproc.c:870:18: error: incompatible types
when assigning to type ‘enum bcm_iproc_i2c_type’ from type ‘const void *’
  iproc_i2c->type = of_device_get_match_data(&pdev->dev);
                  ^
> 
> Yes will fix.
> 
> Thanks,
> 
> Ray
> 
