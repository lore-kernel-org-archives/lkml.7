Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8810C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2672071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAKO2iXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLaAEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:04:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLaAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:04:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so34139148edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIBxewMY3nznL5SvEmEa+wyozMXEUAHnk3liBvERPKU=;
        b=TAKO2iXFBSZsFGt6ExVr9s00eJyYE3rUuhfN5gJzCxeNbrBhiIarX0jWV+AtPKb2Ye
         d1ZLpKKaRCqmxrTmY5JUwQ5NxsMDSUZPOSOXLESoSY6VMdlrCMvV5VFxyRONMwBoBVOV
         m32x0kFwnVLNqpChO8YH8C73CaxVFNqV0FQVKLwYPpbcZroxR0mwPHn0yNfzQOs6w2aK
         q0t4tGrTkCA19oGSxVivd2mzcZe2+77A4n3z4qq1KkVaJxU4f2uBMS2riRLfQ6rRg2Xy
         QfxyJk475yfJ9yWtycqzQWo+YUkkmZeS2bE2Kn4COAjX2SAA4ibITr/6Aw3+GzYxp+DI
         6wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIBxewMY3nznL5SvEmEa+wyozMXEUAHnk3liBvERPKU=;
        b=K9kHQi5DLRRI/ppvseTTdE8Rcv58qluyIIbTOwV/y0taXmfAU95KvHYq7xLf0bpUcy
         3TjEN9pqMIJBlrSX4JIHAYvBZGowk58sEJ0qunyQHUH6qrOFHGPDSBGOWQci9PprfeTM
         JnoMUFwjrV1Afw+Wl/0z/OHbmQRZUuj8ONzRTM3Vq2nLKlb9cZiP/LEqKr5nLrcgpkSn
         g6BN7SMaX2cyl8fC4PZFCmuBKcwMPq2dGYk4CGwqUa1CZ+3YY4nYpGrspRXMGlwSXhiF
         P1RSfM7fcMyE5gZQHMzruiHh6x1NDC4/iFD2gSCEFO9icFKUstQORy2mSoEVQWVNSqeg
         uCQQ==
X-Gm-Message-State: APjAAAX8rC5EasWbYEML1b0OPhxXf2zqP6GCvdqhoq5ZAhaV1AY5Y79V
        W1/G4g8gj7RpvwEughw4WsDjXOtpedM=
X-Google-Smtp-Source: APXvYqwrGbb4SHIthcmfY8qpeubECSaNaWzkINorfKEu9z7KardRZNr+vadbrl3GmAECP0kKhYu/Sw==
X-Received: by 2002:a17:906:3591:: with SMTP id o17mr74979351ejb.209.1577750686139;
        Mon, 30 Dec 2019 16:04:46 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id o15sm5506653edj.3.2019.12.30.16.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 16:04:45 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: gadget: Fix failure to detect end of transfer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191230161321.2738541-1-bryan.odonoghue@linaro.org>
 <20191230185703.GA1763367@kroah.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <e772c382-b820-355d-f2b9-8690a5f85885@linaro.org>
Date:   Tue, 31 Dec 2019 00:05:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230185703.GA1763367@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2019 18:57, Greg KH wrote:
> On Mon, Dec 30, 2019 at 04:13:21PM +0000, Bryan O'Donoghue wrote:
>> A recent bugfix 8c7d4b7b3d43 ("usb: dwc3: gadget: Fix logical condition")
>> correctly fixes a logical error in the gadget driver but, exposes a further
>> bug in determining when a transfer has completed.
>>
>> Prior to 8c7d4b7b3d43 we were calling dwc3_gadget_giveback() when we
>> shouldn't have been. Afer this change the below test fails to complete on
>> my hardware.
>>
>> Host:
>> echo "host" > /dev/ttyACM0
>>
>> Device:
>> cat < /dev/ttyGS0
>>
>> This is caused by the driver incorrectly detecting end of transfer, a
>> problem that had previous been masked by the continuous calling of
>> dwc3_gadget_giveback() prior to 8c7d4b7b3d43.
>>
>> Remediate by making the test <= instead of ==
>>
>> Fixes: e0c42ce590fe ("usb: dwc3: gadget: simplify IOC handling")
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/usb/dwc3/gadget.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think this patch:
> 	https://lore.kernel.org/linux-usb/ac5a3593a94fdaa3d92e6352356b5f7a01ccdc7c.1576291140.git.thinhn@synopsys.com/
> 
> should fix this issue instead, right?
> 
> If not, do I need to include both of these?

Yep, works fine in isolation.

