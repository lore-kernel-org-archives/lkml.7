Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243FBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81A32068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="YMuMnML3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCKTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:19:34 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:41036 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:19:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 3B53A3FDA5;
        Tue,  3 Dec 2019 11:19:32 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YMuMnML3;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hQkhPGnONfL2; Tue,  3 Dec 2019 11:19:31 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 2BC023FD9A;
        Tue,  3 Dec 2019 11:19:25 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2AEFE3601A7;
        Tue,  3 Dec 2019 11:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575368365; bh=afmISXO+p2gaSUWsPbJMmeK9hMl4gLJ2+yXmeqSMwW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YMuMnML3YxQG85m3nectiquUE+7pOb8+v2/BHajWPV5+3wTVSKY9zD6WkShdRlAYP
         nRr3kUEqVN8KFqaxGml5jft/pecEj6eZBSHJC9djpaQjgSr+xudRlUjAJhtxLiNUMS
         qgcKUC2/I/x+BfmmOhsQkUJcegagbtE2x7KicYII=
Subject: Re: [PATCH 2/2] drm/ttm: Fix vm page protection handling
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203075446.60197-1-thomas_os@shipmail.org>
 <20191203075446.60197-3-thomas_os@shipmail.org>
 <20191203095502.hw3r33ioax2x4kvt@box>
 <c1f35529-6e3c-2ba5-bd86-e7cc04cbc1b1@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <5a8b8351-0960-305b-6606-96b673d7b729@shipmail.org>
Date:   Tue, 3 Dec 2019 11:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1f35529-6e3c-2ba5-bd86-e7cc04cbc1b1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 10:58 AM, Christian König wrote:
> Am 03.12.19 um 10:55 schrieb Kirill A. Shutemov:
>> On Tue, Dec 03, 2019 at 08:54:46AM +0100, Thomas Hellström (VMware) 
>> wrote:
>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>
>>> We were using an ugly hack to set the page protection correctly.
>>> Fix that and instead use vmf_insert_mixed_prot() and / or
>>> vmf_insert_pfn_prot().
>>> Also get the default page protection from
>>> struct vm_area_struct::vm_page_prot rather than using 
>>> vm_get_page_prot().
>>> This way we catch modifications done by the vm system for drivers that
>>> want write-notification.
>> Hm. Why doesn't your VMA have the right prot flags in the first 
>> place? Why
>> do you need to override them? More context, please.
>
> TTM allows for graphics buffer to move between system and IO memory. 
> So the prot flags can change on the fly for a VMA.
>
I'll add that and some additional info to the commit message. And fix 
that CC'd dri-devel address.

Thanks,
Thomas





> Regards,
> Christian.


