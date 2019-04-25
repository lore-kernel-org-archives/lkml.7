Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C46B20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209102;
	bh=zamRLXKfkzICTGniLb03igNRexnwV0E5eyIL06U8vtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tVU3ZKQkNH7bhfEKsruhkCs3/Hp0J4+THzvneulHtESbQC+oToVoT2xKakLONSbOp
	 9rH5eNU3bAC+ZJh5078wEv7DWhJo81Mh48mlLIfgqQSx+CQS9Av6Uie03J54AWOY5r
	 2fpnAwyiR63SdRdUtGKZvIehmCQ0L2wzR8IPRfUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfDYQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:18:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34044 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:18:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id h5so240235lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O4VW8mQDLcOJ0Dh9dE0eUcZoFoMBse1+JE4GCdloxiQ=;
        b=DdQHhZ+r9zygTgQ2vKf4L3eyggX+xGPAx6vxZOEDsSWSM2NaEoXiO6ZRQA/UG8BjFR
         edXmnnOlC/BU4AAsuGHsL6MbA4ian8qX7DiiW03a8dIsAYHBKJ3xo9qOyQnHrQ+1ZSs9
         Ma23tQlBFpDvSJWfpfSPizVwFgzlJLHew5QaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O4VW8mQDLcOJ0Dh9dE0eUcZoFoMBse1+JE4GCdloxiQ=;
        b=rro4RfN/H2nYNyfWKBTqK1cBOsAh679qSO6Gg+2AZw1YiG+AsLuOoo4VwD5A9/GFdv
         p1/9+03a8KNNS+4u8o3yacxbpfG8L9y5m08fuygzNMteB7Z2jFCZn5VFUb3HJTuC2q7B
         c64jsmC1zYEJa8I1CtFenwcGI932lWe4elCZ2RTopE5vuH4IcgTvu7AUYSRpbWLRmj+o
         /rmE6rQ8OxUwO/+aNKG7F0EaVr9dKxZ6jT1TybbDIWDCivOMv3MQYuwn+b3HkWCvFEBJ
         yqBkSVcXRHWmwWfZS3fNoYBGymph4vLSRCSqgJi9kGVmyLH1zs1nhax16OZg2Om+ne9P
         Iufg==
X-Gm-Message-State: APjAAAXHATws0OcjtwJn8q3KkCylBr09Oiv1lBTvGzzGCYdhH06R95T5
        Ayk8FfiMVx3ZzqVWd4WlfoVV4N2/cg4=
X-Google-Smtp-Source: APXvYqyKYSK+JS2rsexPoMEgWRFANmfEov/BHOtuQN3EG++4tAkGedPdN7iDXZB8DM7ty/AY25JMUQ==
X-Received: by 2002:a19:b83:: with SMTP id 125mr6046467lfl.84.1556209097758;
        Thu, 25 Apr 2019 09:18:17 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m28sm5116043lfc.71.2019.04.25.09.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:18:17 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p14so173944ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:18:17 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr19497751ljj.79.1556208755990;
 Thu, 25 Apr 2019 09:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190424123656.484227701@infradead.org> <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop> <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
In-Reply-To: <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 09:12:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoWikSJTdy294Mx-4ZyeZOFNCtaHGC_9xOcpCz8rjVFg@mail.gmail.com>
Message-ID: <CAHk-=wjoWikSJTdy294Mx-4ZyeZOFNCtaHGC_9xOcpCz8rjVFg@mail.gmail.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
To:     huangpei@loongson.cn
Cc:     Paul Burton <paul.burton@mips.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:59 PM <huangpei@loongson.cn> wrote:
>
> In one word=EF=BC=8C the bug only affect local cpu=E2=80=98s ll/sc operat=
ion, and affect MP system.
>
> If local_t is only ll/sc manipulated by current CPU=EF=BC=8C then no need=
 fix it.

As to the whole MP vs UP issue:

Is this "guaranteed no problem on UP" true even in the presence of
DMA? I'm _hoping_ some MIPS chips are starting to be coherent with DMA
(but maybe DMA never participates in any coherency traffic that could
trigger the bug even if the DMA _were_ to be coherent?).

Also, as Peter mentioned, we do depend on ll/sc also reacting to
interrupts - again including on UP systems, of course. I assume that's
always handled correctly, and that an interrupt will set the right
state that the SC will not succeed?

Finally, it worries me a bit that the loongson_llsc_mb() things are
all at the C level, so who knows what compiler behavior you'll see
between the ll/sc inline asm, and the loongson_llsc_mb() generation.
Hopefully not a lot (and presumably mostly just stack reloads etc that
probably don't change any cache state), but I do wonder if the
loongson quirk should be *inside* the asm rather than separate.

                  Linus
