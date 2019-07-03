Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CCC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F37321871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmVJrnqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfGCW1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:27:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39367 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCW1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:27:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so3604049otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2V6DzWpvWTZUVXRvfBLQmJzwket1ppQ/Sc433n2/Nc=;
        b=mmVJrnqCbKv1e50NHEEmq1OoZcpLFVzXU1X0qha21y2dJYbJVVyXKBEbwD21H0Mkgw
         h/pzQH1i/cFTXLvSSY6Y7n59RwLUZcrCmeuukwEY4k/Lo9bGBRLuZNkIgrPHl1HS03AC
         OWUDKWQRtkeieoHAoX0gRZwbxw3WnSvdRASvuTP6kW5aM813Tt/j5PdUafTZPbKKbMra
         gKgMcDSUa4+X34/vSWbaD/LaTsKT+LwlKVKKr6kkhh/t3Uxtz323Sa0VnxegvVnRsiu+
         vPk5h/fsjfGfJb/7UkUDTYIOl5rREmnWwt90bN88b56oX7k2sb9B7ix0LvIfbyyJKanU
         jZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2V6DzWpvWTZUVXRvfBLQmJzwket1ppQ/Sc433n2/Nc=;
        b=bZJ+cw1RWC/v2iXDYMQhZgjz7+QzqNxyi/Y7kXdBNCpNjHP02Tuaiksq8GQ9XTr1qE
         ASgOK3lOZHyUOx7+o8HDIrLgWgmcx0nI6oEvDcI9WlHX4DDqgmmVgnjiZNdUPgK13XJh
         tSED3yTDzUHVHNxPsreierKR99v9yYf4rYwnarr6CesWufYUluCSFjOfzzcS7T1YEs6h
         DWeZ0J+ApIkgK8onFurYBKowsJFkjjDn36urToHGigmCGwZxW5pV4my+hpOAgdkzuAkI
         BVeO9KttQ6ZoeOqENARNp2Abs46oG8NruV9vs3JK5hHHHzeOP8qnzGOXV7EVDiENdj3K
         HWgw==
X-Gm-Message-State: APjAAAWXnnaQp2P7kGtssP5uM7rgoFfgjk8GqQljdQMPBhV35IYggM2/
        Wyh2bzvQuTGVPkprmuaNdRS511dgl3IrlqjJx+Eykw==
X-Google-Smtp-Source: APXvYqyeTTr+WvpeAKpXyj3063djbPHVPYZg4Jf5vvwk7ke/KotikoqN8p0GhSt6ugm8Gb7SQ9BHig9URCNweka4tb0=
X-Received: by 2002:a9d:6d06:: with SMTP id o6mr27558240otp.225.1562192851493;
 Wed, 03 Jul 2019 15:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190702004811.136450-1-saravanak@google.com> <7900c670-5b3a-f950-dec9-70d98d94a84f@codeaurora.org>
 <CAGETcx--+3BNjYZ6cgirNr_uZjU0464UHSUcaVHh_uTO2yWTCQ@mail.gmail.com>
In-Reply-To: <CAGETcx--+3BNjYZ6cgirNr_uZjU0464UHSUcaVHh_uTO2yWTCQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Jul 2019 15:26:46 -0700
Message-ID: <CAGETcx_by9aShONfSAR8rfhC69nBzeEhrZSHhOb7HuUBeCu=JA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Solve postboot supplier cleanup and optimize probe ordering
To:     David Collins <collinsd@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Jul 2, 2019 at 5:03 PM David Collins <collinsd@codeaurora.org> wrote:
> >
> > Hello Saravana,
> >
> > On 7/1/19 5:48 PM, Saravana Kannan wrote:
> > ...
> > > TODO:
> > > - For the case of consumer child sub-nodes being added by a parent
> > >   device after late_initcall_sync we might be able to address that by
> > >   recursively parsing all child nodes and adding all their suppliers as
> > >   suppliers of the parent node too. The parent probe will add the
> > >   children before its probe is completed and that will prevent the
> > >   supplier's sync_state from being executed before the children are
> > >   probed.
> > >
> > > But I'll write that part once I see how this series is received.
> >
> > I don't think that this scheme will work in all cases.  It can also lead
> > to probing deadlock.
> >
> > Here is an example:
> >
> > Three DT devices (top level A with subnodes B and C):
> > /A
> > /A/B
> > /A/C
> > C is a consumer of B.
> >
> > When device A is created, a search of its subnodes will find the link from
> > C to B.  Since device B hasn't been created yet, of_link_to_suppliers()
> > will fail and add A to the wait_for_suppliers list.  This will cause the
> > probe of A to fail with -EPROBE_DEFER (thanks to the check in
> > device_links_check_suppliers()).  As a result device B will not be created
> > and device A will never probe.
> >
> > You could try to resolve this situation by detecting the cycle and *not*
> > adding A to the wait_for_suppliers list.  However, that would get us back
> > to the problem we had before.  A would be allowed to probe which would
> > then result in devices being added for B and C.  If the device for B is
> > added before C, then it would be allowed to immediately probe and
> > (assuming this all takes place after late_initcall_sync thanks to modules)
> > its sync_state() callback would be called since no consumer devices are
> > linked to B.
> >
> > Please note that to change this example from theoretical to practical,
> > replace "A" with apps_rsc, "B" with pmi8998-rpmh-regulators, and "C" with
> > pm8998-rpmh-regulators in [1].
>
> Interesting use case.
>
> First, to clarify my TODO: I was initially thinking of the recursive
> "up-heritance" of suppliers from child to parent to handle cases where
> the supplier is a device from some other top level device (or its
> child). My thinking has evolved a bit on that. I think the parent
> needs to inherit only from it's immediate children and not its
> grandchildren (the child is responsible for handling grandchildren
> suppliers). I'll also have to make sure I don't try to create a link
> from a parent device to one of its child device nodes (should be easy
> to check).
>
> Anyway, going back to your case, for dependencies between child nodes
> of a parent, can't the parent just populate them in the right order?
> You can loop through the children and add them in multiple stages.
>
> I'll continue to think if I can come up with anything nicer on the
> drivers, but even if we can't come up with anything better, we can
> still make sync_state() work.

There's actually a much better way to handle this case where you won't
have to handle ordering on the driver side. I just need to add one or
two patches to my patch series. I'll send that out sometime next week.


-Saravana
