Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C0C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5802133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxuSPE8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJEKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:47:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726902AbfJEKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570272441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R5dUvdMbgEbwTpXmX9WkZfKQMZ6PT0/YJasFlmoEyq4=;
        b=GxuSPE8y3RkOBKsQ0yQIO5KEDmbwwzBMRYOeOp4dpHkd8/tSjitoS4y1zuzCng+7qKwnTM
        KxPQt/+bxbe99aeNBHJSvrRDs1k+2FE4CVjZWkZhLMLe+CAWsVdiR1gfFDg4ixZ9M08diT
        oQQ0kqorgTbj4B3jWbleLCuloOZJvZM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-K9onPquIN_64jjlteFICCA-1; Sat, 05 Oct 2019 06:47:19 -0400
Received: by mail-ed1-f71.google.com with SMTP id y25so5727667edv.20
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=izYbdW+25ZVANmo1nd5eWKZEpBl56I5sQaWpmq85eVA=;
        b=DqAvhGH6FD1QmW96sFaZeKyCVRax64Hm2Iz0Ke8TurjG92FXIVsU+Z82wKALYF4Yia
         n8aeziH1GZbmnTFElkIUHyekxcIMCGnVmnl/axtvj33BmXyJjtlPxYEu2suFKN1G2TYz
         bhFX0+44Vdwzyatji3zTs3xX6DeA8eX9KF/dduCuodOnWC+Gv/+aHCFY9C1yXgsIQadI
         U6rwuAfe8J6LP2vKATgGobaJ28ivQ/9c+A4VSz0P+h6g265mUeOjbiVQHVv1abaFS9DH
         5miYs4P7oVVX2UMhQ9vVlhpBTzL1dPZnxioTsuK5dX1sbdYktKGQeZPvyzlr9M2laCXH
         nSCQ==
X-Gm-Message-State: APjAAAUdC5V3oT/ZSh7bV2OHEZhzf3XrXuIN1HEkRS8AiQ2vb+N0hhXe
        kg59X16DV2jqnzJlseiEORFNxJTM/gI/AAnOGxe8kz4V2BxFgWgVirD5lDfLMEDv1Wkl9wY97co
        Wc7sqCGRQPkbRiUm9kEi3OQq+
X-Received: by 2002:a17:906:5109:: with SMTP id w9mr15999514ejk.282.1570272438517;
        Sat, 05 Oct 2019 03:47:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFTNNUuSBfDgRLD/2o8TxUB9BUTjTh1lfnqR9Yzl4mJOA+Xpg1t/F9eclT8PAehQlZ+tzgxg==
X-Received: by 2002:a17:906:5109:: with SMTP id w9mr15999503ejk.282.1570272438309;
        Sat, 05 Oct 2019 03:47:18 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id i5sm1778299edv.29.2019.10.05.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 03:47:17 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Is IRQ number 0 a valid IRQ ?
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <4ef7a462-5ded-0ac7-242e-888a9d36362b@redhat.com>
Date:   Sat, 5 Oct 2019 12:47:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: K9onPquIN_64jjlteFICCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is something which I have been wondering for ever since there are
several places in the kernel where IRQ number 0 is treated as not being
valid (as no IRQ found mostly I guess). Where as other places do treat
IRQ number 0 as valid... ?

Some examples which treat IRQ 0 special:

drivers/base/platform.c: __platform_get_irq() :

         if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
                 int ret;

                 ret =3D of_irq_get(dev->dev.of_node, num);
                 if (ret > 0 || ret =3D=3D -EPROBE_DEFER)
                         return ret;
         }

Note if (ret > 0) not if (ret >=3D 0)

Other example: drivers/usb/dwc3/gadget.c: dwc3_gadget_get_irq() :

         if (!irq)
                 irq =3D -EINVAL;

So 2 questions:

1) Is this special handling of IRQ number 0 valid code, or just
mostly some leftover from older days when IRQ number 0 was maybe
special ?

2) Either way (*) I think we (I volunteer) should document this somewhere,
other then adding a note about this to the platform_get_irq docs any
other place where it would be good to specify this?

Regards,

Hans


*) Either IRQ number 0 is not special and then we need to stop the
cargo-culting of treating it special, or it is special and then we
need to document that.

