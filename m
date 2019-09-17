Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D502A216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbfIQETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 00:19:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51888 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726660AbfIQETq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:19:46 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8H4JitH025198
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:19:44 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8H4JdGB003993
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:19:44 -0400
Received: by mail-qt1-f200.google.com with SMTP id c8so2820964qtd.20
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 21:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=4Uxy06CS4wSQ81eCVHfxRv9J152NHpquq1sd63pwycc=;
        b=Du6pUjy2+Epw573rdM0GMnNdDz+lk8aeLDaBAp2xrQG4Tt6gQVixyJ5ejJkLVI9XiU
         rTLEmAoXogpmzN8IWIJ7boCVH6QYpBh4RrYJ0xdp9+pkoRc8sIyTML5J9zNzlE0XYjf3
         mt2qR8klBVYQEiDUBQKeb2Ht8i8+gT7pRWsoXjEe3Ew0lnPkeaM+kJv0RJp3IUXIfNJ5
         CFd8+njy0YK8uzHdi73CEFzch04sVx4MsVM+v3ca8aYgvn5brLraGa0iWAynKVLeKwZI
         zdJGMBlrQhb3pC2yaF0NcgJQuUrrnrCa2r05wq0jI9monzJRDNU7Ws1tZs4BIIm3QXTa
         E2hQ==
X-Gm-Message-State: APjAAAW6t0l7XmYjXf64ERZDj2Hzmd7faLvrfYZjbqedyckoKRnH35MG
        0FsD30JbNoHZCCXiSVnoCeLZA8Pxvo2pOx94zyXWNs+lJ+OvHGuSSQAqRYBnXu+t55RypFDQKfe
        xtz4n1vtpyHz5QBu3uw+UL0UnuaO3g+jhfEM=
X-Received: by 2002:a37:3c4:: with SMTP id 187mr1709428qkd.424.1568693979351;
        Mon, 16 Sep 2019 21:19:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTkGscHLC5Mm8Ddz+ZkfN1sf+b4s6OeZaJW4YViOQb7XVGM3mlSEzQ7WpdH90fRajQlmWSQw==
X-Received: by 2002:a37:3c4:: with SMTP id 187mr1709417qkd.424.1568693979095;
        Mon, 16 Sep 2019 21:19:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id 33sm680373qtr.62.2019.09.16.21.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 21:19:37 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Namjae Jeon" <namjae.jeon@samsung.com>
Cc:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, "Namjae Jeon" <linkinjeon@gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
In-Reply-To: <003701d56d04$470def50$d529cdf0$@samsung.com>
References: <CGME20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd@epcas1p1.samsung.com> <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
 <003701d56d04$470def50$d529cdf0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568693976_2440P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Sep 2019 00:19:36 -0400
Message-ID: <8998.1568693976@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1568693976_2440P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Sep 2019 12:02:01 +0900, =22Namjae Jeon=22 said:
> We are excited to see this happening and would like to state that we ap=
preciate time and
> effort which people put into upstreaming exfat. Thank you=21

The hard part - getting Microsoft to OK merging an exfat driver - is done=
.

All we need now is to get a driver cleaned up. :)

> However, if possible, can we step back a little bit and re-consider it?=
 We would prefer to
> see upstream the code which we are currently using in our products - sd=
fat - as
> this can be mutually benefitial from various points of view.

I'm working off a somewhat cleaned up copy of Samsung's original driver,
because that's what I had knowledge of.  If the sdfat driver is closer to=
 being
mergeable, I'd not object if that got merged instead.

But here's the problem... Samsung has their internal sdfat code, Park Yu =
Hyung
has what appears to be a fork of that code from some point (and it's uncl=
ear ,
and it's unclear which one has had more bugfixes and cleanups to get it t=
o
somewhere near mainline mergeable.

Can you provide a pointer to what Samsung is *currently* using? We probab=
ly
need to stop and actually look at the code bases and see what's in the be=
st
shape currently.


--==_Exmh_1568693976_2440P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXYBe1wdmEQWDXROgAQIoqRAAm8jm/cfHwLtmt/GjplQFdaIBNROwXTcR
OTCa7aqyK0BzgwO9cDqRMwbGEDaN3ywuY6N9YqPsmhZfvZi57390XSXohlsbURw4
Q1ejw0aOlcKdzmSJJCm6/WMGE+DDLXTyDLowzTNXz39RfRx0y4bGu0JKiFr2QJh8
NaB1XRYo1BurpgyiwuWIqI+jrAEa1VvuSDSWSO/EL8BbJbxGbxJPnmjBkkLSpJlW
BnCTqr7ABrKSibxTGOeoDf/yX3Ce04HU11XBPoHNHqR8f1iUHZaCP6IhBUoxofAM
is3h8PZ/6e1YiME83PHpK4vllzcChhdVk9mxcMxMEpIzsIPLN70jQDhZ3z1G7iC2
eYRtkmBtBhdpDQt6CIQYwEffJB2X9yrfLNIhB5tw+IH94Eh4TgHiPFqxtEHlVSaT
WFHhyN954V+PAWL1brma3rxdY+xOK+IEOnY5DM5bW/c+YeJAIrur2c4iZLVHSRTH
kO0bFYOZ41WPThEJnyzzbtMz9HX0WdR+4A5QqIHnoqnmaTKviMAiMeAlor3rlrjk
RzfSfJUJ7oxOQVPpxCIB0/YJ+HtHXR9nEgKHvdCMmyCfb6/Pq2dqJrqQu9YbUPoW
NlRunOynwSQ5ipVKHwmwGTWyjeprRDzfMUObln77rUI03K8Vtap1he0fmjXlZTFl
x0yeZPkfRJk=
=mJjz
-----END PGP SIGNATURE-----

--==_Exmh_1568693976_2440P--
