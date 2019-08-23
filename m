Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528E0206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVR+ZIdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbfHWKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:30:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHWKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:30:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id h8so12714210edv.7;
        Fri, 23 Aug 2019 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlctfPOJYF69OAlthO3Jpuu+JP9IVaCbpbZ9v8rQAo0=;
        b=FVR+ZIdpi0FOEKmjXRTy63GE/Fb+8Nj09R9Hb9rx9a5tyUCyBp9QXXAtBL3GVEUASs
         FAhsCm3J+fSk2K8xKw+RpHHe7/iR4kw5wZ1WUa4A8uorwQ5Xp1Q09+XxOw/+ERkBL5EP
         Xp/46GyQFxzkseJXnD5DAgXKcpZ8xVZPsRHGLdUA21+vwqJWCQYV+j50x9V/5YCgkVQp
         g7hNqU4YUuwQJhR+zM0P4RMccJ4msXFbL17AxHjX5LYB4xG6sCiJ+jkh52usO3lO75eJ
         6xE0pNzvC86UGs2U9QU2IzUIDDA92E80fxV4V4G04OVLOtaJ86GCmRi6wrpviZ/D9ZoF
         GmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlctfPOJYF69OAlthO3Jpuu+JP9IVaCbpbZ9v8rQAo0=;
        b=L9EeIzK5w1MrVmjjYrQgxFX5WuYis/GSS+MKoOzuOdF7TTlYL1S5pN1Dm1pZvvE7rA
         y8ZxwaTkg+z6qIVIjj/ejAJSF4UCxgwybQGkLKNhOJOG1faBQsAjFCRfGqwyEcgeR9ky
         mBrimgU+PEJwQzJYkjQvy0GKJ/ZAMU5crklVhl04LsyPWOj7IEhFvvoVhL+jg5Fq6ukw
         hDEnddAPEMAyFTA9xLjU7WoLaDQ33hjz4sRzLHR1S6J4NmiLLl8MpLdQkaSJTuCIIFa5
         j4M+MmGNytAnhuxt2wh6hlR3QbQICw0fPkJN9DrK7aYA9tbjaaWX5Wccn7XB2vlu9AQ5
         gDGw==
X-Gm-Message-State: APjAAAXG7BO/8kJZUqa6v4EJJ7G2nXPCzg1C8Cuag48aEm7AQMWOBBcJ
        91NhZYlzFxY5KvjNw0wGintWZ0+GuZVQnzCjq3+0Pp3v
X-Google-Smtp-Source: APXvYqwU+WLrIxH7nF9oZF/ISakCY60kbv3zwf2JFk1dfPXI/S5KtfKclsfYea6mT1tpLtCP+0/2QsZzG9x+Jf7pUyo=
X-Received: by 2002:a17:906:4683:: with SMTP id a3mr3446920ejr.47.1566556238576;
 Fri, 23 Aug 2019 03:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190822211514.19288-1-olteanv@gmail.com> <20190822211514.19288-3-olteanv@gmail.com>
 <20190823102816.GN23391@sirena.co.uk>
In-Reply-To: <20190823102816.GN23391@sirena.co.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Fri, 23 Aug 2019 13:30:27 +0300
Message-ID: <CA+h21hoUfbW8Gpyfa+a-vqVp_qARYoq1_eyFfZFh-5USNGNE2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when
 it's not ours
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 23 Aug 2019 at 13:28, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 23, 2019 at 12:15:11AM +0300, Vladimir Oltean wrote:
> > The DSPI interrupt can be shared between two controllers at least on the
> > LX2160A. In that case, the driver for one controller might misbehave and
> > consume the other's interrupt. Fix this by actually checking if any of
> > the bits in the status register have been asserted.
>
> It would be better to have done this as the first patch before
> the restructuring, that way we could send this as a fix - the
> refactoring while good doesn't really fit with stable.

Did you see this?
https://lkml.org/lkml/2019/8/22/1542

Regards,
-Vladimir
