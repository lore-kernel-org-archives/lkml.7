Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF8C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43F22080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577394435;
	bh=UXc5G2pRSARmdUQqxQWMG4M0fmEd5CAWzP0OrHZROvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jyAMv8+lc3IDxCars6jfnSxLItE2wmNW8BYVNHxT7YXUi9XTKKbV2wjBZhtsC5/sz
	 +kS24AOvqt/sXXjC+sbeVOmAXkQS0wKgvKXRMUHU/m1ds2cBUwEzuvY/6uPC0rNyUs
	 ca66PYu6VrDtLht5g4IE0pOVrhf4Ivh+rX5ETqoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLZVHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:07:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37035 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:07:14 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so15482195ioc.4;
        Thu, 26 Dec 2019 13:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMxRIP36pfqo1oLsZx8wQEz7lcEqyN2UXynWSXMemQA=;
        b=o7jaku4kRmUxfVDGwJkzduRFxv1uZ88tMqatbBaXWfksPofZ87eSnUfymmOPSMMBIJ
         OGoqu5tlok5hRAS7fIOQLyAgkGEGkTR8wfrscKq7uZr8mF/WDmclRdCPK1KHj9ZnmsW7
         7Hyi/5NmbM2wzDEoC9H47IdbXqY8GiJDKONDCJRckGzV4ODhzjR2j/7uEHPgdn7tMap8
         mlNfX5/ovA9uNGXcrkdPzPwmRUVILn0K/g3MJnJDJb/6M2exk2yWaN84VLGlqjsxy9/O
         fIlNjV6bJaTGBJEXfpCJpI8uFrwQcSSJgEWwhxWmcFwJbi7utIzpUXKtL8Oo0hw5aKbF
         a5ng==
X-Gm-Message-State: APjAAAUCaGjkxAZqm/5zq4ZM459aLaLALlMnBLztHsOukGPA2wPNswhm
        z9QX/f6CyVFt6I1KVzZ4TQ==
X-Google-Smtp-Source: APXvYqw5tw6kJzlkw3sJ9TQz9nuzEphZI0fdiuhRrk88vbu6N3WfPKg7ybS0SdebHd4aHRqa9a3eEg==
X-Received: by 2002:a02:7016:: with SMTP id f22mr36836000jac.89.1577394433234;
        Thu, 26 Dec 2019 13:07:13 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q22sm8882207iot.39.2019.12.26.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:07:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:07:10 -0700
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: timer: Use non-empty ranges in example
Message-ID: <20191226210710.GA19454@bogus>
References: <20191216220512.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
 <CAD=FV=Wb6MtqdBZgNWdTH97RZamYfPZ0a9_1CELE_kJHXtKuYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wb6MtqdBZgNWdTH97RZamYfPZ0a9_1CELE_kJHXtKuYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:16:56PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Dec 16, 2019 at 10:06 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > On many arm64 qcom device trees, running `make dtbs_check` yells:
> >
> >   timer@17c20000: #size-cells:0:0: 1 was expected
> >
> > It appears that someone was trying to assert the fact that sub-nodes
> > describing frames would never have a size that's more than 32-bits
> > big.  That does indeed appear to be true for all cases I could find.
> >
> > Currently many arm64 qcom device tree files have a #address-cells and
> > about in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase
> > address and size cells for soc").  That means the only way we can
> > shrink them down is to use a non-empty ranges.
> >
> > Since forever it has said in "writing-bindings.txt" to "DO use
> > non-empty 'ranges' to limit the size of child buses/devices".  I guess
> > we should start listening to it.

I probably need to condition that to account for dma-ranges as you 
wouldn't want to limit the bus in that case.

> >
> > I believe (but am not certain) that this also means that we should use
> > "ranges" to simplify the "reg" of our sub devices by specifying an
> > offset.  Let's update the example in the bindings to make this
> > obvious.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > See:
> >   https://lore.kernel.org/r/20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid
> >
> > ...for the patch that sparked this change.
> >
> >  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> > index b3f0fe96ff0d..d927b42ddeb8 100644
> > --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> > +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> > @@ -99,22 +99,22 @@ examples:
> >        compatible = "arm,armv7-timer-mem";
> >        #address-cells = <1>;
> >        #size-cells = <1>;
> > -      ranges;
> > +      ranges = <0 0xf0000000 0x1000>;
> 
> I checked this over a few times and yet I still screwed it up.  :(
> This should be:
> 
> ranges = <0 0xf0001000 0x1000>;
> 
> ...which makes the first "frame" below actually start at 0.  I'll wait
> before sending out a v2, though, in case this patch is totally wrong
> or something.

Looks good to me.

Rob
