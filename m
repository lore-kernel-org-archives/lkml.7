Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D5DC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A002087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfEHg1PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfKGKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:17:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbfKGKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573121841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfV7Ui0H34lc92hzIDp9GSS0/7fG2fsW51TyX4HtAsI=;
        b=CfEHg1PJYo5wBamWhOPfDIxIqwFz6blp3vY/u4lgx//DVMrfYJkwa60EBdjmhDq+fTuaTr
        b5czqTM2Y3i98riOyNV67izXrxAjfwaZjdpeCr54vHYfzJhTrub1i4mK8hsk7iM6O+zjR/
        A5sjC+b9Sk2FBTGqx1PJ8w2JIQ6FIFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-DKf9nbPbNFy35g1M123gRg-1; Thu, 07 Nov 2019 05:17:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D398F800C61;
        Thu,  7 Nov 2019 10:17:16 +0000 (UTC)
Received: from [10.72.12.214] (ovpn-12-214.pek2.redhat.com [10.72.12.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 446925C290;
        Thu,  7 Nov 2019 10:16:49 +0000 (UTC)
Subject: Re: [PATCH v6] vhost: introduce mdev based hardware backend
To:     Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        alex.williamson@redhat.com, maxime.coquelin@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, lingshan.zhu@intel.com
References: <20191107073530.15291-1-tiwei.bie@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1b60cc37-1c85-df85-1f4d-3f9a10ecef54@redhat.com>
Date:   Thu, 7 Nov 2019 18:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107073530.15291-1-tiwei.bie@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DKf9nbPbNFy35g1M123gRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/7 =E4=B8=8B=E5=8D=883:35, Tiwei Bie wrote:
> This patch introduces a mdev based hardware vhost backend.
> This backend is built on top of the same abstraction used
> in virtio-mdev and provides a generic vhost interface for
> userspace to accelerate the virtio devices in guest.
>
> This backend is implemented as a mdev device driver on top
> of the same mdev device ops used in virtio-mdev but using
> a different mdev class id, and it will register the device
> as a VFIO device for userspace to use. Userspace can setup
> the IOMMU with the existing VFIO container/group APIs and
> then get the device fd with the device name. After getting
> the device fd, userspace can use vhost ioctls on top of it
> to setup the backend.
>
> Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> ---
> This patch depends on below series:
> https://lkml.org/lkml/2019/11/6/538


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks!

