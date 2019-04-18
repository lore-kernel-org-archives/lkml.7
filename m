Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB137C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BjAG+2cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfDRPfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:35:40 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:33360 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:35:39 -0400
Received: by mail-vs1-f47.google.com with SMTP id s11so1406934vsn.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hi4lqBhaN/AwwaaJeItLf8qSxmTg8+ij+o9xauLCQJ8=;
        b=BjAG+2cf//Fi00v0D/sekU7PZd3rTw9Do8+cr4GzVamCzuewtkVlYkMluzjb8sqgfT
         8qDJOWB4UudlRDI3rTVWs0yayxeNJztxrYiPAzxY1jZ8a48Q58P0oI7yzV4NrkFvvHVi
         c80srcG6fTON4msNrMK5UEONylegHMpjQC/0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hi4lqBhaN/AwwaaJeItLf8qSxmTg8+ij+o9xauLCQJ8=;
        b=ofolvMXloP3KMKIEUdqklbTr1aCul+cRH+CYmQAztLIX4FEeu/+GZy1SebDa/3ONoD
         R/dcNeAYydFCyt8jh7njnYwMZ5SO+Xn99mhZKDXNiO9SC8ZA1kKTetKmfh+yUOgrZp/D
         vY36GjD+rjMsen9Aew71xX/JneguPapWLnuLQeXsbVPXfBVabNBPCBiIaHC0McFKaX3K
         ohYBxH0uwpjYsrEuHL6ZE3jTetID7Qw5cKShk6Hn5OGcZ25bycSno4z+YCJlMsQ9BFK4
         B+Tf+Sm1q48w8jfQeYneBh4byBl1LNmeFUYYQ9fnCLdSNISwMzo3XrJFKvo7qTuPdq8+
         Jb8w==
X-Gm-Message-State: APjAAAWUD8xmIYhtlo98tdClfqP4uZYU7Hz9ipZVa65XI4EkddsxSF2K
        1TtVTe57LaFvOUFNzx28s5YETdXh5EsPZ22Hoh3b6w==
X-Google-Smtp-Source: APXvYqxdLdBCHZVg0VEy0bEuGpn4RsJH8JEMEoe+h2Wf7lm/HDLI7Rnca3gI/U8BoI3FnRP60QeYngZQ13uOi17Aj7o=
X-Received: by 2002:a05:6102:119:: with SMTP id z25mr4058764vsq.232.1555601738068;
 Thu, 18 Apr 2019 08:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190412224539.161321-1-ncrews@chromium.org> <1d9add8f-6205-dfa2-d15c-c2fab29b091a@metux.net>
In-Reply-To: <1d9add8f-6205-dfa2-d15c-c2fab29b091a@metux.net>
From:   Duncan Laurie <dlaurie@chromium.org>
Date:   Thu, 18 Apr 2019 08:35:22 -0700
Message-ID: <CADv6+05iC-QtdHdHoCvka4r=LfW1iENxkuGbKEtD7P0=GtAFAw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add telemetry data char device interface
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 1:04 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 13.04.19 00:45, Nick Crews wrote:
> > The Wilco Embedded Controller is able to send telemetry data
> > which is useful for enterprise applications.
>
> What kind of "enterprise applications" exactly ?
>
> > A daemon running on
> > the OS sends a command to the EC via write() to char device,
> > and can read the response with a read() request.
> > Both the request and the response are in an opaque
> > binary format so that information which is proprietary to the
> > enterprise service provider is secure.
>
> In other words: a direct backdoor for the "provider", who can do
> anything he wants remotely on the user's machine, w/o the user having
> a chance of seeing what's actually going on ?
>
> Seriously ?!
>
> In some of your previous mails (*1) you indicate that it sends some
> diagnostics information (eg. "dock is not working"). WTH does that
> have to be "proprietary", IOW: encrypted = kept secret from the owner ?
>
> If I *own* such a device, this is some information, I *need* to know,
> I *deserve* to know, and it is *my* data, as it's a state of *my*
> device. And that's some kind of information that *nobody* else has
> any business with that. Period.
>

We on the Chrome OS team happen to strongly agree with you, which is
why Chromebooks are the only mass market devices to ship with an open
source Embedded Controller.

For devices with the Wilco EC we are working with an OEM who builds
specific computers for "enterprise" scenarios where a company owns or
leases the device and is responsible for the management of it, while
the end user is an employee or contractor who does not own the device
they are using.  For various business reasons we are not able to get
our usual open source EC firmware on this board, so we are forced to
rely on the vendor's closed EC firmware.

The reality is that this is exactly what a standard EC firmware is
today: a black box with an opaque mailbox interface that provides
hundreds of undocumented commands.  Typically this mailbox interface
is hidden behind the BIOS with SMI and WMI and the user has no idea
that these even exist.

We are attempting to cope with this closed EC by fitting these mailbox
commands into standard kernel interfaces wherever possible, rather
than go the traditional route of hiding it in the BIOS or simply
exposing an opaque /dev node and letting user space send whatever
commands it wants.  Our intent is for the interface to the EC to be
intentionally limited by the kernel driver and to be very clear what
commands are available and what they do.  The drivers are also modular
so that if an end user does acquire one of these devices they can
choose not to load some modules and further limit what EC interfaces
are exposed to the OS.

This specific telemetry command provides hardware information about
the device, such as voltages, fan speeds, temperatures, power numbers,
etc.  This is the one command where the vendor we are working with is
not willing to document the returned data format publicly (or even to
us) as they consider the hardware diagnostic data that they gather
here, and the analytics that they run on it, to be critical IP for
their enterprise device replacement program.

It is clear from feedback that this telemetry command is still too
opaque, and we will continue to work with the vendor to try and come
up with a more flexible command set that still allows us to implement
the interface in the kernel without resorting to the usual tricks to
hide it from the user.

-duncan
