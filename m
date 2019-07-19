Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46804C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279B12173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfGSE2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732082AbfGSEGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:06:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0197AC2E;
        Fri, 19 Jul 2019 04:06:19 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 1/2] xen/gntdev: replace global limit of
 mapped pages by limit per call
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20190718065222.31310-1-jgross@suse.com>
 <20190718065222.31310-2-jgross@suse.com>
 <4e402502-acbc-2718-26d4-cbcf83697c15@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <03892464-7429-c2e0-79fd-2774bcc3ce20@suse.com>
Date:   Fri, 19 Jul 2019 06:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4e402502-acbc-2718-26d4-cbcf83697c15@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.19 19:36, Andrew Cooper wrote:
> On 18/07/2019 07:52, Juergen Gross wrote:
>> Today there is a global limit of pages mapped via /dev/xen/gntdev set
>> to 1 million pages per default.
> 
> The Xen default limit even for dom0 is 1024 pages * 16 entries per page,
> which is far lower than this limit.

Actually its 256 entries per page, but this is still lower than the
current limit.

> 
>> There is no reason why that limit is
>> existing, as total number of foreign mappings is limited by the
> 
> s/foreign/grant/ ?

Can do.

> 
>> hypervisor anyway and preferring kernel mappings over userspace ones
>> doesn't make sense.
> 
> Its probably also worth stating that this a root-only device, which
> further brings in to question the user/kernel split.

Yes.

> 
>>
>> Additionally checking of that limit is fragile, as the number of pages
>> to map via one call is specified in a 32-bit unsigned variable which
>> isn't tested to stay within reasonable limits (the only test is the
>> value to be <= zero, which basically excludes only calls without any
>> mapping requested). So trying to map e.g. 0xffff0000 pages while
>> already nearly 1000000 pages are mapped will effectively lower the
>> global number of mapped pages such that a parallel call mapping a
>> reasonable amount of pages can succeed in spite of the global limit
>> being violated.
>>
>> So drop the global limit and introduce per call limit instead.
> 
> Its probably worth talking about this new limit.  What is it trying to
> protect?

Out-of-bounds allocations.


Juergen
