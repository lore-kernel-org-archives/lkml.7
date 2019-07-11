Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA9C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D922206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562818165;
	bh=Ym3n8jRzdjRqnT2GCor1LFlaraDjpj9VTC8nLFjcZjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kn1Ofjy1QlLkFFeuXhpcsWzDBtSMvedPrX8tHMsYhKfF9dtSwYwOimopYsakvUEMB
	 B9bQW0QAf66EDjQzKZNrqMqZ+Pcnqpu1eqpSFa0eYucWlEFWo9SzhRpNdw7W10G4Dd
	 tnfmDRixl/Bca3ILN7RpVooVPW3OLkeQmcIoACrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfGKEFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:05:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41528 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKEFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:05:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so4258557ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 21:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivXca3Gb9/zTO7q/9/U54gRp2T9PacTOB52zjf3jsNU=;
        b=QLvdrDmJy3ZnMYBqiUOQ3BhTTrN7ku0cSrkdkkyoW1TO4NyodhO+MOUpoEtGsMQFOw
         oKgwUM3SU4gNU5tsUh74VCcm6nshUHvwe6/fzGRqKIxp01OGKbZAlDQ2dJYQHwhsGbgz
         glw/52VxxTHQHAST+uSKatrkUycbT8iSDlovw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivXca3Gb9/zTO7q/9/U54gRp2T9PacTOB52zjf3jsNU=;
        b=oZIGffa1CuRJSx1Aj2fzy4gFuEFlGnTPPaBeM/+TSI0rBAQREqWmRJdUH2bTNRvwd6
         xns58ZZ1PEoWvKg+2PrvpjTjNCphONLHYhhlS903BwEqLIFdOk7W+gHdtVYfoMKtxSQj
         zqGfyCQXxdaHHUkkPmjDYxk9qtpmI2jpLsMMy2JyeiTMvY7Cu14//1rsg/MEjnh+fM5X
         oVP1mTN/FtfFJbTHYkkhrZaLDMnot9Ara0pe2TyVGNu7O77n+rcePk/RUyYGyQDvQurn
         ywIFIv/CK2dRcj5rKITlK2aalqGw6snw/G8n9/ncfmxSlNdSvy5MJO2PFPVc5mNwxWig
         2STA==
X-Gm-Message-State: APjAAAWP1PLdA/gjo6zxzBiUdJ5jGL6wubTtgbYcjOlY3CgjANjdQVfI
        T5QQHl0zfLx7EZQYNYOcSZgmHL7g4fM=
X-Google-Smtp-Source: APXvYqx4a6DbxJcRP0e96sO5i98bsAod+bvHIBydiTviYaMTvk7eWmMGkgCs0Nt5rrICoIv5b2AIDg==
X-Received: by 2002:a05:651c:95:: with SMTP id 21mr1005776ljq.128.1562817939065;
        Wed, 10 Jul 2019 21:05:39 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v2sm583766lfi.3.2019.07.10.21.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 21:05:38 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r15so3027155lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 21:05:37 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr563513lfn.52.1562817937331;
 Wed, 10 Jul 2019 21:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190709165725.GA2190@redhat.com>
In-Reply-To: <20190709165725.GA2190@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 21:05:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj00gDz=tX-b5C-xwdogZSaKtRJEDh3SGB69D8W+Wsr2Q@mail.gmail.com>
Message-ID: <CAHk-=wj00gDz=tX-b5C-xwdogZSaKtRJEDh3SGB69D8W+Wsr2Q@mail.gmail.com>
Subject: Re: [GIT PULL] dlm updates for 5.3
To:     David Teigland <teigland@redhat.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 9:57 AM David Teigland <teigland@redhat.com> wrote:
>
> Apart from a couple trivial fixes, the more notable fix makes the dlm
> continuing waiting for a user space result if a signal interrupts the
> wait event.

What? No.

That's not sensible at all.

If wait_event_interruptible() returns -ERESTARTSYS, it means that we
have a signal pending.

And if we have a signal pending, then you can't go back and call
wait_event_interruptible() in a loop, because the signal will
*continue* to be pending, so now your "wait event" becomes a kernel
busy loop.

If you don't want to react to signals, then you shouldn't use the
"interruptible()" version of wait-event.

I'm not pulling this. Because the code looks completely and utterly wrong to me.

Am I missing something? Feel free to educate me and re-submit.

               Linus
