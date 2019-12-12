Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2ADC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F62214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/jlQz9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfLLOKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:10:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38360 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbfLLOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:10:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id i6so1920127edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=agntn3zX+JI+eqZxnVa5cFTQXBG0odRbTBgJtL3lVZY=;
        b=O/jlQz9NjPnQ/JrQW1XNeB162L66kNWnwQoVszhi50nNFvsD8WGu2RXpGJMFEF8dQg
         NFtayb/Klr+dBxExR8CfGmdAyvuiD9XGxyTS1UbmvPUDw62CuyI3RZ6IQG4adEW1IXhz
         GGudm408wtx0iEWHXUff9BTpcb8pC9Pyrpr1+Au/kvF+Nm+ZRmo7BtcQZfmWgB/0zzWk
         svxm/hYxFOiJOgnGGy5Vw40LOhgrhgtvNVh0smc4e+EJJyGCdVmDCReTnppIOqVBch6r
         J20FwGj/f3TSUGMrj4O/qWeTRyavx1Qv8YIZf+O4UPBf/YJxEugLIIFbqHA4f0FnW8uP
         pjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=agntn3zX+JI+eqZxnVa5cFTQXBG0odRbTBgJtL3lVZY=;
        b=MGky5PNMiAqPFD0VujA1xP/VHDWBVg6jwXR1EAehTMt2S+pkjVJrlZjOsstYcPW/sd
         eGJmtbNoT0t/qztakudMgwLRLaY2qmdLjrKEV+3je0gcjGKNfB2npHZ1tY5T9nmbseHC
         J5sVcUoUyA4mZ10GG33+Uq9htwlVwwTHsmyyYjXozVAydd/zxZdFVUR77kKapnCDlKSW
         BaA7/5dnFiNYXSIvtqrUIExlp0UdXoqRcOSC4hh67YEjSpg+F4Q5nbSP1QFjTKdAGQUL
         0WkvQWVN6GMW1Ti92S3hP5XKXKk26IOZ+vdtZWXSkWZWYxGvdDlVMnEyHCOxnuN04Beh
         tMbA==
X-Gm-Message-State: APjAAAXyOujLfhqwl8wbVFvkVBxK9SU/1aoVBDcmVbo7jtmaeNUembxl
        keE5MhRYEvvwZRqdPTf1JALQS9zm2LWq2PPC1aE=
X-Google-Smtp-Source: APXvYqy7Az5XIaBaOPpPEXUA842/VMBLQ6xGXNRDQjXyTXISHzJOz82UB8Lx5ispYKGpyTOKUtqpm8k3Iehryv7gxWg=
X-Received: by 2002:a05:6402:1484:: with SMTP id e4mr9945028edv.286.1576159837173;
 Thu, 12 Dec 2019 06:10:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFqpmVJ90bAV4vasH1Z0DcTUjT7asCJFPeJBxtxGZwAhTVP7=w@mail.gmail.com>
 <b02d053f-1b07-bd4f-20fc-9a26106145d1@suse.com>
In-Reply-To: <b02d053f-1b07-bd4f-20fc-9a26106145d1@suse.com>
From:   Nicholas Tsirakis <niko.tsirakis@gmail.com>
Date:   Thu, 12 Dec 2019 09:10:26 -0500
Message-ID: <CAFqpmVLnHPUZEpvmw1-f=2LoPkfUHO67ETdwtnsPA7DsXRSRSA@mail.gmail.com>
Subject: Re: [BUG] Xen-ballooned memory never returned to domain after partial-free
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        boris.ostrovsky@oracle.com
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And I think this is the problem. We want here:
>
>     balloon_stats.target_pages =3D balloon_stats.current_pages +
>                                  balloon_stats.target_unpopulated;

Ahh I knew I was missing something. Tested the patch, works great! "Reporte=
d by"
is fine with me.

Do you happen to know the answer to my second question? It's not as importa=
nt,
but it does confuse me as I wouldn't expect the total memory to be
balloon-able at
all with the hotplugging configs disabled.

--Niko

On Thu, Dec 12, 2019 at 2:18 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wro=
te:
>
> On 11.12.19 23:08, Nicholas Tsirakis wrote:
> > Hello,
> >
> > The issue I'm seeing is that pages of previously-xenballooned memory ar=
e getting
> > trapped in the balloon on free, specifically when they are free'd in ba=
tches
> > (i.e. not all at once). The first batch is restored to the domain prope=
rly, but
> > subsequent frees are not.
> >
> > Truthfully I'm not sure if this is a bug or not, but the behavior I'm s=
eeing
> > doesn't seem to make sense. Note that this "bug" is in the balloon driv=
er, but
> > the behavior is seen when using the gnttab API, which utilizes the ball=
oon in
> > the background.
> >
> > -----------------------------------------------------------------------=
-------
> >
> > This issue is better illustrated as an example, seen below. Note that t=
he file
> > in question is drivers/xen/balloon.c:
> >
> > Kernel version: 4.19.*, code seems consistent on master as well
> > Relevant configs:
> >      - CONFIG_MEMORY_HOTPLUG not set
> >      - CONFIG_XEN_BALLOON_MEMORY_HOTPLUG not set
> >
> > * current_pages =3D # of pages assigned to domain
> > * target_pages =3D # of pages we want assigned to domain
> > * credit =3D target - current
> >
> > Start with current_pages/target_pages =3D 20 pages
> >
> > 1. alloc 5 pages with gnttab_alloc_pages(). current_pages =3D 15, credi=
t =3D 5.
> > 2. alloc 3 pages with gnttab_alloc_pages(). current_pages =3D 12, credi=
t =3D 8.
> > 3. some time later, free the last 3 pages with gnttab_free_pages().
> > 4. 3 pages go back to balloon and balloon worker is scheduled since cre=
dit > 0.
> >      * Relevant part of balloon worker shown below:
> >
> >      do {
> >          ...
> >
> >          credit =3D current_credit();
> >
> >          if (credit > 0) {
> >              if (balloon_is_inflated())
> >                  state =3D increase_reservation(credit);
> >              else
> >                  state =3D reserve_additional_memory();
> >          }
> >
> >          ...
> >
> >      } while (credit && state =3D=3D BP_DONE);
> >
> > 5. credit > 0 and the balloon contains 3 pages, so run increase_reserva=
tion. 3
> >     pages are restored to domain, correctly. current_pages =3D 15, cred=
it =3D 5.
> > 6. at this point credit is still > 0, so we loop again.
> > 7. this time, the balloon has 0 pages, so we call reserve_additional_me=
mory,
> >     seen below. note that CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is disabled=
, so this
> >     funciton is very sparse.
> >
> >      static enum bp_state reserve_additional_memory(void)
> >      {
> >          balloon_stats.target_pages =3D balloon_stats.current_pages;
> >          return BP_ECANCELED;
> >      }
> >
> > 8. now target =3D current =3D 15, which drops our credit down to 0.
>
> And I think this is the problem. We want here:
>
>      balloon_stats.target_pages =3D balloon_stats.current_pages +
>                                   balloon_stats.target_unpopulated;
>
> This should fix it. Thanks for the detailed analysis!
>
> Does the attached patch work for you?
>
> And are you fine with the "Reported-by:" added?
>
>
> Juergen
