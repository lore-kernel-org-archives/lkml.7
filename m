Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DCDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57F4206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGVxUlgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfKNIQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:16:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbfKNIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573719407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pz4h7KTvi15etsg91JTbTPY+IW6HvuoxNFsGvR7DmQ=;
        b=dGVxUlgPyWJPXjJdKwYvVxg9Os8fsbMp3lDUGsPDnDiHTchJsQ5UocAMtdlhQ9ngl0tOWK
        VK1ixqxQODVYc999NSSUYr+65vdBF8W416H54A0ViTYerJvB0G8OzIDwzwoe/9xUW2cgps
        bOTiB9PUBU+x1TCWfEQ9QhbTu+vX2gY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-DvE3QywuOrGiB5fflIsqgg-1; Thu, 14 Nov 2019 03:16:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76D1DB20;
        Thu, 14 Nov 2019 08:16:41 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4595E258;
        Thu, 14 Nov 2019 08:16:40 +0000 (UTC)
Date:   Thu, 14 Nov 2019 16:16:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct  mapping.
Message-ID: <20191114081638.GH30906@MiWiFi-R3L-srv>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
 <20191102010911.21460-5-msys.mizuma@gmail.com>
 <20191104004825.GK7616@MiWiFi-R3L-srv>
 <20191112204707.jyruwkb4pbdj3jvv@gabell>
MIME-Version: 1.0
In-Reply-To: <20191112204707.jyruwkb4pbdj3jvv@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DvE3QywuOrGiB5fflIsqgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 at 03:47pm, Masayoshi Mizuma wrote:
> Your suggesion makes it simpler, thanks!
> So I'll modify calc_direct_mapping_size() as following.
> Does it make sense?

Yeah, it looks good to me. Thanks.

>=20
> static inline unsigned long calc_direct_mapping_size(void)
> {
>        unsigned long size_tb, memory_tb;
>=20
>        memory_tb =3D DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT)=
 +
>                CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>=20
> #ifdef CONFIG_MEMORY_HOTPLUG
>        if (boot_params.max_addr) {
>                unsigned long maximum_tb;
>=20
>                maximum_tb =3D DIV_ROUND_UP(boot_params.max_addr,
>                                1UL << TB_SHIFT);
>=20
>                if (maximum_tb > memory_tb)
>                        memory_tb =3D maximum_tb;
>        }
> #endif
>        size_tb =3D 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>=20
>        /*
>         * Adapt physical memory region size based on available memory
>         */
>        if (memory_tb < size_tb)
>                size_tb =3D memory_tb;
>=20
>        return size_tb;
> }

