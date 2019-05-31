Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC22BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546E26F93
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoAJZNVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfEaWIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:08:44 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35373 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfEaWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:08:44 -0400
Received: by mail-it1-f194.google.com with SMTP id u186so17754856ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rk8vi2GT1Kz6DVRVbKN7nB2fCQvo4oUTFPvog4etFog=;
        b=RoAJZNVM9UNtsbDZIxdhytc/h/nYGp4cX/w7asLBFt+LL3YGdpSFVdLJ/u8wre27ep
         Zc72jhZEh9jdHPOl1iKQZqxVWeScamm/sKR1VLGzQx1nnXuZI+0MZf4kU+I8mYs+b6aU
         0reiCICEaCdyO23EgeaBnKv2ESrzeKJv8FFJmVeneKkyZKYZjb41UYFYC3JxzhU0ZMM7
         mLAEUPHlWqUQcTH3HrhRi39Dwvdc2zpwscy8iKNdbA6tJrTqOdtBEbVvoizFMbfRjwcl
         RcsfdbcOMjq7AKJqPUOpZehjtHVamaPcM26USwWACHuapHEqvJjFXNLfN3dULvKiJkcX
         SNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rk8vi2GT1Kz6DVRVbKN7nB2fCQvo4oUTFPvog4etFog=;
        b=ZFNhrPKL530yTiz7CSA8hBymzm5qoTMKWtjLYIlN04PKdKjbbKQ2fZtc1ZkzPR2W6Q
         Llvpp+IYOaMKxlN2UXd7nbvN2EmVpgMXd9UcjjD/DHmYSunk293IW2HozeDgJ9QDUdBg
         KSb6N1018nUiGu1MJGR+bCRp7RJGUeC7BbdH3ruZHhEiQTm5F7ovd11WfwwL/da6rjd4
         0NqzQzXIWMa+3WzGWEGcWmgI/1tQMLQxdh5vzsmWfQTn4h0+DZuS9da3IeVviKWQteWc
         3S8qPMgWtjXUqrbQ8dDH56oqFME6SLi41latPoVuUFN8oVLaTWy83zx0rjQOeuibuq6j
         yqMQ==
X-Gm-Message-State: APjAAAWSI7CHVKsMmwN+pUT4Gwc8VNKF05G8R+swpRcgnfcgs3cbb6i7
        cSnkLdSH67dLkkXR5t7zLu8CRQ==
X-Google-Smtp-Source: APXvYqzH+EMg6SX+BlsymH4Hq994bzynu2+kAA7hlzRr88AMlhERcDm6qIxgsjuFesiRwjur1MEYsA==
X-Received: by 2002:a02:b817:: with SMTP id o23mr8340150jam.134.1559340522683;
        Fri, 31 May 2019 15:08:42 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id p11sm3398687itc.2.2019.05.31.15.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 15:08:42 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] net: introduce Qualcomm IPA driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dan Williams <dcbw@redhat.com>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, cpratapa@codeaurora.org,
        syadagir@codeaurora.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        abhishek.esse@gmail.com, Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
References: <20190531035348.7194-1-elder@linaro.org>
 <e75cd1c111233fdc05f47017046a6b0f0c97673a.camel@redhat.com>
 <065c95a8-7b17-495d-f225-36c46faccdd7@linaro.org>
 <CAK8P3a05CevRBV3ym+pnKmxv+A0_T+AtURW2L4doPAFzu3QcJw@mail.gmail.com>
 <a28c5e13-59bc-144d-4153-9d104cfa9188@linaro.org>
 <CAK8P3a2rkQd3t-yNdNGePW8E7rhObjAvUpW6Ga9AM6rJJ27BOw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <5ebccdbe-479d-2b7d-693c-0c412060d687@linaro.org>
Date:   Fri, 31 May 2019 17:08:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2rkQd3t-yNdNGePW8E7rhObjAvUpW6Ga9AM6rJJ27BOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 4:12 PM, Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 10:47 PM Alex Elder <elder@linaro.org> wrote:
>> On 5/31/19 2:19 PM, Arnd Bergmann wrote:
>>> On Fri, May 31, 2019 at 6:36 PM Alex Elder <elder@linaro.org> wrote:
>>>> On 5/31/19 9:58 AM, Dan Williams wrote:
>>>>> On Thu, 2019-05-30 at 22:53 -0500, Alex Elder wrote:
>>>
>>> Does this mean that IPA can only be used to back rmnet, and rmnet
>>> can only be used on top of IPA, or can or both of them be combined
>>> with another driver to talk to instead?
>>
>> No it does not mean that.
>>
>> As I understand it, one reason for the rmnet layer was to abstract
>> the back end, which would allow using a modem, or using something
>> else (a LAN?), without exposing certain details of the hardware.
>> (Perhaps to support multiplexing, etc. without duplicating that
>> logic in two "back-end" drivers?)
>>
>> To be perfectly honest, at first I thought having IPA use rmnet
>> was a cargo cult thing like Dan suggested, because I didn't see
>> the benefit.  I now see why one would use that pass-through layer
>> to handle the QMAP features.
>>
>> But back to your question.  The other thing is that I see no
>> reason the IPA couldn't present a "normal" (non QMAP) interface
>> for a modem.  It's something I'd really like to be able to do,
>> but I can't do it without having the modem firmware change its
>> configuration for these endpoints.  My access to the people who
>> implement the modem firmware has been very limited (something
>> I hope to improve), and unless and until I can get corresponding
>> changes on the modem side to implement connections that don't
>> use QMAP, I can't implement such a thing.
> 
> Why would that require firmware changes? What I was thinking
> here is to turn the bits of the rmnet driver that actually do anything
> interesting on the headers into a library module (or a header file
> with inline functions) that can be called directly by the ipa driver,
> keeping the protocol unchanged.

You know, it's possible you're right about not needing
firmware changes.  But it has always been my impression
they would be needed.  Here's why.

It looks like this:

           GSI Channel   GSI Channel
               |             |         
  ----------   v   -------   v   -------------
  | AP (ep)|=======| IPA |=======|(ep) Modem |
  ----------       -------       -------------

The AP and Modem each have IPA endpoints (ep), which use GSI channels,
to communicate with the IPA. Each endpoint has configuration options
(such as checksum offload).  I *thought* that the configurations of
the two endpoints need to be compatible (e.g., they need to agree on
whether they're aggregating).  But with your questioning I now think
you may be right, that only the local endpoint's configuration matters.

I will inquire further on this.  I *know* that the AP and modem
exchange some information about IPA configuration, but looking more
closely that looks like it's all about the configuration of shared
IPA resources, not endpoints.

That said, the broader design (including the user space code)
surely assumes rmnet, and I don't have any sense of what impact
changing that would make.  I am sure that changing it would not
be well received.

					-Alex

>>> Always passing data from one netdev to another both ways
>>> sounds like it introduces both direct CPU overhead, and
>>> problems with flow control when data gets buffered inbetween.
>>
>> My impression is the rmnet driver is a pretty thin layer,
>> so the CPU overhead is probably not that great (though
>> deaggregating a message is expensive).  I agree with you
>> on the flow control.
> 
> The CPU overhead I mean is not from executing code in the
> rmnet driver, but from passing packets through the network
> stack between the two drivers, i.e. adding each frame to
> a queue and taking it back out. I'm not sure how this ends
> up working in reality but from a first look it seems like
> we might bounce in an out of the softirq handler inbetween.
> 
>           Arnd
> 

