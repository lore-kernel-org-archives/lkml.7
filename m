Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD4ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="xojgy9x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfJKM4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:56:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38308 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfJKM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:56:31 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so21254571iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+EUqmfGWDAdL05osSjASqHsDbqgdE65EEIXIm83sDD4=;
        b=xojgy9x7vGpMMO1XVw+kggflG5vf16sNOXA9BOGMWJB9Nn9oVWLGyTyB3ES0iL+QOq
         FRmH2C2vYADTVbuR7KudRp5AXZtblAtNWvktzJQgTxLRpGk08aBFh6KzgpObif8iLZbS
         n50vWK737S5/rORFqdgs47B87xZWTpn8tzyxipV2nVykeqmQW/GpUyOk05pCLY+C1Jw8
         R/jGy7+ZlxgUgcOctIAH4dU/o+nBTNfd5tYdA9E6LOo3VycET2Tp+vugD3gUMmeqxwaA
         KG1ZKJsG+GUm+BbEGlWkyRNg+jIz0c+XuetfWz+zWbQMWxVWz4eGAnYbp9Mcceai0luz
         9TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EUqmfGWDAdL05osSjASqHsDbqgdE65EEIXIm83sDD4=;
        b=poK7yQmqfpSLuq/DNKNMkkWnKTMAkrZUd3pnSCMP6e8ruL4/lP2npH3iqi8Jchfcz6
         TFIA8XtYc55uk9ATBrJygy7g3S3UpNLVIA8cuAli+Yity/6SBsC5IdAic6pJMX3eqr06
         wzAXGkiZP+7WXXI8Tm1ovBLW3CaNqw0z3sUwlxeZpyLh2lRJDx7eycG8EOCwH7bktyyg
         O3E0grz3LSKceG0K3ITqyhdotDqjoBIRPtKJi5roHRacQzqb3GNbZrui7w4B85W9ugcL
         7asSPQ472inIah4Jp7n7GH21q9kFISUXhtFpI/mkc8gPfx07BfX0h4kt0oSJaVvgPW4y
         xPYw==
X-Gm-Message-State: APjAAAUJm8tEzajWNlyX00njJe2fwSEpa6Z2TRzgcx7ta56VohHg8OEo
        aP/YQv2nBOC6jeqysP3EnWnwL2zF76tjFwD9+bVfkg==
X-Google-Smtp-Source: APXvYqzTkS1nwUshVzno50wD21uyNcAdbgshnDiR/j4kcyVL8MNzKbbRJEgcBYbDdiTjk0yMweAOKgaGCZNl1o1ZSkk=
X-Received: by 2002:a02:cc5b:: with SMTP id i27mr9531652jaq.63.1570798590649;
 Fri, 11 Oct 2019 05:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20191011122409.23868-1-joel.colledge@linbit.com> <c4ae19a8-54c0-98a6-16bd-48f7ce5689f9@siemens.com>
In-Reply-To: <c4ae19a8-54c0-98a6-16bd-48f7ce5689f9@siemens.com>
From:   Joel Colledge <joel.colledge@linbit.com>
Date:   Fri, 11 Oct 2019 14:56:19 +0200
Message-ID: <CAGNP_+U-5bUysiwLN9fL0+d__GKOc_5Ak9MDKi6EeeSzPCK-Lw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 2:38 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Does bitpos really use a non-int type? Otherwise, plain '/' suffices.

bitpos uses gdb.Field. When I use '/' I get an error:
Error occurred in Python command: slice indices must be integers or
None or have an __index__ method

I'm guessing gdb.Field has some kind of override which causes it to be
converted to float when using '/'; hence '//'.

> Overlong line.
> ...
> Here as well. Better use some temp vars to break up the expressions.
> Helps with readability.

Will do.
