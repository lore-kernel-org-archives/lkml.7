Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6555BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A60123431
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rueq1X24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfIDILY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:11:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfIDILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:11:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so8697221oih.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QBe1xYUcl4wDPPrpgdNI6/tC7+3FY0gRDDgV5gUzDa0=;
        b=Rueq1X24ipwfeeFmHVaKF9ycat0gHgTh38x0qR37JORw4l5B2Wx493lvyQia1pYdLI
         XNHfFSGS00l0i9/yVSMrUkxRqU9GDLooHyNNMbCUv8+BSDeEsz1XqDoJoGfWRTlCcUPr
         E+1DBRUq50i1U1CmBJ2wizt5bfZY1AGffFX8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QBe1xYUcl4wDPPrpgdNI6/tC7+3FY0gRDDgV5gUzDa0=;
        b=BE6Lh+4CrYhQ2aZnOvcJGo3yDTDoGdJ2VdUGqoQ1QTWOzzexji/XlDGg43C+E/77VC
         PeL+Rz7MA+AIHi6ULuZD7L/Jw4and720DGjUlGvCZkd7YWPmvYFY09VIruokh22p/VPr
         9hTPZrtPld1pIHUJjyi1ldIYM9F4eMZOul7Esg0mgTgdPYHiG1/j6mmgW5UJp5vfExVG
         iJOT3NFm2fGyOgxcH5LJxjIb+97d7+VG8jjMmWeVlFbXd6V01yKvIYwRRd8ROUJLPcsU
         OJv61feb1rmASNNbpCZhZ/TmGexuhHlFj/QLrpV2hk8BEGbtlZel359Ln7JNagGApN7f
         9JHQ==
X-Gm-Message-State: APjAAAXMKTs9Y5fFSJMPHp9OyaJH1sqcb+VRuXmxcxofggSWDa/fJL0E
        7EfQXYb7qafQKsbW4UsBkPMa6b4fm6ijbfJajf38EspCyWM=
X-Google-Smtp-Source: APXvYqyBQTosIHingKj0P7SporWLcB6z0O7c6rA8B5z3JZ1HTYa1GUQ5sXSJq6kSN8/U1R1RtpxNjxd8GuGYoL3qNT8=
X-Received: by 2002:aca:f20a:: with SMTP id q10mr2479529oih.128.1567584683033;
 Wed, 04 Sep 2019 01:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <c6e220fe-230c-265c-f2fc-b0948d1cb898@intel.com>
 <20190812072545.GA63191@shbuild999.sh.intel.com> <20190813093616.GA65475@shbuild999.sh.intel.com>
 <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de> <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de> <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de> <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de> <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de>
In-Reply-To: <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Sep 2019 10:11:11 +0200
Message-ID: <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8% regression
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 04.09.19 um 08:27 schrieb Feng Tang:
> >> Thank you for testing. But don't get too excited, because the patch
> >> simulates a bug that was present in the original mgag200 code. A
> >> significant number of frames are simply skipped. That is apparently th=
e
> >> reason why it's faster.
> >
> > Thanks for the detailed info, so the original code skips time-consuming
> > work inside atomic context on purpose. Is there any space to optmise it=
?
> > If 2 scheduled update worker are handled at almost same time, can one b=
e
> > skipped?
>
> To my knowledge, there's only one instance of the worker. Re-scheduling
> the worker before a previous instance started, will not create a second
> instance. The worker's instance will complete all pending updates. So in
> some way, skipping workers already happens.

So I think that the most often fbcon update from atomic context is the
blinking cursor. If you disable that one you should be back to the old
performance level I think, since just writing to dmesg is from process
context, so shouldn't change.

https://unix.stackexchange.com/questions/3759/how-to-stop-cursor-from-blink=
ing

Bunch of tricks, but tbh I haven't tested them.

In any case, I still strongly advice you don't print anything to dmesg
or fbcon while benchmarking, because dmesg/printf are anything but
fast, especially if a gpu driver is involved. There's some efforts to
make the dmesg/printk side less painful (untangling the console_lock
from printk), but fundamentally printing to the gpu from the kernel
through dmesg/fbcon won't be cheap. It's just not something we
optimize beyond "make sure it works for emergencies".
-Daniel

>
> Best regards
> Thomas
>
> >
> > Thanks,
> > Feng
> >
> >>
> >> Best regards
> >> Thomas
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
