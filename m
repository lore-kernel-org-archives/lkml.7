Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED4FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39B206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="N8lS+KOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfDBQLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:11:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44460 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfDBQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:11:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so6796530pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R5sYu8eFEFWeOED/6+uFY3pY5zrSN/jFLcMXCXb72Oc=;
        b=N8lS+KOJ1/xe+vodMT0FXgXWRkaWf0Y8Hrt6dbd7LqpskOBBWQWGJxToIJo7S3Oq5u
         qqqtQ0RaOS54608K1HWBpeleUoR6ScuNpWxQxMNdLKS60a7H55ydyRG5rMHZmV5qdFCR
         lIBQFo+628b7u6N/RzeORwdSkhz+lc/3/3NJUzPnNxUvEa9MkZMGJaPQG8Wyh8xDIP2F
         8cAthFMLlC2AY2ZWayNZS63oemkvjOCPKX6ftufNf2qvXxs2Qp/RKhK7kGN51Rpj53iY
         oaB+uQk00ftEbTtRTRpjvxw7tseVYx7oVfd8uHEYZbDtNe5FMuo6mX3DHKatr11boFHS
         94aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R5sYu8eFEFWeOED/6+uFY3pY5zrSN/jFLcMXCXb72Oc=;
        b=SUVZoCMHv9Y3MYJvzhJG3ZtjkMzOLxZkFwLuoWR7dzaJKmWOM3NpnjPlF6mZa59ZFF
         qUV08yqUtqma9exho8vJtMQ4rkpkbDWXCVIL738jUNgUoLdNCE9NaqOO33vpBId+sm21
         Twwy1nMjPFLmL2a5Bs/+yxlRUKGSy5oYe8PzhrLvShDCCDpy5zYFMRbJD3NeBV+/mDb6
         6dATZtlaxyVnpjOiz0wWhIW2bJi9hzXNFvIpaaq52x7UskXdnQkDxxdwtBnUukleYb5i
         qTzqDvZKoaspEKPMTzPmNET7aFk/Nlm73BUbPblo54a08B3MBbpiGb9xiNcQbJjQm0/E
         AofA==
X-Gm-Message-State: APjAAAVqJ7H3letrnh00Y3j7cgdxnB9cRU2v3Uvt581UkxbZKfsHJhPQ
        djsDEXZKb863jT2PZQFcd/8ZNQ==
X-Google-Smtp-Source: APXvYqyk6zIrdBGTScusPFMKzb51Sf1TcA6OrVpVaiwEF7JKp+F1kiv9g3+SIcTT5pAixcJZyRNsvg==
X-Received: by 2002:a63:4e5b:: with SMTP id o27mr67984364pgl.204.1554221482513;
        Tue, 02 Apr 2019 09:11:22 -0700 (PDT)
Received: from ?IPv6:2600:100e:b118:ffaf:d107:e4b0:1269:f9d6? ([2600:100e:b118:ffaf:d107:e4b0:1269:f9d6])
        by smtp.gmail.com with ESMTPSA id v188sm23811377pgb.7.2019.04.02.09.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:11:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
Date:   Tue, 2 Apr 2019 10:11:19 -0600
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7789E14E-C623-4DB7-B076-76B931957C9C@amacapital.net>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 2, 2019, at 9:48 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Tue, 2 Apr 2019, Josh Poimboeuf wrote:
>>> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
>>> +/*
>>> + * Array of exception stack page descriptors. If the stack is larger th=
an
>>> + * PAGE_SIZE, all pages covering a particular stack will have the same
>>> + * info.
>>> + */
>>> +static const struct estack_pages estack_pages[ESTACK_PAGES] ____cacheli=
ne_aligned =3D {
>>> +    [CONDRANGE(DF)]        =3D ESTACK_PAGE(DOUBLEFAULT_IST, DF),
>>> +    [CONDRANGE(NMI)]    =3D ESTACK_PAGE(NMI_IST, NMI),
>>> +    [PAGERANGE(DB)]        =3D ESTACK_PAGE(DEBUG_IST, DB),
>>> +    [CONDRANGE(MCE)]    =3D ESTACK_PAGE(MCE_IST, MCE),
>>=20
>> It would be nice if the *_IST macro naming aligned with the struct
>> cea_exception_stacks field naming.  Then you could just do, e.g.
>> ESTACKPAGE(DF).
>=20
> Yes, lemme fix that up.
>=20
>> Also it's a bit unfortunate that some of the stack size knowledge is
>> hard-coded here, i.e #DB always being > 1 page and non-#DB being
>> sometimes 1 page.
>=20
> The problem is that there is no way to make this macro maze conditional on=

> sizeof(). But my macro foo is rusty.

How about a much better fix: make the DB stack be the same size as all the o=
thers and just have 4 of them (DB0, DB1, DB2, and DB3.  After all, overflowi=
ng from one debug stack into another is just as much of a bug as overflowing=
 into a different IST stack.
