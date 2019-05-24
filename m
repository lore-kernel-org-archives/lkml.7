Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E71C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5362A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDI3F29C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfEXWKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:10:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34694 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:10:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so8138219oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LisRJTREeElarjcXKZC7fl+vtn+Mo2sCNeHPnzLj33A=;
        b=QDI3F29CT2xbd8l417LVX21hqEO0X4lbbyLIBh0TCAA5kKQ8nKiaXLQBylAT+wZ1nH
         a34kWCwnrpYG8/8D6uU97/7/hznFs/oQQfCu+AJjRHNeLchLjaILjqbK3mxoWWlu7gGL
         J9HDm5/OlGkklpyLrQdrMb+bnvYfwbPHR99QyXgGqlvT8a0M5KP7PZDCEcFiWmWdKnxQ
         WEHYXi3SOtdc9S6KyPBm8IoHiLlR95MdpU4daZSOA5aoaTC91qOMdfRpuNLAjGU4IRc3
         kcDE8WnJyjwLlL5sweduBFnAq5N1JHTeRI1XG7gEZXM+GvfAWITapVtq+flu+teb2cHH
         V38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LisRJTREeElarjcXKZC7fl+vtn+Mo2sCNeHPnzLj33A=;
        b=IQkzXTOdO3142e7++agZlBVqGJw8J5ttF71AAmhJnHIpnlDgZsx8AcYXus13d+h3rE
         VBjyZVLT8a4lZJZwb9vwv3m3YYRXdV6/JcI5IhYFNbEfguewNSCsB8ogt0U0d51cTwzR
         3YowlpMyDGWH7Ms/JC4E5yCMqKXWcDYlCje2bEmHef6vVNsyK9SrWSfdfRu9jcbdTYUw
         ueYek/dpbUL7RiBGAd8cpJjxhXBpFyiPu3vYeOXuDmn6Pl34oQ2R6yMTTi7IZiouowqm
         cgEXpWGn0iQ2Up6QCT0gQIYJSwuTpofM7eWg4ar7sivrSDHKfBlXUEGf0QUL24LKDtJ8
         8F3Q==
X-Gm-Message-State: APjAAAUKqSQoqAkGNZ5Bas39LT0lPgaGM9Q/ls5uVTbkbwh38YisNmAD
        C2GmEur5QU792gGU0EdajZBGh3T4QoeYqfNRcUdLOg==
X-Google-Smtp-Source: APXvYqyZdhjdDutgv+h5FjevhFuR56ah0TQQGzA79IF2t7jctEwDhWSQrdnxSQUtwR3A8RGA0+aWb56kya2cx3qLdG8=
X-Received: by 2002:aca:da45:: with SMTP id r66mr1131120oig.24.1558735805773;
 Fri, 24 May 2019 15:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <20190524010117.225219-4-saravanak@google.com>
 <20190524150135.GD15566@lakrids.cambridge.arm.com>
In-Reply-To: <20190524150135.GD15566@lakrids.cambridge.arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 May 2019 15:09:28 -0700
Message-ID: <CAGETcx-DgM2M2iA7x=2nsGu4LVcFAN+o=Wgg+tP+fOUv+D-vLQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] dt-bindings: Add depends-on property
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:01 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, May 23, 2019 at 06:01:14PM -0700, Saravana Kannan wrote:
> > The depends-on property is used to list the mandatory functional
> > dependencies of a consumer device on zero or more supplier devices.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../devicetree/bindings/depends-on.txt        | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/depends-on.txt
> >
> > diff --git a/Documentation/devicetree/bindings/depends-on.txt b/Documentation/devicetree/bindings/depends-on.txt
> > new file mode 100644
> > index 000000000000..1cbddd11cf17
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/depends-on.txt
> > @@ -0,0 +1,26 @@
> > +Functional dependency linking
> > +=============================
> > +
> > +Apart from parent-child relationships, devices (consumers) often have
> > +functional dependencies on other devices (suppliers). Common examples of
> > +suppliers are clock, regulators, pinctrl, etc. However not all of them are
> > +dependencies with well defined devicetree bindings.
>
> For clocks, regualtors, and pinctrl, that dependency is already implicit
> in the consumer node's properties. We should be able to derive those
> dependencies within the kernel.
>
> Can you give an example of where a dependency is not implicit in an
> existing binding?

I already gave the IRQ example. But if that's not good I replied to
other emails with a clock providers example that's based on real
hardware.

> > Also, not all functional
> > +dependencies are mandatory as the device might be able to operate in a limited
> > +mode without some of the dependencies.
>
> Whether something is a mandatory dependency will depend on the driver
> and dynamic runtime details more than it will depend on the hardware.
>
> For example, assume I have an IP block that functions as both a
> clocksource and a watchdog that can reset the system, with those two
> functions derived from separate input clocks.
>
> I could use the device as just a clocksource, or as just a watchdog, and
> neither feature in isolation is necessarily mandatory for the device to
> be somewhat useful to the OS.

Aren't you talking about the supplier here? I don't see any issues so far.

You could have consumers that try to use both the features of this IP
you mention (although I'm hard pressed to see how a watchdog is a
mandatory dependency but let's assume it is). So lets say consumer A
adds depends-on to your IP block for the clock and consumer B adds
depends-on your IP block for the watchdog.

If your driver is incomplete and provides only the watchdog feature,
then consumer A and B will attempt to probe once your device probes,
but consumer A will never probe successfully because it'll keep
getting -EPROBE_DEFER or an error. Your driver will never get a
sync_state() callback and that's fine because you don't know how to
use or turn off the clock source.

If the situation is reversed and your driver provides only the clock
feature, then consumer B will never probe because it'll never be able
to "get()" or whatever it tries to do with the watchdog feature. And
your driver will never get a sync_state() callback and you can never
turn off your clock. But that's the best you'll get till you send a
patch to add the watchdog support to your driver :)

> We need better ways of dynamically providing and managing this
> information. For example, if a driver could register its dynamic
> dependencies at probe (or some new pre-probe callback), we'd be able to
> notify it immediately when its dependencies are available.

We can't depend on the drivers to notify the core framework because
that doesn't work on a system with modules. The example I gave in the
commit text for the last patch is a good one. If your driver is
supplying power to the screen backlight and the backlight module is
never loaded, you can never turn off the supply to the backlight ever.
That use case has to work and it won't work if you depend on the
backlight driver to tell you what it depends on.

-Saravana
