Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B048C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F31220692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9FttcX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgAHToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:44:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbgAHToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578512654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMRQrznsbzSjtlf0lQFDY0JtcAwrzSd+QX0zX3BOs2k=;
        b=Z9FttcX6jL4RzDHrn9BLiRf9Ym0Pqbz0ziUsEn1m8U9FUT8GQH+cw4qvyTnTM/VDQKlwUD
        wxXSMXYhA1p+vTPPFUrHiX6WvRnXUvKuMmothANlYm9WWp68eGiPMTrEPifi/qqmlZecEf
        Ud5sVryUAhmUS6oiBBXCmC3J+Sk/87A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-rp3zaVeaPv6UfNyfqi4P2A-1; Wed, 08 Jan 2020 14:44:13 -0500
X-MC-Unique: rp3zaVeaPv6UfNyfqi4P2A-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1831616wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cMRQrznsbzSjtlf0lQFDY0JtcAwrzSd+QX0zX3BOs2k=;
        b=sdU9CmVu4dpyE5GA4kAzxZEkKCk3tsTlchcLi0IbzQRfGuuJNpc9frRGoCCqcDrMqH
         USSscILeOC94pbBdj5zJ2OeKMnsfUp0IWz4w4dMhjhcs4DvXd/4OVq/ZwK7YWfdX2UwV
         bVZwEb73r1mK4XK9KDCZmBLSUP0+muOUfuXmmlYMuosFezrcrGx0rdnv8CjDpRhtwcfF
         5l23J2YdZTaprdbee09Dzv2SKHi7El7c6jhNVcy+BqRSRGHDqGsu+O4o1nBm45c2QB5I
         smVpy4yUzm4MFVWpw3Z9lU5va32huJveWzMS6wGYn6Yyw2e7gldy09msIDlJWRZeJbOh
         PXYA==
X-Gm-Message-State: APjAAAXvbxeFbU7HnChCqZIC96Dt/zgr84rfXpRGPqg+YNhmG8gNpMxe
        frfvm9SC6rmR/oTKe04HhR3brhjteIUjRT4N2pJpO5zenX7pRcQfggg0j7qTxi5yNNFDR237hyz
        Onm23x+4tQy7/ZgHqWd29Q70M
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr235689wmj.175.1578512652205;
        Wed, 08 Jan 2020 11:44:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6Udq5HntGuIazbWsfw/ygAYHPKVLZ9sImXcCCWDU0SWSRt+amBVLXlg+oTsMtN3geDV3w3Q==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr235672wmj.175.1578512652012;
        Wed, 08 Jan 2020 11:44:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id m7sm127875wma.39.2020.01.08.11.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:44:11 -0800 (PST)
Subject: Re: [PATCH RESEND v2 03/17] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-4-peterx@redhat.com>
 <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
 <20191223172737.GA81196@xz-x1>
 <851bd9ed-3ff3-6aef-725c-b586d819211c@redhat.com>
 <20191223201024.GB90172@xz-x1>
 <e56d4157-1a0a-3f45-0e02-ac7c10fccf96@redhat.com>
 <20200108191512.GF7096@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <649c77ba-94a7-d0bf-69e7-fa0276f536d1@redhat.com>
Date:   Wed, 8 Jan 2020 20:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108191512.GF7096@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 20:15, Peter Xu wrote:
> But you seemed to have fixed that already? :)

Perhaps. :)

> 3898da947bba ("KVM: avoid using rcu_dereference_protected", 2017-08-02)
> 
> And this path is after kvm_destroy_vm() so kvm->users_count should be 0.
> Or I feel like we need to have more places to take the lock..

Yeah, it should be okay assuming you test with lockdep.

Paolo

