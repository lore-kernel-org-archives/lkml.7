Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D25C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6B206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAK16tvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfDDKyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:54:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37170 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfDDKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:54:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so1498260oif.4;
        Thu, 04 Apr 2019 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mNKRYI724wU2ua8Lfa1mKNeq0ZvZ3joRQVVPoI0gIHI=;
        b=SAK16tvdBcDUFOiK0AOv5qY8lw6iSQKIMVknSm5kIQ2HLk2oWFe8H2GCBXbdAy4Bt5
         1K1EBPsFG6009u+vzyoYApZRjiTHgoX3h8sncYkoAekmA348v8d81miR5iIiNozYLVwu
         yc5Mf04canylWe5jgMF04goRQEvIm2ZB3R4ms1GJlnuzgQ6kB30SXNjXywKVcdlFkr7k
         Cd6phMUsUBD66OtGF1bZhTgXdYa+dY1aIz4y6Lzp6UVOXyPKhOq5ITIRMAjj+JgAxUsQ
         5yV4euMkCBlOe8LHjhDuUD4oP3q2+77W5y5odj1x2VAtWfIejUsW9o2UyNIMvkVWi1K6
         Okyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mNKRYI724wU2ua8Lfa1mKNeq0ZvZ3joRQVVPoI0gIHI=;
        b=E07metHUYfj5vnIPqiRNiFjtuD1jRM+GrDnNjtuN158/6b/zIutVYHAQ0YAPZ4XnMo
         YNunzm7zx1IlMqZOtRWcV9D6jLYxCau9HDdKF266aEeibVhxO672oFJDPqJXetA92wAP
         Zp3QaUEN5IxvX7yuUGPXCD4mh2/84vgUn/oQ3LTjEkrP9PkBkIPPfoDMwfMFzNocwAd4
         rifVPc0U34mRZK8kZA2RDS1Vr3pVhPDFC9qgHGDHrZi9Ur9nRaTRSoYT5lzixjs7d1/Y
         LfZnpqSBfo5a88JMuTry9cVgwoizKWTBeltlECjL2iIhleIX+c3u23/0fKVuWSZvOCRh
         Oq8Q==
X-Gm-Message-State: APjAAAXvvBaNSSKc1NFQJTB5bW2yaCOLSABgj4FD/FohYVt900J6gPPL
        fB99po47txDxn4z2WlVHwvAyYLioMBdVextXnEo=
X-Google-Smtp-Source: APXvYqysGmkcALA4vogJEgmghDFBvjeP2+7t8dBOGAh4CWSMUvK4FXK9mqsqmX8CdLvPp3SRLFGRJDPsvxKUI0n2+1I=
X-Received: by 2002:aca:61d6:: with SMTP id v205mr2860978oib.122.1554375288745;
 Thu, 04 Apr 2019 03:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com> <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org> <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
 <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
In-Reply-To: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Reply-To: ego@linux.vnet.ibm.com
From:   Gautham R Shenoy <ego.lkml@gmail.com>
Date:   Thu, 4 Apr 2019 16:24:37 +0530
Message-ID: <CAHZ_5WzRn-Q-E8X-_dmyn14gp1Go2LNbceNNuYnbpEcgpM-1Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Abhishek <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, ego@linux.vnet.ibm.com,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On Thu, Apr 4, 2019 at 3:52 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Abhishek,
>
> thanks for taking the time to test the different scenario and give us
> the numbers.
>
> On 01/04/2019 07:11, Abhishek wrote:
> >

[.. snip..]

>
> >>>> In case of POWER, this is problematic, when the predicted state in the
> >>>> aforementioned scenario is a lite stop state, as such lite states will
> >>>> inhibit SMT folding, thereby depriving the other threads in the core
> >>>> from
> >>>> using the core resources.
>
> I can understand an idle state can prevent other threads to use the core
> resources. But why a deeper idle state does not prevent this also?

On POWER9, we have the following classes of platform idle states
(called stop states)

lite    : These do not lose any context including the user context. In
this state
           GPRs are also preserved (stop0_lite)

shallow : These lose user context,but not the hypervisor context. So
GPRs are lost but
               not SPRs. (stop0, stop1, stop2)

deep: These lose hypervisor context. (stop4, stop5)

In the case of lite stop state, only instruction dispatch on the CPU thread
is paused. The thread does not  give up its registers set in this state for the
use of its busy sibling threads in the core.  Hence, SMT folding does not
happen in this state.

With respect to shallow and deep states, not only is the instruction dispatch
paused, it also gives up its registers set for the other siblings to use
These stop states are beneficial for SMT folding.

Hence, if a CPU thread remains in a lite state for too long,
its siblings in the core would not be able to utilize the full resources
of the core for that duration, thereby inhibiting single
thread performance. This is not the case with non-lite states.

-- 
Thanks and Regards
gautham.
