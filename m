Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4961CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F47D207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+RR4A4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKYIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:20:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32170 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbfKYIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574670002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVpZi8JXk+Gn2x1ju+aRnIKTgySiGqpiCe8/VQiJ+ck=;
        b=g+RR4A4MyQjGtFvJx+fWUiAZSrZfgacwiqVo53ClRdPlP9CgkjPolr7RaA8UAxQQiJ0B9X
        bVFC/lOiaN8qihIjU1rGb8E96K455DtCL1y96k3Tsyc4yCZROJgaDmPXhXkX9qNQJuHnWG
        WOci340roOR4uj2qB0WHGS9IfkeLFDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-IIzbJ_fvOUGlXrfXA5iL8g-1; Mon, 25 Nov 2019 03:20:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C663110CE780;
        Mon, 25 Nov 2019 08:19:58 +0000 (UTC)
Received: from [10.72.12.44] (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF04608B0;
        Mon, 25 Nov 2019 08:19:47 +0000 (UTC)
Subject: Re: [RFC V4 2/2] This commit introduced IFC operations for vdpa
To:     Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com,
        alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com
References: <1574241431-24792-1-git-send-email-lingshan.zhu@intel.com>
 <1574241431-24792-3-git-send-email-lingshan.zhu@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f4cd7ba4-953e-872a-42bd-aa1303c18458@redhat.com>
Date:   Mon, 25 Nov 2019 16:19:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574241431-24792-3-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IIzbJ_fvOUGlXrfXA5iL8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/20 =E4=B8=8B=E5=8D=885:17, Zhu Lingshan wrote:
> +
> +=09if (!strcmp(kobj->name, "ifcvf-virtio_mdev"))
> +=09=09mdev_virtio_set_class_id(mdev,MDEV_VIRTIO_CLASS_ID_VIRTIO);
> +
> +=09if (!strcmp(kobj->name, "ifcvf-vhost_mdev"))
> +=09=09mdev_virtio_set_class_id(mdev,MDEV_VIRTIO_CLASS_ID_VHOST);
> +
> +=09mdev_set_drvdata(mdev, adapter);
> +=09mdev_set_iommu_device(mdev_dev(mdev), dev);
> +=09adapter->mdev_count--;
> +


To avoid confusion, it's better to call mdev_set_iommu_device() only for=20
the case of vhost. For virtio, it doesn't depends on that to work.

Thanks

