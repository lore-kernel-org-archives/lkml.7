Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975EC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D32D208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbfGRPqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbfGRPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1FFE30ADC81;
        Thu, 18 Jul 2019 15:46:30 +0000 (UTC)
Received: from laptop.jcline.org (unknown [10.13.105.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B2110021B2;
        Thu, 18 Jul 2019 15:46:28 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by laptop.jcline.org (Postfix) with ESMTPS id 9FCF6704C8E5;
        Thu, 18 Jul 2019 11:46:27 -0400 (EDT)
Date:   Thu, 18 Jul 2019 11:46:26 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     wbauer1@a1.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: input: fix a4tech horizontal wheel custom usage
Message-ID: <20190718154626.GC25351@laptop.jcline.org>
References: <20190611121320.30267-1-nsaenzjulienne@suse.de>
 <CAO-hwJLAiC1o-kZ5epZHtO2GK+zc5x28pYbZH-XsY4yAuBmHWw@mail.gmail.com>
 <5346893.KeHrH3GHoD@linux-lf90.site>
 <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+Nm+i+ehGurAxD3EQBX8-TFQ7p4J-1rV55fVA=NazgAw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 15:46:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 03:36:03PM +0200, Benjamin Tissoires wrote:
> Hi Wolfgang,
> 
> On Thu, Jun 13, 2019 at 1:49 PM Wolfgang Bauer <wbauer@tmo.at> wrote:
> >
> > On Tuesday, 11. Juni 2019, 16:42:37 Benjamin Tissoires wrote:
> > > On Tue, Jun 11, 2019 at 2:13 PM Nicolas Saenz Julienne
> > >
> > > <nsaenzjulienne@suse.de> wrote:
> > > > NOTE: I CC'd Wolfgang as he's the one who can test this.
> > >
> > > I'll wait for Wolfram to confirm that the patch works before pushing then.
> >
> > My name is Wolfgang, not Wolfram... ;-)
> 
> ouch, sorry for that (I am more used to talk to the I2C maintainer apparently)
> 
> > But never mind.
> >
> > I tested the patch meanwhile on top of kernel 5.2.rc4, where the mouse wheel
> > actually worked.
> 
> Actually, I am a little bit lost here.
> 
> The patch mentions a fix of c01908a14bf73, which is in 5.1 final.
> So if your mouse works in 5.2.rc4, I am not sure how
> HID-a4tech-fix-horizontal-scrolling.patch could break it.
> 
> Could you be slightly more specific in what "works" and what doesn't?
> 

For what it's worth, at least one user has hit this issue in Fedora
starting on stable kernel v5.1.17[0] which has commit abf82e8f7e9a
("HID: a4tech: fix horizontal scrolling"). Applying this patch on top of
v5.1.18 fixed the issue for them.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1730762


Regards,
Jeremy
