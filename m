Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC97FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30652147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BF2eEF+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfCLXXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:23:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41851 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfCLXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:23:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id 10so46534lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPRInBULNINtPyktN881wYXQE2wYAUhJn/8c9GOTsWI=;
        b=BF2eEF+1IYWrdaZaRj+Hb3ck6G4YChfSygnXVh8Y9QHiDoipa1SnJrL8GyTxkRBE3X
         tRzeITSLb9e0MNyIG1VRVa69nainHOxYenPm0ZkCO9/5cDLJi5e3O6ONnAAo3ZAli8FL
         XPXNMV/oMBcBXmvOLAe3HPt4GriBZH0Omukew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPRInBULNINtPyktN881wYXQE2wYAUhJn/8c9GOTsWI=;
        b=VTPCmeCJY9+B/eIXmpTYcTBfjiOs3nnmUCw3RLt7WkHf///xcMfqwPchGbkt1/QXyl
         3uGGVUPZS0CnStqOxJQ7zOYDE1cuAbFFH8qHjv/pzIIZbLznKL1dalyIkFAw0+B4tHx0
         RB0n4IuBzLRoHDms0Nl1FdHKgedYkv3kfXmaM5hg4Gu8xkex87eP7V/ces9MXzvLYZej
         yioI4hhMb84iGH5q4sGXPqHLWtgsGuwerhq7bb2g6v03Yg2pXdVoGgVgRXRLNA/aUfHD
         sOhLBn26XEGv+dyQi2t3HxK75phC3hN6DXnfE85/6fJPB+W19nfWcywZssCW7a1URZ67
         vETg==
X-Gm-Message-State: APjAAAVeBBYpW9uyH5gtlObpt74j1HvhRepbpMMpIbko09YK7jz9VjFH
        moCbUZBfJk+upZuCw7hUeqd0pBwtiGE=
X-Google-Smtp-Source: APXvYqzoueEE25NUsVaSJpyaVG9OwtbnbYbKgJ1O/v880QlKoNYpcp884BhKX8VlglYlf0DYun/zaA==
X-Received: by 2002:a19:5217:: with SMTP id m23mr20232285lfb.19.1552433013463;
        Tue, 12 Mar 2019 16:23:33 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y63sm1796256lfd.58.2019.03.12.16.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 16:23:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x13so3853657ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 16:23:33 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr21708502ljj.30.1552432684100;
 Tue, 12 Mar 2019 16:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-3-git-send-email-yong.wu@mediatek.com> <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
 <1551278000.17917.50.camel@mhfsdcap03> <CAE=gft4iHRo8VQot26dH2NaRNLtxxRYWBmSpjkoL2BE_i6eXQw@mail.gmail.com>
 <e15e94be-3eb9-dc7b-2073-4163f91f0259@gmail.com>
In-Reply-To: <e15e94be-3eb9-dc7b-2073-4163f91f0259@gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Mar 2019 16:17:27 -0700
X-Gmail-Original-Message-ID: <CAE=gft47TODOqKUxCvd+kDKfGbkQC1OVBarb1MaU3KrptcXiNw@mail.gmail.com>
Message-ID: <CAE=gft47TODOqKUxCvd+kDKfGbkQC1OVBarb1MaU3KrptcXiNw@mail.gmail.com>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no driver
 with AUTO flag
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:21 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 05/03/2019 20:03, Evan Green wrote:
> > On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
> >>
> >> On Mon, 2019-02-25 at 15:53 -0800, Evan Green wrote:
> >>> On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >>>>
> >>>> DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> >>>> automatically on consumer/supplier driver unbind", that means we should
> >>>> remove whole the device_link when there is no this driver no matter what
> >>>> the ref_count of the link is.
> >>>>
> >>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >>>> ---
> >>>> The ref_count of our device_link normally is over 1. When the consumer
> >>>> device driver is removed, whole the device_link should be removed.
> >>>> Thus, I add this patch.
> >>>> ---
> >>>
> >>> I will admit to reading about device links for the first time while
> >>> reviewing this patch, but I don't really get this. Why use a kref at
> >>> all if we're just going to ignore its value? For instance, I see that
> >>> if you call device_link_add() with the same supplier and consumer, it
> >>> uses the kref to return the same link. That machinery is broken with
> >>> your change. Although I don't see any uses of it, you might also
> >>> expect a supplier or consumer could do a kref_get() on the link it got
> >>> back from device_link_add(), and have a reasonable expectation that
> >>> the link wouldn't be freed out from under it. This would also be
> >>> broken.
> >>>
> >>> Can you explain why your device_links normally have a reference count
> >>>> 1,
> >>
> >> I use device link between the smi-larb device and the iommu-consumer
> >> device. Take a example, smi-larb1 have 4 VDEC ports. From 4/13 in this
> >> patchset, we use device_link to link the VDEC device and the smi-larb1
> >> device in the function(mtk_iommu_config). since there are 4 ports, it
> >> will call device_link_add 4 times.
> >>
> >>>
> >>> and why those additional references can't be cleaned up in an
> >>> orderly fashion?
> >>
> >> If the iommu-consume device(like VDEC above) is removed, It should enter
> >> device_links_driver_cleanup which only ref_put one time. I guess whole
> >> the link should be removed at that time.
> >
> > It seems like Robin had some suggestions about using
> > mtk_iommu_add_device() rather than the attach_dev() to set the links
> > up, and then track them for removal in the corresponding
> > remove_device() callback. Then you wouldn't need this change, right?
> >
>
> FYI, Evan the patch is queued for v5.1-rc1 as
> 0fe6f7874d46 ("driver core: Remove the link if there is no driver with AUTO flag")
>
> So if you think there is something wrong with it, then please provide a fix or
> raise awareness :)

Oh. Thanks for the heads-up Matthias. It's pretty weird that we have
the kref there whose count we just completely ignore. I'll try to find
some time to submit a patch.
-Evan
