Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FACD214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rlIsQbnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCLQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:06:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37641 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLQGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:06:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id b3so2973359otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMv5aM7NxWtPAwD6wArIfoEs5BMmpOovFGO+3/0qUrY=;
        b=rlIsQbnDzW/HO++Hh3uGRqEHjLGRFc2kxMUVKu/T1a9Suma/JP9gNMIsgPleTKeVti
         FxFH0TEu1Ky2gljd5+Fz17We1pu9gttKEVS1Zw6k70/yGUKJKBnMyGTi1oU7+cjmdNsi
         xcL9wXMTx/5K0oibrykGTjcisMPbE111HovKQQoizdLR/HctvEEUXKVdIStA93Z2Wclb
         uEi95QytJa4BzKNUJEm9mWl+IBf1XorRun9icsflOC8dPevNgCawn9kJsCWfQ9OTJB34
         yJeyIJjd3C9XKKl/LfE2M1BLUuPV0MroeUKSJyvet0i9+QRQOq91N2fiPujBYg5yF3Ru
         PqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMv5aM7NxWtPAwD6wArIfoEs5BMmpOovFGO+3/0qUrY=;
        b=JswYszG2mcvRbXB6ZKsx4/6/j4lbT5TwPUFEWAwFOX4Jf8sk5L1+azOytxawWPBfPJ
         xKEckpHJUK65vPc88fa1zurf6ojFzeIBhofnlBr/zTNeq2AjJF5W61E9OlEOfejXGnWQ
         HcDbM+lV4uoY7j87dzfoguNB+ks+xBVq8RbR384nqtVN/Irl//Eji3pTQnm4iN+v90mg
         iEFO+JysrH+NRiCRjoKRL4zZsbX/WQAWljNMlfoE0PDdNGvedqse2UaZqG16yMWIU/Rx
         QTVKRzvta0hEMSIbKPBX59KPz021r0gantGVaApV/WTCbdKIZ1yL3lNb4c6hyo3R+8gE
         kprQ==
X-Gm-Message-State: APjAAAUtoHd4U3DH+UuvVr3SUF6rEpDrBnhC8MOZUL+sVejOnWEPJSwj
        CNBzYMrR63bj5KuOcoJBfxcMnp60NcgaPim3FRNNyw==
X-Google-Smtp-Source: APXvYqzJ5EsNfyjccMTSxpBXZyt+vC4H6friaBBuNH2H45sV7Xjfq5uKOyvOpJESuc7uLiXfsshZtGk+Kn5n0Vdk2UU=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr23792808otl.353.1552406783898;
 Tue, 12 Mar 2019 09:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com> <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com> <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
 <20190307185623.GD3835@redhat.com> <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
 <20190312152551.GA3233@redhat.com>
