Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031DECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB992070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+GdkZ3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfJUIgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:36:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbfJUIgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571646967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewVPPXtUzwa/2gMziVT4GfNhMvA6qBwP9ka3yYbfjF8=;
        b=O+GdkZ3T+A14MT4k2P8UMhcKAUMdcqnoLITjASyUk0hk1Zq3P4FC0v6LdNcvqrfA3wNLnr
        eJHtdz9aa4cm0DGq/WlN7fN5KWK7ahjCjSw+TbtO/wGheQMsl32KIYK8yPu2zdsiGNIiXs
        TixBYweu1oOZi9qrQAK/JhePPxmRomw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-zoWy5pCgP46PYWXgoF_mrg-1; Mon, 21 Oct 2019 04:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DBCE1005500;
        Mon, 21 Oct 2019 08:36:03 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39B60F6FB;
        Mon, 21 Oct 2019 08:35:50 +0000 (UTC)
Subject: Re: [patch 06/26] mm/memory_hotplug: don't access uninitialized
 memmaps in shrink_pgdat_span()
To:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        cai@lca.pw, catalin.marinas@arm.com, christophe.leroy@c-s.fr,
        dalias@libc.org, damian.tometzki@gmail.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, gerald.schaefer@de.ibm.com,
        glider@google.com, gor@linux.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hpa@zytor.com, ira.weiny@intel.com,
        jgg@ziepe.ca, linux-mm@kvack.org, logang@deltatee.com,
        luto@kernel.org, mark.rutland@arm.com, mgorman@techsingularity.net,
        mingo@redhat.com, mm-commits@vger.kernel.org, mpe@ellerman.id.au,
        osalvador@suse.de, pagupta@redhat.com, pasha.tatashin@soleen.com,
        pasic@linux.ibm.com, paulus@samba.org,
        pavel.tatashin@microsoft.com, peterz@infradead.org,
        richard.weiyang@gmail.com, richardw.yang@linux.intel.com,
        robin.murphy@arm.com, rppt@linux.ibm.com, stable@vger.kernel.org,
        steve.capper@arm.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, vbabka@suse.cz,
        will@kernel.org, willy@infradead.org,
        yamada.masahiro@socionext.com, yaojun8558363@gmail.com,
        ysato@users.sourceforge.jp, yuzhao@google.com
References: <20191019031933.PakTLd2V_%akpm@linux-foundation.org>
 <20191021082841.GD9379@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <70fbf807-bd72-5192-ae38-f5a6b23fddf2@redhat.com>
Date:   Mon, 21 Oct 2019 10:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021082841.GD9379@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zoWy5pCgP46PYWXgoF_mrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.19 10:28, Michal Hocko wrote:
> Has this been reviewed properly? I do not see any Acks nor Reviewed-bys.
> Did Aneesh gave it some testing?

No explicit ACK/RB. I know that Aneesh at leasted reviewed parts of the=20
v4/v5 series and gave it a test (which resulted in "[patch 07/26]=20
mm/memunmap: don't access uninitialized memmap in memunmap_pages()").

--=20

Thanks,

David / dhildenb

