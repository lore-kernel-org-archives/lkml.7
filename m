Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B531821872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7IdaOvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfJVNG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:06:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731804AbfJVNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571749585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Syfd0H8D/BZLCngMYW2+8Gfqpo3syPeWg7AigfxOHa0=;
        b=T7IdaOvNunr1wNsBP9ffS7PduaqV/tkwfalTxTZHSFu2y5t0mfQs8spb0eri7IZW8uUrtV
        rrb+UFDXuLjq9C914hc/Qfh3z7NWwhFOM7psQZVi80IMd0wQq7xXT9sKS+HmyyHwrji21v
        YGXIuhVoFUdobL2AKLepAiu27t238w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-71H0vHNaOHmN2MZTv4qjeg-1; Tue, 22 Oct 2019 09:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABD6B800D4E;
        Tue, 22 Oct 2019 13:06:20 +0000 (UTC)
Received: from [10.72.12.23] (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 514B819C69;
        Tue, 22 Oct 2019 13:06:00 +0000 (UTC)
Subject: Re: [RFC 2/2] vhost: IFC VF vdpa layer
To:     Zhu Lingshan <lingshan.zhu@linux.intel.com>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com,
        alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com
References: <20191016013050.3918-1-lingshan.zhu@intel.com>
 <20191016013050.3918-3-lingshan.zhu@intel.com>
 <9495331d-3c65-6f49-dcd9-bfdb17054cf0@redhat.com>
 <f65358e9-6728-8260-74f7-176d7511e989@intel.com>
 <1cae60b6-938d-e2df-2dca-fbf545f06853@redhat.com>
 <ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b2adaab0-bbc3-b7f0-77da-e1e3cab93b76@redhat.com>
Date:   Tue, 22 Oct 2019 21:05:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 71H0vHNaOHmN2MZTv4qjeg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/22 =E4=B8=8B=E5=8D=882:53, Zhu Lingshan wrote:
>
> On 10/21/2019 6:19 PM, Jason Wang wrote:
>>
>> On 2019/10/21 =E4=B8=8B=E5=8D=885:53, Zhu, Lingshan wrote:
>>>
>>> On 10/16/2019 6:19 PM, Jason Wang wrote:
>>>>
>>>> On 2019/10/16 =E4=B8=8A=E5=8D=889:30, Zhu Lingshan wrote:
>>>>> This commit introduced IFC VF operations for vdpa, which complys to
>>>>> vhost_mdev interfaces, handles IFC VF initialization,
>>>>> configuration and removal.
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>> ---


[...]


>>
>>
>>>
>>>>
>>>>
>>>>> +}
>>>>> +
>>>>> +static int ifcvf_mdev_set_features(struct mdev_device *mdev, u64=20
>>>>> features)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 struct ifcvf_adapter *adapter =3D mdev_get_drvdat=
a(mdev);
>>>>> +=C2=A0=C2=A0=C2=A0 struct ifcvf_hw *vf =3D IFC_PRIVATE_TO_VF(adapter=
);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 vf->req_features =3D features;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>> +}
>>>>> +
>>>>> +static u64 ifcvf_mdev_get_vq_state(struct mdev_device *mdev, u16=20
>>>>> qid)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 struct ifcvf_adapter *adapter =3D mdev_get_drvdat=
a(mdev);
>>>>> +=C2=A0=C2=A0=C2=A0 struct ifcvf_hw *vf =3D IFC_PRIVATE_TO_VF(adapter=
);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return vf->vring[qid].last_avail_idx;
>>>>
>>>>
>>>> Does this really work? I'd expect it should be fetched from hw=20
>>>> since it's an internal state.
>>> for now, it's working, we intend to support LM in next version drivers.
>>
>>
>> I'm not sure I understand here, I don't see any synchronization=20
>> between the hardware and last_avail_idx, so last_avail_idx should not=20
>> change.
>>
>> Btw, what did "LM" mean :) ?
>
> I can add bar IO operations here, LM =3D live migration, sorry for the=20
> abbreviation.


Just make sure I understand here, I believe you mean reading=20
last_avail_idx through IO bar here?

Thanks


