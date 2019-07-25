Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B62C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209A92190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l29inhlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbfGYEsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 00:48:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55599 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbfGYEsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:48:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so43644835wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CjiCyagoNsqpoWWP7KGTzXOceM7b7O4YQsDKRX4Ms0=;
        b=l29inhlXBVh2okbkCb5f/SAYbAURlgoamQDh/gA6pF7TXGwbDpqZbFX4aw/paPnLiU
         u5h16aKmgLL72jOGJOywp1wxiAMVLCRDttztYZK5BwHjxJw4xW8lLaeHUDyvSjHWikCy
         G7V34+woMGgeYGG/0JJQYx4pJPBZtKDjYsliFwJQRs+dPnopy/1aPr0szJhGguToz3xQ
         pd1/6hitOzHw1nejxOggjj4JlnZv9ouR5Aw8m10wqH25D54QA5CvtIDOmdh0ZYTpoP+h
         5pl7/r/vLe4bPB5gfKuFrEOg8WeV2+6TxaacDYi8hLKEFvElO0iviEC1fN7dmaLM4HLN
         M5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CjiCyagoNsqpoWWP7KGTzXOceM7b7O4YQsDKRX4Ms0=;
        b=NOPSpPuGcAbMva0Z4AYG28w9vrtmkdHoOu/WXg3ZReclMnEeed3aCSHaKqIs72/7xo
         fJXpp1+I4gND7Q4/jCKpL1uUf1ZBq0iHMlx8MOYPxttP7GgKG922CZw5ZFQWD6pgcFTI
         3649U7tnHTprEJo0ZLWmzhVNIAQV4tFarkg1wmdUwW5+SL1A4pSjW60ljQkRoihtk+xl
         +TfYDJQ7jAYewvMKH8F+c/6uYs7X2wZwZpr3q7Gt4GhAS1WO8mhm5Yj03NGhM121e371
         bDkPNfuxnHlrdLY1YDvnngacVxrEEVn040dclSZlQj4LUFs1QWINjSY2BBkIhVOlamb1
         oKNQ==
X-Gm-Message-State: APjAAAWbcIDToGUG0JyLVsjgJn0ftcvrj0jFj+hUIpPntvjXB6v36mnR
        3HF80SOm510Ej/xB8/jaeYEcsc5g8/641ogPWnA7eMcpLQm8iA==
X-Google-Smtp-Source: APXvYqw/5anRgyaiKCDwwspxRPCdSOmNMxbjsA4+qFmvCFzLAjk54gDo+M6pbm9Y/DuOU3ix5J9zf62/uj1ZqTKCC8U=
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr76803011wml.84.1564030128834;
 Wed, 24 Jul 2019 21:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr-0SiE=_UFEUovbVpLvhJmZMq_i2tA6Pp0v6cy2aLS_YA@mail.gmail.com>
In-Reply-To: <CAPhKKr-0SiE=_UFEUovbVpLvhJmZMq_i2tA6Pp0v6cy2aLS_YA@mail.gmail.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 24 Jul 2019 21:48:37 -0700
Message-ID: <CAPhKKr-o4p9oYZ7_iagWL5bouUR6O+K7s07dQzjDQw6t9JdRcQ@mail.gmail.com>
Subject: Re: CFP: LPC Testing and Fuzzing microconference.
To:     LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>, guillaume.tucker@collabora.com,
        mark.rutland@arm.com, Nick Desaulniers <ndesaulniers@google.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Eliska Slobodova <eslobodo@redhat.com>,
        andrea.parri@amarulasolutions.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 1:12 PM Dhaval Giani <dhaval.giani@gmail.com> wrote:
>
> Hi folks,
>
> I am pleased to announce the Testing Microconference has been accepted
> at LPC this year.
>
> The CfP process is now open, and please submit your talks on the LPC
> website. It can be found at
> https://linuxplumbersconf.org/event/4/abstracts/
>
> Potential topics include, but are not limited to
> - Defragmentation of testing infrastructure: how can we combine
> testing infrastructure to avoid duplication.
> - Better sanitizers: Tag-based KASAN, making KTSAN usable, etc
> - Better hardware testing, hardware sanitizers.
> - Are fuzzers "solved"?
> - Improving RT testing.
> - Using clang for better testing coverage.
> - Unit test framework.
> - The future of kernelCI
>

Hi all,

Just a reminder, the CfP is open for the microconference and proposals
are being accepted. We plan to start selecting topics starting Aug 11
and  can let you know that if you don't get your topic in, it will not
be selected!

https://linuxplumbersconf.org/event/4/abstracts/

Thanks!
Dhaval and Sasha
