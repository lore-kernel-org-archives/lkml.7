Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1CCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963721904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AocK7Die"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbfDXRhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43061 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392236AbfDXRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id e67so1809343pfe.10;
        Wed, 24 Apr 2019 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4lu+1vlhbjslXcZ+IaIg4nXYQuDoy6RxBAv/fSgycFA=;
        b=AocK7Die1k9rJWmoC9Lppa/12mpfiD05zWa0mE1T8fuIpdLW8fRo2aFmr0f75TdozL
         N2hBvDXmsEjaTaeyAuRMmOLR9ZyjbYWscmM+0IX+xVDiSXcuombCMIlKOjCjpllNvNlP
         JeZuTwDL36HdBYd/xWtHMf5c8y3xlheECrlHusVq6E3hIhmIZht1ZX34R36dZDmMtTyW
         j85tD9gq67k1nHVf9nxwou7CDZGsPPJMlkvB5Qgcb2FUYOC4Taja/pnkJq7vQPJBCX+z
         bBVLV1LlKA5j9RBnBDfc+OPONKk28Uyx1UTlOWpB/lmSxct8eLOe5joW26jb5eqn8aNA
         +Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4lu+1vlhbjslXcZ+IaIg4nXYQuDoy6RxBAv/fSgycFA=;
        b=hX//+OuG5/hBj5porYkfXUUgD7uOvhdNBp1piBLg9XimqrAeiAxhE/P8xNjGBGFi/t
         XqQ6E4QXvhzTQkatNRvCd8pG7ESnOk9Aocz32I7E12cqrNIJ/zLFBpYhNhostiKX+Jl4
         HKfBf/LRhB+HIs88yqjfxR+++iAUxuQKrIM8UuYUQBi5gnsN/yd/BonSvpwS56JpLG/3
         5rNb0dcck/wdhWWNP29FtowSl2ZoHdRGxpohhbVOTlvBx25Kh5wokeQHAsit5sH8iA4Y
         mKOMO1Zd+gZqRlreheRDcmpu4hbwsBikfoGJKpsqnK28Y5YaIyGA1QNc7CZ6ECPXiKv+
         xH1g==
X-Gm-Message-State: APjAAAVZs3l7ao8tScKBt3we4jvpj8bVZ8anmxDNCDvGBi5RYrH/Jeoj
        6NV8t0RGBsSFsmhYMkCMrJ5RouAT
X-Google-Smtp-Source: APXvYqwbJacLfOT43viAmaUbWM1+W6/uhXfGIMf5FgIAXU99Oi8dBsaPVb4PcLTh1v653SuIks+CSA==
X-Received: by 2002:a62:aa06:: with SMTP id e6mr34970659pff.254.1556127457258;
        Wed, 24 Apr 2019 10:37:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10sm46260027pfj.7.2019.04.24.10.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:37:36 -0700 (PDT)
Date:   Wed, 24 Apr 2019 10:37:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iker Perez del Palomar <iker.perez@codethink.co.uk>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
Subject: Re: Fwd: [PATCH 1/2] hwmon: (lm75) Add support for TMP75B
Message-ID: <20190424173735.GB29860@roeck-us.net>
References: <2904a750-c6e9-719b-7523-0f45e0bc82cc@codethink.co.uk>
 <2effcb0e-03c6-0f7e-b154-62cbc9ad415a@codethink.co.uk>
 <655fa0d3-1b76-96c7-4c04-9f258a3305bc@roeck-us.net>
 <e3d0b580-5552-fc4c-7ecc-660b000bfbc4@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3d0b580-5552-fc4c-7ecc-660b000bfbc4@codethink.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:10:38PM +0100, Iker Perez del Palomar wrote:
> Hi,
> 
> 
> Thank you for the review, I will submitted fixed soon. I have one question
> before doing it though, after running scrips/chechpatch.sh I obtain the next
> message:
> 
> WARNING: DT compatible string "ti,tmp75b" appears un-documented -- check ./Documentation/devicetree/bindings/
> #83: FILE: drivers/hwmon/lm75.c:549:
> +		.compatible = "ti,tmp75b",
> 
> total: 0 errors, 1 warnings, 60 lines checked
> 
> So I added the next in
> "Documentation/devicetree/bindings/trivial-devices.yaml":
> 
>            - ti,amc6821
>              # I2C Touch-Screen Controller
>            - ti,tsc2003
> +            # Digital Temperature Sensor with Two-Wire Interface and Alert
> +          - ti,tmp75b
>              # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>            - ti,tmp102
>              # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> 
> 
> Is that the proper procedure??

It would make more sense to add it to
Documentation/devicetree/bindings/hwmon/lm75.txt
since this is where most of the lm75 compatible chips are listed.

Thanks,
Guenter
