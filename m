Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF89ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750B021835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz6/a6BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404135AbfJPImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:42:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40140 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729153AbfJPIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571215317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Odl3XM0IOwYiqnn7McJ4rA5F3y4GYEy0PoMhKp7EuqA=;
        b=Qz6/a6BTH1glApgz5pAka0uDzY9LMPJ5Z1kAsuO0ewGYM1WXWdFV4mp3W9cYqzyn7KmQTa
        h4aTAsd6uEjmH3Gask58MiXEje1VLldSE2ZrkhKVvOWLM/5Niq5lGbPSpsCNoPrnscrZLN
        U1S1Vy+M/UldRJ3x/fiPYP8570TmVG8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322--YOMb6qbNQyp48A4uKe5SQ-1; Wed, 16 Oct 2019 04:41:55 -0400
Received: by mail-wr1-f70.google.com with SMTP id t11so11364566wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKea4fgnuRbz+5DOp7dpx2hJLrHN7p/gd9EwER5p4Gw=;
        b=TT8M9rxyXnTkTUfj+wGAG2vbWBcWGbJovWlMRopOb/Md4y9Gi0hPBXfSDotR0/31Ah
         veh+Np7dlVJFA940IPIOV+nolRo/dNWHflRu8U17VeVLcml+3D6D+/mfEbsdF05h2L7H
         qp3XjqgA63qQjCh6fJM7CuN/fiZy/tSok8kt799CrwYFkbS7TCSU0rNTEceG5QsmoU6E
         YUya67e+pfR/Oj7q/y8f0HQKKdAxI9sG9bR8Yrzdg5gD881jcHLhahuKy+pBr3vldBhP
         fHreXOWsNcQ8bH9sdNuv32IeTxIwXoY/0oMmY4egI7f0DT1NtSGWPF+sStoPr35/CXwK
         83qg==
X-Gm-Message-State: APjAAAWH0NDWMv/qHYIY9G7R3XAL00bo/cBn0fcJVVcW/UsssW463S8X
        BqRnjuFktKMq1Y55znwsGpm3JqJaZ2/TLRamH4KIxcIrlye9EKA7BEaAk6fJCnIGX5z6ko+Du4s
        qGzZvqLB6BOKKaLze1SmPX2J9
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr2289594wmj.85.1571215314256;
        Wed, 16 Oct 2019 01:41:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrQlNyMu4DwNofDUKwhYGMXDXxGX8pkasLXliSgnyS0AbYWsqUQ3yeEDgYtWry+jaTBU/T9A==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr2289580wmj.85.1571215314069;
        Wed, 16 Oct 2019 01:41:54 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id q22sm1633528wmj.5.2019.10.16.01.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 01:41:53 -0700 (PDT)
Subject: Re: Is IRQ number 0 a valid IRQ ?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4ef7a462-5ded-0ac7-242e-888a9d36362b@redhat.com>
 <alpine.DEB.2.21.1910141414210.2531@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c89f2f3d-5bb1-3e84-e989-bb61a36b3548@redhat.com>
Date:   Wed, 16 Oct 2019 10:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141414210.2531@nanos.tec.linutronix.de>
Content-Language: en-US
X-MC-Unique: -YOMb6qbNQyp48A4uKe5SQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/19 2:25 PM, Thomas Gleixner wrote:
> Hans,
>=20
> On Sat, 5 Oct 2019, Hans de Goede wrote:
>=20
>> This is something which I have been wondering for ever since there are
>> several places in the kernel where IRQ number 0 is treated as not being
>> valid (as no IRQ found mostly I guess). Where as other places do treat
>> IRQ number 0 as valid... ?
>=20
> IRQ0 is a historical x86 nuisance. On x86 irq0 is still valid - it's the
> legacy timer irq. I'd be happy to fix that up, but there are quite some
> assumptions vs. the irq numbering of the x86 legacy interrupt numbers in
> general. BIOS/ACPI has them hard coded as well, so it's not entirely
> trivial to fix that up.
>=20
> For everything else than x86 (and maybe ia64( irq 0 should not exist and =
DT
> based irq enumeration treated it as invalid interrupt number forever.
>=20
> Though there were some old ARM subarchs which used to have hardcoded lega=
cy
> interrupt numbers including 0 as well.
>  =20
>> Some examples which treat IRQ 0 special:
>>
>> drivers/base/platform.c: __platform_get_irq() :
>>
>>          if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
>>                  int ret;
>>
>>                  ret =3D of_irq_get(dev->dev.of_node, num);
>>                  if (ret > 0 || ret =3D=3D -EPROBE_DEFER)
>>                          return ret;
>>          }
>>
>> Note if (ret > 0) not if (ret >=3D 0)
>=20
> Yeah. It makes the code fall through when ret =3D=3D 0 so it can try the =
other
> methods. What a mess...
>=20
>> Other example: drivers/usb/dwc3/gadget.c: dwc3_gadget_get_irq() :
>>
>>          if (!irq)
>>                  irq =3D -EINVAL;
>=20
> That one translates irq0 into an error code.
>  =20
>> So 2 questions:
>>
>> 1) Is this special handling of IRQ number 0 valid code, or just
>> mostly some leftover from older days when IRQ number 0 was maybe
>> special ?
>=20
> Kinda both.
>=20
>> 2) Either way (*) I think we (I volunteer) should document this somewher=
e,
>> other then adding a note about this to the platform_get_irq docs any
>> other place where it would be good to specify this?
>>
>> *) Either IRQ number 0 is not special and then we need to stop the
>> cargo-culting of treating it special, or it is special and then we
>> need to document that.
>=20
> One way to solve it would be to change the '0' return value from the core
> functions (irqdomain) to -EINVAL or such, but that needs some thorough
> analysis whether there is valid irq 0 usage outside of x86/ia64.

I see, so the TL;DR: is its complicated. So I guess it is best to leave
this as is, thank you for your explanation.

Regards,

Hans

