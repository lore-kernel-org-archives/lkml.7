Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC00C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F282087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9NW4rN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgAGSmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:42:08 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40769 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgAGSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:42:08 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so95635uam.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sye9ja+Z6ohzCWbDeJ8pZ/COtcElyYSL6CVp6XpyU78=;
        b=f9NW4rN6AaM5yq0rvBItoFOKNN1gKYR4c0i61f+5WTLqZP+BtdbOil6R+kQBrvdIiD
         8hdIu3X5KafVL+GqeGO8VcmwTjF9RgIvzr8SMUWHxpie36qSSc2imJg3KAd0HWSK5Vaq
         PlOsx4cLbaClCfGjUPEhxlR5dSbFKDg39Mpa1548n4VpAxmGHEJQNoqboL4N6JmvP+kS
         v+gD+YcFa3QRE5fDp2UQuwE4QgLlXJL2/ySTyBpJSuYUJqiWdJtmML5SNi06pZFZgT9O
         4YltS9Rc8uO2A7OGGo7ORM1NaAokPTRAu/z5LKzetDljqhQV7j1Ocu6Jjv39AUospHkg
         KWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sye9ja+Z6ohzCWbDeJ8pZ/COtcElyYSL6CVp6XpyU78=;
        b=WR6UdvgmE+rYaDC8+vJfS8tm+QyztWQ+UsdbyXhlXfKSHtxoBedDWfzakL+sqIqWid
         LAelbj8m/lPxQksPi8RfoPW18q+cockvCglL/OEsGdrXSlKn4+kiT1rCr8SUU51OS9hR
         NZz/eQxrX9yMMWIvQ7T3EeGuiSdF097SZXpa/a0MQ9Wpjs80oaNWyKwz8MJG6NLDCnzQ
         Ca90d4NPIkVQD4l4h/A5Nw2rzcS8c9wSF2fdRobfUU+Uk6OOgau6I3Zgmz8nK7pgKz1Y
         5NOWsv61cIVTrzy7WT2dIlHXc3aLAo28gMz8KD0QmXQiU2DaBkBSAv58ECw+ZDorbwQ/
         kQ2w==
X-Gm-Message-State: APjAAAU4gTXsuwjXnkaiI7Okpoq9kHKPMma5yp+NWcWdnhwRpXiy2Nns
        xlTN5T1OxG2aL4BEQbcpRh+hEVCDc7oZr4AC8i0cRw==
X-Google-Smtp-Source: APXvYqzfc8R93dZiw4D5zmB8i08TDfL3o8J/5bGzeySK76LYYv4EUV2Nspl/gyKXw/KUcq4w03bVAnUFpato+/SY0cE=
X-Received: by 2002:ab0:74c8:: with SMTP id f8mr516035uaq.114.1578422526431;
 Tue, 07 Jan 2020 10:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-2-bgardon@google.com>
 <20200107143334.GF219677@xz-x1> <20200107145608.ogi34nkyh2abdgrq@kamzik.brq.redhat.com>
In-Reply-To: <20200107145608.ogi34nkyh2abdgrq@kamzik.brq.redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 10:41:55 -0800
Message-ID: <CANgfPd8_ei0WdF7t73TPveCAh1ifSp9p1B6BOkL32A+499nz=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
To:     Andrew Jones <drjones@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try to implement Drew's suggestion re: syncing global variables
and then looking up CPU ID. If I can do that I'll upload another patch
set for s390, aarch64, and x86. If I can't I'll move this test to the
x86 subdirectory.

I apologize for not responding to the comments on the previous version
of this patch set. I'm still learning the mailing list etiquette. In
the future is it preferable that I reply to those comments when I
upload a new patch set addressing them, or should I add a note in the
new patch emails about the comments I addressed in that update?

I don't have any aarch64 or s390 hardware handy to test on so I'll try
to move support for those architectures to separate commits at the end
of the series, and mark them untested.

Thank you for your quick responses!

On Tue, Jan 7, 2020 at 6:56 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 09:33:34AM -0500, Peter Xu wrote:
> > On Mon, Dec 16, 2019 at 01:38:54PM -0800, Ben Gardon wrote:
> > > While userfaultfd, KVM's demand paging implementation, is not specific
> > > to KVM, having a benchmark for its performance will be useful for
> > > guiding performance improvements to KVM. As a first step towards creating
> > > a userfaultfd demand paging test, create a simple memory access test,
> > > based on dirty_log_test.
> > >
> > > Signed-off-by: Ben Gardon <bgardon@google.com>
> >
> > It's fine to start with x86-only for this test, but imho it would be
> > better to mention that in cover letter, or reply to reviewer comments
> > on that you removed aarch64 from previous post.
>
> I'd also prefer that if it's x86-only that it be put in the x86_64
> subdirectory and drop the arch #ifdefs. The question is why is it
> x86-only for now though? Will it take a lot of work to port it to
> other architectures? Or does it just need testing by someone with
> the hardware?
>
> Thanks,
> drew
>
