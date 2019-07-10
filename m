Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBACAC73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09520645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jilayne.com header.i=@jilayne.com header.b="dJM475y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGJEKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:10:43 -0400
Received: from mx1.supremebox.com ([198.23.53.39]:58873 "EHLO
        mx1.supremebox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfGJEKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:10:43 -0400
X-Greylist: delayed 1756 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 00:10:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=AYOKcfGVOYIwtnBpJskuZTTWudypmg8tOCQ67JADO40=; b=dJM475y+qQShcOTAhRStkp5NwL
        jhmtFFzuzeFwyduNeAEOLv/dvMSsoqagk34N8LSdXbQIQHoS9BIRso2BrhMavjMFb1+wfdg8u3XDH
        RfqC+cGxeXuZM1RwzbbBRwypWa0uCes4fBH0BpjZ2UkNp+Jv5B90LBwMIWlsQDt/n7m8=;
Received: from 184-96-235-43.hlrn.qwest.net ([184.96.235.43] helo=[192.168.0.12])
        by mx1.supremebox.com with esmtpa (Exim 4.89)
        (envelope-from <opensource@jilayne.com>)
        id 1hl3VT-0006mr-KH; Wed, 10 Jul 2019 03:42:59 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] gpu/drm_memory: fix a few warnings
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <alpine.DEB.2.21.1907082150170.1961@nanos.tec.linutronix.de>
Date:   Tue, 9 Jul 2019 21:42:57 -0600
Cc:     Qian Cai <cai@lca.pw>, Ilia Mirkin <imirkin@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, joe@perches.com,
        linux-spdx@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, rfontana@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <472DABBB-81E5-4E79-9910-BA3C26936B40@jilayne.com>
References: <1562609151-7283-1-git-send-email-cai@lca.pw>
 <CAKb7UvhoW2F5LSf4B=vJhLykPCme_ixwbUBup_sBXjoQa72Fzw@mail.gmail.com>
 <1562614919.8510.9.camel@lca.pw>
 <alpine.DEB.2.21.1907082150170.1961@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 8, 2019, at 1:57 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>=20
> On Mon, 8 Jul 2019, Qian Cai wrote:
>> On Mon, 2019-07-08 at 15:21 -0400, Ilia Mirkin wrote:
>>>> -/**
>>>> +// SPDX-License-Identifier: MIT
>>>> +/*
>>>>   * \file drm_memory.c
>>>>   * Memory management wrappers for DRM
>>>>   *
>>>> @@ -12,25 +13,6 @@
>>>>   * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
>>>>   * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
>>>>   * All Rights Reserved.
>>>> - *
>>>> - * Permission is hereby granted, free of charge, to any person =
obtaining a
>>>> - * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> - * to deal in the Software without restriction, including without
>>>> limitation
>>>> - * the rights to use, copy, modify, merge, publish, distribute, =
sublicense,
>>>> - * and/or sell copies of the Software, and to permit persons to =
whom the
>>>> - * Software is furnished to do so, subject to the following =
conditions:
>>>> - *
>>>> - * The above copyright notice and this permission notice =
(including the
>>>> next
>>>> - * paragraph) shall be included in all copies or substantial =
portions of
>>>> the
>>>> - * Software.
>>>> - *
>>>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS
>>>> OR
>>>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
>>>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO =
EVENT SHALL
>>>> - * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, =
DAMAGES
>>>> OR
>>>=20
>>> This talks about VA Linux Systems and/or its suppliers, while the =
MIT
>>> licence talks about authors or copyright holders.
>=20
> That's looks lika a valid substitution and does not change the meaning =
of
> the license, AFAICT.=20

As of the 3.6 release of the SPDX License List, we will have added =
markup to denote that the name in the disclaimer can be changed and =
still considered a match. This is a common scenario in other licenses =
(like the BSD family), but I don=E2=80=99t think we=E2=80=99d come =
across it until the work on the kernel and adding SPDX identifiers. So, =
yes, MIT would be the correct SPDX identifier here as of 3.6 (which will =
be posted in a few days).

For reference, the SPDX License List matching guidelines can be found =
here: https://spdx.org/spdx-license-list/matching-guidelines - see =
Guideline 2.1.3 specifically. Replaceable text is marked up in the =
master files that comprise the SPDX License List according the the XML =
schema and then displayed in color coded text on the website pages (see, =
for example, BSD-3-Clause - https://spdx.org/licenses/BSD-3-Clause.html

Of course, if anyone finds any other license text that deserves this =
kind of accommodation, you can always make a PR here: =
https://github.com/spdx/license-list-XML :)

thanks,
Jilayne
SPDX legal team co-lead=
