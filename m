Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA91C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1422821925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="17xdVOab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKKQXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:23:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40040 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:23:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so11703290otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EK5rfvfSII06/EDQTTan7V0YdFmqp+cuq2tEw4+bqpc=;
        b=17xdVOabPHkdqXoVofyU2oGM4B4m95gnLle7cFrn1YMkwWbiTLbI/0troG20gZ9VZF
         LX95md6dEop4QOSKcJgsP24YOZ4c5m60SFzvCmdSKsNe9Ef4Adyt0ep7D30gPmzEHFM3
         76EKc9E/JZqf/JynqO0TwLB2ckYrJFa2hHgaU6yxQ1Dww953k3L5Rjl7vttXNiVlkffi
         5Rj4ZrSXGK1/vW18zmnQLV1+QauUftzINox4U1Lt5dnXJu92M8zJhKHlXvI8I462ihZ1
         bWKwEIaqGpVwuMVGwc56mpyZ+pRnnftycuMhYBn0tXtijl1QzzztqHZ0zwvmbBxHmN91
         T4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EK5rfvfSII06/EDQTTan7V0YdFmqp+cuq2tEw4+bqpc=;
        b=sQMZeNnoGGhu4kCE7RAHHqx8iDjmFJaErHPVEessKBaLZbQDEFvc89L/ALE+T6+ao0
         DBMJn+Sx626bEMQXPSCTzOuEHARmQVVUkbB1dBgPXqo+8FKJ6XY2Tarpe7BTEwuvUXHz
         vnpXsrSraNdO93urMQIjVTHlZr2Uk9HKclPv+HaqS9refL+5tB9ghzd/dcr/JtBFgPA+
         XCejV1kd/Az85v6OTSxLUTbcSXiZbOWO9tpTQI5grpbJD2hep3DpFK19otOJNaYM4z9z
         mIb7sIFnZwxs5tcImZfcXATrSPHF8u0Eb/mU7DJ7QXxcegZ68b4wuK+Aobei/5gNHnzO
         HrZA==
X-Gm-Message-State: APjAAAUpBcmCnQKTMInzx+4oIYQBY7kHqQTn7qCqmtDyj5k9hsrufF0l
        ukpGubOhDi5Dtg6BCRNjXFHziPVKw1VajvWbtUCziA==
X-Google-Smtp-Source: APXvYqywohi4GCAt/BglQ3C0fcbjKIg2OIffbbL/IPdakdWcpjfBuw1FR1rGa7efSojC1F+sMY799Z6U/QZm/PuYdQo=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr20766490otd.247.1573489429293;
 Mon, 11 Nov 2019 08:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
 <20191108091851.GB15658@dhcp22.suse.cz> <5fc7da0c-bd79-9f3b-e5d9-8688648cf032@vx.jp.nec.com>
In-Reply-To: <5fc7da0c-bd79-9f3b-e5d9-8688648cf032@vx.jp.nec.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Nov 2019 08:23:38 -0800
Message-ID: <CAPcyv4joVDwiL21PPyJ7E_mMFR2SL3QTi09VMtfxb_W+-1p8vQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] make pfn walker support ZONE_DEVICE
To:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 12:01 AM Toshiki Fukasawa
<t-fukasawa@vx.jp.nec.com> wrote:
>
> On 2019/11/08 18:18, Michal Hocko wrote:
> > On Fri 08-11-19 00:08:03, Toshiki Fukasawa wrote:
> >> This patch set tries to make pfn walker support ZONE_DEVICE.
> >> This idea is from the TODO in below patch:
> >>
> >>    commit aad5f69bc161af489dbb5934868bd347282f0764
> >>    Author: David Hildenbrand <david@redhat.com>
> >>    Date:   Fri Oct 18 20:19:20 2019 -0700
> >>
> >>      fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c
> >>
> >> pfn walker's ZONE_DEVICE support requires capability to identify
> >> that a memmap has been initialized. The uninitialized cases are
> >> as follows:
> >>
> >>      a) pages reserved for ZONE_DEVICE driver
> >>      b) pages currently initializing
> >>
> >> This patch set solves both of them.
> >
> > Why do we want this? What is the usecase?
>
> We are writing a test program for hwpoison, which is a use case.
> Without this patch, we can't see the HWPOISON flag on the
> ZONE_DEVICE page.

I'm not sure that's a goal that's a worthwhile goal. That hwpoison
flag has specific meaning for the System RAM case where the page is
going to be marked offline. For the pmem case the nvdimm core tracks
'badblocks'. I did attempt to use PageHWPoison to track which pmem
pages had been marked UC to prevent speculative consumption, but that
implementation has been found to collide with lookup_memtype() so I'm
looking ot replace it with something that consults with the pmem
driver.
