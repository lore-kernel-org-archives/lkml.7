Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4962067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 00:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Or6uEcGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfD2AHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 20:07:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfD2AG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 20:06:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so470739pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n2mvnFGe7DhWnAVJ4HPTWEsItuKdoQBnBqAP6kIcYug=;
        b=Or6uEcGq20/dbV741dpgRcmnluoZolSsauu907Q2n5IqtHesTqLypagpN4KylfV4J4
         gV/Ri1WN8QiMSpSFwMNVrtg+g50Mh9dq9f59O5tPGvKm4CoKzYz808goOti/dswLGmR1
         AYMHlHdbG1/yE0hzyy72pnjLNc6uo7AC6CMfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n2mvnFGe7DhWnAVJ4HPTWEsItuKdoQBnBqAP6kIcYug=;
        b=mcusVgBNSVshBhIu1dTFBxLMa3yQNbXHpb4pXL8haUY1FDPJJWVAKJXLIJQKbwscFQ
         uY776IVKJGtXzVjwXsQ/3bht4sUoEP+6knP5vE5jOWPgFPkssx0b04Xytp5QhJJEtEbN
         0Orxx146qFoxqCdTHaSbpCEqqIWAQjRDnP/6jkmJOHJewyxD1d+dcPoY75XU+c18Wtf8
         MumXJvLOi/g/Cht72a12gOkUiUTQ6msDJuSmEFcxn6Fu65NRzVjdjGoCgFH3leGIotxR
         M630h/ROR9MGv6bUVIIdZb/zK2LOazgMQfKeGtiCJJYV+58mkhxJex/Cl7kixeyQxOai
         BgKQ==
X-Gm-Message-State: APjAAAW17qHHhJS7zT32WISga//LX2mgJDWapkGEEkf06skz50ai/DPY
        pc3eGoyChtntR/Yud4hQdd0KXg==
X-Google-Smtp-Source: APXvYqwb6MwKjVD4beBIgVSrqvnOCys+S049kGs7qQXovjqAUY28iQ+jdtiBGffI7iAuh/EIjCR1vg==
X-Received: by 2002:a63:4714:: with SMTP id u20mr47465141pga.316.1556496419070;
        Sun, 28 Apr 2019 17:06:59 -0700 (PDT)
Received: from localhost (ppp121-45-207-92.bras1.cbr1.internode.on.net. [121.45.207.92])
        by smtp.gmail.com with ESMTPSA id w23sm44714029pgj.72.2019.04.28.17.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 17:06:57 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Matthew Garrett <mjg59@google.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr <cmr@informatik.wtf>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
In-Reply-To: <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <059c523e-926c-24ee-0935-198031712145@au1.ibm.com> <CACdnJus9AhAAYs-R94BH7HDuuQfXjgdhdqUR6Pvk9mxbuPx1=Q@mail.gmail.com>
Date:   Mon, 29 Apr 2019 10:06:51 +1000
Message-ID: <87wojdy8ro.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mjg59@google.com> writes:

> On Tue, Apr 16, 2019 at 1:40 AM Andrew Donnellan
> <andrew.donnellan@au1.ibm.com> wrote:
>> I'm thinking about whether we should lock down the powerpc xmon debug
>> monitor - intuitively, I think the answer is yes if for no other reason
>> than Least Astonishment, when lockdown is enabled you probably don't
>> expect xmon to keep letting you access kernel memory.
>
> The original patchset contained a sysrq hotkey to allow physically
> present users to disable lockdown, so I'm not super concerned about
> this case - I could definitely be convinced otherwise, though.

So currently (and I'm pretty new to this as I've only recently rejoined
IBM) we aren't considering access to the console to be sufficient to
assert physical presence on bare-metal server-class Power machines. The
short argument for this is that with IPMI and BMCs, a server's console
isn't what it used to be. Our console is also a bit different to x86:
we don't generally have bios configuration screens on the console.

In your example, a sysrq key would allow you to disable lockdown after
the system has booted. On Power though, we use Linux as a bootloader
(Petitboot: https://github.com/open-power/petitboot) so being able to
disable lockdown there allows an IPMI-connected user to prevent a signed
kernel being loaded in the first place. I don't know if this is
_actually_ worse, but it certainly feels worse.

There are of course some arguments against our approach. I'm aware of
some of them. I'm also very open to being told that not equating console
access with physical access is fundamentally silly or broken and that we
should rethink things.

Regards,
Daniel
