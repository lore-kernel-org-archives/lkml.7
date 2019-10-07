Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6692ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB721655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSxgdALO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfJGOHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:07:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727324AbfJGOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570457237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71z1kc3OeYBqKhbglYKNUURvf9tFEv/IgVrZxfBdLmE=;
        b=FSxgdALOESg8b7JS8FuLtT7umDSP0mqlZqTZjE3xkQvM0+Xy5ida0JSMvMWBTh8xDiVKjk
        TKTbDcVh5BzJy4B4votZti2lrV2O7PNSMpeWbAVaAia+PTm58WFsW0nPdwr2+BwNzZ7Y5Z
        RVfHlQ42L40aXNG3WJcjubopBxLzlR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-W5OznxaxPmWGx2X_aizscA-1; Mon, 07 Oct 2019 10:07:14 -0400
Received: by mail-wr1-f71.google.com with SMTP id m14so7581262wru.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MKvbGD7Yw7mqmY6GTBU9jIz1eQXbtpW9orS+BGZ0hSQ=;
        b=CaqnrChMrpzFBCvaYkPrtXR+O6foRvFXzh029AmQrkpZxrxKnOBSiOXgSN7By2Io05
         rNid0Mkc0iVdT67dUKsRJaZwFpoB+aFcvlxPQSUAkcMAi8sWYe1m43FxZFTilhAV9bl8
         DlDAc9TsHxJunXAxbOnmMIxEAyD4RpTow/Sf6FLNEuwsj4tpuW4/K6pyeVVxHzS21KRI
         dQQYuNTtnfE7mhJItLxOE26pYf2oIrBXJR0PKTePgq6+vn6/sleJZm79d/IMPS+Kn7Q/
         QUJvJ+mFTKtUWTvEvY6LGWTeay3isQWKTCBjRr+Ocp+k0d3Xlz6xItWpWJkfrFoci0wN
         L3Ww==
X-Gm-Message-State: APjAAAWrIBBJfJoV1GRsDMS/652GFFlYJ3eyqZyfpSAiabD3WifG2bH6
        GppuzebjGj2J3nWIQFX6DAMY01s3ERiIa5BOLPt/YBK+LmuGW/Jpa2tV+UW0TEmf5E95jTE3m/X
        RPe/XeVOO78tqeBEP3a9zbv+7
X-Received: by 2002:a5d:6704:: with SMTP id o4mr23003842wru.365.1570457233203;
        Mon, 07 Oct 2019 07:07:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz42O7kbQBeyOblxLhSd5U+RqCBDYV4gX9kjW/pct7VAke69+ewx7a/kPKX8Ojo4Kj7ZddrBg==
X-Received: by 2002:a5d:6704:: with SMTP id o4mr23003824wru.365.1570457233036;
        Mon, 07 Oct 2019 07:07:13 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id u25sm13500238wml.4.2019.10.07.07.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:07:12 -0700 (PDT)
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
 <20191007130942.GA82950@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a485ad7f-ad7b-00e1-910b-e4ab3fe07cd2@redhat.com>
Date:   Mon, 7 Oct 2019 16:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007130942.GA82950@gmail.com>
Content-Language: en-US
X-MC-Unique: W5OznxaxPmWGx2X_aizscA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-10-2019 15:09, Ingo Molnar wrote:
>=20
> * Hans de Goede <hdegoede@redhat.com> wrote:
>=20
>> Hi,
>>
>> On 07-10-2019 10:50, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 07-10-2019 05:09, Arvind Sankar wrote:
>>>> Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
>>>> memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
>>>> sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
>>>> according to git bisect.
>>>
>>> Hmm, it (obviously) does build for me and using kexec still also works
>>> for me.
>>>
>>> But it seems that you are right and that this should not build, weird.
>>
>> Ok, I understand now, it seems that the kernel will happily build with
>> undefined symbols in the purgatory and my kexec testing did not hit
>> the sha256 check path (*) so it did not crash. I can reproduce this befo=
re my patch:
>>
>> [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
>> ld: warning: cannot find entry symbol _start; defaulting to 000000000040=
1000
>> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
>> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
>=20
> I've applied your fix,=20

I already answered this bit.

> but would it make sense to also integrate this
> linker test in the regular build with a second patch, to make sure
> something similar doesn't occur again?

But I forgot to answer this part, yes I will look into making the build
fail as soon as we have the fix for this in place for 5.4 .

Regards,

Hans

