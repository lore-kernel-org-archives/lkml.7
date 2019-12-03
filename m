Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D421C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AD82073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpD+3ND0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbfLCNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575380896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5EBEqGJPiXNRYZecHBTQ2o/Z3ABHvD6lVKEN+XEBDY=;
        b=UpD+3ND0cPId5lqhRZnixgCSkWtT734DAqgNN5p/HxaOz5xnObdTK8po7vRaL/ZpYfquvv
        dx46BHirA6r3tcwuGiR4L4+kR20wxCGlURry8SkVWH3gNuXEFPW3Ov2au9dKiiJiBawNcW
        BwCrjmb5QaddVoHY/0bXDVXXjFUUHrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ZCHPP63BMb6TteVSxJP0hA-1; Tue, 03 Dec 2019 08:48:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so1828538wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5EBEqGJPiXNRYZecHBTQ2o/Z3ABHvD6lVKEN+XEBDY=;
        b=ponpZBorkbe7T5iZOe+8c0bkQUcSJ/oLc6pCctFVYY5GN0z+WiL17bC2Hob+6tsX4i
         M6IFiy13lI/k/5DwKOsKY1XOFa0h6WItMk0PI8cJWAgyjxRBpvAJvb8J46AHlnbqAV2Y
         YBLvcMvJKNlmCtfqpklFFT5o8O+Dw7sWhZuhT6bTz2C2qDapXBpk4Do79Abu794h0sD/
         Kg76f4z0baPnY8i6c8FQ3rbzHXOHFm9XkbFNvQ9BJu4Lz0a/4QhTbzeNbVT0y37AhfQ2
         euE4ShIdtRaAJ0oX2yeVOiyuSii7NsS45hW/+CTp4hqcaNkaRgS/panB2lrafVJsWbyM
         WXsA==
X-Gm-Message-State: APjAAAWq3tcMI1EAHoBaGDX0QmOB95ch4U6D22Gup6C899AN0GgdoaHh
        tMGsz2FZC5dI2Ti0P6uAOnKpHNM/It4YILM8XjoQbPz1D1qowXZBB0GuJ5RgilHoSQIywieXG4n
        VIuosglx01DwGtNAgTLsaLiDm
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr29075742wmo.12.1575380891891;
        Tue, 03 Dec 2019 05:48:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1BjGoe1DzkR4woD0VDV01r9r26SUZiRfcr2ar76yyw43E2q/uHXedhVEWM4sCNcuphONk7Q==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr29075727wmo.12.1575380891617;
        Tue, 03 Dec 2019 05:48:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id u26sm3075492wmj.9.2019.12.03.05.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 05:48:11 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com> <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
Date:   Tue, 3 Dec 2019 14:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202215049.GB8120@linux.intel.com>
Content-Language: en-US
X-MC-Unique: ZCHPP63BMb6TteVSxJP0hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/19 22:50, Sean Christopherson wrote:
>>
>> I discussed this with Paolo, but I think Paolo preferred the per-vm
>> ring because there's no good reason to choose vcpu0 as what (1)
>> suggested.  While if to choose (2) we probably need to lock even for
>> per-cpu ring, so could be a bit slower.
> Ya, per-vm is definitely better than dumping on vcpu0.  I'm hoping we can
> find a third option that provides comparable performance without using any
> per-vcpu rings.
> 

The advantage of per-vCPU rings is that it naturally: 1) parallelizes
the processing of dirty pages; 2) makes userspace vCPU thread do more
work on vCPUs that dirty more pages.

I agree that on the producer side we could reserve multiple entries in
the case of PML (and without PML only one entry should be added at a
time).  But I'm afraid that things get ugly when the ring is full,
because you'd have to wait for all vCPUs to finish publishing the
entries they have reserved.

It's ugly that we _also_ need a per-VM ring, but unfortunately some
operations do not really have a vCPU that they can refer to.

Paolo

