Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F405920833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwpa7N+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLDLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:05:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727466AbfLDLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575457500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T19X4nvS8o6/QCGqV5cYH9dB5ySF6S5McpcQOxAuM1Y=;
        b=gwpa7N+QlyvEwAyLuFjR2Cj+LU1whkt2XeyQiywvnZOMe8YA3NqDqC2DrSPwHWBOUPMevC
        sp1wI9JFrbGgVFHUu9/YxeJRzyKcD5OUzzziJ3J7n+veP9XB8JXZ7J0waVS15edQ7+mUOb
        BpKEXOtICPYrs0T+NVnDvBvRrBaANc8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-BNCD6OTNNSOUBu-pIXxETg-1; Wed, 04 Dec 2019 06:04:56 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so3456334wrq.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mPzTUYV/4/AeMFkskqxn26gUIegqrDV8tBrRpiOjJE=;
        b=E4VsriG9/ACm7rdPZsqOshtkuSXDcRoGdPCq5Ui4BDqGjMGtM7YVQ4DMjky5A+zee4
         hZX3yvFUoUCyllgWktBctKjel1R0cUaWC3/VNMDI3t2uW7fXZL+6jmRar8G8T7XmoiAw
         xDJnnESYFSB7haE9l9bMVZO8mbWeclbN1uH8hnhsUZGuErLGilL/yC8ius79Zv9kEcwl
         lNuIu4AyyIaUj5gvCm+sWUeFK6gwsrjYcnsP9rxgZMHQ6BhOcB2L+D5bxmcJ4y883Xus
         ybnPXX3fXJgJ788KxLgQMFNSsBDz9nty1/jW5M8ysJE/rGnOCq07VLh+WJYZMjV7ysIr
         XQOA==
X-Gm-Message-State: APjAAAUKyfb9uMOjSYMfweUJQijbdTOp301R6lWWRHcQgKHsWYLt2DxR
        PBTZLIz5B00hdkppHT/akTTu6KU7zTett/QDSYX5Zgs62/B3c3lAxgdKIk11AjQMfbFpOXzYXr0
        pd464HbCEqqvMAiFfN6LfZtQS
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr3157138wrj.325.1575457495740;
        Wed, 04 Dec 2019 03:04:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZej/ubogLxmoGHCyzT2M4jWD3RKQn+Hr3K0Odb3wHdjAp8chAUWwQGUSBl7gRSN6mqYV+jA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr3157105wrj.325.1575457495413;
        Wed, 04 Dec 2019 03:04:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id k19sm6238150wmi.42.2019.12.04.03.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 03:04:54 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
Date:   Wed, 4 Dec 2019 12:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
Content-Language: en-US
X-MC-Unique: BNCD6OTNNSOUBu-pIXxETg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/19 11:38, Jason Wang wrote:
>>
>> +=C2=A0=C2=A0=C2=A0 entry =3D &ring->dirty_gfns[ring->dirty_index & (rin=
g->size - 1)];
>> +=C2=A0=C2=A0=C2=A0 entry->slot =3D slot;
>> +=C2=A0=C2=A0=C2=A0 entry->offset =3D offset;
>=20
>=20
> Haven't gone through the whole series, sorry if it was a silly question
> but I wonder things like this will suffer from similar issue on
> virtually tagged archs as mentioned in [1].

There is no new infrastructure to track the dirty pages---it's just a
different way to pass them to userspace.

> Is this better to allocate the ring from userspace and set to KVM
> instead? Then we can use copy_to/from_user() friends (a little bit slow
> on recent CPUs).

Yeah, I don't think that would be better than mmap.

Paolo


> [1] https://lkml.org/lkml/2019/4/9/5

