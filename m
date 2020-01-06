Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28154C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43762072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWgPNtmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgAFCv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:51:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26399 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727307AbgAFCv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578279088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsRJ7uoCT/3TCgqLDKH0aLBqgk5O1Rp9vht+XRsijOA=;
        b=RWgPNtmXajvE5hLnVdmNi2p9s2KUFQYHOcl/02Fd/mVXTmkMZVqp6uf2mrwuoeuvZjjwXe
        6YDcqbXK4PufVzfQ0epPLInIKDcY1sneEpw5H2G3AKxzotz9mZsBTyDFttobEdxmwDosfU
        vVa0lXKoUH05S6eBsZT2yI4a0Fd9qAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-DGFkBu0UO6O5ST1fwjOQGQ-1; Sun, 05 Jan 2020 21:51:25 -0500
X-MC-Unique: DGFkBu0UO6O5ST1fwjOQGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6F8A801E76;
        Mon,  6 Jan 2020 02:51:23 +0000 (UTC)
Received: from [10.72.12.147] (ovpn-12-147.pek2.redhat.com [10.72.12.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3DC10840F1;
        Mon,  6 Jan 2020 02:51:12 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Liu, Jiang" <gerry@linux.alibaba.com>,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
 <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
 <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
 <46806720-1D1C-40C3-BEE2-EDB0D4DA39BF@linux.alibaba.com>
 <7e151886-408e-2c1d-3958-77c26b8a4ac0@redhat.com>
 <20200105062023-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e8dafb72-0737-01ad-f1c9-28870dbb8c1a@redhat.com>
Date:   Mon, 6 Jan 2020 10:51:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200105062023-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/5 =E4=B8=8B=E5=8D=887:25, Michael S. Tsirkin wrote:
> On Fri, Jan 03, 2020 at 05:12:38PM +0800, Jason Wang wrote:
>> On 2020/1/3 =E4=B8=8B=E5=8D=882:14, Liu, Jiang wrote:
>>>> Ok, I get you now.
>>>>
>>>> But still, having fixed number of MSIs is less flexible. E.g:
>>>>
>>>> - for x86, processor can only deal with about 250 interrupt vectors.
>>>> - driver may choose to share MSI vectors [1] (which is not merged bu=
t we will for sure need it)
>>> Thanks for the info:)
>>> X86 systems roughly have NCPU * 200 vectors available for device inte=
rrupts.
>>> The proposed patch tries to map multiple event sources to an interrup=
t vector, to avoid running out of x86 CPU vectors.
>>> Many virtio mmio devices may have several or tens of event sources, a=
nd it=E2=80=99s rare to have hundreds of event sources.
>>> So could we treat the dynamic mapping between event sources and inter=
rupt vectors as an advanced optional feature?
>>>
>> Maybe, but I still prefer to implement it if it is not too complex. Le=
t's
>> see Michael's opinion on this.
>>
>> Thanks
> I think a way for the device to limit # of vectors in use by driver is
> useful. But sharing of vectors doesn't really need any special
> registers, just program the same vector for multiple Qs/interrupts.


Right, but sine the #vectors is limited, we still need dynamic mapping=20
like what is done in PCI.

Thanks


>

