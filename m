Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92C205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557250547;
	bh=QpGCIYI22OmPrtKNZByqkY/eP0ucnMsjEQvSLHbvg1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vLRdIJo1mu05hBSQkYcxs3XjG0EMMc80VEEwUDS+p0XzBFCYvjz+DlupU7l7CsCe0
	 UgQ+iX2+G7AEKLlXF/gzHsW2iFYxW9rxzWyC1VLbzRBhp/QI+Vry/BcnWDDnW6sUZE
	 DKhEX/xsZKeuvkUrHqROhOpI41CnrudHR3DkeJtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfEGRfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:35:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34387 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGRfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:35:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id s7so9662103ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffMscuu3PUeSeZb5tEXYoJU5cfVCzk2YToQl4OvjLZo=;
        b=H36Gpb50r9djkhKtwQe3VJpRaLJw/NGSVDsmjM54fy8tMa/SUIs7pLVJp581T7Ys20
         8jaYXH5Sh569s93/hVFiq5rZNQH56hFJ256xdH0tmNKP7Bczg/VWm64TU4aXNw+s8jYx
         QPwg4iTwOqo5JQRRyAhG7MhENuqZqg3/ZjtCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffMscuu3PUeSeZb5tEXYoJU5cfVCzk2YToQl4OvjLZo=;
        b=avoNHA8uhHsme46qtZNDJqubeUWlcYtKDXP5vXpfKMhn8xXrQ1zk98+3UAjbtSMQNJ
         /VNV88i1IZeWVD7r1744jiyEMa6/dS3wZouzpZ/l18Su52ZOVWzXi72/NBE0hD0MFLQg
         Ck7+gl23bzuQ+uchjBOc0ED4wd74BcNnLLUHU+Wl8TDdpZ/+r8xgRn5kpESWPRpTaP9s
         sj/eRQe/PSl2YldGZtRjlkps695ZjW9HC214ogXxXmMtSB957QjbeEebzOHHIT4Pj4HU
         ycE0PziYJzgMGKgP4wJVGjDFNYTHWv56rEesGN+ShTTcMZnfJ3vTkyv4gPQlyk+lDMib
         pIzg==
X-Gm-Message-State: APjAAAUguZsQg4bkHafTkhYgKEcYWKyfthChkSHoQ6vyA2d/WvQeDia+
        fR0lfPdqEvxdiCJqbDT91i/dPV3S5gI=
X-Google-Smtp-Source: APXvYqwFJpJXFt96v/SD14kBNrxVfKAZLRK1VmtiPPnMg+AnbG9Y4epOcpzSkLsERghqOkMKe6tTBA==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr18474297lji.163.1557250543289;
        Tue, 07 May 2019 10:35:43 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a6sm538720lfi.89.2019.05.07.10.35.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:35:42 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d8so12449469lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:35:42 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr17155883lfl.67.1557250541931;
 Tue, 07 May 2019 10:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190507132632.GB26655@zn.tnic>
In-Reply-To: <20190507132632.GB26655@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 10:35:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
Message-ID: <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
To:     Borislav Petkov <bp@suse.de>
Cc:     Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 6:26 AM Borislav Petkov <bp@suse.de> wrote:
>
> This branch contains work started by Rik van Riel and brought to
> fruition by Sebastian Andrzej Siewior with the main goal to optimize
> when to load FPU registers: only when returning to userspace and not on
> every context switch (while the task remains in the kernel).

I love this and we should have done it long ago, but I also worry that
every time we've messed with the FP state, we've had interesting bugs.
Which is obviously why we didn't do this long ago.

Has this gone through lots of testing, particularly with things like
FP signal handling and old machines that don't necessarily have
anything but the most basic FP state (ie Pentium class etc)?

I've pulled it, but I'd still like to feel safer about it after-the-fact ;)

               Linus
