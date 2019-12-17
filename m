Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81209C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5445121582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2mYBiZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfLQQ27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:28:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbfLQQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576600138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QjX231V5laeRafQx7w7GoeX0Nh1hHz4npFVAtL7D8g=;
        b=O2mYBiZXLJ1sy6lZoH+3CuEdC3AiUFCjSaaWwhXU5cX8lc6y8dxc0MOB3gcYl3X7poan/2
        LXF5gtlvH1kUpqAns4HnYbwoeaNz6eXIWSCE2ruhuBkzKBGbFRDuleACFL2LPcDOgcm9bu
        iy4UlXNyMZWcqI4vmMVV0o5yrnvie4k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-Fvhu9w9HPT-Sf0zZveDktQ-1; Tue, 17 Dec 2019 11:28:57 -0500
X-MC-Unique: Fvhu9w9HPT-Sf0zZveDktQ-1
Received: by mail-wr1-f69.google.com with SMTP id c6so5529416wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 08:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QjX231V5laeRafQx7w7GoeX0Nh1hHz4npFVAtL7D8g=;
        b=c8Bg596uitXgIshGJlcMbUL8rKTLZYZhEp9TRpS6wrn8ve8aJ5GYRqxhpUgv5nT5kM
         LBMkdWMp4+WFra7xJ5jlJJB3chKg2Mfr22uzUEwGQVh2ep5VVb2jAMAzUKDK2hDrE5GE
         VMn9PrVS1IFRaizz6TMC4AH+g/UznV0M6WhFKf0SOgyHNMtfOBBHSMfQC/fxMNd0cESe
         2L3fZoTPMx+2Dn0W4WnxpljUGGAChSaEksfHmYKAB4pbRwUJ6e9Q3eKahfCewEhc611R
         2IW5YXAI3MrdQRIyB6wAs6u+45lNN/Ijs7hwdYfsCyxTjKObI3yWPbFODqPD29Nsprzl
         qyBw==
X-Gm-Message-State: APjAAAVRSQTFTKtpBubgU7YIB62liLd+S2DkK1k/bd2KwmhWux3ZQc9X
        kWN9cR6TbSmAl0IptisHIhRi168YRY+DcrTWcn6sTwAx6zDrW10OXaM4awy3ijh+f76769YdqD/
        /Ysyp2M+eSp7LJw8lh4CUkGvy
X-Received: by 2002:adf:93c5:: with SMTP id 63mr38034360wrp.236.1576600135975;
        Tue, 17 Dec 2019 08:28:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRJaRQi6xIACk4g1bfPvll2CC76RIL71MS1JCPM6b+N9bpbm+K8CT7GIX0TKm/lKeMlLnoNQ==
X-Received: by 2002:adf:93c5:: with SMTP id 63mr38034345wrp.236.1576600135728;
        Tue, 17 Dec 2019 08:28:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a? ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
        by smtp.gmail.com with ESMTPSA id e18sm25885046wrr.95.2019.12.17.08.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:28:55 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <20191216185454.GG83861@xz-x1>
 <815923d9-2d48-2915-4acb-97eb90996403@redhat.com>
 <20191217162405.GD7258@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c01d0732-2172-2573-8251-842e94da4cfc@redhat.com>
Date:   Tue, 17 Dec 2019 17:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217162405.GD7258@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 17:24, Peter Xu wrote:
>> No, please pass it all the way down to the [&] functions but not to
>> kvm_write_guest_page.  Those should keep using vcpu->kvm.
> Actually I even wanted to refactor these helpers.  I mean, we have two
> sets of helpers now, kvm_[vcpu]_{read|write}*(), so one set is per-vm,
> the other set is per-vcpu.  IIUC the only difference of these two are
> whether we should consider ((vcpu)->arch.hflags & HF_SMM_MASK) or we
> just write to address space zero always.

Right.

> Could we unify them into a
> single set of helper (I'll just drop the *_vcpu_* helpers because it's
> longer when write) but we always pass in vcpu* as the first parameter?
> Then we add another parameter "vcpu_smm" to show whether we want to
> consider the HF_SMM_MASK flag.

You'd have to check through all KVM implementations whether you always
have the vCPU.  Also non-x86 doesn't have address spaces, and by the
time you add ", true" or ", false" it's longer than the "_vcpu_" you
have removed.  So, not a good idea in my opinion. :D

Paolo

