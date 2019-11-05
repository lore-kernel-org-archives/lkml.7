Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15729C2BAEF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59612084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5kg6ivk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfKEI5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:57:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730502AbfKEI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572944220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePB2ZQmY2sifU+nwwoHipXio+6LOoXm3aODKbiWSPvI=;
        b=O5kg6ivkJS5VzdoaoCRE4n4UimbTzx3aNyPc1vaBwWIbWn2MptffR0vS53ppg7SaLB6KwN
        r8b57eggEOSVmA8NUkw/RrDT7bF6PRlz6bhIQJiupJb4O/EoL2P26JOf0oAZOjAfZMpoSr
        Ea9WpAf6/dKAHkXqez6wmuzlWqeQn1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-s5fQEbBQNE-l8mw9EbzlxA-1; Tue, 05 Nov 2019 03:56:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078B6477;
        Tue,  5 Nov 2019 08:56:55 +0000 (UTC)
Received: from [10.36.117.253] (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6B26600C4;
        Tue,  5 Nov 2019 08:56:51 +0000 (UTC)
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
To:     Jerome Glisse <jglisse@redhat.com>, Hillf Danton <hdanton@sina.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com> <20191104190355.GH5134@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2f271007-0a46-bc9f-fca9-4fceeb819cc1@redhat.com>
Date:   Tue, 5 Nov 2019 09:56:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104190355.GH5134@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: s5fQEbBQNE-l8mw9EbzlxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.19 20:03, Jerome Glisse wrote:
> On Mon, Nov 04, 2019 at 06:20:50PM +0800, Hillf Danton wrote:
>>
>> On Sun, 3 Nov 2019 22:09:03 -0800 John Hubbard wrote:
>>> On 11/3/19 8:34 PM, Hillf Danton wrote:
>>> ...
>>>>>
>>>>> Well, as long as we're counting bits, I've taken 21 bits (!) to track
>>>>> "gupers". :)  More accurately, I'm sharing 31 bits with get_page()...=
please
>>>>
>>>> Would you please specify the reasoning of tracking multiple gupers
>>>> for a dirty page? Do you mean that it is all fine for guper-A to add
>>>> changes to guper-B's data without warning and vice versa?
>>>
>>> It's generally OK to call get_user_pages() on a page more than once.
>>
>> Does this explain that it's generally OK to gup pin a page under
>> writeback and then start DMA to it behind the flusher's back without
>> warning?
>=20
> It can happens today, is it ok ... well no but we live in an imperfect
> world. GUP have been abuse by few device driver over the years and those
> never checked what it meant to use it so now we are left with existing
> device driver that we can not break that do wrong thing.
>=20
> I personaly think that we should use bounce page for writeback so that
> writeback can still happens if a page is GUPed. John's patchset is the
> first step to be able to identify GUPed page and maybe special case them.
>=20
>>
>>> And even though we are seeing some work to reduce the number of places
>>> in the kernel that call get_user_pages(), there are still lots of call =
sites.
>>> That means lots of combinations and situations that could result in mor=
e
>>> than one gup call per page.
>>>
>>> Furthermore, there is no mechanism, convention, documentation, nor anyt=
hing
>>> at all that attempts to enforce "for each page, get_user_pages() may on=
ly
>>> be called once."
>>
>> What sense is this making wrt the data corruption resulting specifically
>> from multiple gup references?
>=20
> Multiple GUP references do not imply corruption. Only one or more devices
> writing to the page while writeback is happening is a cause of corruption=
.
> Multiple device writting in the same page concurrently is like multiple
> CPU thread doing the same. Either the application/device drivers are doin=
g
> this rightfully on purpose or the application has a bug. Either way it is
> not our problem (note here i am talking about userspace portion of the
> device driver).
>=20

If I'm not completely off, we can have multiple GUP references easily by=20
using KVM+VFIO.

--=20

Thanks,

David / dhildenb

