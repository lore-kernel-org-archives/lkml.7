Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9FEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9050214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caQ4JLUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKMIEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:04:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727132AbfKMIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573632240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWcZWJtzdppcM76KohD37mlvGtsiTZ4jS7DFNLMCC7M=;
        b=caQ4JLUom70nkFciUj1MAfkncR8tE3hsDFBAyswyVaLAzNC3Yjc4zNsg9HR+X011OlAhpI
        j09iVYphzgYBfBGcH9aeNN1OfPY9e1RCAY1b7Bt9QyxaAWdsBR6+rvoFJ+0T8fpF7MHn/m
        GyN8UZr6jRZN/P1W4/88EDhzKKsLgzo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Yj_yvQm_OyC09Eyw-7NIHw-1; Wed, 13 Nov 2019 03:03:57 -0500
Received: by mail-wr1-f71.google.com with SMTP id w4so1135205wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 00:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uO6TAe5CY3chuTGSu2TisEgi2TBlw5xURmLltnTdu2U=;
        b=VskwFbaO0OHWLLFrGZOKZIMFhtYI6GO07qREYT3bXhlRBBJ3e97ZjWKG2yb5nfORcc
         E6AjuyhETYBcA7P+8rnhU9rkV7yLB81xbaLAWzMQXgcySJOKa3h6BPThsPyJ16v6sKAt
         pZkswODmz+ZG+KRzkOHHlXJT6qBqe96765nxAi0E/1zmrkx+ndxv5VF+CTJPKZ7BgnAv
         z3jl9o9dusjsJwqmDLKk00RbyBj9rQtvYQaG0SBvxc9KxVS4tksPZY6UXfz/2tWxqwUA
         zskYd4/YGeYmCU/afKwkdDcNuHUaWH1iEz/yLC6JGB9fTUi/eApv9slvoq6DLqXvElop
         WDqQ==
X-Gm-Message-State: APjAAAXqYDD/WDjX/lz2D6YuNq+mBfL3U7Gm6FeMfN8Zkiir1D/mbDOg
        jNClLfb/Oxcm1/Xc2366UFcSja7FsyuS12GJc8EThzKzJJwfPAJWcqqBWkaxk9d0JKg7JtJBvHy
        G9OLUkuq0f85kjEDSR2Qm0mzT
X-Received: by 2002:a7b:c055:: with SMTP id u21mr1522373wmc.55.1573632235400;
        Wed, 13 Nov 2019 00:03:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdVvtKiYmZt1fSzZA8kPfb3J2pg0i+JjNFD/a5EyFATv6YGKKR2tWjoIt78oPPlSoqWsctkg==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr1522332wmc.55.1573632234803;
        Wed, 13 Nov 2019 00:03:54 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y6sm1887805wrr.19.2019.11.13.00.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 00:03:54 -0800 (PST)
Subject: Re: [PATCH] vboxsf: move out of staging to fs/
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
References: <20191110154303.GA2867499@kroah.com>
 <20191112063440.GA15951@infradead.org> <20191112065629.GA1242198@kroah.com>
 <20191112225427.GA1873491@kroah.com>
 <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f7e11836-8f90-4ddf-1c81-4d49d35d91d6@redhat.com>
Date:   Wed, 13 Nov 2019 09:03:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiLZpyGyOcymND-Pk7_a_MXHZHJtsT9TryHmZBE7Babiw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Yj_yvQm_OyC09Eyw-7NIHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-11-2019 00:12, Linus Torvalds wrote:
> On Tue, Nov 12, 2019 at 2:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> Christoph, this is what you mean, right?  If so, I'll send this to Linus
>> later this week, or he can grab it right from this patch :)
>=20
> No.
>=20
> I was unhappy about a staging driver being added in rc7, but I went
> "whatever, it's Greg's garbage"
>=20
> There is no way in hell I will take a new filesystem in rc8.
>=20
> Would you take that into stable? No, you wouldn't. Then why is this
> being upstreamed now.
>=20
> Honestly, I think I'll just delete the whole thing, since it shouldn't
> have gone in in the first place. This is not how we add new
> filesystems.

I understand you being unhappy with this.

The problem is that Al Viro, after an initial review around v2 or v3 of
the patch, which I believe I have fully addressed, has been ignoring
this patch / new fs for over a year now. I've pinged him repeatedly
both via email and on irc, but with no luck.  I guess he simply is
too busy with other stuff.

I did ask other fs developers to review and have gotten reviews
from David Howell and Christoph Hellwig. I've addressed all their
review remarks and I've had reviews of the newer versions with
just a few nitpicks remaining. I've also addressed those nitpicks.
But I never got an Acked-by or Reviewed-by from either of them
on any of the newer versions.

I even talked to various people about this at plumbers, but
I did not get any traction there either.

On the advice of Christoph I've asked Andrew Morton to take this
directly under fs/ instead, twice. When this all went no where I
went the staging route, with the current result.

So for 5.5, and assuming I can get David's and/or Christoph's
Acked-by, is is ok if I send this directly to you?

Regards,

Hans

p.s.

Christoph, David, can I get your Acked-by for the latest
version of the patch (v17) ?

