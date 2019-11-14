Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E63C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E10E2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eX/6mQTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKNVBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:01:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36003 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:00:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id x22so2070035lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EidICKv+YxOdKta/BmYMkRiZPHxyIgLhnXFRPuBa/e8=;
        b=eX/6mQTc/SZuA8D7fQQO3Weyl87rPCk/GntsJseCcgZPnBhpzyFLwl3wO3kyRPrOVW
         /N+uDwayvFKH+Lp1Z/sQFnDVNx3E/1iV6zbx2E+FsyXrRnbzogUqwNC6RKLOeXqUJ7Pc
         9Ogy4mR/ToRbm7/ZzzcCrlnVNSPIHmiAyGb1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EidICKv+YxOdKta/BmYMkRiZPHxyIgLhnXFRPuBa/e8=;
        b=jEyRiPQe2u72Lq+2jCiWLmmp6W+bkcCvqXEGHF8Xk/aEZsrr0lDf+yhNhmBhwcUVOI
         wX3KEY+iSCVjKF5lE/oxc2vtbdIkUx07PFzLhrNmIZYMG5ps/Ha3nIYqw/QrYwSAKqKN
         U/BCVPCWhPp0BiVABg5M0B8InexNC2qg6i0uNrX0dL4i+mCkneGNNevrHre9wg6qyH/1
         sGNT9SY191NHuyYS5UybAKJmemL6RW7Yi7dXFWiJsqlwN6uZFrnbycRcFQWEl4YXekqs
         0OC2xGe1O5UdFZARO5WR0xM/dxLER+6k8514LhOa7CSUKAOtQzL4HkRd3+jbVZk9hr7S
         o1HA==
X-Gm-Message-State: APjAAAWltm70kyAAUCJ30chE6OVUHMPTCdrCf3ENgGYBhvB5BTe4xfv3
        cIXB9vvoS6NI19A0NIALMjGbxz6We60=
X-Google-Smtp-Source: APXvYqyjEx7A8ytf79j7HjkDw7KtiWLGj2yaChkary28cefMj/vmGduChlpmL3Hd6KZ8l5dugTnudQ==
X-Received: by 2002:ac2:5193:: with SMTP id u19mr8378874lfi.83.1573765255954;
        Thu, 14 Nov 2019 13:00:55 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g21sm2929482ljh.2.2019.11.14.13.00.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:00:55 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n5so8215950ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 13:00:55 -0800 (PST)
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr8298533ljj.210.1573765254551;
 Thu, 14 Nov 2019 13:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20191113031044.136232-1-jflat@chromium.org> <20191113175127.GA171004@google.com>
 <20191113182537.GC4013@kuha.fi.intel.com> <CACJJ=pxba6=SR=kWO-vgqU=wkj7gnVAm62b2tcYf2K+1ucySRg@mail.gmail.com>
 <20191114152432.GD4013@kuha.fi.intel.com>
In-Reply-To: <20191114152432.GD4013@kuha.fi.intel.com>
From:   Jon Flatley <jflat@chromium.org>
Date:   Thu, 14 Nov 2019 13:00:42 -0800
X-Gmail-Original-Message-ID: <CACJJ=pywjs1=6mC7M8bOYKR3HfKx97C9jMEft7d98c6-go-Ubg@mail.gmail.com>
Message-ID: <CACJJ=pywjs1=6mC7M8bOYKR3HfKx97C9jMEft7d98c6-go-Ubg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ChromeOS EC USB-C Connector Class
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Jon Flatley <jflat@chromium.org>, Benson Leung <bleung@google.com>,
        enric.balletbo@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org, Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 7:24 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Jon,
>
> On Wed, Nov 13, 2019 at 05:09:56PM -0800, Jon Flatley wrote:
> > > I'll go over these tomorrow, but I have one question already. Can you
> > > guys influence what goes to the ACPI tables?
> > >
> > > Ideally every Type-C connector is always described in its own ACPI
> > > node (or DT node if DT is used). Otherwise getting the correct
> > > capabilities and especially connections to other devices (like the
> > > muxes) for every port may get difficult.
> >
> > Hey Heikki, thank you for your quick response!
> >
> > In general we do have control over the ACPI tables and over DT. The
> > difference for ChromeOS is that the PD implementation and policy
> > decisions are handled by the embedded controller. This includes
> > alternate mode transitions and control over the muxes. I don't believe
> > there is any information about port capabilities in ACPI or DT, that's
> > all handled by the EC. With current EC firmware we are mostly limited
> > to querying the EC for port capabilities and state. There may be some
> > exceptions to this, such as with Rockchip platforms, but even then the
> > EC is largely in control.
>
> The capabilities here mean things like is the port: source, sink or
> DRP; host, device or DRD; etc. So static information.
>
> I do understand that the EC is in control of the Port Controller (or
> PD controller), the muxes, the policy decisions and what have you, and
> that is fine. My point is that the operating system should not have to
> get also the hardware description from the EC. That part should always
> come from ACPI tables or DT, even when the components are attached to
> the EC instead of the host CPU. Otherwise we loose scalability for no
> good reason.
>
> Note. The device properties for the port capabilities are already
> documented in kernel:
> Documentation/devicetree/bindings/connector/usb-connector.txt (the
> same properties work in ACPI as well).
>
> > I think you raise a valid point, but such a change is probably out of
> > scope for this implementation.
>
> This implementation should already be made so that it works with a
> properly prepared ACPI tables or DT. If there are already boards that
> don't supply the nodes in ACPI tables for the ports, then software
> nodes can be used with those, but all new boards really should have a
> real firmware node represeting every Type-C port.

Hey Heikki,

I spoke with Benson and Prashant and you raise a good point. Moving
forward we should probably be describing these capabilities in ACPI.
We do want to support existing devices, and making changes to the ACPI
tables would mean firmware modifications for each and every one, which
is a complicated process.

To date the port capabilities on all ChromeOS devices have been the
same. I recall now that we don't (and with current firmware can't)
query the port capabilities from the EC; they're just hard coded into
the driver. In the absence of these nodes in the ACPI tables we can
populate these capabilities in software nodes. This would allow us to
support existing systems without the expensive firmware change, and I
think it still provides the scalability you're asking for.

Are you suggesting that every port on the device gets its own ACPI/DT node?

Thanks,
-Jon

>
> thanks,

>
> --
> heikki
