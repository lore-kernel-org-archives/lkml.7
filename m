Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB85FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8B820673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567096111;
	bh=/3XYAj9CTeqNvEs/5WFosqWbeVIGIJC89BWHtEUKy6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yccf6YM+kXcvdfkejXpwG7aLvq6+31e4f9xsIBLgm24wO92xohF+Yw24RJTzugmdO
	 wt6FrT221pnrSeZjynNkF0zRaNudMHCiGcSsxXBLYfQ1xOPzFswqyrKiP0uIPzOiw2
	 alZ+LQi8yaZ0zzXDDtGPK+MI9tGqO/Fav0NEj9PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfH2Q2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfH2Q2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:28:30 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10ABC21874;
        Thu, 29 Aug 2019 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567096109;
        bh=/3XYAj9CTeqNvEs/5WFosqWbeVIGIJC89BWHtEUKy6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vh8jxTE9WDNlVqN9nDyLo2hP/zQwl5fieofWR+NvbRQ0Fv1BtBJnVyV4sS6QDZAcw
         iTy7+1VajtoKlu7vrbo2eAcnUFDTFHaQTrTDVNWkroiQULkDdlO6Vdf1JAe11jWUuq
         WqyZS2jf+CwCos5xrIbDtP6XzmJ+Fz50WKcdDTKk=
Received: by mail-qt1-f173.google.com with SMTP id y26so4350279qto.4;
        Thu, 29 Aug 2019 09:28:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVq4y2DvizS27hlIsKkOTOCXVC3nTyaS/Tp0jDXioUHgzMPCX2I
        hAMHNOw6Zltq9RY1xU2/JcpDh3GhJZBQbUkagA==
X-Google-Smtp-Source: APXvYqxQAVi5sTuGVrQcOOhxsD8C1pY1fapusvr14aZUc3qMow3tTYBTgbOKbg0VIyz4suaIb9yRp12OMoEaCpRNAhE=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr10849544qtc.110.1567096108264;
 Thu, 29 Aug 2019 09:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
In-Reply-To: <CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 11:28:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
Message-ID: <CAL_JsqKWcGSzCF_ZyEo6bbuayoYks51A-JAMp_oLR1RyTUzNUA@mail.gmail.com>
Subject: Re: Adding depends-on DT binding to break cyclic dependencies
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:55 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Hi Rob,
>
> Frank, Greg and I got together during ELC and had an extensive and
> very productive discussion about my "postboot supplier state cleanup"
> patch series [1]. The three of us are on the same page now -- the
> series as it stands is the direction we want to go in, with some minor
> refactoring, documentation and naming changes.
>
> However, one of the things Frank is concerned about (and Greg and I
> agree) in the current patch series is that the "cyclic dependency
> breaking" logic has been pushed off to individual drivers using the
> edit_links() callback.

I would think the core can detect this condition. There's nothing
device specific once you have the dependency tree. You still need to
know what device needs to probe first and the drivers are going to
have that knowledge anyways. So wouldn't it be enough to allow probe
to proceed for devices in the loop. Once 1 driver succeeds, then you
can enforce the dependencies on the rest.

> The concern being, there are going to be multiple device specific ad
> hoc implementations to break a cyclic dependency. Also, if a device
> can be part of a cyclic dependency, the driver for that device has to
> check for specific system/products in which the device is part of a
> cyclic dependency (because it might not always be part of a cycle),
> and then potentially have cycle/product specific code to break the
> cycle (since the cycle can be different on each system/product).
>
> One way to avoid all of the device/driver specific code and simplify
> my patch series by a non-trivial amount would be by adding a
> "depends-on" DT binding that can ONLY be used to break cycles. We can
> document it as such and reject any attempts to use it for other
> purposes. When a depends-on property is present in a device node, that
> specific device's supplier list will be parsed ONLY from the
> depends-on property and the other properties won't be parsed for
> deriving dependency information for that device.

Seems like only ignoring the dependencies with a cycle would be
sufficient. For example, consider a clock controller which has 2 clock
inputs from other clock controllers where one has a cycle and one
doesn't. Also consider it has a regulator dependency. We only need to
ignore the dependency for 1 of the clock inputs. The rest of the
dependencies should be honored.

> Frank, Greg and I like this usage model for a new depends-on DT
> binding. Is this something you'd be willing to accept?

To do the above, it needs to be inverted.

Convince me that cycles are really a problem anywhere besides clocks.
I'd be more comfortable with a clock specific property if we only need
it for clocks and I'm having a hard time imagining cycles for other
dependencies.

Rob
