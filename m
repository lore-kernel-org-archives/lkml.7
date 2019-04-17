Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5C520675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnhMrA7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfDQRF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:05:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732934AbfDQRFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:05:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so32928960wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5YQ2UvnrYIgGu2pNNBbpfJmEtRw3z6vx3kKEusfGzQA=;
        b=KnhMrA7oSQ3RSn46BZsG/m17vFx0X4vBjrIPAeeBjlXqKmAZ7uQeJJ4T4IZvbp9J+P
         O3te7gnc6uuMt9BC2RCdxyO5GfMm2/kI4TFYXOurTUcYRlz/17RHbnAFv5svPnIUOqyh
         lFm5w48skQ8c/SHhw6F4g1Qiy7uD1NTW7zuq08yGJU0mTcYJGvR7LUYYfo5R7oNIkYSA
         j3Kt12lTN6Nvertshfe/5tY7GRa4KgpiwQRu140jAxNMaHi/Asj8XCjwiDZAUm+mcD3o
         U69Ahe0mk4hFkg7saWA3pPNMDuTKzskZHUteswAgK3QoNtCa2WPnymCHnBJUGG/7JMdl
         +liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5YQ2UvnrYIgGu2pNNBbpfJmEtRw3z6vx3kKEusfGzQA=;
        b=ed0PrYsrk64YtwlpECUpuPcKIIb3KEyisS721N9jbhDyIejgLxUnLFZ5yHQVDOrK+f
         wQYh9v8dpgBjvyEsx6s6s9qfRJSmm42bXhu807CSGvOgoWWgOI+CgdgjIiaC0Ozv9bhd
         nRbSxx0aHNEVMuNSt9Z+0KU+P3xXNoc9rG5spl6L0hTn1G/CBxHAVblZv1b7rYtBHJPe
         XFP5+mn9iZpkZiF/b3fsECVfGvr7+r8FRSRg6Kx2IU9CeLO5xeaA/BtAlPlgxRpeuHkb
         Nds9YhWa3R9Ng/tW2oo2vyG8zCBkKC+QAs3UQCvW9jAzcAU/p9vyETAgVDRgPqJeA6eC
         VEyg==
X-Gm-Message-State: APjAAAUMwIhkbjszxhVanqhFvrB2wAuKPjBITyU4Q3j2w10GMzdOFJEG
        EzbxcViClOdhJFzS1Ic3eyHLrA==
X-Google-Smtp-Source: APXvYqwOlAl7nw1NuBzi+kqd4UZXR1gA5LlLS0RZ9dTcwbE4osdQxNWHum22sl5Ul+e2Zv5OqeovWw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr59231203wrr.190.1555520753793;
        Wed, 17 Apr 2019 10:05:53 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id o10sm88087920wru.54.2019.04.17.10.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:05:52 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: do not report EPROBE_DEFER as error.
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        khasim.mohammed@linaro.org
References: <20190417085411.14552-1-jorge.ramirez-ortiz@linaro.org>
 <20190417154638.GC5703@sirena.org.uk>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <7d84d820-c3e9-16cb-b5b7-31761589d4ec@linaro.org>
Date:   Wed, 17 Apr 2019 19:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190417154638.GC5703@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 17:46, Mark Brown wrote:
> On Wed, Apr 17, 2019 at 10:54:11AM +0200, Jorge Ramirez-Ortiz wrote:
>> Do not log a temporary failure to get a regulator (EPROBE_DEFER) while
>> the driver is requesting retries.
> 
>> -			dev_err(dev, "Failed to get supply '%s': %d\n",
>> -				consumers[i].supply, ret);
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(dev, "Failed to get supply '%s': %d\n",
>> +					consumers[i].supply, ret);
> 
> Please leave at least a debug log in place, it's not good to just
> silently fail - even if we will retry someone might still need some help
> debugging (eg, figuring out that they need to enable whatever driver is
> providing the supply in their config) so we should tell them why we're
> deferring.


you mean replacing dev_err with dev_dbg on all cases or only on defer
leaving  dev_err on the rest?


> 
> BTW does an e-mail address need updating somewhere here?
> 

dont know, whose email? I got these from get_maintainer.pl (below); or
are you referring to mine (in which case it is correct, I am back at
least for a bit longer)

Liam Girdwood <lgirdwood@gmail.com> (supporter:VOLTAGE AND CURRENT
REGULATOR FRAMEWORK)
Mark Brown <broonie@kernel.org> (supporter:VOLTAGE AND CURRENT REGULATOR
FRAMEWORK)
linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
FRAMEWORK)
