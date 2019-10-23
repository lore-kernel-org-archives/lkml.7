Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF6CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvVsdjIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407181AbfJWQSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:18:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404695AbfJWQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571847533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42dR9KjvWxTtpNo0xdhv7ZprPq7NaqJV9H6bwrJzSyY=;
        b=DvVsdjIq4XD3f1We8eOx8IujJDn+gCVhGiLCSmyK0BpWdgW1A07+qchHgy6IBdeMVviLsn
        40xQXiCWV+AyDPTeBJMXgezujyS0mUJqPmGcUP7K9ZFVKCA6OVc5TLaQS8t4+0kIJ/bSag
        ffLxeBVLdEya9fAMptp+wiC9djHvcVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-BdisPddhPKK0HzH_B01oUg-1; Wed, 23 Oct 2019 12:18:50 -0400
Received: by mail-wr1-f69.google.com with SMTP id r8so4004238wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOBGfSTF1KhMQpx4CgtoYn86qXiufMDfXR3BQXzAiZU=;
        b=jBkakNeCSZWU3lgUqUgPJlykFhH/fKsl4thDKUDiTFfET8z8LhrQxPzY5pc9nzYaox
         tsqThQFpqS+G2Lng7NHoJ/Unew3SclDSXCya0kQHNq7gNPqCVoWPbJbkz9WgXz9EqLBW
         mRDpSSIRrgIogP2j922Eu1ifVWDw8w3sahgnsSRDwaniL7tQP2D5W3PLD0PueYN+CArb
         Wd0FsJRiBkP4hSzgc2NPjck9kSmqCi0/qfHjrVvmvp4i+YdFjK9kbzklvejOg0J3d+wy
         jzbos+cKxrljeSPPwoTEADHl9/jSrWV5V2HBMYKGwJCih4eIqTUSwWVMmq/0wJNNaYP6
         +wLA==
X-Gm-Message-State: APjAAAVerT1h9s2CIHEs9/hINitX0XCY1mDBEjwzJCSeeCX//CpcSsJV
        nrz1wliDBBu7eJ91gZqWozseY5qLgvi0j8QvZfI3NdmHottDO2tj4KlOGzF7VcSz7tOfOUkTitC
        vZmRfiyXgywDVFc9M2PnY/oRg
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr752676wmk.28.1571847529565;
        Wed, 23 Oct 2019 09:18:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYz1HPlsDwZXRMQfmrsug6VYnNhIgU6zeDVTcRhDmNybUK9nIvatCeNxKFr3IjmW++iM0D8A==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr752660wmk.28.1571847529404;
        Wed, 23 Oct 2019 09:18:49 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id x12sm12712262wru.93.2019.10.23.09.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:18:48 -0700 (PDT)
Subject: Re: [PATCH] Add touchscreen platform data for the Schneider SCT101CTM
 tablet
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Gorbea Ainz <danielgorbea@hotmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR10MB2574F4636A90613136ACF4BED86B0@VI1PR10MB2574.EURPRD10.PROD.OUTLOOK.COM>
 <05eec4e5-927c-fdd6-037b-71520e149d5b@redhat.com>
 <CAHp75VeoUCxLt9YFPBpS3d8zOpXb7B4UbpPaiNLWAv0tm4zPHA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d18ca285-9a45-286f-3f61-c02059b2f9a6@redhat.com>
Date:   Wed, 23 Oct 2019 18:18:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeoUCxLt9YFPBpS3d8zOpXb7B4UbpPaiNLWAv0tm4zPHA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: BdisPddhPKK0HzH_B01oUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-10-2019 18:15, Andy Shevchenko wrote:
> On Wed, Oct 23, 2019 at 7:08 PM Hans de Goede <hdegoede@redhat.com> wrote=
:
>> On 23-10-2019 17:23, Daniel Gorbea Ainz wrote:
>>> Add touchscreen platform data for the Schneider SCT101CTM tablet
>>>
>>> Signed-off-by: Daniel Gorbea <danielgorbea@hotmail.com>
>>
>> Patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Daniel, I received your patch just fine, shall I resend
>> it to the list for you ?
>=20
> What list? Everything seems okay to me.
> I don't see it in patchwork, though.

Right, Daniel replied that vger@kernel.org did not like his email/patch
so it makes sense that patchwork has not picked it up.

Regards,

Hans

