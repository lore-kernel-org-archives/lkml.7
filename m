Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD345C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C8A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfCKWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:36:37 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35779 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfCKWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:36:37 -0400
Received: by mail-pf1-f181.google.com with SMTP id j5so313230pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 15:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTSLkO2dt0jTP41e0HX+zZNoDtNdiga3jBAnHIfBWR8=;
        b=HptzQuhaRYPUAKJbDoKaM1yu+MoeT0/T3sCt3vraAxisPvfaYaNRu7n1+Z15ZZQkyy
         GWCQdr4JvrNByGweMK7Xv9vJbbJMzDnb4o9QNEaQVHu8iNKjB1GykkwNBmQ4x3zVUdNJ
         JNg38IQ4MPhmi/xddPTTfH0/M1vUenaFh9vZuU3arqCFWpnzjGtbQlPCn1OqrQrnjnPc
         C0z/1olDCAVgVKeWi4qIAWAamYlDn1h4VWMVmKzmNdgi/1Z+s/tSG85SH1eY1tHeUV0D
         BlzXZvsZUeUh7FRaWfXCevy1xFhEJcZeYqm5GHRHlhe02Vo19QoCGUqm+XLRmBIUkovQ
         PFYw==
X-Gm-Message-State: APjAAAXuvKNdd8l5Hpz59lgn75uxlDmehRTouHSUcH53vwySEbOJnCac
        t+PmNbKaBW/6yKXZ9OdnXIxvio0nF6Y=
X-Google-Smtp-Source: APXvYqwtCMMAgm1ExGxRZdQlC7xQXFp1fcMVya1tiDe1OLHW4XIgMQjZPtO8FWjJfPY2Gx+joy0m+g==
X-Received: by 2002:a62:2ad1:: with SMTP id q200mr34726914pfq.34.1552343796423;
        Mon, 11 Mar 2019 15:36:36 -0700 (PDT)
Received: from sultan-box.localdomain (campus-061-148.ucdavis.edu. [168.150.61.148])
        by smtp.gmail.com with ESMTPSA id g67sm16424983pfg.13.2019.03.11.15.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:36:35 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:36:31 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190311223631.GA872@sultan-box.localdomain>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:15:35PM -0700, Suren Baghdasaryan wrote:
> This what LMKD currently is - a userspace RT process.
> My point was that this page allocation queue that you implemented
> can't be implemented in userspace, at least not without extensive
> communication with kernel.

Oh, that's easy to address. My page allocation queue and the decision on when to
kill a process are orthogonal. In fact, the page allocation queue could be
touched up a bit to factor in the issues Michal mentioned, and it can be
implemented as an improvement to the existing OOM killer. The point of it is
just to ensure that page allocation requests that have gone OOM are given
priority over other allocation requests when free pages start to trickle in.

Userspace doesn't need to know about the page allocation queue, and the queue is
not necessary to implement the method of determining when to kill processes that
I've proposed. It's an optimization, not a necessity.

Thanks,
Sultan
