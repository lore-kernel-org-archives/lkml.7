Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8794C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6FA20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="rZAHpK0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfLDOQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:16:19 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39368 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfLDOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:16:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 404F63F47A;
        Wed,  4 Dec 2019 15:16:16 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rZAHpK0e;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Km9YbJabySxh; Wed,  4 Dec 2019 15:16:15 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B12EC3F435;
        Wed,  4 Dec 2019 15:16:10 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CC96A360608;
        Wed,  4 Dec 2019 15:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575468969; bh=6lPiouUhoiffGwUD7wWb3htpX7yUG7AcztUp9kFYLLI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rZAHpK0eBRbwsu388vybVwAbkZPQbHLOKHyty+7r1UkSH/04RpXI227bMqMFVxlRP
         UrWX6Ijp3UQj9Wj1JrcokDlB6PmEsywz/A8GWJ0k+N90X8OolmzmVQX97MzB97QuBG
         Cuz7tDkgVF3SLv9OwcbU14195XaWJKO0qK8uDafY=
Subject: Re: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-3-thomas_os@shipmail.org>
 <20191204135219.GH25242@dhcp22.suse.cz>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b29b166c-e9fe-f829-f533-b39f98b334a9@shipmail.org>
Date:   Wed, 4 Dec 2019 15:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191204135219.GH25242@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 2:52 PM, Michal Hocko wrote:
> On Tue 03-12-19 11:48:53, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> TTM graphics buffer objects may, transparently to user-space,  move
>> between IO and system memory. When that happens, all PTEs pointing to the
>> old location are zapped before the move and then faulted in again if
>> needed. When that happens, the page protection caching mode- and
>> encryption bits may change and be different from those of
>> struct vm_area_struct::vm_page_prot.
>>
>> We were using an ugly hack to set the page protection correctly.
>> Fix that and instead use vmf_insert_mixed_prot() and / or
>> vmf_insert_pfn_prot().
>> Also get the default page protection from
>> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
>> This way we catch modifications done by the vm system for drivers that
>> want write-notification.
> So essentially this should have any new side effect on functionality it
> is just making a hacky/ugly code less so?

Functionality is unchanged. The use of a on-stack vma copy was severely 
frowned upon in an earlier thread, which also points to another similar 
example using vmf_insert_pfn_prot().

https://lore.kernel.org/lkml/20190905103541.4161-2-thomas_os@shipmail.org/

> In other words what are the
> consequences of having page protection inconsistent from vma's?

During the years, it looks like the caching- and encryption flags of 
vma::vm_page_prot have been largely removed from usage. From what I can 
tell, there are no more places left that can affect TTM. We discussed 
__split_huge_pmd_locked() towards the end of that thread, but that 
doesn't affect TTM even with huge page-table entries.

/Thomas


