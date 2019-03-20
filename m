Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F70217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDLpFhHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCTCCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:02:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43192 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTCCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:02:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so8431026qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 19:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy+jMGYRiXfngc84bG5ClaHuiAX+PAoEVMhiyw2k2rk=;
        b=BDLpFhHM2K+aOMgLRaBP3ux0fxo+n2D8dZnWQtTBgXBXJ1MATodbKQTctylT7WBPb+
         4hhomE27WuFaMsmqBLdYns1YDzJHLpvfTSS2zhjrOnx7E/Xh8aCMooZcofiSW4G3Ahds
         wj5KF9JaZ9bd2uHAuh3teiZuGeB/ZwGrruaOrHt83tmgWStzkdXkKndMLyQLt9IraKs5
         w+AoebdW18xYVDYe/oTvKsP2dFpQOrgLZNMKIFaYaAiY2WO8Vvy7Y8grFPZU7M9TqG2w
         dgGy02I0waeWgMOz1JTJNTwRJ+WSyA1XCHSu3BZ+xtHPo8HLHU1IMDUwqDh5Nix8fEap
         Fpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy+jMGYRiXfngc84bG5ClaHuiAX+PAoEVMhiyw2k2rk=;
        b=hVE9hgGPP1HfwRQ+sXrKr864+Kp/5nMyZyDB2GtHFs8Na7ZD872LpVxfgiR6BghxMt
         LSypUn6XgRoX+TDv6KwCD4DhFk+2hlZTPuYKp1GmC5d8TxMxH00nsjs03hA+th9QdBwl
         ZA5dcbn9PupI6CBc6CFZZ1uK1auVKCA4x9pixNiRi57PEpOYp6O+adJdx+/FbvQEpSwf
         yC32xB1sBeb1CaHuBsrP5hSvaSG13SlZjsttZJ8IwjnKVZjDxsYP3H6qoF2g83kt7P9I
         oXXjFPN5dKTi7AKcz+BycCjaE1fHo25M5tr/voyxrSGXMbzO3InDBDM2Br5PJD/0Myty
         lcuQ==
X-Gm-Message-State: APjAAAUxLJew1d43Yzx807UHr40q8/uX1jZE4ZZveLeukVKeipKPbP5t
        /5wFLUcjTO/wUqtROYdfT5soii1jyCG6PBlU1UY=
X-Google-Smtp-Source: APXvYqyZVU9OsGZm31L3XkccWIZ4CHzbsaOmXHE2yK7R1dxhApQCGdn+EMiwiuBmh+IJgcln4kiNAgFDqOC/xU60cB8=
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr4424829qkj.173.1553047339011;
 Tue, 19 Mar 2019 19:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190318085733.3143-1-duyuyang@gmail.com> <20190318085733.3143-20-duyuyang@gmail.com>
 <1553012967.152266.48.camel@acm.org>
In-Reply-To: <1553012967.152266.48.camel@acm.org>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 20 Mar 2019 10:02:07 +0800
Message-ID: <CAHttsrbm_rWkMHDUqiSV+74ctRYB2ymkT9JbgWsFfvCxXP4yqg@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] locking/lockdep: Change if to else-if when
 checking bfs errors
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Wed, 20 Mar 2019 at 00:29, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> > -       if (ret < 0) {
> > +       if (unlikely(ret < 0)) {
> >                 print_bfs_bug(ret);
> >                 return 0;
> >         }
> > -       if (ret == 1)
> > +       else if (ret == 1)
> >                 return ret;
>
> Have you verified this patch series with checkpatch? Checkpatch should have
> reported that you are changing code that conforms to the coding style into
> code that does not conform to the kernel coding style. Checkpatch should have
> reported the following:
>
> "else is not generally useful after a break or return"

I didn't. And, these changes were done in a row; my not checking each
of them was careless.

Thanks,
Yuyang
