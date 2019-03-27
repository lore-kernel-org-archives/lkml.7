Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B8C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366D62087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chY+FDRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfC0Bqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:46:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43826 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbfC0Bqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:46:49 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so12654558iol.10;
        Tue, 26 Mar 2019 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6y9c/7x1WlirmnjZEheHDM5tBdS+V+J/OFT5azB9lZk=;
        b=chY+FDRIo9ubzIVbs8qlZ4rzCeS9ShM16gEivOdXgF9ZIwF+fXk3CyWXBcLo3qwhAm
         uQGx9mTnZYRsaZMPQNTqpHQJLn1bNAcQAhtVMWdDdQhjGCed6b/tH2sgfGK3VAYa+nuG
         aAx/1jbD8ZuFqkpXMcAul6Xh0a1x7842fSG5i4giYbkBKLUzjsdxpbiStMTlBvLPYTLP
         S96wqSAAUDqtctTR/RJYtML+gCCJQtCgofnIsXJ0tRXAhTzml1kP1CNjUI9RzGH3X22z
         NciBwkuDH/VDN+sqhiVBdC+CXKUFfp3zk3JhvVfnTIdZN9dhOc+d6xycoFrInIOGjOcD
         TDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y9c/7x1WlirmnjZEheHDM5tBdS+V+J/OFT5azB9lZk=;
        b=t+CsRD/Hu7Ll444otsHjnjBOzA1PC1wNCwRoMSuYVcDA4+dvKDTSBie2NDB0XW6nOx
         Cp0qtSb0igY5kwCxAGv1fTmauLACkeDzf8rKL2bjIJIJ9KpSMEa2tkGe1I5MWaeM/Ogn
         94XGB2fEE3MFCq+MUILpS97QAdGNuJnVAHtFy973jKD4Wf/IfsCre8H/xl9EcpzAvd00
         96Y7qMJMj1F4Yrh/wVenjysFRsV7JXauyjqNFYnmxmmJ4D2yrGXH02BAK670uejGMkKF
         3GJpVLyLlAEyrkP6E54br4xqOUZMUv7p1Ev5SIpbAYXzOeFQVguevzpoo4v1gglIGOwW
         VXhA==
X-Gm-Message-State: APjAAAXUcNo/7dURv+Q86qJ1DswxXvu4J7dNsDUz4ItONNrtT0UExD8+
        pl4gqnYHi13qHiTvUImYGHvwaOxchXXPKpnDAzZDYbT9
X-Google-Smtp-Source: APXvYqyOLq8tXnj3Wq9crOBVLrFspQUEsy4ducuPArM4z2yKNwUcy9iFcxIJD9/z8eDvFdvbIbIuZ+AyMhpGd1WhlM0=
X-Received: by 2002:a5e:a505:: with SMTP id 5mr25080316iog.28.1553651208215;
 Tue, 26 Mar 2019 18:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190326152139.18609-1-thirtythreeforty@gmail.com>
 <20190326152139.18609-3-thirtythreeforty@gmail.com> <20190327004603.GA28785@kroah.com>
In-Reply-To: <20190327004603.GA28785@kroah.com>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Tue, 26 Mar 2019 19:46:36 -0600
Message-ID: <CACmrr9iqK-g8o3tAAHD3NDy+9BiOkoXH+vFMT+stG37iZ2Zp5g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] staging: mt7621-mmc: Initialize completions a
 single time during probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 6:46 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 09:21:39AM -0600, George Hilliard wrote:
> > -     init_completion(&host->cmd_done);
> > +     // The completion should have been consumed by the previous command
> > +     // response handler, because the mmc requests should be serialized
> > +     if(completion_done(&host->cmd_done))
>
> Did you run your patch through checkpatch.pl?  It should have reported
> an error here :(

No, I didn't.  My mistake, sorry.  Will fix up and resend again.

George
