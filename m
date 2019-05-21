Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399DB21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjMJS+dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEUOYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:24:18 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40826 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEUOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:24:17 -0400
Received: by mail-ot1-f49.google.com with SMTP id u11so16477538otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUxrnziin1x574uzkZypKzeIsKwDlwnDKF5aI5CN+oY=;
        b=RjMJS+dXsEtXak9tMSuGKKjN8TDKmWL/9t8Scn9r4N8yeEi/CIK1rXNHcjotaVvmPt
         YMXpfqNpx3rLn9mRyX8HUiUZ8FGmdh54swFrIDxpcEFeTDmCw1qux50YA+ZI3q0sqt59
         Ujy9PcWSIVElJ81LQsblcYdqwyaXoNByVQyGX5Z0En5eMt50rUYqpK2JUecUoTelXS/8
         Tu6Os+3ETx9iqmTm5V+7hnF61DMulmdNMtJLYSUrxt0i+OwEG+7XKqXRlZSmPEml/o3J
         /JWpv6FkN4f7C2GVf/evBSKVrOPBjKQna43Qy56EhDjw/8Phro4Ke14GShklE6Z5Csv9
         s+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUxrnziin1x574uzkZypKzeIsKwDlwnDKF5aI5CN+oY=;
        b=tIEOLknYIluHnIJ5oJZZ9ct7Y22BntMChlEB/gMeiqT7BfiTiSA0/X1FR2AhEVvglM
         5OflyeVTE/goF6x9sQecgVe0lix23DQ7wHst9nqG7uXIbrC2PRqdbAxD7KAltH+P+noc
         fvEeFgTXbvK3lVohsU7X2y5cr3ZY2fzbGfz8G2WkbYuDF3M2SLN0+50Zyew6Coi3xHxX
         /Jx/C2MuU3i8OXACUgP2XM3++h/kM7bVVW6bh0XKqjnJ2h54R95reDI7zrgl96cb8MIz
         5lDZrqTsFkjKBiow+3w1awrRn0ZwhguYxn+ux8tzfQZTpfh61RSmARpvUI0NXX/dHeyV
         0MJg==
X-Gm-Message-State: APjAAAVeKl1O9Fm3f+eV/Nz68f0vViOferEt/9XmAe4Q0SliTOgRKl2v
        xFBRFsiqBhOKXeVQ0S3w2mxSldBOC0dtQkQjtxY=
X-Google-Smtp-Source: APXvYqz3MAWNZRXh3jlLxFwfO58pZuC74XzewO5pp/vp/5H38msqNuUfMqTdLt7EdPg7pW6ThTlL4Hmkxrcv9TvPf0g=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr33996649otg.116.1558448657107;
 Tue, 21 May 2019 07:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
 <CAGngYiVNQrr2nKfGCdi8FzS5UnmGaDj_Gu_F0ZeOTMKX6_1Zuw@mail.gmail.com> <20190521141715.GA25603@kroah.com>
In-Reply-To: <20190521141715.GA25603@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 10:24:05 -0400
Message-ID: <CAGngYiUxd15xVkcbFm4cC+0a+UU+VODTKC0z4p=NoW+pTXoYzA@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oscar Gomez Fuente <oscargomezf@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>
> Greg already took this patch a while ago :)
>

Thanks for bringing that up Greg, I'll double-check your tree next time.

Oscar, please ignore the v3 patch I posted.

Sven