In-Reply-To: <20190312152551.GA3233@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Mar 2019 09:06:12 -0700
Message-ID: <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 8:26 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, Mar 11, 2019 at 08:13:53PM -0700, Dan Williams wrote:
> > On Thu, Mar 7, 2019 at 10:56 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 09:46:54AM -0800, Andrew Morton wrote:
> > > > On Tue, 5 Mar 2019 20:20:10 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > > My hesitation would be drastically reduced if there was a plan to
> > > > > avoid dangling unconsumed symbols and functionality. Specifically one
> > > > > or more of the following suggestions:
> > > > >
> > > > > * EXPORT_SYMBOL_GPL on all exports to avoid a growing liability
> > > > > surface for out-of-tree consumers to come grumble at us when we
> > > > > continue to refactor the kernel as we are wont to do.
> > > >
> > > > The existing patches use EXPORT_SYMBOL() so that's a sticking point.
> > > > Jerome, what would happen is we made these EXPORT_SYMBOL_GPL()?
> > >
> > > So Dan argue that GPL export solve the problem of out of tree user and
> > > my personnal experience is that it does not. The GPU sub-system has tons
> > > of GPL drivers that are not upstream and we never felt that we were bound
> > > to support them in anyway. We always were very clear that if you are not
> > > upstream that you do not have any voice on changes we do.
> > >
> > > So my exeperience is that GPL does not help here. It is just about being
> > > clear and ignoring anyone who does not have an upstream driver ie we have
> > > free hands to update HMM in anyway as long as we keep supporting the
> > > upstream user.
> > >
> > > That being said if the GPL aspect is that much important to some then
> > > fine let switch all HMM symbol to GPL.
> >
> > I should add that I would not be opposed to moving symbols to
> > non-GPL-only over time, but that should be based on our experience
> > with the stability and utility of the implementation. For brand new
> > symbols there's just no data to argue that we can / should keep the
> > interface stable, or that the interface exposes something fragile that
> > we'd rather not export at all. That experience gathering and thrash is
> > best constrained to upstream GPL-only drivers that are signing up to
> > participate in that maturation process.
> >
> > So I think it is important from a practical perspective and is a lower
> > risk way to run this HMM experiment of "merge infrastructure way in
> > advance of an upstream user".
> >
> > > > > * A commitment to consume newly exported symbols in the same merge
> > > > > window, or the following merge window. When that goal is missed revert
> > > > > the functionality until such time that it can be consumed, or
> > > > > otherwise abandoned.
> > > >
> > > > It sounds like we can tick this box.
> > >
> > > I wouldn't be too strick either, when adding something in release N
> > > the driver change in N+1 can miss N+1 because of bug or regression
> > > and be push to N+2.
> > >
> > > I think a better stance here is that if we do not get any sign-off
> > > on the feature from driver maintainer for which the feature is intended
> > > then we just do not merge.
> >
> > Agree, no driver maintainer sign-off then no merge.
> >
> > > If after few release we still can not get
> > > the driver to use it then we revert.
> >
> > As long as it is made clear to the driver maintainer that they have
> > one cycle to consume it then we can have a conversation if it is too
> > early to merge the infrastructure. If no one has time to consume the
> > feature, why rush dead code into the kernel? Also, waiting 2 cycles
> > means the infrastructure that was hard to review without a user is now
> > even harder to review because any review momentum has been lost by the
> > time the user show up, so we're better off keeping them close together
> > in time.
>
> Miss-understanding here, in first post the infrastructure and the driver
> bit get posted just like have been doing lately. So that you know that
> you have working user with the feature and what is left is pushing the
> driver bits throught the appropriate tree. So driver maintainer support
> is about knowing that they want the feature and have some confidence
> that it looks ready.
>
> It also means you can review the infrastructure along side user of it.

Sounds good.

> > > It just feels dumb to revert at N+1 just to get it back in N+2 as
> > > the driver bit get fix.
> >
> > No, I think it just means the infrastructure went in too early if a
> > driver can't consume it in a development cycle. Lets revisit if it
> > becomes a problem in practice.
>
> Well that's just dumb to have hard guideline like that. Many things
> can lead to missing deadline. For instance bug i am refering too might
> have nothing to do with the feature, it can be something related to
> integrating the feature an unforseen side effect. So i believe a better
> guideline is that driver maintainer rejecting the feature rather than
> just failure to meet one deadline.

The history of the Linux kernel disagrees with this statement. It's
only HMM that has recently ignored precedent and pushed to land
infrastructure in advance of consumers, a one cycle constraint is
already generous in that light.

> > > > > * No new symbol exports and functionality while existing symbols go unconsumed.
> > > >
> > > > Unsure about this one?
> > >
> > > With nouveau upstream now everything is use. ODP will use some of the
> > > symbol too. PPC has patchset posted to use lot of HMM too. I have been
> > > working with other vendor that have patchset being work on to use HMM
> > > too.
> > >
> > > I have not done all those function just for the fun of it :) They do
> > > have real use and user. It took a longtime to get nouveau because of
> > > userspace we had a lot of catchup to do in mesa and llvm and we are
> > > still very rough there.
> >
> > Sure, this one is less of a concern if we can stick to tighter
> > timelines between infrastructure and driver consumer merge.
>
> Issue is that consumer timeline can be hard to know, sometimes
> the consumer go over few revision (like ppc for instance) and
> not because of the infrastructure but for other reasons. So
> reverting the infrastructure just because user had its timeline
> change is not productive. User missing one cycle means they would
> get delayed for 2 cycles ie reupstreaming the infrastructure in
> next cycle and repushing the user the cycle after. This sounds
> like a total wastage of everyone times. While keeping the infra-
> structure would allow the timeline to slip by just one cycle.
>
> Spirit of the rule is better than blind application of rule.

Again, I fail to see why HMM is suddenly unable to make forward
progress when the infrastructure that came before it was merged with
consumers in the same development cycle.

A gate to upstream merge is about the only lever a reviewer has to
push for change, and these requests to uncouple the consumer only
serve to weaken that review tool in my mind.
