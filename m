Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6696221925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7TFCwPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbfJPLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:16:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390947AbfJPLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:16:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so17100041lfn.8;
        Wed, 16 Oct 2019 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxVNF9emcO9vOzZ5Qy5dhVZsoYfmUatJ5whvaHZ26tU=;
        b=c7TFCwPEtNzGt1V0t4kWXCiAXCN1SJiuzGxoyRVZuHYGJ9bA5iimWG2Rv/WOHzx9tQ
         0c5fuV90QpWy0gWsi97R3hhepPTY3KPW6mkkl8PrOTW/TOMRKad5bCnkWgJDDsu3bFRq
         nknIEmWqKKp9i48gTwBzl6URFhks1NDyJM84oMpcA7CPid2RMjgOEA7fDap5nVusZzUA
         8VP5We8KOnFuV7XptNybusmv9XJmZ+fKYORmkbTAIwjF+d0ehj16N2RGdmGwzjABMX8w
         7YLEc+uLjG1sddE2SGXMcejGPXgvsqiMNlWl/zCzPnbhoi9vOJZnkhDlSIVkMkl44aG5
         iuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxVNF9emcO9vOzZ5Qy5dhVZsoYfmUatJ5whvaHZ26tU=;
        b=oszuGkJEPcCn4wwLdXk4TltBCmLSxJsjVCEnALTD3VQ7J5uaU7n4zsIjzBLVhbo7eo
         ihzfv9Chg3fcgJwnSfrQF++PNwbXDnxosSxbJqUNPFAHqEiOWAbLoQvLGE2bkeMf+Mrz
         6/2tBNf6S7qSlzf3pjSHldUxy8g3rxrNKZsV6KDGKg18GXWI81oBcEc8lOlUWZV3YZJS
         qAenKAyk9xt5MkK+9D979jMyt9fLNnwzyZ1Z/zHOv4sY5SQQ+u6Kh6XCfMWQ9O25kyF7
         8sihlzbHnbQPYIp6wmKveUrymkVZkgt3HR9nhAea1gwkXm1pDGk6Y9NnfrZDz9pDGja5
         hjpQ==
X-Gm-Message-State: APjAAAVnwbgJTzIvZxEq15e2rB/4TL/AHvFhL64muOrFVYJgtI8ndldz
        XLeOYhBHG9YbJZn6B0luD4o2E6WHKaMm07CJN9s=
X-Google-Smtp-Source: APXvYqwRjFDkFx/43M2eXk4OoUppcwOlsECBDKNqWNiS1H42r6Ekg79etDPeqGnuibPhM2Qnm1SuI+RP+gp2lW1DJag=
X-Received: by 2002:a05:6512:30d:: with SMTP id t13mr17409610lfp.150.1571224591326;
 Wed, 16 Oct 2019 04:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com> <20191016104110.GB10184@linux.intel.com>
In-Reply-To: <20191016104110.GB10184@linux.intel.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 16 Oct 2019 14:16:20 +0300
Message-ID: <CAE=Ncrb_7wQsv0_EvZWe5-WA2UU_GywgfnVo7hC-FDTY6bzpFQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 1:41 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:

> > > get_random_bytes().  TPM could have a bug (making results predicatable),
> > > backdoor or even an inteposer in the bus. Salting gives protections
> > > against these concerns.
> >
> > The current issue in the randomness from my point of view is that
> > encrypted filesystems, ima etc in common deployments require high
> > quality entropy just few seconds after the system has powered on for
> > the first time. It is likely that people want to keep their keys
> > device specific, so the keys need to be generated on the first boot
> > before any of the filesystems mount.
>
> This patch does not have the described issue.

My understanding was that you wanted to make the tpm_get_random() an
alternative to get_random_bytes(), and one reason why one might want
to do this is to work around the issues in get_random_bytes() in early
init as it may not be properly seeded. But sure, if you this wasn't
among the problems being solved then forget it.


--
Janne
