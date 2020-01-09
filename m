Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13E4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDFE20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnO6whRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgAIUv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:51:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33835 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728664AbgAIUv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578603116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qu8blCRDlzm/qLVFE5UR+s1TwIN4x5NgSUj8f1EJSs=;
        b=BnO6whRP49RZB2Jj4XBkd9cicr9ZFca/EHR90lPYfggbvHYitLrF0jDXcLHdYNlzl+ycsB
        Cyl4MNUVxYG5+ijn9KzQu26EsusqFcSYncP8JNispc+0czfcq91ufsGMizxBy7/yvR+V2a
        l7jrcz+vfBS/C5s2CEczOc8EEpp9OLk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-3VifxMCdM1aMVYntAiojWA-1; Thu, 09 Jan 2020 15:51:55 -0500
X-MC-Unique: 3VifxMCdM1aMVYntAiojWA-1
Received: by mail-wr1-f72.google.com with SMTP id d8so3330258wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+qu8blCRDlzm/qLVFE5UR+s1TwIN4x5NgSUj8f1EJSs=;
        b=tWOj9XdEC4aPaD1be5PIl44ibAOcNEHbnSaSf36Z0BF4MdIgasIInTOss8o6MTNOic
         XRjhOxXL2z6cCh2yDBcYFjAjfo4DJdo8Hp7zCf0n45z9RBSAveJH4MIVhlnWMAIofEVt
         7G8hBVTvO/B7k7q1OQBc9weTHxYfdv0pZWsf/SIQrGZXQnDQ7WNXB9zmEYkMHEH7NQZN
         /7NxaFfGG8vZisXN+tameMbiKMQgGkljRM0OoZdxazldYGXU24TBX6CLSXi/JX4Tt7td
         sonXD9I1gV/STyGoqkP1wUhlmSfYlvIFKUc7vq9LE4T+Sd/i9v5QAGJrtHXzTNxD75Eu
         siig==
X-Gm-Message-State: APjAAAUBHLF3tTzpKxWn+O82jlig32pT3LMkuA55xiGWdQYeskMgvnh1
        qYa7O+NI8o8qa9L7rps+SHBiQMvonuxBSeQl4/VXyzXadvsRTy2rr7Kgx5sP1TvJOrGntidm3zC
        LzMhrAuvtnjIOUl32cXXxvV6X
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr13068434wrm.241.1578603114519;
        Thu, 09 Jan 2020 12:51:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUkc1W0JH2wPGSGgsriAl9XJ5bfYNaxAfV5pQh7ajg11nbajhVxytC/uExDq3BtxUddmlSDg==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr13068413wrm.241.1578603114251;
        Thu, 09 Jan 2020 12:51:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bc4e:7fe8:2916:6a59? ([2001:b07:6468:f312:bc4e:7fe8:2916:6a59])
        by smtp.gmail.com with ESMTPSA id m7sm4047716wma.39.2020.01.09.12.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 12:51:53 -0800 (PST)
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
To:     "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109094711.00eb96b1@w520.home> <20200109175808.GC36997@xz-x1>
 <20200109140948-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feffe012-0407-128a-185a-42cb9d5aac5c@redhat.com>
Date:   Thu, 9 Jan 2020 21:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109140948-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 20:13, Michael S. Tsirkin wrote:
> That's one of the reasons I called for using something
> resembling vring_packed_desc.

In principle it could make sense to use the ring-wrap detection
mechanism from vring_packed_desc instead of the producer/consumer
indices.  However, the element address/length indirection is unnecessary.

Also, unlike virtio, KVM needs to know if there are N free entries (N is
~512) before running a guest.  I'm not sure if that is possible with
ring-wrap counters, while it's trivial with producer/consumer indices.

Paolo

