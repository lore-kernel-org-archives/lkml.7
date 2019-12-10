Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8C2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5MYWxfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfLJJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:34:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726915AbfLJJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575970474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkqyHzuZRB9HPpEWKuIWzSx2tHDZpQpQcGjAwOGBtLA=;
        b=L5MYWxfRnnYBr9WK7ntM7ODd0P0FuA9sbn1sl2KfzUCvnWxbHYcKbSd6/SWKxX1z2Z5S9W
        rEBk/iD8AdnI+M1/YyGbvSJEO7YcOZ4jUQwm0xB3pOiQM64hktsRK+GFTYjbTXGj/apAJ6
        mNZQTQDo1e82m8IiL7m+bSpH/v3Zkw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-QHAv85vJN8-bN_txsG6q-w-1; Tue, 10 Dec 2019 04:34:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31144107ACC9;
        Tue, 10 Dec 2019 09:34:30 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6BE5C219;
        Tue, 10 Dec 2019 09:34:27 +0000 (UTC)
Date:   Tue, 10 Dec 2019 17:34:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, david@redhat.com, jgross@suse.com,
        akpm@linux-foundation.org
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20191210093424.GL2984@MiWiFi-R3L-srv>
References: <20191210084413.21957-1-bhe@redhat.com>
 <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
MIME-Version: 1.0
In-Reply-To: <75188d0f-c609-5417-aa2e-354e76b7ba6e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QHAv85vJN8-bN_txsG6q-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 at 08:24pm, Balbir Singh wrote:
>=20
>=20
> On 10/12/19 7:44 pm, Baoquan He wrote:
> > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
> > parameter") a global varialbe global max_mem_size is added to store
>                   typo ^^^
> > the value parsed from 'mem=3D ', then checked when memory region is
> > added. This truly stops those DIMM from being added into system memory
> > during boot-time.
> >=20
> > However, it also limits the later memory hotplug functionality. Any
> > memory board can't be hot added any more if its region is beyond the
> > max_mem_size. System will print error like below:
> >=20
> > [  216.387164] acpi PNP0C80:02: add_memory failed
> > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > [  216.392187] acpi PNP0C80:02: Enumeration failure
> >=20
> > From document of 'mem=3D ' parameter, it should be a restriction during
> > boot, but not impact the system memory adding/removing after booting.
> >=20
> >   mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of memo=
ry
> > =09          ...
> >=20
> > So fix it by also checking if it's during boot-time when restrict memor=
y
> > adding. Otherwise, skip the restriction.
> >=20
>=20
> The fix looks reasonable, but I don't get the use case. Booting with mem=
=3D is
> generally a debug option, is this for debugging memory hotplug + limited =
memory?

Not really. My understanding is whether 'mem=3D ' is for debugging or not,
it should only take effect during boot-time. Even though people add
'mem=3D ' for debugging only, they will have to reboot if they want to do
futher testing, e.g memory hotplug, or any other feature which makes use
of the memory hotplug mechanism to implement their functionality, like
ballon, or pmem.

Thanks
Baoquan

