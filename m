Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CE5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFEA21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAs8NYST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfKDKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:37:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfKDKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572863860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMXyGR7I3i/vhgf/dekFdcU/0hdNU18RC/twvaKN7SI=;
        b=NAs8NYSTg1BFoE8Ey/SN3T5a7mBCju2FzoFOKDIAY433UAyQjkB0bfNblFewI1bU4SEHZW
        fr/DBAnppHxYSaBKfumDCn9zC+/NhVAOKdDM5Ixj5iLfoOS348QgKsus9GMGeTsj/zpoMn
        NNOwtngrX/Qq0IaJcfz9HU960BD6dsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Xv08RWICP4GRgnKWVX-6qA-1; Mon, 04 Nov 2019 05:37:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 934198017DD;
        Mon,  4 Nov 2019 10:37:36 +0000 (UTC)
Received: from [10.36.118.62] (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546C519C4F;
        Mon,  4 Nov 2019 10:37:35 +0000 (UTC)
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20191031221602.9375-1-hannes@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <39ae67e9-fc2b-5c85-63a2-a149cd99b0b3@redhat.com>
Date:   Mon, 4 Nov 2019 11:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031221602.9375-1-hannes@cmpxchg.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Xv08RWICP4GRgnKWVX-6qA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.19 23:16, Johannes Weiner wrote:
> Currently, the drop_caches proc file and sysctl read back the last
> value written, suggesting this is somehow a stateful setting instead
> of a one-time command. Make it write-only, like e.g. compact_memory.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   kernel/sysctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 31ece1120aa4..50373984a5e2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1474,7 +1474,7 @@ static struct ctl_table vm_table[] =3D {
>   =09=09.procname=09=3D "drop_caches",
>   =09=09.data=09=09=3D &sysctl_drop_caches,
>   =09=09.maxlen=09=09=3D sizeof(int),
> -=09=09.mode=09=09=3D 0644,
> +=09=09.mode=09=09=3D 0200,
>   =09=09.proc_handler=09=3D drop_caches_sysctl_handler,
>   =09=09.extra1=09=09=3D SYSCTL_ONE,
>   =09=09.extra2=09=09=3D &four,
>=20

Makes perfect sense to me (and we might notice while in next/master if=20
this breaks something, hopefully)

Acked-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

