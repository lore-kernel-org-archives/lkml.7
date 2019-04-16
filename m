Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818FF20872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCt81qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbfDPRKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33170 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so10657918pgh.0;
        Tue, 16 Apr 2019 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yZ3+SyiTKCssIAOvU/ruDWpPlPUw9/GOSXDr85FF90=;
        b=euCt81qrbiWQ5b3nzxGBQ0bnfWZqgLeMnlY9UOAyWLOoCxxY4sn+e46a8IbaLAsq46
         HnX6WgOb8o7cIuZoSqCChbw+XW96kuuvWWGv3qIIGZP1u8VBjt2PRJl5oYj96iHJqY80
         iQXdMgqxms+n8L9827SZmhNAwNCCJqmbZJVAarvZVswYTpQBRaqtOxHFFu3XdtSnQ4on
         sVUI1ge2BZQDHqCXq5QYkyKqpnfbz1A1toHXaYNKvnSdiYPNwer/HMhemiYGufTm5rhG
         ToINOTCoq5Lc+PLJ5GTx5wuuhAuCETfOqkgm4fjfPDnca+WhO23qZyn6KHx/Q/ddP+AE
         Kqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yZ3+SyiTKCssIAOvU/ruDWpPlPUw9/GOSXDr85FF90=;
        b=ZgK+agPm4+1XcqVP7hcMtp53yFccnMQsJFurYXTXYxJXcp7pZAWjhxfaiIyJCr/b+h
         eFb7cUARcZ3sqG1uhQdBxasN1lSaIJoiHFkiQh5ATMBfH4lcEKYpMRQ1GXY5WmfsDJa5
         0u+uBpNIr3/vT68O4YOeZ1EXNJDPmj9GwpJDQtTQgIWMLri3l22Dv6Ni5Ea1nci0qTp1
         lcE6EAzgPJWhH/xoxaUPrvE4G4m1UaWUigBU/koRHXU9Kq2h9A6lbrnaNmlLeqMglFyY
         oItXuAJyBsxT5vXbX2llULL7MjgNIj+KinqFPN9HDDPcWSGYAmcd6PyABUWlBYIBmP2b
         QprQ==
X-Gm-Message-State: APjAAAXmWIF7dcAduBWNtwwMSBF7l+nuEL9URkAuyJesUMsP8THGfnpy
        pzj9Ql8P5MGyuEtfLeHRL/Jnv4L2jzevYd5S3pX5vVR3
X-Google-Smtp-Source: APXvYqw3an4H+ZaVcwy/0zqRWL8zhfkHu/hlIEI9b5Ju66roh0+O8Yre980QBwZ821BAl/HZPj4lFxEe56OixqlZWbU=
X-Received: by 2002:aa7:8d9a:: with SMTP id i26mr71707213pfr.220.1555434601210;
 Tue, 16 Apr 2019 10:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416012001.5338-2-xiyou.wangcong@gmail.com> <20190416095852.GA31772@zn.tnic>
In-Reply-To: <20190416095852.GA31772@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 10:09:49 -0700
Message-ID: <CAM_iQpU6+xD+LmVtd=GPVp2zXgmLjT8tstRa7ia0pNgO0AcaPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ras: close the race condition with timer
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:58 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 15, 2019 at 06:20:01PM -0700, Cong Wang wrote:
> > cec_timer_fn() is a timer callback which reads ce_arr.array[]
> > and updates its decay values. Elements could be added to or
> > removed from this global array in parallel, although the array
> > itself will not grow or shrink. del_lru_elem_unlocked() uses
> > FULL_COUNT() as a key to find a right element to remove,
> > which could be affected by the parallel timer.
> >
> > Fix this by converting the mutex to a spinlock and holding it
> > inside the timer.
> >
> > Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >  drivers/ras/cec.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> > index 61332c9aab5a..a82c9d08d47a 100644
> > --- a/drivers/ras/cec.c
> > +++ b/drivers/ras/cec.c
> > @@ -117,7 +117,7 @@ static struct ce_array {
> >       };
> >  } ce_arr;
> >
> > -static DEFINE_MUTEX(ce_mutex);
> > +static DEFINE_SPINLOCK(ce_lock);
>
> Nah, pls keep the simplicity here by retaining the mutex. Use a

I don't understand why mutex is simpler than a spinlock here.

They are just locks requiring different contexts, I don't see how one is
simpler than the other. Do you mind to be more specific?


> workqueue instead to queue the spring cleaning from IRQ context and then
> do it when back in preemptible context.

By workqueue, you must mean to say delayed work, right?

But the global workqueue is not serialized either, if you really prefer to
move it to a same workqueue for serialization, we have to switch to an
ordered workqueue here. It certainly could work, but I don't see how
this way is any simpler than just using a spinlock.

What do you think?

Thanks.
