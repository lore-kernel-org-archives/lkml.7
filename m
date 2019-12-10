Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E87C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191C8207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLyQlMLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLJNcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:32:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26913 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727061AbfLJNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575984718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zG80mYfBd3fViyzCn3KpotJdNxDgZHe7SOcelUNx0g=;
        b=QLyQlMLOQ9mhnS3zQ6DEwvRoxNPlYGGOpN/a2Yps2ffB/PFshe0ce2GJLrlq5u3aET6d/Q
        L90limQULW64MD4+6BXbZ9QVHIhtR7M1/o42tTC3E7REv2IpgJj/BgZM/qepZ+V38xZTHj
        ST9VpGHnTwnd4TNzvJGBVW6SHkFkoNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-4PL6x97iPfiz1xzNriYr1Q-1; Tue, 10 Dec 2019 08:31:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so8906538wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 05:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+zG80mYfBd3fViyzCn3KpotJdNxDgZHe7SOcelUNx0g=;
        b=Yemhr9RkANzMRgzXwtB8WTPcwmqExfYRDTGqk/XFWXkJEbdovCH6vBi9SG7cck44uB
         Q48cyt5c8s581MRBOxiGEVZ6fR5JKfer24pTfkrSxyV5gX5J9wp5Tnm2NmN908coLI4m
         1kouiWGJdNPnGNlongfVtL+qoU8BUx3fZG5SKT6V9Ufc0aw1X02ZEROslTjdUSe6GvnY
         gPf+QHsIhcXrgz3NYeJiD1BdTzw2xOtjsoBUrNVH75iWDRFfd1OLDgrjjNRdTOEbx9Gr
         AHsZ8gTCNwNcE6vr9MclARABNkhCnXGxPKBmgbsog/ePBtcIEFE5pD5nXLf5MgYElne+
         9Xcg==
X-Gm-Message-State: APjAAAUbPIAE58iea4me+9lP8XM2ovycFjZlwoUX+SXvTJFpF6aKfJHu
        7Y9MVJad44dJtEPnmSfefurNPH+oi80lLPoHZFxIXHv0lq452u6DPvBTV//h58lIZzJ7lN7aGmS
        kMyhFTiEBmInEUruwiqKMD5dj
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr3153938wrw.373.1575984716150;
        Tue, 10 Dec 2019 05:31:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfhzGVbFt8ye1oZ0Fqx1K1/PNOqob3EdPQ1TOnXC1rqknFM0Gg4Ty4IHcOaPiNjQiXQIi79Q==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr3153914wrw.373.1575984715928;
        Tue, 10 Dec 2019 05:31:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id z6sm3476706wrw.36.2019.12.10.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 05:31:55 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
 <20191210081958-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
Date:   Tue, 10 Dec 2019 14:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210081958-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: 4PL6x97iPfiz1xzNriYr1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 14:25, Michael S. Tsirkin wrote:
>> There is no new infrastructure to track the dirty pages---it's just a
>> different way to pass them to userspace.
> Did you guys consider using one of the virtio ring formats?
> Maybe reusing vhost code?

There are no used/available entries here, it's unidirectional
(kernel->user).

> If you did and it's not a good fit, this is something good to mention
> in the commit log.
> 
> I also wonder about performance numbers - any data here?

Yes some numbers would be useful.  Note however that the improvement is
asymptotical, O(#dirtied pages) vs O(#total pages) so it may differ
depending on the workload.

Paolo

