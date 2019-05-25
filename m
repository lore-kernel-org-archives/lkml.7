Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60AAC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E75217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 02:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpSfcMLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEYCJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 22:09:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45773 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEYCJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 22:09:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so10335064otl.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZzs5xzeqtVuzgwwnEv2OC+wDQwHzVptWWlrVSZVAQI=;
        b=LpSfcMLDiUhQLwFnbv22EYTidAmanIzvxucTe3e3Huy/p1Pv+V8iQonG/LTIbtqSWP
         9Mp9d+nb8WvRERLdmhJmbQ41VSRNvOmAVJ5D0lN8KdiLk4w0FDjGQaU4ppwrVx+S+WjV
         in5CGq3+upoHcc5SpSSxDe+e1+p84Psxss2SgCpq5LjgwHvBkTBVC9utrFESDIqTzsPz
         O57+O5yBKxJBq7ZHP3q+xSNxtVV+bcMRif+DI+fCRXXh2Un/j/BDDcmVQosE/Wr3BsER
         8OoeFAnK0EHvaGtU91i4CNa5tspsh08desjK5wg9SPtIzbYyu5O4iF05+Hrb1Fw3F+9L
         wz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZzs5xzeqtVuzgwwnEv2OC+wDQwHzVptWWlrVSZVAQI=;
        b=IYKU58MqY8G22sgOnltmeI74YqsD7q7r1VO1iKF4Rdlksrmbc2lSLiAhNF7r3UGIG4
         8RoRYEZay5z6lAA2XA3xq40sypETdXIxWxJD8o7Ndqn0kuwJylFrvsdSmZG0vAeU6Gbb
         lOuLCUgqaenzMFeoLXSMzB9oPUD2yYbncf0xQgNAtl75oYBNk9zSmXnf7bLcKnCZxSnT
         r6q3krFrc3XTR79x3ZN2nyVjbY23vKQDpkPMFNbxhmD3g/Xk/SVUPvnmWqosaoHsUyMp
         vEaSls6d8nIFuO7CiindFvT/jZ5WNUj05HX0HosRKJKaN2nd1FXld5LwOm3saNAOM8FJ
         mMMQ==
X-Gm-Message-State: APjAAAWuedXSACzTbJPBvOUVnbzXMprrQb+7L/cVFS7rCpXd+3HyfuMk
        oLHAca2uhU/s/EWM8CEMWeLQyyAkKXs8vaLHlD2Zsg==
X-Google-Smtp-Source: APXvYqywCXHUTcsaMeWUQ99nmh25iIlVZDM17cQeOhrhvN/0hvRddyY0+adbYQ5SE14e+43owKTnBffphfwKTj126pQ=
X-Received: by 2002:a9d:3b49:: with SMTP id z67mr53168810otb.236.1558750172585;
 Fri, 24 May 2019 19:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com> <06b479e2-e8a0-b3e8-567c-7fa0f1c5bdf6@gmail.com>
 <CAGETcx-21GEoBKhpzcsrDt3sEo-vUpwqnr3To7VbSPd8aW86Nw@mail.gmail.com>
 <6d3995c1-e1e7-35ff-d091-501822c97ecd@gmail.com> <0634ea45-2941-73fb-f8d8-b536e929a4a8@gmail.com>
In-Reply-To: <0634ea45-2941-73fb-f8d8-b536e929a4a8@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 24 May 2019 19:08:56 -0700
Message-ID: <CAGETcx-bNhnfaThygrSbnbAmQ8PqEGHj8eVO3OvhJAomJ936Eg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe ordering
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh... mobile app is sending HTML emails. Replying again.

On Fri, May 24, 2019 at 5:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/24/19 5:22 PM, Frank Rowand wrote:
> > On 5/24/19 2:53 PM, Saravana Kannan wrote:
> >> On Fri, May 24, 2019 at 10:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> On 5/23/19 6:01 PM, Saravana Kannan wrote:
> >
> > < snip >
> >
> >>> Another flaw with this method is that existing device trees
> >>> will be broken after the kernel is modified, because existing
> >>> device trees do not have the depends-on property.  This breaks
> >>> the devicetree compatibility rules.
> >>
> >> This is 100% not true with the current implementation. I actually
> >> tested this. This is fully backwards compatible. That's another reason
> >> for adding depends-on and going by just what it says. The existing
> >> bindings were never meant to describe only mandatory dependencies. So
> >> using them as such is what would break backwards compatibility.
> >
> > Are you saying that an existing, already compiled, devicetree (an FDT)
> > can be used to boot a new kernel that has implemented this patch set?
> >
> > The new kernel will boot with the existing FDT that does not have
> > any depends-on properties?

You sent out a lot of emails on this topic. But to answer them all.
The existing implementation is 100% backwards compatible.

> I overlooked something you said in the email I replied to.  You said:
>
>    "that depends-on becomes the source of truth if it exists and falls
>    back to existing common bindings if "depends-on" isn't present"

This is referring to an alternate implementation where implicit
dependencies are used by the kernel but new "depends-on" property
would allow overriding in cases where the implicit dependencies are
wrong. But this will need a kernel command line flag to enable this
feature so that we can be backwards compatible. Otherwise it won't be.

> Let me go back to look at the patch series to see how it falls back
> to the existing bindings.

Current patch series doesn't really "fallback" but rather it only acts
on this new property. Existing FDT binaries simply don't have this. So
it won't have any impact on the kernel behavior. But yes, looking at
the patches again will help :)

-Saravana
