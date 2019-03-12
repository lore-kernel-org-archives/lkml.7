Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31C821734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eICtM3WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfCLRmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:42:44 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35215 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfCLRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:55 -0400
Received: by mail-wm1-f54.google.com with SMTP id y15so3508129wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJNmxFq4kvtgDMxGW5EQZmwTBHXCE8cD8UO0j6EqecE=;
        b=eICtM3WJdg7Bq7C7keVDYg0CrinSY8xGGeQG45rEmu59uiZfjFMczd9uA/UYhoAK+g
         hCH2sfdCvx95nRGUSuHYhXxnYObCMQL27F3dvIFV/nD0pkzS+RWsuLvO20H3uohxUK8Q
         bFWGc02dYBQDpx9KIr9IkMTpmmOLw6OjlJlPjDrBDeBbHlAJFaklVRj5VOu0U31Btj3D
         Y2PvQxG1UvzKcsj7by517lkcVQ00sM0No4sycN/PgwxHIT9WthtTO4uSpYByiS94nf9g
         UJ6r3xqwjS105/10FTzY8I8djkMo+4TPDnzH9B4ZzIGH0kaWVK0ouPit1AgkSDsEVjT0
         4K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJNmxFq4kvtgDMxGW5EQZmwTBHXCE8cD8UO0j6EqecE=;
        b=NghbaTMhb5AqeRI5htT7nYTF8qtt8rg6TqsO078qkO1Br6c2jmeIxSVVHmyAbsRE3r
         9/1EuPSWAhpjYywoEUW9S/9rGd2lMs2ELaNBv5sRothT5afPxn5tpWMc26zJE+oIyRB2
         TscW0qKVW9wA267b/H4NZzMlybvaXcxFu/QAYt2TEmUxpMlBlESr865s2u4mqlafAme6
         YxD5fImQ53ge58BZimldZ8b8rak5DZmY41EP46aClFs23o0JsGUMKeQj0aLrKiRFx+Ay
         G2fB2AJdG82Z4SKEw1Xl5P/tKcS4VyxpQr+GnFa0EQ2eEDqofYOjd7rWInEIoUmLysvM
         YX6w==
X-Gm-Message-State: APjAAAXMSIT2Zz7xFsyl31KTFv3MSeWe1s07uf+aCr/L4/VkexVUi5JS
        Jor2hkfpMjEqu+6Qn1S2HrljPlxzklii6XRCK+cuMg==
X-Google-Smtp-Source: APXvYqx87Bwal2xirLDgWzJL461s60oU++NHtJORE9GT9nlzsH1PR8HvbGpV44aPviSqK/l38j0DtUaUXf28zAVP9qA=
X-Received: by 2002:a05:600c:2115:: with SMTP id u21mr3406355wml.70.1552410952458;
 Tue, 12 Mar 2019 10:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
 <20190312165805.GF5721@dhcp22.suse.cz>
In-Reply-To: <20190312165805.GF5721@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Mar 2019 10:15:40 -0700
Message-ID: <CAJuCfpH9emgP=iaMy2_BEJ6HT3vvrvoeqTrCUXeBBD9VNR99kA@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 9:58 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 12-03-19 09:37:41, Sultan Alsawaf wrote:
> > I have not had a chance to look at PSI yet, but
> > unless a PSI-enabled solution allows allocations to reach the same point as when
> > the OOM killer is invoked (which is contradictory to what it sets out to do),

LMK's job is to relieve memory pressure before we reach the boiling
point at which OOM killer has to be invoked. If we wait that long it
will definitely affect user experience. There might be usecases when
you might not care about this but on interactive systems like Android
it is important.

> > then it cannot take advantage of all of the alternative memory-reclaim means
> > employed in the slowpath, and will result in killing a process before it is
> > _really_ necessary.

I guess it's a matter of defining when is it _really_ necessary to
kill. In Android case that should be when the user starts suffering
from the delays caused by memory contention and that delay is exactly
what PSI is measuring.

> One more note. The above is true, but you can also hit one of the
> thrashing reclaim behaviors and reclaim last few pages again and again
> with the whole system really sluggish. That is what PSI is trying to
> help with.
> --
> Michal Hocko
> SUSE Labs
