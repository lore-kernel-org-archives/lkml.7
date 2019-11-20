Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A5CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7987C22304
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="L0I5X4rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfKTLr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:47:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35645 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfKTLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:47:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so27801730wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4/bttUSD50/OpRThxoCWFJkuJ+71MHXEy9HmrbnEDso=;
        b=L0I5X4rm1qeU0PdOmqB4UlnESbgPAzScef+wfVtFwALWKkDarLKBikM6gomHD9Iu8r
         E18thZ/EEnxlOTcyMRbph/zTD55zYPRluf3Wt4zQKbli3/8JGugm16LASisTd5Tj+uOg
         GR+8QK9yVGMx4AWebT+7gCebXVmYIHvcTk9pSdwLDIy5coZOZ3EMBHKPMHH93r3d+PvL
         hIGH+s7jUnbopg5ccKw4nvwzs+2Rqx2u7DPOJ2SDqY4Yh91u9dNLpwxoJBbAZTODtBHm
         NQ6b7gTmkS4o3rM2ve0UkZoH097gvMrIl5U2Bn2Fg/BsHTS6AeNv596B9HrFRXVeFWrf
         5UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4/bttUSD50/OpRThxoCWFJkuJ+71MHXEy9HmrbnEDso=;
        b=EiM0Zgehm5cCdVE9UGaGta7WkPi7HQ0Waih6/OgQA3uj612hLO6Y8ZN4ATphuHMllq
         F0t/Uy/ZNInGgeyA0PuazenhRjjKaKsDUnfKPSUfmR0B+hO0S6YZpQ9WHnn0dl1Y0gIK
         v4PkVuBNRX3BYA+NjOVNaDWCHnuwjCKCUivDMBmuMvyzgjEvgendWZMAmqy2z4ZlJQab
         tUKfxf7p7KUxiVBN1/nb9h2sr8SJja0EbwOrePoD5m9X/NkrzqGopjspnqCAGcmm2Lgy
         raAipb8EVUoJXqBPpx2LsyB86j1iT8YGognsmsjumJcceT4WLN3OJmYydOTl8XjrdIPF
         4umA==
X-Gm-Message-State: APjAAAVaxEkD3kzCeqiuE3ozcZCDocQ+XvV+c6rHrISjYd+RAlv+LSkp
        6xcqU8N9Bu3+e6E9HdD4a3yKIA==
X-Google-Smtp-Source: APXvYqzNPrXpTeHh7WeB0sYJYjz8IaD4nRr3NDbSHWZvDVgOnUS9XRcG8kJ+2eU5PNou9WPCk0dPrA==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr791601wrc.231.1574250476673;
        Wed, 20 Nov 2019 03:47:56 -0800 (PST)
Received: from [10.32.50.232] ([185.149.63.251])
        by smtp.gmail.com with ESMTPSA id j3sm30133417wrs.70.2019.11.20.03.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 03:47:55 -0800 (PST)
Subject: Re: Re: [PATCHv1 2/2] Input: EXC3000: Add support to query model and
 fw_version
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Ahmet Inan <inan@distec.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20191107181010.17211-1-sebastian.reichel@collabora.com>
 <20191107181010.17211-2-sebastian.reichel@collabora.com>
 <20191113002339.GJ13374@dtor-ws>
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <eb7f29f9-673d-6e37-0846-226e21b95766@flowbird.group>
Date:   Wed, 20 Nov 2019 12:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191113002339.GJ13374@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 13/11/2019 01:23, Dmitry Torokhov wrote:
> Do we really need to re-fetch model (and firmware ID) on each access?
> Can we query it as probe time and cache? This I think would simplify the
> driver, as you probably would not need to hook it into the ISR. Can you
> just post a read/write transaction to fetch it without waiting for
> interrupt? Or, if single transaction does not work and you need to wait
> for certain time for response - just add msleep() and maybe mark driver
> for async probe...


Having the sysfs access actually read the data from the device can be 
useful to check that the I2C link is still working (in a test scenario).


The documentation does say that one should wait for an interrupt after 
issuing the commands.

The msleep() could work but the value would have to be empirical and 
could be fragile.

Furthermore what happens if a touch event occurs just after sending the 
query request?

Having the interrupt handler be the single read() point and dispatching 
solves that problem, even if it does complicate the driver to some extent.


One further thing is that there are other commands that may be added in 
the future that cannot be cached (commands to do tests or fimware 
updates for example).


Regards,


Martin


