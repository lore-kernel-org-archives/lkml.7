Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8A62077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ICflxezx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLILPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:15:34 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfLILPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:15:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47WgbP58Jyz9sPT;
        Mon,  9 Dec 2019 22:15:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575890132;
        bh=ivv4mE7Cr1A3kfsmagNzfPIiXMkqIAmjoGySHTdZaAc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ICflxezxfXgKJj2TRHo09PDXTraGDxZcWeBZTgTzH+exDGc5sfNSJtteSmALMo6wo
         +xGFAmmj9EMgYtJ3g0PR0ekeoO+N6Ros3jf/BcrWAyrO/l4o8gkoBlcKNVA0BMNk3P
         BkExbGo9kBfcQIgVHiXmwUgsyIK/DcisYja4s0FeDH0xtkT0uTcayOAnq8ygAkMGN1
         MZuCTNGeZmxNUEu06CCARatSHqlxKRp4H9x3t3ZetkQduwregnmEb6ICzjAcUmeFnl
         vvHvM5TJNsW2k4oa3jTbFih+LomGYOdYWUulN+nXKTHZCDifgsXGktZo8oT5u56fT5
         Pew9Pt07D3rUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 0/2] mm: remove the memory isolate notifier
In-Reply-To: <990e19a3-b758-aaca-0ea2-c04e191cb6dc@redhat.com>
References: <20191114131911.11783-1-david@redhat.com> <990e19a3-b758-aaca-0ea2-c04e191cb6dc@redhat.com>
Date:   Mon, 09 Dec 2019 22:15:28 +1100
Message-ID: <8736dtrbqn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> On 14.11.19 14:19, David Hildenbrand wrote:
>> This is the MM part of
>> 	https://lkml.org/lkml/2019/10/31/487
>> 
>> "We can get rid of the memory isolate notifier by switching to balloon
>> compaction in powerpc's CMM (Collaborative Memory Management). The memory
>> isolate notifier was only necessary to allow to offline memory blocks that
>> contain inflated/"loaned" pages - which also possible when the inflated
>> pages are movable (via balloon compaction). [...]"
>> 
>> Michael queued the POWERPC bits that remove the single user, but I am
>> missing ACKs for the MM bits. I think it makes sense to let these two
>> patches also go via Michael's tree, to avoid collissions. Thoughts?
>
> The prereqs (powerpc bits) are upstream - I assume Michael didn't want
> to mess with MM patches.

Yes, sorry I meant to send you a mail saying so.

cheers
