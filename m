Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6769C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0E02186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554506879;
	bh=mcMU/aR5oZbRK0/am6slSOCd1xOeWPOoK4B1OWce+8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y97UlaiwdEimi5MrPqhzwAcjnG4ORFZg8PoL8Xxl8w2zZlYwfLApB5uccgl5vmjz/
	 i3v+Zco3bcrMyvwDEPAcjm87WHdKEbgbRJvSzgMrYXF1AM8wisvv1Pw0eIVjlct0lD
	 oC53yDBhDCmZk+fkhOLj84LOUxbU6pqkuUJAVhSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDEX16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:27:58 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37283 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:27:57 -0400
Received: by mail-lj1-f173.google.com with SMTP id v13so6615586ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tA287do+ksgXuZoWPDuYwT6K5d2oSYrqKqVAiowrrk=;
        b=Gx97GmyyBEPz3pcEPwO5yCGkAW096HaSQe+zapmwu96uid7q/L9lnyXZqXmAKmrcek
         Y3XogV9K6+Sd/rJb/JI2/Hi3Bc7efV4mblqLeHY5tOiAAmuuAwkJ8fEi1S/7yxCAi9w7
         a48d+7SpS9vZk0/3y/uRLTIPEoh6EPEy8PvCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tA287do+ksgXuZoWPDuYwT6K5d2oSYrqKqVAiowrrk=;
        b=a6h5BQBuJmFjnUz6TkKAGWB2Fa4GRugBxapunZFVzlV26RfWDE5dBTvq/8tcKBV3wT
         nVpFxgpH7aVnqEF7ZcSCXWwjjg90OUaLQVc16oLG6qHDdEE6CrSlGDImFq82uLOppRcG
         06fOGgmoX1+Z9UaDYoyRYxMPUs8eDQoTxljdUco1sF5oYCwwWigEoSEiuZYWEcBMlxSo
         6bDTsic7+v384cvCD9lzoXknH3pfdJ/nuTGegRRbldqobAwJrtjfuhlSfw10pEJm5tmj
         OaY4GlPTE7oHhlDAw0x68DLR5p0iGi996ZjblKT99ttskTpF9n1vx5ZY/4E0bW2ENTTt
         eW0A==
X-Gm-Message-State: APjAAAXfq0VfP3Wdqn1K4oNt/a0HTG8COtNEYuAyR4BeWDCVFPcAkXXy
        hIa7xCf2npiCxDIiPRI8g8Bsk1zehDU=
X-Google-Smtp-Source: APXvYqwzht1jSdHz+h6zhkNOuwWQkPEmWt957Vf/WZSfDAkI67aNOYUYp+pAshQgOmcgk6pzbWylQA==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr8456382ljk.78.1554506875586;
        Fri, 05 Apr 2019 16:27:55 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q77sm4678612lje.11.2019.04.05.16.27.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 16:27:54 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a6so5531097lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 16:27:53 -0700 (PDT)
X-Received: by 2002:ac2:485a:: with SMTP id 26mr8165931lfy.128.1554506873595;
 Fri, 05 Apr 2019 16:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190405192115.17416-1-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Apr 2019 13:27:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgnPRBy_YkY771qdetwViEZ8uWwZpjxAOs_UsvzRV3rpQ@mail.gmail.com>
Message-ID: <CAHk-=wgnPRBy_YkY771qdetwViEZ8uWwZpjxAOs_UsvzRV3rpQ@mail.gmail.com>
Subject: Re: [PATCH-tip v2 00/12] locking/rwsem: Rwsem rearchitecture part 2
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:22 AM Waiman Long <longman@redhat.com> wrote:
>
>  v2:
>   - Move the negative reader count checking patch (patch 12->10)
>     forward to before the merge owner to count patch as suggested by
>     Linus & expand the comment.

All looks good to me now.

I didn't apply and _test_ any of the patches, but they look sane and
the numbers you quote are compelling.

So ack as far as I'm concerned,

                   Linus
