Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A0C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1BF21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Au9Z0pKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfKEMsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:48:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388373AbfKEMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572958122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jEVDWNch/xYgmO6OEN+wbzCxr5VY9dJ1NypSvMkGAk=;
        b=Au9Z0pKOIFUiV7USCxLar/8ex0Sa6NwU3XtbM+uI6vCScReZ0Rwd2HR6n1dI9UIn2mEqVo
        d057pYUgub1O6GhYEwnTQdLhX6O+3mJI5Kj7E9QJJvhosR7ePRvkxuQR/cjc+WaAqWd1Td
        bl3fuZ8rj2YRVstZDfd15CiByhgHYbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-MXpRGnxXNxOf2pXTLPnBXA-1; Tue, 05 Nov 2019 07:48:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC151005500;
        Tue,  5 Nov 2019 12:48:36 +0000 (UTC)
Received: from [10.72.12.252] (ovpn-12-252.pek2.redhat.com [10.72.12.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 069201001B00;
        Tue,  5 Nov 2019 12:48:04 +0000 (UTC)
Subject: Re: [PATCH 1/2] IFC hardware operation layer
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com
References: <1572946660-26265-1-git-send-email-lingshan.zhu@intel.com>
 <1572946660-26265-2-git-send-email-lingshan.zhu@intel.com>
 <20191105074309-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9506db6b-ae68-271d-5e13-411715811131@redhat.com>
Date:   Tue, 5 Nov 2019 20:47:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191105074309-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MXpRGnxXNxOf2pXTLPnBXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/5 =E4=B8=8B=E5=8D=888:45, Michael S. Tsirkin wrote:
>> +
>> +#define IFC_SUPPORTED_FEATURES \
>> +=09=09((1ULL << VIRTIO_NET_F_MAC)=09=09=09| \
>> +=09=09 (1ULL << VIRTIO_F_ANY_LAYOUT)=09=09=09| \
>> +=09=09 (1ULL << VIRTIO_F_VERSION_1)=09=09=09| \
>> +=09=09 (1ULL << VIRTIO_F_ORDER_PLATFORM)=09=09=09| \
> ACCESS_PLATFORM must be enabled for sure?
>
>

I think so, consider vhost-mdev can filter it out right now.

Thanks

