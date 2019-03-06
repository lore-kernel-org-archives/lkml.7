Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43657C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162402063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFKuLd26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCFSnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:43:39 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:55002 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCFSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:43:39 -0500
Received: by mail-it1-f172.google.com with SMTP id w18so11134863itj.4;
        Wed, 06 Mar 2019 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKsJSARaIXiJsFyVSuRaZysl9pduI66L9p2pAHVz2y4=;
        b=lFKuLd26PoIcx6hogS2YHTqJUMClViOLA34+tUpEX26awsWVyMv7LSszyu7OuPv0UN
         bf+btaQivqAeZbYIbveaDUEHgxF2IeYKfEn1M7G8tQjrAhgibnH1QlweCxohnf21HIBJ
         KnDYWZR1D5URjSD/pPnbSv7uRHNXRalACiKdfaOdarCkVRVCnMOWGNii6WNmI2An1lWM
         TXogghqokttOGPiCN/vtAEwzHqVbGK049zpQSoNpCJPTDBaEpk/OMP8oEOZL+xlXTuFe
         idMC8kdih4EAGpuyY/DsUcHXT7vRV5gJNzKGr88YIzGAm+DMl64Cf5PvutPuH+gmvQCT
         ln4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKsJSARaIXiJsFyVSuRaZysl9pduI66L9p2pAHVz2y4=;
        b=ftTev4klAdTtiA7zZQ0uenbHwuOOGtfHiXr9qt0iq4cvjIBdAyzd54qApnx0NTVdt5
         OFziWptc0vliydvLneDGC+2kkrs0Gk4gc07yS/UnAbqumAAYgoYNC9NwkybrET1f5KyL
         YuKryxJoAGqNNQZ4Z8nC8ZWXkRYdJlZV/KFkQJbUej7tOtkPdqHJkaCPP+7EbtExELuE
         TMu8ttXtLuUfxkNTQT7p3PdvKx6N28vybRu90ycMPdGKm1hydaK96sLIRyZ5bnm3wrdU
         G+U78lKuod6uSRr1DTBAgo1G4rzpQg4Mi2snFwhqsNaFRRC0q+cQpb3pruuxsyn/HfDW
         RBHg==
X-Gm-Message-State: APjAAAVfgjvBLk/RFtFEsNFxplEaox1gMY3Zi4nfwm8q4u9chfbSA6LF
        kly8ImQajnKRWFwhGyFCgaVnPGakSCgyB+o5Xzo=
X-Google-Smtp-Source: APXvYqzQc8y/SQZqjHW3Wb9NqF49Slajo0x5JptFFGJXyB/4hlWmx/e0UkTYelRMjCYNpSfD5JXcVrwTMz9Jo8gY5ws=
X-Received: by 2002:a24:45e3:: with SMTP id c96mr2719435itd.89.1551897818040;
 Wed, 06 Mar 2019 10:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com> <20190306130955-mutt-send-email-mst@kernel.org>
 <afc52d00-c769-01a0-949a-8bc96af47fab@redhat.com> <20190306133613-mutt-send-email-mst@kernel.org>
 <7a77ce2a-853f-86c6-6d10-1d8db8fb8ae4@redhat.com>
In-Reply-To: <7a77ce2a-853f-86c6-6d10-1d8db8fb8ae4@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 10:43:26 -0800
Message-ID: <CAKgT0UfC0E6_ZSs5zvkTsH+2LdQuL7fWHqNJQtz+j7BThx5FDA@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:41 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> On 3/6/19 1:38 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 06, 2019 at 01:30:14PM -0500, Nitesh Narayan Lal wrote:
> >>> Want to try testing Alex's patches for comparison?
> >> Somehow I am not in a favor of doing a hypercall on every page (with
> >> huge TLB order/MAX_ORDER -1) as I think it will be costly.
> >> I can try using Alex's host side logic instead of virtio.
> >> Let me know what you think?
> > I am just saying maybe your setup is misconfigured
> > that's why you see no speedup.
> Got it.
> > If you try Alex's
> > patches and *don't* see speedup like he does, then
> > he might be able to help you figure out why.
> > OTOH if you do then *you* can try figuring out why
> > don't your patches help.
> Yeap, I can do that.
> Thanks.

If I can get your patches up and running I can probably try the same
test I did to see if I am able to reproduce the behavior. It may take
a bit though as I am running into several merge conflicts that I am
having to sort out.

Thanks.

- Alex
