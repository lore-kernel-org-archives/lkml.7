Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E88C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F277721835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSjxWfWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfJHTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:47:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729385AbfJHTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570564043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiLraLEOHVJMQW3DZM6T811AWApI3wm6nU4uAi5YLA4=;
        b=fSjxWfWuntY7x4DKEd4necUVWR3P2cL+HGTTsGAoh+5JPGdm7gyg/saXURl8Q/PcQEBIVl
        p/cSRsaOp8RCSHu5e2KxoFQFHFZTkD21xbBZ5MwDb+lArdy25a9M/FOLKGumPepMfT6Uo7
        F2OVKPnrfP5lqafHjhMfTeNG6LUjejo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-beo1XltJNGWqfrB7AIed_Q-1; Tue, 08 Oct 2019 15:47:21 -0400
Received: by mail-wr1-f69.google.com with SMTP id 32so9592008wrk.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9PwM6aqKCiJLV+IIYiBNTz1lzh80V+pvcsEJSuL6Dsk=;
        b=sp8gbRow5n5OlBohsP/sRBmhXUs9sH3R1sTKDRj0173HPxrtAlJ2hEM3F66osA5b3A
         BfqbelNKAQr9LO/cUz2z0PD++GYcouL3xO21ymdSxq1ouSxuBzaLwjxcVGw2cfUFcMOg
         GWe3OouNyz3Ts4kH+D/B2bdgXg5wdYntoDpILZAzBpJvHsjTaf4+s24i8mCP/QZFGTmP
         frqwMvEawOAUOjrg9mAJ6KUlMFMpr+Y9IHwbaKrzC/oA/ST65+i56MRRA8BhR721UCnO
         tza/vBWfK7sHxLD9zONlZD06YFIQA46XJBb8D5/j/d472dp+uxlWpDcl6KWvhUi0pFIh
         YvZg==
X-Gm-Message-State: APjAAAVvGIHlPyVqOWrZMBbNK6f2otcrTI6h2xcpWa/IiWzJmKxEndoM
        FGsCsicUE9kJonlDJmFYbQvRWStfc1aietkdPBH+IGSNCJzhZcegEBoEssaMCaU8jWe4cKBnmyu
        xf8Csk/oMdK55NwC9VylcRXzM
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr4831610wmj.71.1570564040738;
        Tue, 08 Oct 2019 12:47:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJlALWevvlEenjVPCyVJrYw0c1CrRdaL/NdPL7Y1i+9HYclK/R/sOgnLBu6GUskCbDEiEI/A==
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr4831588wmj.71.1570564040470;
        Tue, 08 Oct 2019 12:47:20 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.158])
        by smtp.gmail.com with ESMTPSA id x5sm17615412wrt.75.2019.10.08.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:47:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
In-Reply-To: <20191008150847.GA15276@andrea>
References: <20191007163115.26197-1-parri.andrea@gmail.com> <PU1P153MB01691E9B0DD83E521B1E12C0BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <20191008150847.GA15276@andrea>
Date:   Tue, 08 Oct 2019 21:47:18 +0200
Message-ID: <87imozyq7t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: beo1XltJNGWqfrB7AIed_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> On Mon, Oct 07, 2019 at 05:41:10PM +0000, Dexuan Cui wrote:
>> > From: linux-hyperv-owner@vger.kernel.org
>> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
>> > Sent: Monday, October 7, 2019 9:31 AM
>> >=20
>> > Hi all,
>> >=20
>> > The patchset:
>> >=20
>> > - simplifies/refactors the VMBus negotiation code by introducing
>> >   the table of VMBus protocol versions (patch 1/2),
>> >=20
>> > - enables VMBus protocol versions 5.1 and 5.2 (patch 2/2).
>> >=20
>> > Thanks,
>> >   Andrea
>> >=20
>> > Andrea Parri (2):
>> >   Drivers: hv: vmbus: Introduce table of VMBus protocol versions
>> >   Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2
>>=20
>> Should we add a module parameter to allow the user to specify a lower
>> protocol version, when the VM runs on the latest host?=20
>>=20
>> This can be useful for testing and debugging purpose: the variable
>> "vmbus_proto_version" is referenced by the vmbus driver itself and
>> some VSC drivers: if we always use the latest available proto version,
>> some code paths can not be tested on the latest hosts.=20
>
> The idea is appealing to me (altough I made no attempt to implement/test
> it yet).  What do others think about this?  Maybe can be considered as a
> follow-up patch/work to this series?

IMO such debug option makes sense, it shouldn be a simple patch so you
may want to squeeze it in this series as it will definitely have code
dependencies.

--=20
Vitaly

