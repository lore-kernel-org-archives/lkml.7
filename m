Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B97C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B941521855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 06:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FtkhRbMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfI3GxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 02:53:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45977 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfI3GxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 02:53:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so8162783ljb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yATsTcqOqIzZMV98qWIAPWwEMjMrM8gXIgA2HND81Xc=;
        b=FtkhRbMuAFq9oBu9QY8Qq4PUBi7P8wG9pwBBI5gh9ZFAP1uE5Z8owLiNoz//UjqGYQ
         fQhndMyHQ1hPRQnD6ur2p6trxwMyp46wm3Vcw6Fyrpl81AW00cOdQytunyp/2v8lQemU
         SaOycOu6xeFMyUosNLzTevrP3MKyY/e5X/5NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yATsTcqOqIzZMV98qWIAPWwEMjMrM8gXIgA2HND81Xc=;
        b=CDEdqbFG+zaT+ZxtAV3XUPntNAsGTW4x1Cmaw3ymXLUfgyqEtdgoOJrJTXZypVT4YI
         MVGuPZeIAC1n5PxgGDxD4zpHNqvWs8RJXOuWVJNyQ6/PA3q18UiKdkJ+0/a6j548qi1T
         /fxcV5YEQGfyBrv1XlhXsaILjiPgH5k9t4M8ZaZGkFVtwFCQhGkmDu9iZMZFtkiAa9H9
         vH6xZh80EVWICH2QboHC5TUkSjYp+vKJV445bGe3GLSnf/EuGVdLrjidMpu5qZcBa2wL
         AWrQcTDYWZTJA5CpkNB77BtydB2Fvu3ZfcXQDKOvYUXY+SS9v+3daPmEt1lt0UvHL93d
         SIoQ==
X-Gm-Message-State: APjAAAVwsqOOohTMzh3ZPW4QEUDRhXRWGVt3a6l4nL8yzaPeqU1HVEzC
        eDRdpQEEkKRWhWa9xDE5anfKfZDKBWu+4OYdl70H3Q==
X-Google-Smtp-Source: APXvYqziLiuF94ED9ic8k7xqYKDkQNdzt1q3xAbH4DhKGFt+OHhSfqDtzXLbca2sgZAoi7etyCT/7Lt0hhqj6DqlfRM=
X-Received: by 2002:a2e:1246:: with SMTP id t67mr11165358lje.174.1569826390743;
 Sun, 29 Sep 2019 23:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <1569472808-15284-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190928181910.GB12219@kunai>
In-Reply-To: <20190928181910.GB12219@kunai>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Mon, 30 Sep 2019 12:22:59 +0530
Message-ID: <CAHO=5PHj1PQUGi3EYBPVNUsRHsEo9WxU6CsvR=9+bP4n6z-cMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Icarus Chau <icarus.chau@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Shivaraj Shetty <sshetty1@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 11:53 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Thu, Sep 26, 2019 at 10:10:08AM +0530, Rayagonda Kokatanur wrote:
> > From: Lori Hikichi <lori.hikichi@broadcom.com>
> >
> > Enable handling of i2c repeated start. The current code
> > handles a multi msg i2c transfer as separate i2c bus
> > transactions. This change will now handle this case
> > using the i2c repeated start protocol. The number of msgs
> > in a transfer is limited to two, and must be a write
> > followed by a read.
> >
> > Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > Signed-off-by: Icarus Chau <icarus.chau@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Signed-off-by: Shivaraj Shetty <sshetty1@broadcom.com>
> > ---
> > changes from v1:
> >  - Address code review comment from Wolfram Sang
>
> No, sorry, this is not a proper changelog. I review so many patches, I
> can't recall what I suggested to do for every patch. Please describe
> what changes you actually made. It is also better when digging through
> mail archives.
>
Sorry for inconvenience, I updated the changelog and resent the patch.
I have kept the patch version as v2 only. Hope that is fine.

Best regards,
Rayagonda
