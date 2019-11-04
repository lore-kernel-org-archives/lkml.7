Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC2CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074E21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVZRRJU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfKDCwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 21:52:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728437AbfKDCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572835951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXjYrGIsHqKdgGAtBr7HEpIjQtsm9UUKtuxj6Twt+UY=;
        b=RVZRRJU4LWQme1tbNNbzKqlsFPVDGtYGVVV71VhCWd52Px6osGA8AOTDo6RNqO24G6Z7gr
        EnOgLd2zADDjviY7mwnYsjjb56vxkWrPgjK0zbxgBIqkeF3FAcvNPxnVzJJF/cY55o2hje
        lbwtc4d3CgwzCJnSvkYhEF617S2vgts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215--hfYGEOLOBaATEUH2p7Y3g-1; Sun, 03 Nov 2019 21:52:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58B2B800A1A;
        Mon,  4 Nov 2019 02:52:23 +0000 (UTC)
Received: from [10.72.12.188] (ovpn-12-188.pek2.redhat.com [10.72.12.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFF69600C4;
        Mon,  4 Nov 2019 02:51:55 +0000 (UTC)
Subject: Re: [PATCH V6 3/6] mdev: introduce device specific ops
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
        "cunming.liang@intel.com" <cunming.liang@intel.com>,
        "zhihong.wang@intel.com" <zhihong.wang@intel.com>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>,
        "haotian.wang@sifive.com" <haotian.wang@sifive.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>,
        "freude@linux.ibm.com" <freude@linux.ibm.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        Ido Shamay <idos@mellanox.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "stefanha@redhat.com" <stefanha@redhat.com>
References: <20191030064444.21166-1-jasowang@redhat.com>
 <20191030064444.21166-4-jasowang@redhat.com>
 <AM0PR05MB4866E91139617C9F2380BBAFD1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <495efacd-4898-fb89-2599-dce3a5a277f0@redhat.com>
Date:   Mon, 4 Nov 2019 10:51:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866E91139617C9F2380BBAFD1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: -hfYGEOLOBaATEUH2p7Y3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/2 =E4=B8=8A=E5=8D=884:11, Parav Pandit wrote:
>
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Wednesday, October 30, 2019 1:45 AM
>> To: kvm@vger.kernel.org; linux-s390@vger.kernel.org; linux-
>> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; intel-
>> gfx@lists.freedesktop.org; intel-gvt-dev@lists.freedesktop.org;
>> kwankhede@nvidia.com; alex.williamson@redhat.com; mst@redhat.com;
>> tiwei.bie@intel.com
>> Cc: virtualization@lists.linux-foundation.org; netdev@vger.kernel.org;
>> cohuck@redhat.com; maxime.coquelin@redhat.com;
>> cunming.liang@intel.com; zhihong.wang@intel.com;
>> rob.miller@broadcom.com; xiao.w.wang@intel.com;
>> haotian.wang@sifive.com; zhenyuw@linux.intel.com; zhi.a.wang@intel.com;
>> jani.nikula@linux.intel.com; joonas.lahtinen@linux.intel.com;
>> rodrigo.vivi@intel.com; airlied@linux.ie; daniel@ffwll.ch;
>> farman@linux.ibm.com; pasic@linux.ibm.com; sebott@linux.ibm.com;
>> oberpar@linux.ibm.com; heiko.carstens@de.ibm.com; gor@linux.ibm.com;
>> borntraeger@de.ibm.com; akrowiak@linux.ibm.com; freude@linux.ibm.com;
>> lingshan.zhu@intel.com; Ido Shamay <idos@mellanox.com>;
>> eperezma@redhat.com; lulu@redhat.com; Parav Pandit
>> <parav@mellanox.com>; christophe.de.dinechin@gmail.com;
>> kevin.tian@intel.com; stefanha@redhat.com; Jason Wang
>> <jasowang@redhat.com>
>> Subject: [PATCH V6 3/6] mdev: introduce device specific ops
>>
>> Currently, except for the create and remove, the rest of mdev_parent_ops=
 is
>> designed for vfio-mdev driver only and may not help for kernel mdev driv=
er.
>> With the help of class id, this patch introduces device specific callbac=
ks inside
>> mdev_device structure. This allows different set of callback to be used =
by vfio-
>> mdev and virtio-mdev.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
> [ ..]
>
>> diff --git a/include/linux/vfio_mdev_ops.h b/include/linux/vfio_mdev_ops=
.h
>> new file mode 100644 index 000000000000..3907c5371c2b
>> --- /dev/null
>> +++ b/include/linux/vfio_mdev_ops.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * VFIO Mediated device definition
>> + */
>> +
>> +#ifndef VFIO_MDEV_H
>> +#define VFIO_MDEV_H
>> +
> I should have noticed this before. :-(
> APIs exposed are by the mdev module and named with mdev_ prefix.
> And file name is _ops.h,
>
> We should name this file as mdev_vfio_ops.h
>
> And #define should be MDEV_VFIO_OPS_H
>
>> +#include <linux/mdev.h>
>> +
>> +/**
>> + * struct vfio_mdev_device_ops - Structure to be registered for each
> s/vfio_mdev_device_ops/mdev_vfio_device_ops/
>
> Similarly for virtio in future patches.
>

Will fix in V7.


>   static void mtty_device_release(struct device *dev)
> --
> 2.19.1
> With above small nit changes to rename the fields and file,
>
> Reviewed-by: Parav Pandit <parav@mellanox.com>


Appreciate that, thanks.


