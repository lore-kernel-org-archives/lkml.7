Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929C22070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg9PCB+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfJGQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:57:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbfJGQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570467420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ds6pyGFUgAlo48+0gNzJE98Ix35K9s00JTvg/dMmXpk=;
        b=Lg9PCB+UuKMRGR1/tIz/qyFn6/OGB7LddGnEDQ5+VTazjurP/bOtw7afUOU2eoE36Yv5Lu
        phPruF75IL3+l3Y5HqhAxVP6SI5urjXrT6KlmeSXJcWuViGsLTfy1rKORu/0yz4m/aSYI+
        DXWvvsmep/DtdtjzIaF1Km0Y/boe9DU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-CQtL6-aaNvO_3W3XPS_59w-1; Mon, 07 Oct 2019 12:56:56 -0400
Received: by mail-ed1-f71.google.com with SMTP id o92so9405116edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1CSWLKvlWejbOftg/y2xVMNmqQ4hHOqwQAeyYB2Yp4=;
        b=jJ1bUgCoTfnJZQomD0tFYDsG2JHOSOs1TXIRakbUyn1b0InOZ1Fc2wM8Xk6U9Pg5UO
         JYJvtjBCa+/R6eeTU5MQ2nOzsjJBhrPnDmFodsAiKODL/SimL0R6GbqeRBk2ryFuKTZB
         uSulgtLr7I9PcVQsytjEzqw2z34WGSHxb+Uj5al5gu2w1ZwilKgjIG1S65tobqhXuwGw
         lk3CAfHrd/HOPX0TlOZfkzZOZZx762A1b3ut8/gc+4Asjrumdu0egDroRqNdOOog6FLv
         R7U3DT4NDoS00IRM/xm/nuNex27iHIPVqOP1Vp8RwiM9dBnv1yFD6PAkUtfB5N3FbXXw
         V3rw==
X-Gm-Message-State: APjAAAWKMEHcWfGmcPDnK+Eiy+DZFi2EiXdhUzO5Ukcjpsf2sSFm4jNN
        PS7sIHxHXtB/axlaZdH+KIkqOe1i7Jvo00Ruu48IuzYxxKYbIMQBqMvj+Kt7CaVEy4xQAq3GbFE
        pGmIAgG+ZrmCpOds6ef+Xrgc1
X-Received: by 2002:a17:906:768f:: with SMTP id o15mr24985414ejm.42.1570467414799;
        Mon, 07 Oct 2019 09:56:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSl+2GSUrWpgPgOw3FgxH7Lck4WvUWk/mcp8CpPB4ba6sOS3wsZM/I84eKupqoeizw41CTBQ==
X-Received: by 2002:a17:906:768f:: with SMTP id o15mr24985404ejm.42.1570467414588;
        Mon, 07 Oct 2019 09:56:54 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id bo6sm1882177ejb.30.2019.10.07.09.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 09:56:53 -0700 (PDT)
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
 <20191007132005.GB269842@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec3b0807-efd0-12fc-670e-98cad9fcf754@redhat.com>
Date:   Mon, 7 Oct 2019 18:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007132005.GB269842@rani.riverdale.lan>
Content-Language: en-US
X-MC-Unique: CQtL6-aaNvO_3W3XPS_59w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-10-2019 15:20, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 11:10:18AM +0200, Hans de Goede wrote:
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
>=20
> Yes -- this should really be fixed. purgatory build should fail if there
> are undefined symbols, in fact the Makefile apparently is trying to do
> something to catch undefined references?
>=20
> LDFLAGS_purgatory.ro :=3D -e purgatory_start -r --no-undefined -nostdlib =
-z nodefaultlib
>=20
> This doesn't seem to actually do anything though. Anyone know of a way
> to force ld to error if the resulting object would have undefined
> symbols?

I've figured out a way to get an error for the missing symbol, I will
Cc you on the patch which I will post upstream soon.

I will also write a similar patch for s390 and post that upstream
(untested) separately.

Regards,

Hans

