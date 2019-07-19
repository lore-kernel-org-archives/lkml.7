Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3811C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7754B21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fKxPvlLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbfGST1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:27:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43497 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfGST1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:27:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so9645996otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0VZQjknwaoc/xd9akWANU4Fp73ScqYtBO644ZC7wPw=;
        b=fKxPvlLKbUq8P0bg/ik56UxG2NQdUFZ3DAgaW2Pr2j6CyWeYcAAsfWOo0ZpikfvSZJ
         54cGxGITLZdqALGzt347hbB8wcYz+31kLBSOIxRb5p1DPL/ll+i67zYu0x1QVbEj0J/A
         Sh9LWyTgS/kPDaI2HDAXUY6N2vGApnH9qS9/RjqZdiVRUvUVC1qQv65HEDNFwUR6wCVt
         trOTx0w05bacRnq1SFOrep4tMLxxja63k8Kk3mUYsVX49y5kLl2GYSDUuh9GEqnwpcMu
         z52JAgOnzyOCFakbfQyFUhSgXuq2M/uIV6NO2/PVcyENPqo/AFwoVhVWN9phAFnbe0ze
         ECXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0VZQjknwaoc/xd9akWANU4Fp73ScqYtBO644ZC7wPw=;
        b=XiGR99dLjQlD9PxSZ+rtNprGXTT6VnlPoGQ4TKZwnkrXJdkExfhi9U23K79oVOoSQE
         Xbglr7zayOtH6doXg+OUPByOEInOMgEhvohhUlPkF2VhpjtlH2ooBBrEzjZst8pADz+C
         ehTnmpUKMA7KWzONDbgkubWAs0LywcZpmxTALdr98SqKytmll2zxBL/BYYLTZlUfQElT
         OiyAIo9b5EmJCpttHFkT57G6/FdgPQxq8WK4t7xaIf+FyIxsAZQuO1ARpyYdkyvdcils
         BC+z4RE4ulv1oDr1W3+pQTrfyeCXSPJuen4wL9U0z+PMql29kb9/xuihZgN48537YKa+
         NwYw==
X-Gm-Message-State: APjAAAXU8GBWPw96aGigOnY1RQmsbKsMqCIb0TuNcf6bmGQh6QUQOxBb
        tMJ95r+BfySJLi9Pokt1GePHUrTrLQNHL3Fz414TSQ==
X-Google-Smtp-Source: APXvYqw9bgQsi3vZ3MzvpCN0pBxwq2QkQmUYIh5r8RmfpS2ryTSlNZCmAQ0WP+YV9yFZsm/0qNeEO3e1Bxp03Df1xTQ=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr42423280otk.363.1563564460821;
 Fri, 19 Jul 2019 12:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190718225757.ndUBg%akpm@linux-foundation.org>
 <20190719061313.GI30461@dhcp22.suse.cz> <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Jul 2019 12:27:29 -0700
Message-ID: <CAPcyv4h60cMowdgBjeG2G2Qgm14nxA-UejJVuZM7S+9-fC30JA@mail.gmail.com>
Subject: Re: [patch 23/38] mm/sparsemem: introduce struct mem_section_usage
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Toshi Kani <toshi.kani@hpe.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        jmoyer <jmoyer@redhat.com>, Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 9:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 18, 2019 at 11:13 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > Has this been properly reviewed after the last rebase and is this
> > actually ready for merging? I have seen some follow up fixes
> > http://lkml.kernel.org/r/20190715081549.32577-1-osalvador@suse.de
> > and do not see those patches being in the pipe line. Or have they been
> > merged?
>
> It looks to me from the patches that Andrew updated them with
>
>   https://lore.kernel.org/linux-mm/20190715081549.32577-2-osalvador@suse.de/
>
> and
>
>   https://lore.kernel.org/linux-mm/20190718120543.GA8500@linux/
>
> so it looks good to me.
>
> But that's just from reading the patches, I might have missed
> something and I don't see the history.

I verified them. The rebase contents are identical to the manual merge
I did between my dev branch and hmm.git before sending them to Andrew.
So no lingering surprises that I can see.
