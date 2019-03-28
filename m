Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3090C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3C120700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="OVJxbSIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfC1LvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:51:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33571 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1LvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:51:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so22528644wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtICsfKWeZZq7aPt+RhcRvc0cqTR0JGThhSSnPrI/PA=;
        b=OVJxbSIryaVG8yc+vVNaZnjkzUMi24XYIpmTsVDM7MHHRjlqzRttE8E5o0T+oHKQHM
         0nTxBELaOuIH6Mwo9rfxlh/FdQE3v03KnU86GE6FQZ7dO9rC0iUnYcSteTlLJGz0r+FC
         MjQlJTWxbbaFz3MkRqvdnGJS1WjLhdncdtO/d+o+St178Ok77ofuYl9zM9aQAw+2xce5
         6BTW1CE8foH04TNZCGKCjfogh4st9+yr3VzGdiIuOtgUyBex/N/aXicKRpHl/Z7uZ0/e
         AH6nm1z3Tmpi0vlvMjzjMQHTmDi3IR0bpEqjja9DFGKL/mzZcglmfBzFniylupgDFaaR
         b1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtICsfKWeZZq7aPt+RhcRvc0cqTR0JGThhSSnPrI/PA=;
        b=ayubywBhpIk+qccxHhIrUUTu4KqDhAG82qAc+GjKVdr4Ib+9Mx4Wc4N0lxyjbcMdyY
         2CwuzT/Cl9CF1Kv7HCSn13wSloFuft2eHcxlmYdyBPmCxh689DLGpWFbrHGGtWLK9HBU
         AFvtWSBgl9TYqbBE1DRlp30sqS4bkxf+0C2fCEDA3v2HcTIYmeBJAErMijxL/O43wXwL
         cavcG90JKCq2dGip90SJ3BHSiPK4iLxuiQVDEpwGnv6U6m02bINu6n/UDwCExsE8d+l6
         rtR4Tq/Sqe6k4CHLlPdNJVzqyZHnSbxZx0Ucqm7NxJJQw1wyhaHbRwiUvfZshB3JWMhv
         vOoA==
X-Gm-Message-State: APjAAAVPR3FaoT/z7m2TCEtFeB5mxFFsPa7mlP9u3UQEnd5P15gzEl5X
        WmXZvuzeORENv5x3piJA8Cj8OHIpnAOPogw/nAkdgg==
X-Google-Smtp-Source: APXvYqzjWgO0HyMkte94fAYgoIUJoRZh8zJuxKv/a/ooVyFyePmtFGWjCH6maDjlRD7jUZD/jjwWCxhqQv655mmYvsE=
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr9176668wrj.0.1553773874071;
 Thu, 28 Mar 2019 04:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com> <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
 <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com>
 <CAMRc=MeN4W3iOc5+t+9b7knRJVx8vA+eb95bRHFBGZJvC0ffuQ@mail.gmail.com>
 <CAFRkauDMj_5p7yviNYsymj7P_qPfFC1crhiP5ouwEnp7jt_rPg@mail.gmail.com> <CAMRc=McRKEP1ro4tWkXbyJKRJeaab9HL1r4cj9H9XBjjA2r6vA@mail.gmail.com>
In-Reply-To: <CAMRc=McRKEP1ro4tWkXbyJKRJeaab9HL1r4cj9H9XBjjA2r6vA@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 28 Mar 2019 19:51:02 +0800
Message-ID: <CAFRkauBmMWzjKQV-qBbT=FLZuyHjsu3ngV_VO_pX3ZHwuhg7JA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you mean you don't have a public git tree? Can't you create a
> gitlab account and just push the tree there? Alternatively, given the
> amount of patches you send, I doubt the kernel.org maintainers would
> refuse if you asked for an account.
Because using linux-next tree is good enough for me.

>
> Frankly, this week is quite busy for me, so if you want me to play
> with pulling random patches, then the test will have to wait until
> next week.
No hurry.
You can test it when you have time to do that.

Regards,
Axel
