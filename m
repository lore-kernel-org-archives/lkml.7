Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C164C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64972070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0jEj9zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfHSQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:03:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41577 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfHSQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:03:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so9271903wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6CiC3PI+TmOa2p2Q2SeB4X/ZsXshUT7DqEoOM5ckDHQ=;
        b=G0jEj9zV3eHqI1j8W40/3fnNs82adJ3/UEI+kEZAZDf+H9nczzYzLB/t1dOYuND52g
         Zsqaw5E9SNMHuyCkZVr0K5I2rB0mxLGPmbSFeGR4ex2qV5IdSd5d2ykx2F2C0Gd7ARkD
         hW5Jpr+nDc5SEg5xkamYzxCLL4hT3dz2e9wk325giL2Ct76TMMgslshO1RP4NdwNnH8d
         jFlC6RdBu845K9FlsgHXaEhavopGWu07xmmfSHsVtW/UphPyk1cNpWaSumgBpOO9Rrw7
         QNyGYu3l0FiA9KGS7h/Wz6vwSFfGlXgkqbji+U0d6WQLRwMrNYh4giZ/pypWafEJHvI6
         sGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6CiC3PI+TmOa2p2Q2SeB4X/ZsXshUT7DqEoOM5ckDHQ=;
        b=ULSU1HL5lJc1i7CXzkSC82YjgAzXhDEuw+7TTqnLwcGilYuSAX+IIp+kxp4AVwMfXQ
         cwZSEdTmYs2Q7PCmtIEvUX93/v/6stQh7SFqj4L0U7MQptaN7vOUugBnY1jjdpQUyFOb
         eohcLRzTxigSSQ1ggqv9xHUMoQEJS8DY7Rfv84nZK3B13TXDgLBGmuxdsKsv+v5AhmYz
         4XCv12tM6sRXSCFzhkc602oUmQd2cdTkgEZ/qHrsaYDcuYwJIYfqoX9k4eIaSuuv/tgS
         G71iWn7PcHD/8DO/u0F7nVLAM8pQx6ffuba7HtCeaRPy3MguuT+b3fN5i+ijS8PM+7XJ
         8gcA==
X-Gm-Message-State: APjAAAV/t0k7TcBzOGfZXpF04NFhsq4YoIbzQ8OR77EoNW6pXX0ltkEn
        SJe1cO5xlvzM6M4LiP481p5LGA==
X-Google-Smtp-Source: APXvYqx1eK0G7jwYaqgVAS+nqtWjQWIhjZxh4MmgupwqIPPmzYQcW6th/ak/QwO45xkaGiS3mSuXgQ==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr14857333wrw.68.1566230625109;
        Mon, 19 Aug 2019 09:03:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s2sm13301910wrp.32.2019.08.19.09.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:03:43 -0700 (PDT)
Subject: Re: [PATCH v4 3/9] nvmem: core: add nvmem_device_find
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
 <20190809103235.16338-4-tbogendoerfer@suse.de>
 <8d18de64-9234-fcba-aa3d-b46789eb62a5@linaro.org>
 <20190814134616.b4dab3c0aa6ac913d78edb6a@suse.de>
 <31d680ee-ddb3-8536-c915-576222d263e1@linaro.org>
 <20190816140942.GA15050@alpha.franken.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fca76e6d-fa0b-176b-abcf-e7551b22e6a9@linaro.org>
Date:   Mon, 19 Aug 2019 17:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816140942.GA15050@alpha.franken.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2019 15:09, Thomas Bogendoerfer wrote:
> On Wed, Aug 14, 2019 at 01:52:49PM +0100, Srinivas Kandagatla wrote:
>> On 14/08/2019 12:46, Thomas Bogendoerfer wrote:
>>> On Tue, 13 Aug 2019 10:40:34 +0100
>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>>>> On 09/08/2019 11:32, Thomas Bogendoerfer wrote:
>>>>> nvmem_device_find provides a way to search for nvmem devices with
>>>>> the help of a match function simlair to bus_find_device.
>>>>>
>>>>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>>>>> ---
>>>>>    drivers/nvmem/core.c           | 62 ++++++++++++++++++++++--------------------
>>>>>    include/linux/nvmem-consumer.h |  9 ++++++
>>>>>    2 files changed, 41 insertions(+), 30 deletions(-)
>>>>
>>>> Have you considered using nvmem_register_notifier() ?
>>>
>>> yes, that was the first idea. But then I realized I need to build up
>>> a private database of information already present in nvmem bus. So I
>>> looked for a way to retrieve it from there. Unfortunately I couldn't
>>> use bus_find_device directly, because nvmem_bus_type and struct nvmem_device
>>> is hidden. So I refactured the lookup code and added a more universal
>>> lookup function, which fits my needs and should be usable for more.
>> I see your point.
>>
>> overall the patch as it is look good, but recently we added more generic
>> lookups for DT node, looks like part of your patch is un-doing generic
>> device name lookup.
>>
>> DT node match lookup is in https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=generic_lookup_helpers
> 
> these patches are not in Linus tree, yet. I guess they will show up
> in 5.4. No idea how to deal with it right now, do you ?
All these patches are due to go in next merge window,
You should base your patch on top of linux-next.

thanks,
srini
> 
>> Other missing bit is adding this api to documentation in
>> ./Documentation/driver-api/nvmem.rst
> 
> ok, will do.
> 
> Thomas.
> 
