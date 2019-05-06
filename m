Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A22C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930802053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFMrfz6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfEFO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:59:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44408 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfEFO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:59:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so2492020plj.11;
        Mon, 06 May 2019 07:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLbPX/jc7tfPj8ZUy6gaQ1Cz5/GWVvpyc6+DIQ2G8xI=;
        b=MFMrfz6rkhP6p/6Nr8Pc7iwkiKQzrtKzppdvsG5uSlWVW7hyK27q7GQUPwYEC8shL5
         6Lh191M/iSZ3VtDPmsLWk4/1TL8oVNhPLRAytWzdrLHxt06Bf3Bvwd/u/0lBhSW4QgGA
         O3lblGfOtFwK8rZCmIpgGVaUwBXHFMN5av2UUUUS9Uk5TNVv/NeCdbne+y+np0pg9JrB
         fGIr9vC+YkSq+1vCXe8wROfljy5RL2VmetGcjCa1DqhQecdXfN/o4jjoWJUoJZxSyBcR
         /hMvQOdIHVcvMAcqw2aE9XKsDfOKNpdeNbTNhaXWM0NbxPlogfwRjtMJpKvbs1KHiqip
         bxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLbPX/jc7tfPj8ZUy6gaQ1Cz5/GWVvpyc6+DIQ2G8xI=;
        b=pJgauNzeu6TVe+4sh1EgJNs6qe2YYrmjEu6vhNvzH0JYHf6ncIbbn4LSawmaZF/wcy
         l99jNMXce4B9JPbnctZnNNyDelKct0zywX4RQPZ/UwJlg31//ZGUaUG+DGyp+hE9h6th
         sSzuG4AelidXLWilCoxOQInuT4WKYtFhPVFXsI27DrZGEkn6GzPaC/3pXBkTZaPKRtz7
         M+pObumXxZaGR+dYmTuSdN/D4aUSc5OxXgTCy8h4aotNQoX2Jc3r+QFDcQaFAqN6imCQ
         +jCnxZp05qaAC4R+eE2zcvoGHnfUBW2I25GbAeOM9Sl2fV6lmrIgwojntsISLoploSb8
         QYNw==
X-Gm-Message-State: APjAAAW7y0VYOojWpveT9A4BJNGLVQbeLKgA10Sa5rv8oCWUt5RfSlNN
        AC6XHuPm5fIBiA4pCKfBPKpHzmKzPIREHER+u2g=
X-Google-Smtp-Source: APXvYqwzSMqo9crfo125Yxte4pN3tmzi3CJP3QdsNC5Pdax4AytdjIDg9svbewfAzG6RNN0bV71MCBLFPZSIh21F0+E=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr33389919pll.87.1557154775857;
 Mon, 06 May 2019 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190429150135.15070-1-hdegoede@redhat.com> <CAHp75VeE=88mCcgVx3Y3PQJPQ819Z7=3s=jRGz1y=t09phk=rA@mail.gmail.com>
 <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com>
In-Reply-To: <085c5b6e-d220-ebd1-38d2-def7efca24b8@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 17:59:25 +0300
Message-ID: <CAHp75Vfe9uK_b_V+uG29wb1L6J7u1hpbU+P4beXso9KNPM+8Rg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
 critclk_systems DMI table
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Semyon Verchenko <semverchenko@factor-ts.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 5:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 06-05-19 14:38, Andy Shevchenko wrote:
> > On Mon, Apr 29, 2019 at 6:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> The Lex 3I380D industrial PC has 4 ethernet controllers on board
> >> which need pmc_plt_clk0 - 3 to function, add it to the critclk_systems
> >> DMI table, so that drivers/clk/x86/clk-pmc-atom.c will mark the clocks
> >> as CLK_CRITICAL and they will not get turned off.
> >>
> >
> > Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > supposedly to go via CLK tree.
> >
> > P.S. If you want it through PDx86, I need immutable branch / tag from CLK.
>
> Stephen added the patches this depends on to his fixes branch, so they
> are in the 5.1 / Torvald's master branch, since we are now in the 5.2 merge
> window, you should be able to cleanly apply this directly.

We don't do back merges, so, our base is v5.1-rc1. Does it mean the
commit in question is in v5.1-rc1?
AFAICS it was appeared in v5.1-rc5.

-- 
With Best Regards,
Andy Shevchenko
