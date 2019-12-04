Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF1BC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135E1207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1wc9iFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLDKkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:40:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727445AbfLDKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575456019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRNmBx2wsqK9xIWW91qWtVivmtgY9ipTfRTyxrXmrXQ=;
        b=H1wc9iFBDQZCik8Yxgr7/aF8fRvcysYMLOIjky913WJRBIbg2EQLlxDtw7V73P6G5xP9Wk
        G0L+C6bbDCAxoV6Ozi/YA+xO5jtp0cGt8QokbYt9kIa7h9V8pWoKforqmJW6azlS782Cu3
        ke4YDO/gusBxjqXMYcWPJVV3opt3hPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157--F5P7tqOPUahJOzke-L-NA-1; Wed, 04 Dec 2019 05:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A85A618A8C89;
        Wed,  4 Dec 2019 10:40:15 +0000 (UTC)
Received: from [10.72.12.45] (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBBD177E4;
        Wed,  4 Dec 2019 10:39:59 +0000 (UTC)
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <776732ca-06c8-c529-0899-9d2ffacf7789@redhat.com>
Date:   Wed, 4 Dec 2019 18:39:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -F5P7tqOPUahJOzke-L-NA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/30 =E4=B8=8A=E5=8D=885:34, Peter Xu wrote:
> Branch is here:https://github.com/xzpeter/linux/tree/kvm-dirty-ring
>
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This is a continued work from Lei Cao<lei.cao@stratus.com>  and Paolo
> on the KVM dirty ring interface.  To make it simple, I'll still start
> with version 1 as RFC.
>
> The new dirty ring interface is another way to collect dirty pages for
> the virtual machine, but it is different from the existing dirty
> logging interface in a few ways, majorly:
>
>    - Data format: The dirty data was in a ring format rather than a
>      bitmap format, so the size of data to sync for dirty logging does
>      not depend on the size of guest memory any more, but speed of
>      dirtying.  Also, the dirty ring is per-vcpu (currently plus
>      another per-vm ring, so total ring number is N+1), while the dirty
>      bitmap is per-vm.
>
>    - Data copy: The sync of dirty pages does not need data copy any more,
>      but instead the ring is shared between the userspace and kernel by
>      page sharings (mmap() on either the vm fd or vcpu fd)
>
>    - Interface: Instead of using the old KVM_GET_DIRTY_LOG,
>      KVM_CLEAR_DIRTY_LOG interfaces, the new ring uses a new interface
>      called KVM_RESET_DIRTY_RINGS when we want to reset the collected
>      dirty pages to protected mode again (works like
>      KVM_CLEAR_DIRTY_LOG, but ring based)
>
> And more.


Looks really interesting, I wonder if we can make this as a library then=20
we can reuse it for vhost.

Thanks

