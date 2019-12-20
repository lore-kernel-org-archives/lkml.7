Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD4BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29E22467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="p3sd2f8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTIGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:06:19 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44264 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfLTIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:06:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E18D23F39C;
        Fri, 20 Dec 2019 09:06:16 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=p3sd2f8Z;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X975R5nw9Zgj; Fri, 20 Dec 2019 09:06:15 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E5BAC3F5AD;
        Fri, 20 Dec 2019 09:06:09 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E6E6B36215B;
        Fri, 20 Dec 2019 09:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576829169; bh=Q2+zsn1qCmWl8yYgXnf252a2g92KszZb+cwwyH5RgCo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=p3sd2f8ZZmX+4iXnUTLPMIFKc6tKabjE4bXiMCS3K45uQ3jcgbSyOI8kT3MYfBZA2
         oBJDjhM2bPK/1aJ+6OKK0E17wXlaSX84YE7OmGpNfyt8MVMeDfaah0vTz9W5XAW+I9
         nTsjpKTa4R5PZhmxaiwEK0cbgeBb51SqgAF8Zt6o=
Subject: Ack to merge through DRM tree? WAS [PATCH v4 0/2] mm, drm/ttm: Fix
 pte insertion with customized protection
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <cc7e153d-84ff-d1f8-484f-614eafac1864@shipmail.org>
Date:   Fri, 20 Dec 2019 09:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191212084741.9251-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 12/12/19 9:47 AM, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> The drm/ttm module is using a modified on-stack copy of the
> struct vm_area_struct to be able to set a page protection with customized
> caching. Fix that by adding a vmf_insert_mixed_prot() function similar
> to the existing vmf_insert_pfn_prot() for use with drm/ttm.
>
> I'd like to merge this through a drm tree.
>
> Changes since v1:
> *) Formatting fixes in patch 1
> *) Updated commit message of patch 2.
> Changes since v2:
> *) Moved vmf_insert_mixed_prot() export to patch 2 (Michal Hocko)
> *) Documented under which conditions it's safe to use a page protection
>     different from struct vm_area_struct::vm_page_prot. (Michal Hocko)
> Changes since v3:
> *) More documentation regarding under which conditions it's safe to use a
>     page protection different from struct vm_area_struct::vm_page_prot. This
>     time also in core vm. (Michal Hocko)
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
>
Seems all concerns with this series have been addressed. Could I have an 
ack to merge this through a DRM tree?

Thanks,

Thomas



