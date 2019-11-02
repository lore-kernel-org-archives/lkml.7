Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74B2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572732245;
	bh=uWJi/MwEfcXtvMshsyfTyXUwqGP5JBPovIygjDprHms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tIMn8Kun0JJAWJvnarL1/dy9i2JoFBUs4luaKckKfC3YWqmS95mu2sea1hV2fFDJ5
	 SJHx+4nXBy2Kk4YpJ5EGoewt07ANof4PVA/LtL0ywHtDeB/XpiM2uZUI1Jo6uRhWIE
	 etx8qxkOJWBTmBdkcSb9rL/bbQP1Xvro7YMmfshk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKBWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:04:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35137 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfKBWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 18:04:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id y6so9604579lfj.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=XRll/5vMVkjx89KHnpq6WWB0oHHUpEHdiN6O6XIbNfDvJpLq9nAHdnvBRo0qcYtdlV
         dDebt2KT4z/UoQ3oT2Pk6vWaFBXKSztN5uuRAQNTvGwr3g3jPPeee0pGSv+auGk2TkT9
         /FiIqnPnAFsk6ubf5wFePKPpQhSpZfg8GPgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=HnTk8AnauFuwQkWDJbbtCKcCRMHpiYZGtynHAuJ3u3WDLlx7ayqja2P7Lr5bGhmCE4
         Lm2K7z/Twt/tGIvL6t9dZfvR0I98GD2G0cJG3VB6RRcTAZ7/qOo6JtBpUg8emhqnGxif
         9w9fVTdYM07faIIIOSftEUdoeYAGMKRldsbX0wP+NXZAWIs20+d08IcpuYONJO68KG+o
         RgFKP3w+sTIKGdk+TXjqHQsSfUTRDNUmjAW+8W2MKyVrgHMjqVC1qioqRRMqJwrovc/l
         JUHOF/bJJ7OLT7t3G9Um8yHXnVLyQGQYZ9LdOcbyykoRC7jsjHorLwyY/VTTqA+3xVU8
         HqtA==
X-Gm-Message-State: APjAAAVmH8Wq5z9pKbe9eZdvg+z+diwdKpDd5m9e/W1JmUOaFhI7setr
        eb4ugQFMckwqbhUSylBMEgN3okL/9lk=
X-Google-Smtp-Source: APXvYqydWEIYZPnGNQeuRFzomUzkhSFGqIMo1QNxMqWbEaduNPPQnr9++Had+rF/wCXL2xD3fBnTpA==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr11954271lfg.21.1572732240590;
        Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h16sm4244380ljb.10.2019.11.02.15.04.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r7so5022543ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr13611187lja.48.1572732239632;
 Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
In-Reply-To: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make i=
t just do write() under the hood.

Sure it can. Just don't modify the data you vmsplice. It's really that simp=
le.

That said, if we don't have any actual users, then we should look at
removing it (maybe turning it into "write()" as you say). Not because
it's hard to use, but simply because it probably doesn't have that
many uses.

               Linus
