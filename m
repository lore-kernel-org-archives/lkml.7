Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7EEC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D388D207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="epoV/rWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfISKsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:48:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36525 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbfISKsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:48:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so3624097qtf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S84nPCMJw9014JGc2/dK9IWBxuhEAg3PazuB+GdiwGY=;
        b=epoV/rWGyV+MeWkqCmr1N0HPDaOuyIUAOjpBEJur9IzQRw9OhWkvcFyS3mKV/ZDIKo
         Hsv7jI6ug4T5DCmRWwIiMaSR/3qoUIRpFCO8njewQOpVLG780sJXDQ+W7MtCWgFm4OJf
         rBSYmJDPF27Sj0p/USsIon84XoxNyaz5w0q/hgpekwzylQw85FAP5/cEh5jdpRttaNK2
         GiTyGlx8W/3zz3W0tXInCXXmc0YuvTjcyX/igseGYZXDmDgFzyk/CSd/uOARFJlFv8BB
         z3Pwe4Ymb+uXvbT0E4UrelJd4Cfh9RBJUvkDEeaSMDdHEe86s4q8tE6nTNfw4K0CTT+S
         E2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S84nPCMJw9014JGc2/dK9IWBxuhEAg3PazuB+GdiwGY=;
        b=Eoj+r6tPYTSITjmJP4SjCzgVH/guq36U1nCJu3gA7tp5lXVc4hK419mx2zOh8cR2q8
         z9YYIpVsUr3THXVLo/ZcDuykGSsW7Y8dg4n0AIPY3JUOe3oUO5Jh0rxlQ6zNbHWZdauQ
         fBsBVKmUWag7k6IOOVFaYIfxYCkWaK2bqHzmZZpiTMHDk4Zi1BojENEF+aKH1Ry4LdHC
         KDTo92fgX3zfkuU48jKdhzFxOoT5h3qUn78J6r53OHmGe9p46qaH2kod4BJ84GeaKgnT
         l93lY/s/GefLM5udlsSpOHX6hi5VSM3CA+ANKzCM0/GFz+wG3MjY9vF0LW0bbKL8wrE9
         E2yw==
X-Gm-Message-State: APjAAAUfV9cBENXq3qpzlxZgYpN0J6ma3HY+wJhlCrFuZ0Zo+IGOsjwh
        nCc6WxW/YOugjafQrf/9gVrlU9y/UaHbliKnJTA5ug==
X-Google-Smtp-Source: APXvYqx0WQCFMLZUm7VzlRE6d/t71TZ4OI6ZTg/ZfOLHT1IoSbKsT/JgNfS5bdw3Ul1urko74l5x6/ZlECf4xji7aa4=
X-Received: by 2002:ac8:595:: with SMTP id a21mr2344007qth.337.1568890129189;
 Thu, 19 Sep 2019 03:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190322121745.159768-1-kyletso@google.com> <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net> <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com> <20190409130649.GD20058@kuha.fi.intel.com>
 <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com> <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=0rRgNH5bU-zcP58MNi+VSa+xeAQWL67egaZ-ui-ebmYA@mail.gmail.com>
 <9f9a2de9-2cfb-385c-8e99-54b2587113ce@redhat.com> <AM5PR1001MB09943830CFED9CB321CC883D802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com> <009662c6-2897-e2dd-03a7-992fc0a78599@redhat.com>
 <AM5PR1001MB099452876C75E45FD774BA77802B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB099452876C75E45FD774BA77802B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 19 Sep 2019 18:48:32 +0800
Message-ID: <CAGZ6i=10-DVWRseYXjRGVyRtnTijT9Mg_TBTkv=3qWiMfv28cw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping! Anyone still reviewing this patch?
I have another change related to AMS.
I will group them as a set and re-send it.

Regards,
Kyle Tso


On Mon, Apr 15, 2019 at 6:03 PM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 13 April 2019 21:39, Hans de Goede wrote:
>
> > On 10-04-19 18:38, Hans de Goede wrote:
> > > On 10-04-19 18:14, Adam Thomson wrote:
> > >> On 10 April 2019 16:45, Hans de Goede wrote:
> >
> > <snip>
> >
> > >>> Starting toggling from tcpm_set_cc() just feels wrong; and currently
> > >>> power role swapping is broken with the fusb302, which IIRC used to
> > >>> work. I suspect this is related.
> > >>>
> > >>> I plan to write a patch tomorrow to functionally take tcpm_set_cc()
> > >>> back to the way it was before. This should fix your case and I hope
> > >>> this also fixes power-role swapping.
> > >>>
> > >>> This will re-introduce Adam Thomson's problem, but I have a feeling
> > >>> that that actually needs a fix in the tcpm.c code rather then at the fusb302
> > level.
> > >>
> > >> To be clear here, the names TOGGLING_MODE_SNK and
> > TOGGLING_MODE_SRC
> > >> are a misnomer from the HW spec for fusb302. The device isn't
> > >> toggling anything as far as I'm aware, so I don't necessarily agree with your
> > point.
> > >
> > > If I understand the datasheet correctly:
> > >
> > > "The FUSB302 has the capability to do autonomous DRP toggle. In
> > > autonomous toggle the FUSB302 internally controls the PDWN1, PDWN2,
> > > PU_EN1 and PU_EN2, MEAS_CC1 and MEAS_CC2 and implements a fixed DRP
> > > toggle between presenting as a SRC and presenting as a SNK.
> > > Alternately, it can present as a SRC or SNK only and poll CC1 and CC2
> > > continuously."
> > >
> > > It is still attaching Rp resp Rd to CC1 or CC2 one at a time to detect
> > > polarity, so it is still toggling, it just is not doing dual-role
> > > toggling. This is also expected behavior for a sink, a sink may not
> > > present Rd on both CC pins at the same time, otherwise the source
> > > cannot detect the polarity and the source also cannot detect if Vconn
> > > is necessary.
> > >
> > >> It's a mechanism to
> > >> have the HW report when the CC line changes on connection. Without
> > >> that we have no reporting from the HW for the fixed role scenarios.
> > >
> > > Not just connection, also polarity detection. Notice that the tcpm
> > > framework / the driver also has a start_drp_toggling() method. I think
> > > we may also need a start_srp_toggling function just like it and call
> > > that from the SNK_UNATTACHED and SRC_UNATTACHED states for single-role
> > > ports. I agree that we need to start toggling when in those states,
> > > but tcpm_set_cc gets called in a lot of other places where AFAIK we
> > > should NOT restart toggling and your patch causes us to restart
> > > toggling in those cases.
> >
> > Ok, so as I suspected, commit ea3b4d5523bc ("usb: typec: fusb302:
> > Resolve fixed power role contract setup") is what caused the power-role
> > swapping breakage I've been seeing.
>
> Apologies for the breakage. Annoyed I didn't catch that when submitting that
> patch. Thanks for looking to resolve this and will review your updates shortly.
>
> > So I've prepared a 3 patch series:
> >
> > 1) Add a new start_srp_connection_detect function which, when implemented
> > by the tcpc_dev, gets called instead of start_drp_toggling for single role ports
> > (SRPs)
> >
> > 2) Implement 1. for fusb302 to fix the SRP issue Adam was seeing, without
> > depending on set_cc starting "toggling"
> > or something like it for the fix
> >
> > 3) Revert commit ea3b4d5523bc, restoring power-role swap functionality.
> >
> > This should also fix the issue Kyle Tso was seeing when trying to change from one
> > Rp setting to another.
> >
> > I'll send out the series right after this email.
> >
> > Regards,
> >
> > Hans
>
