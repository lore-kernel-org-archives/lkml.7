Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E787ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A8021855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WG8m/x9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfJAQnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:43:18 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:45515 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbfJAQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:11 -0400
Received: by mail-yw1-f49.google.com with SMTP id x65so5039728ywf.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdLG/r7+P2Ngh8ZWtcYEEBy7N3f+Jkee88RnUZ/onlY=;
        b=WG8m/x9u6EkqT3rbeISwibZR7wgr+y475s8ZYI+aKyhwk79T6y6VPB35Cs3YbjtDOu
         DMmMM05x8SATtUB1NF3jvKOnIBm+Ma+zsUa1igpmoXAVCEj36LiGlKAZn8XriduTz/+X
         lXFMHVYW3vWZlla1cL3hfo+Ya47QiCoBw+zgqJ17l477sI6j+qm6bmUNF9e2cC+Xekee
         RcWy0oOSfg3sY79agjSWAuQSmKt8Mwf5LSDuwLv3fISsnvpixqEd0RHOkYvTTRNwzJZQ
         JPt/3eSuKe93B93Vts+/m6/wQLLYAFHappRoIYpDavTNDUoJf1WUg1G+EJ56VfVcT672
         4/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdLG/r7+P2Ngh8ZWtcYEEBy7N3f+Jkee88RnUZ/onlY=;
        b=GiTTr3Bt9z5q6OmRzvsiXf4zWtFKAY03MM57ibR+HU3FuG2TkJXmHLT180ff2/pU3C
         VWGhTv//Rj2k48mD+RCPEEaK+tu2nkKNY91Kkj4OqK03sXrMr+mF2GKFr/IauUVcsnfR
         oMARTosj+oiRi4JbjJwqUlFRVcyDsvyA0eX3frUZEyAQXtkGm7l+h2pVqOARYolI4QNt
         cQ1P+ZXDOifr2hb1ovnvDyt+aVvVZ0Gw80gFfvPuGZbUc5LnI1LlThbln1IAmbt7TBvP
         ncB9gaOskK1aejV1ppBdRDX5Ygozr+en1wJulPeA1esNRc5N7TE6+MymL4tAnB/yyJGu
         ij3g==
X-Gm-Message-State: APjAAAXehrc+KiRdV8CemQpnLUntPi5u1tbREj4OdnY+tB+nzjbV+oU4
        Y8sEufyuQ4DlCCyWApv4QJC66jZtvW6BvTqlJqJ/iPbr38bKtQ==
X-Google-Smtp-Source: APXvYqw8ExU/R+uf06q48A3Wc10DKEkfY9elTc4ZQLBRVAtnt6bXMEPjFlsfSkkw9RUm1qqJ4HjtU5LK9JF/fO1AX6o=
X-Received: by 2002:a81:a144:: with SMTP id y65mr16843887ywg.437.1569948189853;
 Tue, 01 Oct 2019 09:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191001162710.GB3526634@kroah.com>
In-Reply-To: <20191001162710.GB3526634@kroah.com>
From:   Mat King <mathewk@google.com>
Date:   Tue, 1 Oct 2019 10:42:58 -0600
Message-ID: <CAL_quvS4o7rqpjPL2hcJ_-cJWUVNfgaLzzMoymHrswshxYYwKg@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rafael@kernel.org, Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 10:27 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 01, 2019 at 10:09:46AM -0600, Mat King wrote:
> > Resending in plain text mode
> >
> > I have been looking into adding Linux support for electronic privacy
> > screens which is a feature on some new laptops which is built into the
> > display and allows users to turn it on instead of needing to use a
> > physical privacy filter. In discussions with my colleagues the idea of
> > using either /sys/class/backlight or /sys/class/leds but this new
> > feature does not seem to quite fit into either of those classes.
> >
> > I am proposing adding a class called "privacy_screen" to interface
> > with these devices. The initial API would be simple just a single
> > property called "privacy_state" which when set to 1 would mean that
> > privacy is enabled and 0 when privacy is disabled.
> >
> > Current known use cases will use ACPI _DSM in order to interface with
> > the privacy screens, but this class would allow device driver authors
> > to use other interfaces as well.
> >
> > Example:
> >
> > # get privacy screen state
> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> > enabled 0: privacy disabled
> >
> > # set privacy enabled
> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
>
> What is "cros_privacy" here?

This would be set by the device driver. This example would be for a
Chrome OS privacy screen device, but the driver would set the name
just like in the backlight class.

>
> >  Does this approach seem to be reasonable?
>
> Seems sane to me, do you have any code that implements this so we can
> see it?

It is still early in the implementation so there is no code quite yet.
I wanted to get some general feedback on the approach first. As soon
as I have code to share I will post it.

>
> thanks,
>
> greg k-h

Thank you for the feedback.
