Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5882EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A7B2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt+7+hRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbfIELZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:25:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbfIELZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:25:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so2314755wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSSehVjGWa5LE0/gH3icTwBJRpC+AS+nnud+/72hXME=;
        b=Mt+7+hRDjQpIIeJgMoGnabQHJimWM0kgJ2UdEMA4e/koR8gzYQ1321o30N4BZocB2u
         /qPsUN06ep9Ol+mmRjACdrinITrJu1c9O4N3xnvY5dqYqZ+/ItmVEl2A/ZYZrOg5W0oX
         d7PWqHT4dqRUH6829VDN0TFRWP1t1mvuuMzlSP+Tki8dp5s7y99j397jmCxbbgGWrbln
         y/8uvI+kalF1Wrvu+ca8Do/eDHZ/0edCauMNiGxvt5we7BPMssy+foqfahPlM0xsLnrz
         SkWQLtSRXNWpZA/0iWLZbGPpULHsaKv9wnWz3rTo1RkEttQopkNbw9P2GXMkDn5AWHGB
         KxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSSehVjGWa5LE0/gH3icTwBJRpC+AS+nnud+/72hXME=;
        b=XQGjU3e6Mv09gP09m/GzNJaJY8KveH5RgdsOfrA7aAgl/9rHZRaNOMjevSBm4ob9Zo
         +tmIH3inTq2KAAztdRS/cuKt10Q3hl9KNDSw/dgJ3ER7x3OcQ5EUVSVXfn787V4E8dnv
         O7HpXOyKYuye9Z25gqBstmxlJ5Kz0DPzKVxa28g098Mg+VdtzFGH82CAC3F5ez/YtwI0
         NdDH58Jvyl14oIG+51rxRD3mNwEz1lCTu/nyzAMrhLAzsw5++OHUMUgNnSDkRgBYmGeC
         fp0BGOOW4J10DJYcvs8GzOkHtuRyX88XmU3Hq2nRHHjRgsrkBCZN0GPGbfxKJwAcXz9T
         81tA==
X-Gm-Message-State: APjAAAU9aIUDoyptqqKldU8t1YpkeYhAn1ldvXS1i/ll5jCPr9rGVnZT
        xmBC7iFRHm8DELmZE+WPKGkGbg==
X-Google-Smtp-Source: APXvYqxetEUY8/CDjePqsdfkQZ4EdeUdz1CGPrEUDvyI1B7HWzOYDYHQy7uMF49ubR5yv2wYKsd3pQ==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr45427wru.35.1567682745012;
        Thu, 05 Sep 2019 04:25:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id f3sm2347171wmh.9.2019.09.05.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 04:25:44 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:25:41 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        maco@android.com, sspatil@google.com,
        Will Deacon <will@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        linux-usb <linux-usb@vger.kernel.org>,
        USB Mass Storage on Linux 
        <usb-storage@lists.one-eyed-alien.net>,
        linux-watchdog@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH v4 12/12] RFC: watchdog: export core
 symbols in WATCHDOG_CORE namespace
Message-ID: <20190905112541.GA227928@google.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190903150638.242049-1-maennich@google.com>
 <20190903150638.242049-13-maennich@google.com>
 <20190903161045.GA22754@roeck-us.net>
 <CAK7LNARYqqCSCc0G4FL7_bj80iMoLLJrUJ7B3+huD25EUkrttA@mail.gmail.com>
 <c6ac941c-06a4-e5dc-5cb9-fca7b40d7e9a@roeck-us.net>
 <CAA6KcBBeP9xYbVws4=RMFNA4kyrodE-R3mifhbkee-Q+jFRcoQ@mail.gmail.com>
 <20190905104147.GA27788@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190905104147.GA27788@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:41:47PM +0200, Jessica Yu wrote:
>+++ Matthew Dharm [04/09/19 09:16 -0700]:
>>On Wed, Sep 4, 2019 at 5:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>Note that I don't object to the patch set in general. There may be symbols
>>>which only need be exported in the context of a single subsystem or even
>>>driver (if a driver consists of more than one module). For example, a mfd
>>>driver may export symbols which should only be called by its client drivers.
>>>In such a situation, it may well be beneficial to limit the use of exported
>>>symbols.
>>
>>I can appreciate this benefit.
>>
>>>I am not sure what good that does in practice (if I understand correctly,
>>>a driver only has to declare that it wants to use a restricted use symbol
>>>if it wants to use it), but that is a different question.
>>
>>I think this question implies that you are coming from the perspective
>>of "security" or wanting to restrict access to the underlying
>>functions, rather than wanting to clean-up the way symbols are handled
>>for manageability / maintainability purposes (which is the goal, as I
>>understand it).

The goal of this patch set is to introduce structure into the exported
surface that goes beyond naming conventions like 'usb_*'. So, it is
rather about maintainability then security. In particular, creating the
visibility of which parts of the kernel use which other parts, might
help to find cases where suboptimal choices were made. Maybe already
during development/review.

As Guenter correctly noted, a module is able to declare that it wants to
use a namespace. One idea that came up earlier was to maybe restrict the
namespaces that can actually be imported by modules. But I would see
anything in that direction as beyond the scope of this series.

A nice side effect of having to declare the usage is that it shows up in
modinfo and module users can reason about how the module interacts with
the rest of the kernel.


>>HOWEVER, I have one question:  If these patches are included, and
>>someone wants to introduce a bit of code which needs to use two
>>symbols from different namespaces but with the same name, can that be
>>done?  That is, if driver A has symbol 'foo' and driver B has symbol
>>'foo' (both in their respective namespaces), and driver C wants to use
>>A.foo and B.foo, can that be supported?
>
>As of now, we currently don't support this - modpost will warn if a
>symbol is exported more than once (across modules + vmlinux), and the
>module loader currently assumes exported symbol names are unique.  Do
>you have a concrete use case? If there is a strong need for this, I
>don't think it'd be too hard to implement.

The implementation does not change the fact that symbol names need to be
unique. As Arnd just mentioned in the other thread: the linker will
already fail if two builtin symbols use the same name. It is rather a
tag attached to the symbol.

Cheers,
Matthias
