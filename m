Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED586C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F1D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UTQUhcEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfEUNYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:24:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34156 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:24:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id l17so16318790otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRqM/fo2M22HfK1yd2xZk4oUzdYSt76QFJebCVErlJY=;
        b=UTQUhcEX7/X5ApzqT2hbojHbZQM4ASXo3x2bK9x2oa0mob9do0b6nZc5qWBspjeBD4
         Uic7YfUS4IZ7NGgvj+A9XZRPZ4NMo1CWIYbe5F9PNcVN996kQs5eW7c0XmJlyKTCi7lo
         3xdDtsBhoYlQoyMbfvmNExpxJXnIyOVw+FDpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRqM/fo2M22HfK1yd2xZk4oUzdYSt76QFJebCVErlJY=;
        b=hqldxMZUmv7lCERKPOGFNcS2EPPzzoVo/54oZ+sdGk4CtZYHN+rzUVBy3AaBZ3e1NC
         ERq9HnECAaOkkR/69LmI27ItUb5wUZg8d4QhEGvbL5fATMpf31SBcu5bjWnjhDhRXU+Y
         MdiNQSWZYfJVEr5wnHhu6uT2cBl6IgMfHrJOmi5LoyV71eyuqbRzQlriug5/b2+u/Ihj
         sBJsGi6+aIjHvDGHlw57GQBupGEdie3qjGMaVBB2VEp51SXZdGMnsdKKVaIMdOIMtncn
         fVkYe/m2wmSfm0m5u3B5Yh0lTsHAj7IYec94IouH6pW5hI2xi2ug7avmLtV85LtEIqPF
         r2Xw==
X-Gm-Message-State: APjAAAV6lIFhli/wqm+CNn9zziYHwFhHhP8D6ub3NG76wOrU8Gz93s5w
        C/JS7VlUU0ppoX+XJpSCUQSRTjhzIGbP4YghLzykQw==
X-Google-Smtp-Source: APXvYqxz+Op98WpP0iRUy6MkWY6kShi4rUCR0VitlHaRC510/Ii1oV/MfZjUS0Hm81MGNLdWZa+3EfTXcaP7vsFCwvg=
X-Received: by 2002:a9d:538b:: with SMTP id w11mr3702166otg.154.1558445076881;
 Tue, 21 May 2019 06:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <edd4c014e69b68b90160766c6049f2ed922793c7.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtZo0BQg_u9ZPNY_Rk2JY4YT8d5NDRKFQMWeYyAviVShA@mail.gmail.com>
 <20190520130454.GA677@pauld.bos.csb> <CANaguZA1Ujahr78wt4pxnLzR_in47_EXvxMQLWrP4NS3mpP91g@mail.gmail.com>
 <CAERHkrtaEEO69ZsDfy8mcU=H_gTFRuTeoKTC0Bc1pUeD7Z3fqw@mail.gmail.com>
In-Reply-To: <CAERHkrtaEEO69ZsDfy8mcU=H_gTFRuTeoKTC0Bc1pUeD7Z3fqw@mail.gmail.com>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Tue, 21 May 2019 09:24:25 -0400
Message-ID: <CANaguZAhbd5VarCJDo6ehOz-hf_gBzgJcetxphC1V5aZtuTc-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/17] sched: Add core wide task selection and scheduling.
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please try this and see how it compares with the vanilla v2. I think its
> > time for a v3 now and we shall be posting it soon after some more
> > testing and benchmarking.
>
> Is there any potential change between pre v3 and v3? I prefer working
> based on v3 so that everyone are on the same page.
>
Makes sense, testing can wait until v3 is posted. I don't expect many
changes from above, but its better to test on the posted v3.

Thanks,
