Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C53DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7B1207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oYEjye0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfLJMvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:51:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46762 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:51:49 -0500
Received: by mail-io1-f67.google.com with SMTP id t26so7209062ioi.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JgPpbJKgKk5ge2hxH63npBJJGTpFbabBxheJNeCT7Ok=;
        b=oYEjye0H6hKY6gGcnac5iO58/GfeSdv8GGQSnYEDVrhr+uEYE2ErjrfI8yKnmRWbEt
         XC0nhe5IwW1yXhaLPK9hQLLiIKRmjE5ZxKZ3lNZuXYfxQaoBOq8P+G25jxwdNQbUiTsF
         aoXklJqSWMgA48GvDBplby1Phpz4thl4Jq5sWvInWTd9GDFDtEKSIsC3/LWytMoWTVgM
         vQtQHB+QA/XV7/AU0t7IHU+hcfEKHtJlzh3kLcMeB1JcROGqsGQsuExnw6uW1kDjzu9g
         BNyGWwF98uhvymZ7wYEhHhA76HWa3SFThDvQlfgdI8iADJicUc6c2aC66bypvZx8BWeu
         dKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JgPpbJKgKk5ge2hxH63npBJJGTpFbabBxheJNeCT7Ok=;
        b=BJ2dD2XDdlJN1I+Xo3XoKjx7o7XvP2d0iWROhbyfUjAsTDMgNN2IHDPyHHkAt9m7ke
         1N88oD1BcFQi8reKO8/4rAaHWLwi5HNTas/J4Wsc4zzxagq5qHPMb9dUWuhhQkgLE7Bn
         0nAMUwHdZf/5ayEnTABlgcn5TITSUo6uMnDDd26YtzJXlU4Jt6lOVolowAlOg6mqUUqN
         OogStNSFamcnnX8ZWDEh1T8RmsGoZCZUjwgQHMAAfBKpyVcvPUJhYFs0O5pWjIiGz8tA
         fCKzCNxMAsasNoRArYaNiijyuP9pY+h8Hajf4dVToP6SU+BIp10ggUaDuVgzpFN8P1r7
         Qd9Q==
X-Gm-Message-State: APjAAAUpHY/T0EYPgKEzGEas7x1K0xAxWW9VoC4QB8xBewC2zEHdc9L3
        vqtwl4D0LR5BFgp/LDwwWk7jkjff4Hw2+M5dHrqcrg==
X-Google-Smtp-Source: APXvYqynpw7gaQGO7mjSCY56iomKeth2/yoMzc8yiyPTj3+kSrz/0Xfs08bh/5hGxRSlnIB/JUidQg8EovSp0EqpJ9w=
X-Received: by 2002:a02:630a:: with SMTP id j10mr25293147jac.102.1575982309008;
 Tue, 10 Dec 2019 04:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20191210100725.11005-1-brgl@bgdev.pl> <20191210121227.GB6110@sirena.org.uk>
In-Reply-To: <20191210121227.GB6110@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Dec 2019 13:51:38 +0100
Message-ID: <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 13:12 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Tue, Dec 10, 2019 at 11:07:25AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We need the of_match table if we want to use the compatible string in
> > the pmic's child node and get the regulator driver loaded automatically=
.
>
> Why would we need to use a compatible string in a child node to load the
> regulator driver, surely we can just register a platform device in the
> MFD?

The device is registered all right from MFD code, but the module won't
be loaded automatically from user-space even with the right
MODULE_ALIAS() for sub-nodes unless we define the
MODULE_DEVICE_TABLE().

Besides: the DT bindings define the compatible for sub-nodes already.
We should probably conform to that.

Bart
