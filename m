Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5F20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCIPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:50:15 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35989 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfCIPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:50:14 -0500
Received: by mail-ed1-f45.google.com with SMTP id e4so523472edi.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 07:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1vH19OLSobakAZFj+R+HeYC8yMmPXzpd0MbGz9aiYIc=;
        b=pfcw1p1jl+TVKSUarm1dCuQgjFxrsASi7uFT84z7PQLtdIqJ0A/13CL3vyu9fTT6iS
         /oqbOZySmIT6PDQ9XMM4rfPbnUfNTf1YizzWrBKnsSBQQCz3NQ62C/yocVE2uW8/YFso
         GqQfVI+kImQ58Aviitw3YpwyDEUWU3A/9++SrdYurziTcLkZGKE/zcwz5QKrzelo2WDO
         kXX5/9xPJ9dpJXHviLOckAP7hdVjCpALqc4MM9hyvfWpwwgkwY6fo72Gxce4ikI3Aor6
         p+Z89HFZt9/jIoHSh6Ed2W11t48iZggegFNdVqhXJxYsEybnZesC9pcbktqycI7ysW7P
         i6Yw==
X-Gm-Message-State: APjAAAWzjBx5W3Ovvxjjvwq89ysRlTlIDzpPeSagq8fVnyqIZLL0ZGco
        xm/3dqC+XhhGwzbfMTJ4EktWEQ==
X-Google-Smtp-Source: APXvYqzDP98i2eLHjxhD4miJQkH+FwbHl2/jWW9sbOtgt+kAyWIMN76/UGTJSRCjIn2JWMoBV2E/fQ==
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr38104654edq.14.1552146607863;
        Sat, 09 Mar 2019 07:50:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id d10sm2003112ejr.64.2019.03.09.07.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 07:50:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 969561804A0; Sat,  9 Mar 2019 16:50:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Andre Naujoks <nautsch2@gmail.com>,
        "wg\@grandegger.com" <wg@grandegger.com>,
        "mkl\@pengutronix.de" <mkl@pengutronix.de>,
        "davem\@davemloft.net" <davem@davemloft.net>
Cc:     "linux-can\@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: can: Increase tx queue length
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com> <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com> <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Mar 2019 16:50:01 +0100
Message-ID: <87zhq43v4m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Appana Durga Kedareswara Rao <appanad@xilinx.com> writes:

> Hi Andre,
>
> <Snip> 
>> 
>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>> > While stress testing the CAN interface on xilinx axi can in loopback
>> > mode getting message "write: no buffer space available"
>> > Increasing device tx queue length resolved the above mentioned issue.
>> 
>> No need to patch the kernel:
>> 
>> $ ip link set <dev-name> txqueuelen 500
>> 
>> does the same thing.
>
> Thanks for the review... 
> Agree but it is not an out of box solution right?? 
> Do you have any idea for socket can devices why the tx queue length is 10 whereas
> for other network devices (ex: ethernet) it is 1000 ??

Probably because you don't generally want a long queue adding latency on
a CAN interface? The default 1000 is already way too much even for an
Ethernet device in a lot of cases.

If you get "out of buffer" errors it means your application is sending
things faster than the receiver (or device) can handle them. If you
solve this by increasing the queue length you are just papering over the
underlying issue, and trading latency for fewer errors. This tradeoff
*may* be appropriate for your particular application, but I can imagine
it would not be appropriate as a default. Keeping the buffer size small
allows errors to propagate up to the application, which can then back
off, or do something smarter, as appropriate.

I don't know anything about the actual discussions going on when the
defaults were set, but I can imagine something along the lines of the
above was probably a part of it :)

-Toke
