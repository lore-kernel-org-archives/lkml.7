Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E2C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6B120833
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFOJeEv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfDTSZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:25:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfDTSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:25:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so3894063pfr.4;
        Sat, 20 Apr 2019 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ8y5mFIdqzNGUZnBmwx5iymSgQ29DHWCnuYeuYo1Ec=;
        b=GFOJeEv59ua6iGd/j2LVfsUt6QYblkOI46WHT80ZW5j80yCfI0wnhpE59N/u2G0gJq
         qCzB/8Jv/oLZZsiiWUZBonLHG5NwiJvUmPcSjzZ9JqLMEGgGgD1OLSWLCKjpp5SOUoeY
         LJ+EWOpJ81N5AEmB/Tv03jeKMw8fWGZqR9aB5h7fGiK3t+SEbIOY/ybMfPPbYYT7Y1x9
         XabXipFFCYdPQb2dJstupPlAqnmFu4ck89b4gqJkask1mnlguukWvgS/dqqCfAHDab7r
         SZyXwmTmbjmRSnQgSvZ1vgSgUGIVVuvOfWT7qZ9SYCQmmoOa2e0xg8TinJ3bT+bMwJXd
         S3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ8y5mFIdqzNGUZnBmwx5iymSgQ29DHWCnuYeuYo1Ec=;
        b=NvaM1p6rKjPaPXpmcOmKN+lpm96VBIWA1TejtHbWVhh87hIX371etbYOzNGwJQl/2t
         NbPlnFOq0Wg3qRSa6nO7wnyTNJzxcsG/oMSWJkprSWMBUemlYROeSe924UND9OBO4YFl
         zPiD6Y244lLasYX+xidDjVaIbEjGQG3HEgV8p4b5UREL3uRwJC6316/qAfmAbsDhUVCw
         2LHmGYvlHC6ZfFbMA+Sy6I0rSOvq+H5XeF8dLPt1qVXeo5YPLq3dlmm6xPrL0bs9UQr2
         MzTP2y1OkAAJye2W2VhsxQtBXoPPQih6WVII+VH4aKUbZ1J0PuRkY7dJfSTtV4ejUBGq
         Lc3w==
X-Gm-Message-State: APjAAAVsdAdGIV5cwmQMXiajYdOfxiHTXOXEOulDyaYRIu58uS9ECvgy
        CuJvaNF3V7l9Ot3wDfZ8xh/eqyeX5K5ldMrrQH4hS2+Y
X-Google-Smtp-Source: APXvYqwdzMJNgm/3LSQApJzlLtz4G8JbfUBlMc1t1GWT1Op99cYYnm8DfzBWXJXZt1HMnoNnuvF3ZZ+O3SoeWDJ1q+k=
X-Received: by 2002:aa7:8092:: with SMTP id v18mr10914137pff.35.1555784754834;
 Sat, 20 Apr 2019 11:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
 <20190416214634.GP31772@zn.tnic> <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
 <20190420113444.GC29704@zn.tnic>
In-Reply-To: <20190420113444.GC29704@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 20 Apr 2019 11:25:43 -0700
Message-ID: <CAM_iQpXKWDr4AbROO=ZbkxwQHkj4anA9FJAaohOqg1SCq0L7eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 4:34 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 16, 2019 at 04:16:08PM -0700, Cong Wang wrote:
> > It is actually fairly easy:
> >
> > 1) Fill the whole page with PFN's:
> > for i in `seq 0 511`; do echo $i >> /sys/kernel/debug/ras/cec/pfn; done
> >
> > 2) Set thresh to 1 in order to trigger the deletion:
> > echo 1 > /sys/kernel/debug/ras/cec/count_threshold
> >
> > 3) Repeatedly add and remove the last element:
> > echo 512 >> /sys/kernel/debug/ras/cec/pfn
> > (until you get a crash.)
>
> Thanks, I was able to reproduce with that. Below is a conglomerate patch
> which converts __find_elem() to using Donald Knuth's binary search
> version. I don't know what I was thinking then and why I didn't use
> it from the get-go. The textbook even says that one can easily get it
> wrong...

If you want to go that far, you can choose to use lib/bsearch.c too in
case you want to reinvent the wheel.

What's your point here? You know my fix is targeted for -stable, I doubt
your 83-line change could fit for -stable.

Feel free to drop my patch to favor yours. I am really tired.

Good luck with that!

Thanks.
