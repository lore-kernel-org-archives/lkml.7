Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50AFC2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B608205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSqp01Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLDKO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:14:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727268AbfLDKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575454465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jaZNglZBHWh1PXOWzB13kdHQKSWZGLUFvmmlN21CdK0=;
        b=RSqp01Goo6FZSOX79wURMhjgMBdWWO/7ILKsy24sINbPe4EM3MilAtB4Aa5oa4JjXM2aZn
        7NTdCR5v4UTiMvhVWrW/aOxBVOWNI9f3IpyPwxIBuUhBHlwvRdDAjySaperCHXX83+spGq
        okNDZeYf1lWiczyJsA6KEdM272NEXo4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-RVj9DOZCOgOuO8kpUEyTBw-1; Wed, 04 Dec 2019 05:14:22 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so1922357wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jaZNglZBHWh1PXOWzB13kdHQKSWZGLUFvmmlN21CdK0=;
        b=Xljqd+G9Oz3slKRgX5AUaNZ4toKfthJIiMMO+Mk+62cAtKHXdqYupBRP1FibmdiWO7
         8Tc7otLlLmvRbhTB080L1ZaREikIwelvoICVeZdUyXe2+Sr+GIOJpQ/UjMqpeOS70Bf6
         rfoSIEcUTC4hTVnXWGhXJJewvK/H+QPKRZBrmxsrxb6uk/381uKNcwqesf0RkrQoVLdr
         GC4YOO3kqMA0gJiCxcDSNCHv6Ym05e+iDWZnd+PqnxD6BiALWm3Kdsmd6asahuC+05Hz
         lfMvjlq58gpa4zcVWF+xblJyWf5Aeb7o9PMfltV+jRwjABsbMzEZsivqm1XyuOLAAxlp
         5S/g==
X-Gm-Message-State: APjAAAVWwPjVj+tSHfCYddUKTIiy2Uq6yU28fyK/7MXtOXPJ9NXKuWWd
        n5hgIwr85isMbN7ho9S2qm/zqv/35oMWHEMV4vRD3PmlGN6qAxzVKTulXH7IzaFknIa21FRBJLN
        l2LR/2GnHWqaL6fiENf0RH/LC
X-Received: by 2002:adf:ef92:: with SMTP id d18mr3009770wro.234.1575454461048;
        Wed, 04 Dec 2019 02:14:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1mQooSgrWGZALy9jHjc1l54Ros7SOKeVLepAlo+Jylrte2L011cYMVOzZALXmbTSQo50Kmg==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr3009739wro.234.1575454460809;
        Wed, 04 Dec 2019 02:14:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id n188sm7149011wme.14.2019.12.04.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 02:14:20 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191203191328.GD19877@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24cf519e-5efa-85a7-9bc0-9be15957eb0a@redhat.com>
Date:   Wed, 4 Dec 2019 11:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203191328.GD19877@linux.intel.com>
Content-Language: en-US
X-MC-Unique: RVj9DOZCOgOuO8kpUEyTBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 20:13, Sean Christopherson wrote:
> The setting of as_id is wrong, both with and without a vCPU.  as_id should
> come from slot->as_id.

Which doesn't exist, but is an excellent suggestion nevertheless.

>> +		/*
>> +		 * Put onto per vm ring because no vcpu context.  Kick
>> +		 * vcpu0 if ring is full.
>> +		 */
>> +		vcpu = kvm->vcpus[0];
> 
> Is this a rare event?

Yes, every time a vCPU exit happens, the vCPU is supposed to reap the VM
ring as well.  (Most of the time it will be empty, and while the reaping
of VM ring entries needs locking, the emptiness check doesn't).

Paolo

>> +		ring = &kvm->vm_dirty_ring;
>> +		indexes = &kvm->vm_run->vm_ring_indexes;
>> +		is_vm_ring = true;
>> +	}
>> +
>> +	ret = kvm_dirty_ring_push(ring, indexes,
>> +				  (as_id << 16)|slot->id, offset,
>> +				  is_vm_ring);
>> +	if (ret < 0) {
>> +		if (is_vm_ring)
>> +			pr_warn_once("vcpu %d dirty log overflow\n",
>> +				     vcpu->vcpu_id);
>> +		else
>> +			pr_warn_once("per-vm dirty log overflow\n");
>> +		return;
>> +	}
>> +
>> +	if (ret)
>> +		kvm_make_request(KVM_REQ_DIRTY_RING_FULL, vcpu);
>> +}
> 

