Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A5BFC619B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF49921A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtEtacNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbfKEKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:07:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388228AbfKEKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572948465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+p6MzjaCDgcAgk98VJBsyJP1N813kTt9VSOvi9TO8ZM=;
        b=AtEtacNhCGs/V+NferlO1/shjJfbhz2PbMW6OdFt8ZF9drWYGHwBGtr9zaYdudIravRdGn
        i8tpp6F/5e6KgedG7vOwU/acScGDolB0nPn1SBy0RoJPR5EThKoreLJWr6MZiza4EaA18h
        EK6AidkZu3RIUft47VL+97ULBvDiEKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-M3qGGrxpM7GVcLI_o98zVQ-1; Tue, 05 Nov 2019 05:07:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F4EE800C73;
        Tue,  5 Nov 2019 10:07:39 +0000 (UTC)
Received: from [10.36.117.253] (ovpn-117-253.ams2.redhat.com [10.36.117.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A429561069;
        Tue,  5 Nov 2019 10:07:35 +0000 (UTC)
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191102120221.7553-1-david@redhat.com>
 <20191105012049.x2k4v2xizd2tim5b@gabell>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <495a43af-befb-91f9-0097-9f0b449ff632@redhat.com>
Date:   Tue, 5 Nov 2019 11:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191105012049.x2k4v2xizd2tim5b@gabell>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: M3qGGrxpM7GVcLI_o98zVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.19 02:20, Masayoshi Mizuma wrote:
> 5.4-rc5 with this patch works for memory-hotadd and remove, thanks!
> Please feel free to add:
>=20
>      Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> Without this patch, memory hotplug fails as panic:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   ...
>   Call Trace:
>    remove_memory_block_devices+0x81/0xc0
>    try_remove_memory+0xb4/0x130
>    ? walk_memory_blocks+0x75/0xa0
>    __remove_memory+0xa/0x20
>    acpi_memory_device_remove+0x84/0x100
>    acpi_bus_trim+0x57/0x90
>    acpi_bus_trim+0x2e/0x90
>    acpi_device_hotplug+0x2b2/0x4d0
>    acpi_hotplug_work_fn+0x1a/0x30
>    process_one_work+0x171/0x380
>    worker_thread+0x49/0x3f0
>    kthread+0xf8/0x130
>    ? max_active_store+0x80/0x80
>    ? kthread_bind+0x10/0x10
>    ret_from_fork+0x35/0x40
>=20
> - Masa

Thanks a lot for testing!

--=20

Thanks,

David / dhildenb

