Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5CAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB132084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcMi6gcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfEOMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:46:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50809 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEOMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:46:10 -0400
Received: by mail-it1-f195.google.com with SMTP id i10so4595884ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZM2dVmtpB91ztK5q6w+vsDsuNLBXq6DC4P72JFFSO4U=;
        b=fcMi6gcShhNjgXodtqpD244sqMhT3zyNSii7fD2oy4R54ZYhB6X4l3jlWMJIRyvvnY
         Twmu4FSXXaJp4hNRy5klMSYXLe6f0oOfZ9z2BiWZCjB/wSMClaOiv+hzPpaZfasIn2Q+
         GjTM34okiHNQsT9WORSXqQUfdnFiNNfAXPLIsPfYnfsyUtDKpXmbjnJOlx7tvDqGU1qw
         SQNH76JPwYlWn9pcOA+OXhBgRthvtR1aheGSTL7BjcK9ZABaXw6OUNRltpBM0rky7sHZ
         RkKkHRMi8Q3G5Quys9DRRMrG66pTN1ogI77RKIZmdqR04HSSie/v4rU/ZQAjufXEcSOl
         YKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZM2dVmtpB91ztK5q6w+vsDsuNLBXq6DC4P72JFFSO4U=;
        b=L/SPvrZMwdfen4K1bh2zW46HzE60+Gqp0UqLWyG8xTjxWJbwsLQzF0AH0d3d/zjY98
         jbIvuyLbIlxTrODCqLFSRdDSD0+AbrqI92ISRE7t3I4YUUfiEzuWMwwsqs8pRRFAoN3l
         RS20NyY1i40rlNoKrjg/w0i1RmRwqeymz/PV6uvgYE6xDuoMXsMsQt2Y2p37dzBKEMSB
         lgvzMi8Y1TVXmDNY+rpHUAJw/6kGJgAUZO6BRa5Iu9AoNYzvjE2RoVWusKPbSf8N83pK
         ZaPxSP8oMKC3/k1O0mmvp7MLsuVqucYNqGgULG6vYx4i5gbT1ZJ/+QgYiCXiQIYWoufG
         fAig==
X-Gm-Message-State: APjAAAUaxwapbSykXe26WWpVNNf3OdCls4+RVnRehDqMVy1TToOODiJB
        JREAhDXzWgbryuMMcLSyx421IDf5nOc=
X-Google-Smtp-Source: APXvYqyUzYu964DbKtbK8zpmoa4E8Nir5mjDm5+bqvtm+pssi2adtiS9AeMPogBVO+BwUIwEZkqzHQ==
X-Received: by 2002:a24:1d8f:: with SMTP id 137mr7626938itj.66.1557924369314;
        Wed, 15 May 2019 05:46:09 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id s8sm583508iot.55.2019.05.15.05.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:46:08 -0700 (PDT)
Subject: Re: [PATCH 13/18] soc: qcom: ipa: IPA network device and
 microcontroller
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-14-elder@linaro.org>
 <CAK8P3a0WW6B3fASNB9th_ncPine7X0OfhJD139yUC31UQiGQdQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <1271594e-cd60-8415-bd50-c297b15e7bf6@linaro.org>
Date:   Wed, 15 May 2019 07:46:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0WW6B3fASNB9th_ncPine7X0OfhJD139yUC31UQiGQdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 3:21 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>>
>> This patch includes the code that implements a Linux network device,
>> using one TX and one RX IPA endpoint.  It is used to implement the
>> network device representing the modem and its connection to wireless
>> networks.  There are only a few things that are really modem-specific
>> though, and they aren't clearly called out here.  Such distinctions
>> will be made clearer if we wish to support a network device for
>> anything other than the modem.
> 
> This does not seem to do much at all, as far as I can see it's a fairly
> small abstraction between the linux netdev layer and the actual
> implementation. Could you just merge this file into whichever file
> it interacts with most closely, and open-code the wrappers there?

This used to be a bigger file, containing IOCTLs for configuring
the endpoints used.

It is logically separate from endpoints, because not all endpoints
are attached to network devices.  The IPA command TX endpoint isn't
associated with a network device, and the default route RX endpoint
isn't either.

In addition, the modem can crash and be restarted independent of
all other endpoints.  I haven't added proper handling for that yet,
though (just the ipa_ssr_*() stubs), and I thought maybe in
finishing that I might find  keeping it separated in this way
would better fit how that would work out.  The presence of the
"rmnet_ipa0" network device essentially represents the presence
of a functioning modem.

That being said, in the process of trying to streamline the data
path, I *did* add a netdev pointer to the ipa_endpoint structure,
so I've already blurred the line between these layers.

So I will try to do as you suggest, and this code will most likely
end up in "ipa_endpoint.c".

					-Alex


>       Arnd
> 

