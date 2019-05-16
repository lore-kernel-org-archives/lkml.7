Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5F1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E882070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psld2Rtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEPLGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:06:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37035 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:06:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so3334864qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZQndzh86WbUHEi3CwFSV9T2RCQpkeqBqaYeKeBxwUM=;
        b=Psld2RtdeZRlGVV5tdrrJynhm7e/dFtxWzMOoPeFZJPquYW1kFw1SQ6xOahgOJ2yxk
         77PEYBrExFmG5yRf8hgm61HiKZA3CshlVnI+GV+axsa8VyK9Ob9hykIQ5F17OsAs5W/4
         sRo1CvdvBfaif+s3qQcN24+/0AqW3ga+XZRVrWBqDb5stLv9E7a25VIZdW32t8OmN4qC
         74dm12NOmjhIkItJHo7aglM4ba1aLG2bt3XbemPXYjB4+1E+Tt6gA0tTM7iRd9xIh0aY
         9DD4tZ6JlPGDXcksayufTtWEGyCYVggVzmr7oJty0zeVbNWxXZjBSNIiEN6rUNY8Jkku
         9LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZQndzh86WbUHEi3CwFSV9T2RCQpkeqBqaYeKeBxwUM=;
        b=fAt99Gr/OqHcmXae6N8K1KKwvzCJJG0NOmNxdl2ejx/DpgO0kRzht1REqprHFlEogp
         QhbB74GkJG35RVo+08QJueYdEqhMHlyokkRB0pCoS0jTEI+xw8DkmgqN7JrTFlDB0++O
         W3dE0EQVHr7lPvlHMUwPw8mjs5H4EhOyiuH1Nd0bDLaCybyhDoXehdVyMDYv1ECXPJ0a
         Fi04494eOc6VwMPhgeRrQNROhJwZFvAyy9K98WmWBPCGom+KX58HU1Gw6n+y4D+jAQGc
         ARm9ZXvfFG5eIM7+ACYxpydqtyyie8titOnaH+M2cc5P1EwRzWWLAplFm+dtdCA5rIWJ
         kBsg==
X-Gm-Message-State: APjAAAUiQi448PyNFSz4glPsLHkDEo63sPIoycUrAnD7+uz7I4HGjjKq
        QJiZ8gZ6NYi5NcrEinhyiuezmYFN4UeGHI7nZIo=
X-Google-Smtp-Source: APXvYqxmwACH3/ucuzQ11oikIaz38SVPxf5pVj94ABf6HuCZoQ2r4Xsm0yDuaaU+mdTliYsJdmYhE6lYwa5042+AQtY=
X-Received: by 2002:a0c:94b9:: with SMTP id j54mr42131qvj.54.1558004780853;
 Thu, 16 May 2019 04:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190515141731.27908-1-parna.naveenkumar@gmail.com> <20190515151342.GC23599@kroah.com>
In-Reply-To: <20190515151342.GC23599@kroah.com>
From:   Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Date:   Thu, 16 May 2019 16:36:08 +0530
Message-ID: <CAKXhv7cO7CLSW1mxLbo8-s7akSsXzsRY+U445B=SNhJA8oqppQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] char: misc: Move EXPORT_SYMBOL immediately next to
 the functions/varibles
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 at 20:43, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 15, 2019 at 07:47:31PM +0530, parna.naveenkumar@gmail.com wrote:
> > From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> >
> > According to checkpatch: EXPORT_SYMBOL(foo); should immediately follow its
> > function/variable.
> >
> > This patch fixes the following checkpatch.pl issues in drivers/char/misc.c:
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> >
> > Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > ---
> >  drivers/char/misc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Where are patches 1/3 and 2/3 of this series?
It does not has corresponding 1/3 and 2/3 patches. By mistake I used
wrong argument to 'git format-patch' command.

>
