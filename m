Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC39EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16262173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMjby8wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfH3Mzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:55:43 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:42814 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3Mzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:55:43 -0400
Received: by mail-io1-f54.google.com with SMTP id n197so11734237iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNnBzo8UVoTjL4wSLgI7GVaHhYiAJWqGOIGNt2syJds=;
        b=qMjby8wpIWmuoz6hJKNlQHJXIUhrgW4smA90LuK3yIXWp0rj9Kf/rS2RlTZPPSpvL2
         fDQu1W0wrbHDEpnW4q96l1IIi7Fv9zoD7fMSlGCMsieoVt0PSr1M0GZLcqI+h2G5GkR1
         C1iHNGaTeQPeSfSQ9bSWW1lrokQO4DXJB0sfm3Q9+IAQtyCvfZjRb7ZvLnOH/+srsqLv
         SL714iq3i+5potUan6Tjw7oOlSCEBOYdkCdrsjpz096kUgOUXKFBWvjw8s3zfe1bqtRF
         /uf2bLC+2ICNl2Sr1LurlCFzZh10p+1F0TUsn4CrLHhyVrp755zBXWvtuuqsrHYdJ2SZ
         YnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNnBzo8UVoTjL4wSLgI7GVaHhYiAJWqGOIGNt2syJds=;
        b=ENuXR6gktwjuikBoQjxZzwDgYs8/qYP8M0W7bk9fAl24mqSAUkI+SImDdEM/g769dA
         zErRTwsKQLEpRnIwtmaiMCYfCxqoRdUmTI71y7A38RofGzOdY3yo5LZ4vfXs9EeH+S4Y
         AiF6NyxsYUu3p7aX7Er1znE7R8zaOK3GLUblAckv/eqL4sviPiTpV4nOQ+H12+hW4WHF
         uJPSS9b/PirIeUmv3eGMXFCioVEM7H8G9idWUN9AQF0sifs2YDec822SH4HoQuk0ePbS
         Fi8TlVPpu6lNDnh9DTrLwIHgkHR/WL9LicvgtGJyw8Yw5fMmgYiS4detkQED3xOneHjH
         Fm0A==
X-Gm-Message-State: APjAAAVmvnqcfcWUEA8xb1h8mpWS26kxTNflZrxxZcsGrY12WCAAhINW
        Kij4A1oT/qTTftp+H1E2sfTGk9DAmc5qwnrC6zMCel0=
X-Google-Smtp-Source: APXvYqx+Ua5Si7yLDAo4+pt5UYoEY8hUjfGHu/9/XjpVmOtk+kFIcoQwQVdshhSWpm92/vq73j96+CnO7LQgYGJbSUc=
X-Received: by 2002:a5d:8d0b:: with SMTP id p11mr1082984ioj.136.1567169742741;
 Fri, 30 Aug 2019 05:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com> <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
 <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com> <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
 <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
 <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com>
 <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
 <CAM6Zs0XE8GW-P4Q3YM3KZo-1L+g2wt5QRN+JM3_m1xuwgFDVXQ@mail.gmail.com>
 <alpine.DEB.2.21.1908212313340.1983@nanos.tec.linutronix.de>
 <CAM6Zs0VT4hnLu6YAutW8at1-W7DWN990atqdxP2Wv9MwjGG5Dg@mail.gmail.com> <alpine.DEB.2.21.1908281747080.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908281747080.1938@nanos.tec.linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Date:   Fri, 30 Aug 2019 07:55:31 -0500
Message-ID: <CAM6Zs0WX2Dp7bWs+mERCWgJbuOdShMRRS-9g+7nyinkUqj=xDQ@mail.gmail.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Woody,
>
> On Wed, 28 Aug 2019, Woody Suwalski wrote:
>
> > I have tried to "bisect" the config changes, and builds working/not
> > working between
> >  rc3-rc4-rc5, and come out with the same frustrating result, that
> > building a "clean" kernel is not producing the same behavoir as
> > incremental building while bisecting.
>
> So what you say is that:
>
>    make clean; make menuconfig (change some option); make
>
> and
>
>    make menuconfig (change some option); make
>
> produces different results?
>
> That needs to be fixed first. If you can't trust your build system then you
> cannot trust any result it produces.
>
> What's you actual build procedure?
>
The build procedure: a "clean" one - I have a script/make to build a
.deb by untar the src, patch, copy .config, run make oldconfig, run
make, package.

The bisect and config-change procedures were simpler - I was running
"git bisect bad" and make (followed by make modules_install, copy
bzImage to boot, rebuild initramfs) and reboot. For config changes -
drop new config, hand-merged in steps toward the presumed "good" one,
and run make, and install and reboot...

So I was not running explicitly make oldconfig every time, however I
believe that config has been updated to match other options
selected/unselected by make itself (so I have assumed that make
oldconfig has been automagically run sometime during the build).

But for the bisect procedure I did not run "make clean" at every step,
again - in my former bisections it was not needed, and actually saves
a lot of compilation time toward the end of bisection...

As such I could not directly answer your question - however yes -
building "cleanly" from source seems to produce different results than
doing it incrementaly...

Thanks, Woody
