Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D31C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65B02230F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHZscnUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfKTOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:15:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39460 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731525AbfKTOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:15:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so22622653oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1JInq8ybqUU+dzA1t2otshUzEZEEJedhwySk87aqLw=;
        b=oHZscnUMVUxWTr4jd4Zbb07mNQh9/Ms8vfy/BbtJekxDp/8b0RrOmDmfGmKOkrrui5
         Qw1yQQmpbM/RO/3GpQ1GC/Lt+TRP1G8hQ3Et+2coXzvpaf3rFU4NSkgVKgXxtNN/flGr
         LVCS9Op5LA9u2gN0Cz9T5DjKW5HF2TAi/cslU7aEK15bLH/U6ZT5/dQ08cJcoU8DCo9k
         d1Kohid4zPG1uPSpAZxVi4KxziSQB97NpmkOaSjaCchznRi9VmYp+pVceyrwBuPeZVlE
         loWjwNG7D2DkSq6Ap3rurASIC66VIoG+C1g5EUU3ix8rBTqFtkvZJhzaAYtHLSDmd94c
         LHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1JInq8ybqUU+dzA1t2otshUzEZEEJedhwySk87aqLw=;
        b=lH8A+xJ8sywaOthhBJewweNon6NgTsATf9K+dVzXdrVRoEMF7FUa4qsRqnuOLGIBQg
         nM84LKXw/X5QE3g0cl/RJhdLPnkeUKv2g9Mk/FlzTNKMyg+H7jEX6/L7pfKK+P87AMXX
         cQ214fuCqve8+HYiBfLkEpvqHkbUEA5IUo6M3Cu7tgxH5y5ka27cH5eJEKhRtl+wS7nm
         dG1TVknKy8yrSV7nN+OVEkfOaFbC5BcN1E1Oeik1CxKnvVaV0GokpClXgTz5xwNtkwRc
         mW0kUGrh9LsMjv9mpCCJTlZvVUIqhCeHPCQq16OJReo0eOozOR7iEu/5/oQAXNEbO9uu
         qESQ==
X-Gm-Message-State: APjAAAWycopGPfzyB9Aq+itgjZxZQ6wl1DoTfGrBZM6hvzwhcMi95aWF
        bHdQfACdx3SbZEaKqq6T4w5cpOUMWWnFGPEhwUQ=
X-Google-Smtp-Source: APXvYqxGxavH3Y/9DAjAEaBRilNFvr3OzLbmyZMg3GoZCZysI0K5AX0/C841m+qoGS2t+NAU5OSm1y1ivJtjV6ysJw4=
X-Received: by 2002:a05:6808:3a1:: with SMTP id n1mr2926729oie.86.1574259334867;
 Wed, 20 Nov 2019 06:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20191119154611.29625-1-TheSven73@gmail.com> <20191119154611.29625-3-TheSven73@gmail.com>
 <20191119181426.GE3634@sirena.org.uk>
In-Reply-To: <20191119181426.GE3634@sirena.org.uk>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 20 Nov 2019 09:15:24 -0500
Message-ID: <CAGngYiV6iuNh5-mgmCx4RYOnWJAvDkwrpzEeonHf5oXfruqoRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] regulator: tps6105x: add optional devicetree support
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 1:14 PM Mark Brown <broonie@kernel.org> wrote:
>
> This and the binding look good.  I think there's no interdependency with
> the other patches and I can just apply them?

PS I'm assuming you're accepting the regulator patch, so I'll remove it
from future versions of the patchset, and drop you from To: and Cc:,
to keep the noise down.
