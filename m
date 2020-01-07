Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BF6C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587502072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cwJlYynO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgAGMdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:33:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44709 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:33:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so14789158wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GXTBxUXFf/0lblKnPV2tJJx5huyZR82ySCgLFN7gCSA=;
        b=cwJlYynOcPBu0xjHXZZtpNCmwXosTzSWCtLwB3W1r1F0BYW1V+9cNdIXBOJ7v5ssmn
         KxurqCUl8ttNr8KL4synUaSdUyAOcSW+XSv4HHYpnC+E6ctaLjgOPMHNm1kqUEGBTzEF
         MkwoqzXCAQt2sJ1fAtXtdaHp1UaJ6OXabwQqaIjuQiS5gRHZJiW6HVMJFPHZdneDiwbj
         LZ8RZRw1vpqaLW8KXieB2i+2arTsB0wBlFWVsIryoPlSJfdh58C8W+d5YHTc8iLfC3vf
         bZVSd3eU9AzvXiPSUmUUzzwjELxsvKf37egkTVkqPmnkSJo5ucKHDyjDRzqvmB4KHxp6
         pSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GXTBxUXFf/0lblKnPV2tJJx5huyZR82ySCgLFN7gCSA=;
        b=h0Vghcbe/RWy2Vy48BqmECPJbG2mzeskI2NIR+wtu7JN2ALMm21DljGxKMOsjXdQwH
         aVjzXglPcyYpJras+vm2JF6TC5bkSI1hQJEQDBOF3rFjXXv34rECNxeUD9CFE/z3M3tQ
         MtvunBmP+XD5OH5UsJHJSMOENSUDy8bev1BjwRKrCcU4YYynZLXBmSKc6RbKj+JIr1Ly
         lpngH5PBxdofdg/qXjtonfQ3efM6qeQto4LTqcgNJfGWDo5YHuRhYe04moJDB4qgI7lG
         XX6mIHuidhqjvlUfQX2Jnr0P3HBMDZ2VKJSX4XypY5pdU8xpROZLtFpgsWbbW7rGqTth
         +Hog==
X-Gm-Message-State: APjAAAWiq+c+rAaefbjnRIdab4tL42WBP0ZGGtO5hNuGQiCDAo+w6514
        rNRlZ88AJPBll3xaWoTF4/upPVxhDDM=
X-Google-Smtp-Source: APXvYqy74uz9nvj2BIPxpdM20AIWwAe3Di+G7rYdWb/b+n9twWOnu7KnRC6p6sEYexCJAXfIfdL7xA==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr110724265wrm.394.1578400430159;
        Tue, 07 Jan 2020 04:33:50 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca? ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f127sm26361528wma.4.2020.01.07.04.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 04:33:49 -0800 (PST)
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
References: <20191213105521.4290-1-glaroque@baylibre.com>
 <20191213111702.GX10631@localhost>
 <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
 <20191213134404.GY10631@localhost>
 <08ae6108-0829-3bb4-f398-7e6a58719d29@baylibre.com>
 <8EBBCE1B-688D-4097-A2AF-6E099A0AD68B@holtmann.org>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <11747601-6d29-d2c8-7639-896d654280a4@baylibre.com>
Date:   Tue, 7 Jan 2020 13:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8EBBCE1B-688D-4097-A2AF-6E099A0AD68B@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 1/4/20 10:58 AM, Marcel Holtmann wrote:
> Hi Guillaume,
>
>>>>>> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>>>>> #endif
>>>>>> 	bcmdev->serdev_hu.serdev = serdev;
>>>>>> 	serdev_device_set_drvdata(serdev, bcmdev);
>>>>>> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
>>>>> Shouldn't you be used using of_irq_get_byname()?
>>>> i can use it if you prefer but no other interrupt need to be defined
>>> Maybe not needed then. Was just thinking it may make it more clear that
>>> you now have two ways to specify the "host-wakeup" interrupt (and in
>>> your proposed implementation the interrupts-property happens to take
>>> priority). Perhaps that can be sorted out when you submit the binding
>>> update for review.
>> no problem i add a "host-wakeup" interrupt-name.
>> you are right it will be more clear with name and we know why this interrupt is needed.
> have I missed the v5 or are still sending it?

sorry i was in chrismas holidays .

v5 was sent before holiday and you comment it [1] ;) , on v5 you ask me to send v6 with tag.


Regards

Guillaume

>
> Regards
>
> Marcel
>
[1] : https://www.spinics.net/lists/linux-bluetooth/msg82424.html
