Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD882082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VCx5m/fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfC1QrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:47:11 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53999 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1QrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:47:10 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so7129716itf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o/nFTW+oTLyFRU57wgAC3ho3qjiW4SjfPZsPXc6ZXXc=;
        b=VCx5m/fKi0LoSSKExENrfjMUYAduUqfMQf5RagDrTGNF6PPg2NsuQa+4BiENfYrZiZ
         YRpHlnl0fnoZ1XOTc9vf0UsaZhLKzgPdAbrc24sffrkHKCBJR8TvkZxfwmrzyPxTwgs/
         Mjopi1rWaSvVP+OQlmw+G0IUpl7RWAl7+s5kX6Eba33JWk6Hq2aW5ouF3LjSkYq4nJiA
         zv814mZXbomk5wTk/deVeDq6xZWQClie5ns26CKM3VoUqx8KOGFwyIvYIURzRjerZTKF
         yDiHHrUn8s7EG1iZ+wibixbqPAArOcLOadzTeExii7iWXX/nLWOnAkQxfvoqP+jZ8BHh
         YJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o/nFTW+oTLyFRU57wgAC3ho3qjiW4SjfPZsPXc6ZXXc=;
        b=nF2Sn3MafVsEaRk0hGMj01jYLhHlREmE/dMHdXyELq9HwgrPON3CoVNEV1AvryJhB+
         s1OthxSESGPFe2qRaR6suTCXxWKWBAp3MYYDXHF2ZMFckd2wUEBkb+VEQnfQGty2EOuY
         60bM2ZZOPzTNcDipwQkPvIS7r0/+Sy4urQnU41DfRUQ9q2GEJXM84696eZU9JmyMfLzn
         h9OK56oQ2LwiGWh2yxnzR5I8PVo1mW01VojT+xh8BYw42MC4BQKfoVnLyFbLw3jYvhD7
         yl4Qbn2PTqjINx9oWvpidX5s/ggWma/N7/OXErObM0Sd6ZwUtE757KU5Q8KXq5SiJdFs
         ViSg==
X-Gm-Message-State: APjAAAUM3zXAuTCbQlhnPGtbkB5Q6fqXjAajIA9R46d9zKbUL20A7SsH
        XCVZ71BY4w/xG1WlFDAW3x7BZAsLd2Tg2bVjBcX98A==
X-Google-Smtp-Source: APXvYqwB3D/qbLi1xuQ5CEFcdT5vwMPYX4UULhkkpo9f1bAE9bRFOA1j2rAdCDmUTdhsZVm7DrH1zVqqYewciIZrb0U=
X-Received: by 2002:a02:924d:: with SMTP id y13mr22947060jag.24.1553791629914;
 Thu, 28 Mar 2019 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190322173052.23763-1-brgl@bgdev.pl> <CACRpkdbw7zvYx1s742HmYj8E=J0=SygEgBHVDyQ5c84N70V3fA@mail.gmail.com>
In-Reply-To: <CACRpkdbw7zvYx1s742HmYj8E=J0=SygEgBHVDyQ5c84N70V3fA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Mar 2019 17:46:59 +0100
Message-ID: <CAMRc=Mfd=cj7TcMOeaSJaAG_kfs8tg2UMGUR6iTwNhT3+q3n6A@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix debugfs read
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 mar 2019 o 17:38 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Fri, Mar 22, 2019 at 6:30 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The debugfs read callback must advance ppos or users using read() on
> > the file descriptor will never get the EOL. This wasn't spotted before
> > as I was using busybox cat for testing which uses sendfile() internally
> > and only noticed it now when switched to cat from coreutils.
> >
> > Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Patch applied for fixes.
> Sorry for slow application, I was in no-wifi-land for some days.
>
> Yours,
> Linus Walleij

Ugh, I was thinking about sending you a pull-request with this and a
subsequent fix this evening. Plus other fixes I have in my tree.

Bart
