Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D658C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8B220867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr8Uhvk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJGNlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:41:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726334AbfJGNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570455664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fX/zCON3jac9NXSSdIrhRtFdIBVCQNgDQg3GIFKl4R4=;
        b=Mr8Uhvk9SitbQuTxfYiLYzCnpoljM4B2TA9ISGmNOsuM+Y2+mnGzb5ugzMBr5aNzeELH29
        gUh6neskhT6AsnmFmtauJ9+TtBh77zKQo/ekcvMBRmAJQZDfdFEtVU5dqZOUC3lSwvnDB7
        +80/vaj5CRh3DyGzzWB0jesDAxDOFRU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-B9wjmCXEMSKcyESt7q1-ew-1; Mon, 07 Oct 2019 09:40:59 -0400
Received: by mail-ed1-f70.google.com with SMTP id 34so9047589edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6BIubpxJ0QU0S7koZZBlDHe4I0HSpCMQNSMgJFFjz8o=;
        b=OcQqAvHV0BpnbfJ9yFUqAfKE0wmWusxF6xHxTDmUE+CwBDli+bpyE4MBxedBBbXNOT
         eJvkj+/fUGVr8JwUEth/+/3ps0myKdd0aRhKu1+GL00fhSlX5ySS881u5GTzcppFMdk1
         yTDGGNg5TsmsRZWmaVe8y52anRv9fjRNZZM+5YJqeEUJ0M4veI1FAlnpXXo9NVcAADMK
         t8kIMUgeir/21wqv7wPctxdfm13JWLPjFR4GcE5gWZdTpefPNv9ZduTTw0O8RzN44oIK
         ZXenvV8gkJmA6ar6LtMZKxWfzRBWLVhLWdPiSSqBcyyBHNUKWa8o5lBZN3zMwCztS3hJ
         Ik3Q==
X-Gm-Message-State: APjAAAWa1MUl2eTBLsPNf04q4hU7CsRoEBZPHNb8SDfKOWkksh3HtoS2
        tKIVfSh4/bGJjAFaNmqZkrc+vaOfo5av/JSJC6F6ObmbktfZ295LnugxCAsP1XyoiaukSebNwha
        hD/39s4CZI05fECTQUr74e6OX
X-Received: by 2002:a17:906:4541:: with SMTP id s1mr24149660ejq.210.1570455658055;
        Mon, 07 Oct 2019 06:40:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJmIm8Quny+OBkSIqinUtMfGVIzeVLQzArWaylv6qin04EtCicTZ90yN69Dh/c4aMBaUUMUQ==
X-Received: by 2002:a17:906:4541:: with SMTP id s1mr24149645ejq.210.1570455657850;
        Mon, 07 Oct 2019 06:40:57 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id o22sm3232501edv.26.2019.10.07.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 06:40:57 -0700 (PDT)
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
Message-ID: <cf44ec0d-33d5-1577-40ad-0d4acbac7e8b@redhat.com>
Date:   Mon, 7 Oct 2019 15:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007130942.GA82950@gmail.com>
Content-Language: en-US
X-MC-Unique: B9wjmCXEMSKcyESt7q1-ew-1
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
> I've applied your fix,

Thank you, unfortunately I was just minutes away from sending a v2
which adds a missing barrier call (not strictly necessary, more future
proofing).

Hopefully you can still pick up v2 instead, let me know if you want
an incremental patch instead.

Regards,

Hans

