Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AFC20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="RuhaXpaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbfDJMxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:53:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41468 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDJMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:53:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id d15so522895vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrVNfDqjgIN2g5iPNbjQcpAH2KmlBTnI6OFAGpNZsRI=;
        b=RuhaXpaBaUXsAch31PfmdWMfzIe8KpMmaKt4FyzRw1saPcrxcCXdzpeL9y+TEnNPJW
         +7slG5m7ncYwWJSMwOaM0EAmdRI+NCL0yPWu7VVJJR+BDG4ZPQo9fwgew1iqVS0zFV/d
         3qMEg5wg7d89g3wOApHz8RZDrT2mfox6M9eodEH/TETyHoGi5gz2UZTYsMuCCSI2Zjxl
         rZyiS9z0S2pS6S8BV4ByOsJ9RjbGMb6VKU+n7TB800+xwZFUMSi03S3OYoY1H87cxhpN
         efOXgctoP1xAkMPOpPCELFYsWNdLB/QBHd2dF1CAiK8zID6NmRimRQkd0qzBn/ulUAwb
         bWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrVNfDqjgIN2g5iPNbjQcpAH2KmlBTnI6OFAGpNZsRI=;
        b=r/Bj/rVDws+/VdpI2Yj5Gcy6ojQ72BrtmQBLgmMUMJQZ6Sfw/3PIf3Bx+Cvvfk6Z/P
         9ZCtgMmlkH0yr2KBrzkQ74lZzhLNyJGR4ppuV/Ncrky8eu+VHOQcInIgRCUZ5sIzTHiL
         AwUJoAgXHr5oIe1KS0FlY/v1E7Bk8wQ161YZfzTl4kJ+i0DczkXYE8NCudcsJLaKH8K/
         citxfZhrxiHVHYaoR6K2PnPCw3T/SY22gBvoZk+inGl0EM7ACCMaIlUeSwcr83cRO2z9
         1x0pPPg8he/zR4Io1CipqTqH3h3IwIeeVC30loM27Yb25JTC4Srlb3zOdZXqs4UctPyq
         gnSw==
X-Gm-Message-State: APjAAAV+2G1y0Ws3uH2Q2BedjxvsjDRJ/UNFMwVHqVMHjxHnfF8AqUPg
        rcTz1iHaPOecjGoFC27ZJErkKpRE4Len8ANTG11PDQ==
X-Google-Smtp-Source: APXvYqyJyHqe7nMs9WlN+RSvm8n4BO6drOx3CHPRbJnH1lAqiwWfNSsnf6UkkIHCRIh9OhofiuPJyHzQiHc3VcoaYd8=
X-Received: by 2002:a1f:3644:: with SMTP id d65mr21233271vka.34.1554900780431;
 Wed, 10 Apr 2019 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190408073308.3082-1-hans@owltronix.com> <5D5705F7-C0D7-4303-82A2-965320560220@javigon.com>
In-Reply-To: <5D5705F7-C0D7-4303-82A2-965320560220@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 10 Apr 2019 14:52:49 +0200
Message-ID: <CANr-nt2oJhHvK8SydTQgKkPj_bPuN1VJx1k+z2A3Dfotxdghvg@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix crash in pblk_end_partial_read due to
 multipage bvecs
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 2:22 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 8 Apr 2019, at 09.33, hans@owltronix.com wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Ever since '07173c3ec276 ("block: enable multipage bvecs")' we
> > need to handle bios with multipage bvecs in pblk.
> >
> > Currently, a multipage bvec results in a crash[1].
> > Fix this by using bvec iterators in stead of direct bvec indexing.
> >
> > Also add a dcache flush, for the same reasons as in:
> > '6e6e811d747b ("block: Add missing flush_dcache_page() call")'
> >
> > [1] https://github.com/OpenChannelSSD/linux/issues/61
> >
> > Reported-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >
> > It ain't pretty, but let's fix the breakage while waiting for Igor's
> > partial read cleanup to be ready.
> >
>
> I would prefer to have the real fix, but it is good to have this fixed fo=
r
> 5.2. Can we agree on a revert if Igor sends the patch within the 5.2
> window?

yeah! please chuck this patch out of the window when we have a nicer fix re=
ady.

Thanks,
Hans
