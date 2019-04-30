Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549452147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="KLGl4dDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xse+7eu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfD3P2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:28:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53583 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfD3P2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:28:21 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 11:28:21 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95B2013CFD;
        Tue, 30 Apr 2019 11:19:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Apr 2019 11:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=mesmtp; bh=PqdKVmAegcUY+01jWk7gCCUC
        FnxdsWffSKcoSAyZrz0=; b=KLGl4dDWcypYzghgDsD+u5AdKCTJx0WYYG32QPOk
        VRAEAvLki/saXIZ+FELVvNyd7eBf2kY+a+Lgyt+d3XlYyd/rIlyohecS7+qW6g9e
        49Kp6aYvS5jv3QcTTDrFEKcl8zesN2nSOQEpftwDoDcraREJhwRM6FjNQ+gVfrfv
        Jjw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PqdKVm
        AegcUY+01jWk7gCCUCFnxdsWffSKcoSAyZrz0=; b=Xse+7eu6e+7sB7A3vfrfLJ
        UXqM/IAhrTe87qCpxc0Z7GbAFLTuYr2KNo6haKf5T+UOy8kVtyq4PXYpW5yNVK6h
        tovKSlKwUijGrJcrcjgs+6dMZpjU/TzEpkUDKrnJa2mmM5n0FMiyF3Fww+QCXSk2
        +SpHuaGG3oOxg3Q+kL+kLvM/hMwRbY+V02tQSy67kRTkJvM8UR+wtjzWbnWwcZvm
        2JV+oTolMHJRr8Ppt4S1smYPPmgbKu5x+U/EAsjMHD6XWfVJHkmAjZyq2nOZCkp0
        9TNee8DAGrr1WC+slp8v5rMuPfuKYq/SGRd00fLPVakamG5VrYplpN6T01bv1v8g
        ==
X-ME-Sender: <xms:gmfIXNIp3cgHm5z8P87KAp4zfzY5ZS_E_R4aKo-nfR_eV_Zx6humzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujghofgesthdtredttdervdenucfhrhhomhepofgrrhhk
    ucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmqeenucfkph
    epieekrddvrdekjedrleehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggvrhes
    rghnihhmrghltghrvggvkhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gmfIXAMRsaPLqfhQUsdfwSRIsOaWifswxzpnBY04sYzPHfRHrKLaUQ>
    <xmx:gmfIXNYROxrkfHO9y3_UupmN1f78ui2nxLhrcW1JjYak2qzBoYvOWA>
    <xmx:gmfIXEyQgwzU5MKiqAZNI3cZSNthcGfmFgflccqtzXSqTEtRkpX6yA>
    <xmx:hGfIXOtcc0O3WEiGO4HvZqWv4cKhud4QyMiawWAcTNunwmyh_u1ZBQ>
Received: from blue.animalcreek.com (ip68-2-87-95.ph.ph.cox.net [68.2.87.95])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84A6B103CC;
        Tue, 30 Apr 2019 11:19:30 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id DEAC8A21364; Tue, 30 Apr 2019 08:19:28 -0700 (MST)
Date:   Tue, 30 Apr 2019 08:19:28 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: audio_manager: fix a missing check of
 ida_simple_get
Message-ID: <20190430151928.GA1854@animalcreek.com>
References: <20190314064525.15756-1-kjlu@umn.edu>
 <CAAs364_6MpywkbsFdZrT5TEdrD8+u1eTmg-8_KY0dypy_PgMxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAs364_6MpywkbsFdZrT5TEdrD8+u1eTmg-8_KY0dypy_PgMxQ@mail.gmail.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:49:46AM +0530, Vaibhav Agarwal wrote:
> On Thu, Mar 14, 2019 at 12:15 PM Kangjie Lu <kjlu@umn.edu> wrote:
> >
> > ida_simple_get could fail. The fix inserts a check for its
> > return value.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  drivers/staging/greybus/audio_manager.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> > index d44b070d8862..c2a4af4c1d06 100644
> > --- a/drivers/staging/greybus/audio_manager.c
> > +++ b/drivers/staging/greybus/audio_manager.c
> > @@ -45,6 +45,9 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
> >         int err;
> >
> >         id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> > +       if (id < 0)
> > +               return id;
> > +
> >         err = gb_audio_manager_module_create(&module, manager_kset,
> >                                              id, desc);
> >         if (err) {
> 
> Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

I am sorry for not responding until now.  For some strange reason, email
from this list are being delayed.  I just got this today (April 30).

Thanks for the patch, Kangjie, and thanks for the review, Vaibhav.

And FWIW,

Reviewed-by: Mark Greer <mgreer@animalcreek.com>

Mark
--
