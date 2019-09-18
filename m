Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A1821848
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKK1qSzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbfIRWQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:16:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42099 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbfIRWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:16:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so796518lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3ImQjl8Bf9jLInH/+f6JGq3h0AOejxnjsmvVuyngAM=;
        b=RKK1qSzXcw8nfpCul5nupa4ZUBO1Y7GY0JTBdWrwakLE604w2CBOjGfsePhNWrVYyF
         R5d/XORp1yR60ov/ZBaeu9qHNFEOhfa0ow4nTJvxkXUNZ4kqli3/WVAE0NoN7WPkxijV
         7ezaKX1BfMeOjjgDDy8wa7G+ZK3KeAL30tAOMdZ3R7Hwa3vrb/eSihW3joyJeWNtiFdp
         25nEUKyFShdg8Obr0foI6KL5Ik0pzt/KMQCCyfZVw5BHQWTy2TkA9HtkTkmB+6PDtPR4
         GhjylE9bPeb2sDXlGGCbxji9wHku8GEiabRtyqGAbW/JHFiF/6mEHDtQtbrrgNwQ2bA/
         ZgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3ImQjl8Bf9jLInH/+f6JGq3h0AOejxnjsmvVuyngAM=;
        b=BDfC+1mlgGZkBiXUqbtZbk6EAAHCbzUh4nlcSfkH5bPO3cenNtf/tVkfIf7d5PWIWR
         aYS2Le+wjNco0zbgjYsoIYrfupR3pK61AETnMC/VP8280ONbFZaxJDWh0UQQfONHUD5X
         ZQLI2bc6zjCK+FHRMZHNXUiRvnm0d6JyjM33U3uqOj+7On+X0IYmYJOR7LdAsOFTta82
         6FPlyS6QUJahhPFTdYfq70RG2QAzuKHHnVEpPyFtKxPatqI8idy/OF3+i1QKe5x/1ePW
         hanASW6u9XSPU/26vSGxmbbHv+MFtYlEnZ/s3BweOpoF3SJdEQGvV5eMllaUoktEQMzy
         tZQg==
X-Gm-Message-State: APjAAAUPGcVklkGMZRySTCVRLHb/Jpql39C69kLp8lhZxna8PfUG+vjc
        vEiF9U61jEBqK6X++NSHv0EzlevD9bUVg9SuQ8E=
X-Google-Smtp-Source: APXvYqyDqHu54xwsarhdn5wx/w3CVipKz10T3K65N3SpREA/RbxSM2ScLegw8Pv6upPTJFIkkZHZd/XZQgsYXlSFIhQ=
X-Received: by 2002:ac2:4ad9:: with SMTP id m25mr3265664lfp.89.1568844987143;
 Wed, 18 Sep 2019 15:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152101.GA27884@sinkpad> <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad> <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com> <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu> <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu> <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
 <20190915141402.GA1349@aaronlu> <CAERHkrs9u24NrcNUwHq8mTW922Ffhy9rPkBGVN_afm1RBhabsQ@mail.gmail.com>
 <ade66e6d-cc52-4575-2f8f-e4d96c07a33c@linux.intel.com>
In-Reply-To: <ade66e6d-cc52-4575-2f8f-e4d96c07a33c@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 19 Sep 2019 06:16:15 +0800
Message-ID: <CAERHkrsW8conSUNbbmAD7AHyRTGy=80QUiJAsx_LaJDNQoZ35g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 4:41 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 9/17/19 6:33 PM, Aubrey Li wrote:
> > On Sun, Sep 15, 2019 at 10:14 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> >>
> >> And I have pushed Tim's branch to:
> >> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim
> >>
> >> Mine:
> >> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-core_vruntime
>
>
> Aubrey,
>
> Thanks for testing with your set up.
>
> I think the test that's of interest is to see my load balancing added on top
> of Aaron's fairness patch, instead of using my previous version of
> forced idle approach in coresched-v3-v5.1.5-test-tim branch.
>

I'm trying to figure out a way to solve fairness only(not include task
placement),
So @Vineeth - if everyone is okay with Aaron's fairness patch, maybe
we should have a v4?

Thanks,
-Aubrey
