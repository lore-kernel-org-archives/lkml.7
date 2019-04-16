Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23267C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E347E206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrWbPwMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfDPSAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:00:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32796 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbfDPSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:00:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so10721231plo.0;
        Tue, 16 Apr 2019 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9011hH5bzBiIpFx008nC8F1N7MLGdKNpynmAJ8DUYw=;
        b=XrWbPwMVpXUvQI5agrbZzjiliw+tVOOQxsUujJHBZJ6D8S/5w3cbWHTrVxCh90FhZO
         dEPxHwmNYYS5JORemypzIE2+YRJOV4LkVsVV+Kp0LxIRMNrIrf93loI1lBdKAB23aKFx
         7+blDWKckYBimvj//uPy0iww7qpBlz9kWWuWNviW4EjMadCJr0dns6Xa30YsJI/7J2op
         7ULiAQZ5FotD8enPd5j1joF6i855v4zt225lYUYSj+Jx2O/TIWtEF09SarMRzJyrobCo
         hqrDtXvI07VpSjV6GFy3dFl3FWmUzLSqEsxy28fiiJgKxYGREGBpoTmYAreVVTwUcblO
         Es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9011hH5bzBiIpFx008nC8F1N7MLGdKNpynmAJ8DUYw=;
        b=rPZj++s3/cuKQG0DnUnc7/ugjmLTCrZXvG5+8OjZkKguP6C3w07X0D8Q9VNQU/mJh1
         L12R/sFjN2m6KkskpNWA7GDa1I6mxQvrD6vrazGRGAX8/w+BYJbf3q2ZjlFoQ6nxBpVh
         5TyIXWZ7n+udBTNaHfqldo8C9L1HDImSf3+zeml823CgkD+BoZ+IhKhT9fZP9XJ6pzga
         j/wf96VnFoplmjXFddQeCtYiFousFVJndhPdCKJny6TbrraPezPMS1A29EKRmSDZ9218
         tVH40sn5Ozg9BMQghC8PuO1tHG0Ej8UAO5OdRXZhuzXVWHMkXcqsFFK0A0q9jLi/EiLV
         h0KA==
X-Gm-Message-State: APjAAAVAEQwsKucr780o0VM8SSb5n+NkeQsdvrThLbEOKrdwYYPlZrvq
        dls2ze0fTckm856SrcNHBZlMm4j3nt75mNI5DG0=
X-Google-Smtp-Source: APXvYqzVaRvCOuR54ejJezIhrvJpYWXi9Cl8Gk7Z6kf/+91Z0n0/NoEGo0sISUi8OB2W1Erc+l1CI2zIE5B4NPlOTgw=
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr84715669plp.126.1555437644335;
 Tue, 16 Apr 2019 11:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416012001.5338-2-xiyou.wangcong@gmail.com> <20190416095852.GA31772@zn.tnic>
 <CAM_iQpU6+xD+LmVtd=GPVp2zXgmLjT8tstRa7ia0pNgO0AcaPA@mail.gmail.com> <20190416174259.GK31772@zn.tnic>
In-Reply-To: <20190416174259.GK31772@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 11:00:32 -0700
Message-ID: <CAM_iQpWPq8p3L1v_h0_iEkq4Lcw=E84boZEQYUJxxuJtgHDo9w@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 10:43 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 16, 2019 at 10:09:49AM -0700, Cong Wang wrote:
> > They are just locks requiring different contexts, I don't see how one is
> > simpler than the other. Do you mind to be more specific?
>
> Yes, I'd like for this whole CEC code to be lazy and preemptible as it
> is not at all important when it does its work, as long as it gets it
> done eventually.
>
> Can't be preemptible with spinlocks.

Got it, but the work done with holding a spinlock isn't heavy, given
there are only at most 512 elements in the array.

>
> > By workqueue, you must mean to say delayed work, right?
> >
> > But the global workqueue is not serialized either,
>
> Serialized with what? Insertions?

Hmm? We still have to serialize either the timer callback or
a delayed work with the rest of array updates (add or delete),
right?

As far as I understand, two works in the global workqueue could
be still ran in parallel on different CPU's, this is why I said it has to
be an ordered queue to guarantee the serialization.


>
> That's what the mutex is for and the insertions happen in process
> context.
>
> So yeah, delayed_work sounds like what it should do. I.e.,
> queue_delayed_work() and decay_interval_set() should do
> mod_delayed_work(). Something along those lines, anyways.

This part is perfectly understood.

Thanks.
