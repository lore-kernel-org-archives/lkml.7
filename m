Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BF122304
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP57T3Ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRTlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:41:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37983 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRTlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:41:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id z25so15624630oti.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3o0IsIZAZ7wZG7kNKtDTIC/+CrHgjEOKYqn/GJZgow=;
        b=IP57T3BawVyl+urI2HsWXb3a52KJBX1CVpOTmaws+YDj5nD8X94w/onrfLkCgdDNod
         wN66e0baMmlaayqO4Q3w/oj9JHMWfC3vyWSS1dnr+ktELyPIKg2CPpNZiEgrMSyTARJu
         MfEDJNd3GECOcxNV2Pt9Tm1NrDZr2sdTONBOAecH5v7zpR37Y5ZQyPSy9rL9hesTYa8F
         VW9wgwHLCxTr2sng/rdtXaBI/SkDjMD/wHYF3gAaCdx5bPmqjM/knxvxIJbignzjLPiF
         vrWTBmmunBhanAtLrzaAHfQoJFRV4XID3x2sLXwQ9ZkWVk8rMiynFeppf12qstMIXUF1
         0AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3o0IsIZAZ7wZG7kNKtDTIC/+CrHgjEOKYqn/GJZgow=;
        b=ez3ff33yiuea2KNnnLvWSsQN5G6ZShDOy6IsLCCf/6BQprH5AiTJUv5gFo/TTBupFn
         IVRayil1MODvjvEnaobGaklXfdbEf5cWZlMXG9q+7fWrxF1yis5j8Pk6D2VOakf4lhO2
         JvzR23N6IztFHGdtZhB1QOMP7QNnaQxVCT5gU8AssIb7mPibtsyjLepO7zvwo5tXh1Gy
         FeQcA62JGDefT9wmqXpsnDd2UYYXKoGzMbL5LsDd5dNwugL5kBXG0hMhgS8rPAFmoYr7
         3IbA9fLv5sQesk9Lh5UkPDi2FlWr0UpysN8hwVyISlqIg+rI7uf8+/Wi8h2Gw1X8jMGb
         hdTw==
X-Gm-Message-State: APjAAAXC9/B5BUZT4lTAyi6RepvtDFncfec2GxGLc1H8RQ8w2ooPH+Ug
        0H91ibNYcDfLCUhXn8A17KPSWwHzOussPyyjJlhrsA==
X-Google-Smtp-Source: APXvYqzUsgAQBjPOYLPLOEbi+X4F4sQfjR2aYPz7uHf2rwXILQINWQCn1hgtNd0dkCm49mZdpcu3Q2oMsIQ6w0Mchn4=
X-Received: by 2002:a9d:5543:: with SMTP id h3mr715368oti.33.1574106090265;
 Mon, 18 Nov 2019 11:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com> <010d5a90-3ebf-30e5-8829-a61f01b6f620@gmail.com>
In-Reply-To: <010d5a90-3ebf-30e5-8829-a61f01b6f620@gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 18 Nov 2019 11:41:19 -0800
Message-ID: <CAHS8izMWi0BXyiv+Nx4PSV+QkN8beHn0WH9HwwjsMJacwRntvw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Wenkuan Wang <wwk0817@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10/30/19 9:36 AM, Mina Almasry wrote:
> > /* Must be called with resv->lock held. Calling this with count_only == true
> > * will count the number of pages to be added but will not modify the linked
> > - * list.
> > + * list. If regions_needed != NULL and count_only == true, then regions_needed
> > + * will indicate the number of file_regions needed in the cache to carry out to
> > + * add the regions for this range.
> > */
> > static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>
> Hi Mina,
>
> Would you please share which tree this patch set used? this patch 5/9 can't be
> applied with Linus's tree and add_reservation_in_range can't be found.
>
> Thanks
> Wenkuan

Sorry for the late reply. Locally I have this patchset on top of
linus/master and a patchset that added add_reservation_in_range.

But, this patchset can be rebased on top of this commit with 'minimal'
merge conflicts:

commit c1ca56bab12f3 (tag: v5.4-rc7-mmots-2019-11-15-18-40, github-akpm/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>

    pci: test for unexpectedly disabled bridges

It's the latest mmotm I find on https://github.com/hnaz/linux-mm.git.
My next patchset will be rebased on top mmotm.

>
> > - bool count_only)
> > + long *regions_needed, bool count_only)
> > {
> > - long chg = 0;
> > + long add = 0;
> > struct list_head *head = &resv->regions;
> > + long last_accounted_offset = f;
> > struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> > - /* Locate the region we are before or
