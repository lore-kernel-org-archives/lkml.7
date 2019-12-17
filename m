Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614E8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CCA206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576617318;
	bh=QCdqve/K0tbMuqiHdiDyo9hxYUKFLb+nQhxsTAcTu4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tcjTTg/IZPsH4Eif9cty+yoqNZ+cAdrO1P7iEZKlF3Lwd4SIIPI0rwUG69tZm7PxV
	 BgzWGpaVPTUseu3rouVy7BWXYar1G5MOvGFnVd3eBIebWA87HzcZtABb5IWR6z22r/
	 1MXcYMWaLUHbP1Z7hAIg020TSElEp8A0kLAn6rqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfLQVPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:15:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40783 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfLQVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so1698671ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miIxpQ/Ljqg/1nvvnERImSZJGAAMIhMIrlQ3MRCjAF0=;
        b=DQpT/HDqDEnXfuTHalEnH7z0eHJ9zRmDVgQR+3sMlGUq2uVljvCZCRD71oPnT7JE1j
         sxYQOl2ad2Dy8B6VfwMkYmYcQSSdkvT9u0z41CapTmKJMf+VFVLo2LX/00xAnRCtYeRM
         Wi8Sn7atlRHf0teoKy6kSdg018cHdY4DHM7o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miIxpQ/Ljqg/1nvvnERImSZJGAAMIhMIrlQ3MRCjAF0=;
        b=XyFx/D/ZTNXPsOZ9TKXqa1dI/HcHTReXRWiecSqqUJ1nBYQjDDqedOQoviBQzSU/h3
         XVSdojrHF9z1zZmNn3YDdaDatO7/zh4ZWnAX9ZyAClST09zYClLAcht/HJJC4eih0Fb6
         52cKIfcY9mKhijCbpQf2BIz3SPRVlyyX4pJUCcNgbrIniD3/uWz+IvqAPccq1rssJyya
         rI61bbcMaeAQZxtqwg1+rT0mHXhHE9qmTirlFIx5Ty+1YL/l4OsmnpP71bTPCvP+PuIw
         C53ZwLkLXO9WYQkpSbAFoyNCkxcKmP33MO/EecRrsd9d4hjO24oCqfbvnV2JqRkeAZHF
         LoMA==
X-Gm-Message-State: APjAAAXg9vO7U92CUDG3NU5/xy0X7D2VSmpIDX/cJCc/gBZUL2vYUBPw
        mkpD7TevzfgwHbPbrLFY4HNcEUc5Exc=
X-Google-Smtp-Source: APXvYqwGtLjzp2ML7AfhPBwkRVm4wOZ4HZ00LAQIWYqnkq7A/Pqiksv/IP7JGeRoGyP6g/Q/hr7Blw==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr4899708ljc.100.1576617313042;
        Tue, 17 Dec 2019 13:15:13 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y25sm11240553lfy.59.2019.12.17.13.15.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 13:15:12 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 15so62023lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:11 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr4054922lfi.170.1576617311430;
 Tue, 17 Dec 2019 13:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
In-Reply-To: <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 13:14:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
Message-ID: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     youling 257 <youling257@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be fixed by 2d3145f8d280 ("early init: fix error handling
when opening /dev/console")

I'm not sure what you did to trigger that bug, but it was a bug.

              Linus


On Tue, Dec 17, 2019 at 1:34 AM youling 257 <youling257@gmail.com> wrote:
>
> I had been Revert "fs: remove ksys_dup()" Revert "init: unify opening
> /dev/console as stdin/stdout/stderr", test boot, n the system/bin/sh
> warning.
