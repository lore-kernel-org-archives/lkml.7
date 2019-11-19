Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA287C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9922067D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aldipVGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfKSLjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:39:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727529AbfKSLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574163546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqslKyHX5IkfV4p/2W8dpmzdL4w7O9b6FLnrdnA2aXY=;
        b=aldipVGoi3YYMLCxBckUlEQtIizkp3Lrg2j6N6Z8OLq654dPJYLV5XPX5KfKRlUeFUhCOy
        SOTcaUtYkf6TCeuxudBYfrKCVc4AhityJYAsAKq5gQLoK9SWfMG1tFEPMvXlEAp43O1qM/
        pZnc15Ab53bdSLFf3U2+HQq+xlTQ2Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217--XTH75I1NQiRokKnsiwpSw-1; Tue, 19 Nov 2019 06:39:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39AD85EB;
        Tue, 19 Nov 2019 11:39:04 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62ABE60467;
        Tue, 19 Nov 2019 11:39:00 +0000 (UTC)
Subject: Re: [PATCH] virtio_balloon: fix shrinker count
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20191119101745.39038-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3820c098-504a-c4d2-2832-dea6b8d282c4@redhat.com>
Date:   Tue, 19 Nov 2019 12:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119101745.39038-1-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: -XTH75I1NQiRokKnsiwpSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.19 11:18, Michael S. Tsirkin wrote:
> From: Wei Wang <wei.w.wang@intel.com>
>=20
> Instead of multiplying by page order, virtio balloon divided by page
> order. The result is that it can often return 0 if there are a bit less
> than MAX_ORDER - 1 pages in use, and then shrinker scan won't be called.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 7cee05cdf3fb..65df40f261ab 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -825,7 +825,7 @@ static unsigned long virtio_balloon_shrinker_count(st=
ruct shrinker *shrinker,
>   =09unsigned long count;
>  =20
>   =09count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09count +=3D vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PAGE_ORDER=
;
> +=09count +=3D vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER=
;
>  =20
>   =09return count;
>   }
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb

