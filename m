Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7681C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BEC2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="m2y5d8Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfJHKxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:53:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39374 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfJHKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:53:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so24518874qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I/XAz6EQQu2WMJ2Xm/Zu1m8Sd6t9gK7D5HCK9hWTzCE=;
        b=m2y5d8Tcs8u9GpWYwEKhUdJe2ngQOmPDj8+a3tK4xhEr7u+kr7LXS8iuB+aghFA6Qy
         4uAE4PbkaRR3EPMk/yWmyEoVUD7Q/ds9QkzWfe+uVbB7rkVVo+GjRREQuU7XfTBOeGT0
         8jpEBsQq74dAtyTlQLF7Dnzq4++Xve8gLpyZcb/Oh1hc38ko7n6dQLmmMHaOvgxtimYg
         TVoK+YGXK7nbFHF0ykRBPsKI3DDQR9uDk/SfqP3ng2a462tViNsbQPrWLoQU8byY+ZkH
         NAXVtNsem3dW6UyvF9IkNVll9OhGoVzkRJupzKxkylIfjZ641a9c2TJYhUA1SAqRgWNb
         kYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I/XAz6EQQu2WMJ2Xm/Zu1m8Sd6t9gK7D5HCK9hWTzCE=;
        b=hRgAJ9pvP9uLpavZcNT/UBgbF7q2mzAwzIYAfu87V3XqvCIAhXObeaLcPkVWsmS37J
         xXjJL0g03jHxl1gKzpQJXeUToDgDg7gMuBToYmZHLwTJuf1DPg1jKM5tQAev+OHu56z0
         fRYhYUcU8RvED5agRj90vIROHk883pygkQCQ4elEHpqInuskyZM1ATc/S8XGkAaZlhAh
         WEJ+hP9x+lBi0vpoIoemwyCirpN0vZfNxOazlhoXjkQfYmeG1IEbZa27TkgbvJJ95zZ+
         UDQH7yKzgA4hjsfJG9rmsEka6iyVTynuoYh/uvzDDVq3hiFYY743LUEGfQlUdOZpGImR
         KcOg==
X-Gm-Message-State: APjAAAUjnvQjMFVU6buGgr1/Nlidl0Z0eKnKaLjydC/rZEJ/MpLVvKtT
        9pEc/CMN5m9kejkEGmJ26KxPaFMRDWlEfE0q3bZxCw==
X-Google-Smtp-Source: APXvYqzbJ/Tk9Al57lBqL/SeljRXAbglXoJFju7NC/jfHt0IuVX+6aDIXdMxE1cxGezyP3wqRp8o1f7BVO4yYBd3Nu4=
X-Received: by 2002:ac8:c01:: with SMTP id k1mr34376936qti.59.1570532014073;
 Tue, 08 Oct 2019 03:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191007115009.25672-1-axel.lin@ingics.com> <20191007115009.25672-2-axel.lin@ingics.com>
 <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
 <20191008104407.GA4382@sirena.co.uk> <CAFRkauDq=6X9LRj7APwKOV+7CVZN5OSVuWXmwBQ3QQPWD9Nauw@mail.gmail.com>
 <20191008105101.GB4382@sirena.co.uk>
In-Reply-To: <20191008105101.GB4382@sirena.co.uk>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 8 Oct 2019 18:53:22 +0800
Message-ID: <CAFRkauCft5p4P_LkZVLde62Yh03p-_2hNPm6wEct5XSeg-p0Bg@mail.gmail.com>
Subject: Re: [RESEND][PATCH 2/2] regulator: da9062: Simplify
 da9062_buck_set_mode for BUCK_MODE_MANUAL case
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 08, 2019 at 06:48:15PM +0800, Axel Lin wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > It doesn't seem to apply against current code.
>
> > I just test apply it and It looks fine to be applied by linux-next tree=
.
> > Or which branch of regulator tree should I generate the patch?
>
> Well, I queued it for 5.5.  I've not seen if it's got dependencies
> against 5.4 yet but you chased me so...

Ok, I see the problem.
commit a72865f05782 ("regulator: da9062: fix suspend_enable/disable
preparation") is in for-5.4 branch
but not in for-5.5 branch. So it does not apply to for-5.5 branch.

But if I generate the patch on for-5.5 branch, I think you will get
conflict when merge for-5.4 and for-5.5 to for-next.
