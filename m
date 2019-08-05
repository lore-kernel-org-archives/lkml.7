Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B13C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E0C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHEIzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:55:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40444 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:55:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so77890664eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84QEP6FR40jS8MsBxZuPCzBl4Z7+iuUpFONR975wak0=;
        b=s5jPBA9g3Nqvf+LxYW1Updrv6lyQrsKIM3+YYPUPlonN+pptH0c7FxfQ0NfUNFuqJ1
         HjtGZu5Rd69G+gFEVg2CFejJr/OBmXmHHY9S/ZjuNJkeyEHpXg/052299cALqUVlz0EB
         t4Zik9okuVjkTPsvtCbcXx7o/egn0BGsvPiiOgla4w/fXUKaGVfufVokcaJmy/qBPDO4
         AOVjewO9taZhwAmgTod5r6h0uSlaEzqfFDICXG0fN1KKzuR2ReOMr/ZxkV64FuSeMSBm
         jFoPjnvvc5McWSY1rj5FOvqlbF/Yb3YWi1UG8mtSvAmyRfOONZmHgMCFHCi2pUWf+3tu
         DeOg==
X-Gm-Message-State: APjAAAXnjxwOsfv3/U+epvW3rJ+v74+SdzjWACsoxSGT7sk0Y6Sfd+Gj
        xHNkqXF4Ffe99Yb3Afa/P7HhAw==
X-Google-Smtp-Source: APXvYqxBlSLzlAvy5N0qg2kyn7ZnVVogxS8dW1P324AzPoIeg9M28l87KxSLZpKgMwRiFN7yACOz4Q==
X-Received: by 2002:a50:acc6:: with SMTP id x64mr135478105edc.100.1564995306572;
        Mon, 05 Aug 2019 01:55:06 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e43sm19988862ede.62.2019.08.05.01.55.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 01:55:05 -0700 (PDT)
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, YueHaibing <yuehaibing@huawei.com>,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510> <20190731110629.GB5092@dell5510>
 <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
 <nycvar.YFH.7.76.1908051051080.5899@cbobk.fhfr.pm>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7988688e-8020-3d03-63cd-d844c01e5bf6@redhat.com>
Date:   Mon, 5 Aug 2019 10:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1908051051080.5899@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 05-08-19 10:51, Jiri Kosina wrote:
> On Wed, 31 Jul 2019, Hans de Goede wrote:
> 
>>>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
>>>>> may return positive value while success now, so check it
>>>>> correctly.
>>>
>>>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of
>>>>> Fixes: logi_dj_recv_query_hidpp_devices")
>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> OK, not only it didn't fix problems with logitech mouse (see below),
>>> but removing mouses USB dongle effectively crashes kernel, so this one
>>> probably
>>> shouldn't be applied :).
>>>
>>> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with
>>> error 7
>>> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback:
>>> logi_dj_recv_query_paired_devices error: 7
>>
>> Please test my patch titled: "HID: logitech-dj: Really fix return value of
>> logi_dj_recv_query_hidpp_devices"
>> which should fix this.
> 
> Hans, have I been CCed on that patch? I don't seem to see it in in inbox.

I have "Jiri Kosina <jikos@kernel.org>" in the To: for the patch in the
copy in my Inbox (I always Cc myself).

Anyways, you can grab it here:

https://patchwork.kernel.org/patch/11064087/

It has gathered 2 Tested-by-s and 2 Reviewed-by-s since posting, so
assuming you like it too, this is ready for merging.

Regards,

Hans
