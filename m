Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF642C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837932071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibzca+ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKVPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:55:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbfKVPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574438149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=po6yZvLzvGuf/JKHed4MQOE6rYLICxK0ouM8np6WEEM=;
        b=ibzca+oxN2uGOvkrmhwnjQlaF8LACBdfoOZvLoTYh881/s8gQPVxBXoTuHelaNQ3XuZX2B
        OTggXJza10o9LlZBUfquwDvF46WVHuYvwQUYZ7Y6n44+t6qbf3MHWYa805urZXmqB+cjwE
        Eu/14iilfIXVvrLWPg0X3Unjb5buUy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-nj-aXOQeMfmQGGl3xMgaiQ-1; Fri, 22 Nov 2019 10:55:45 -0500
Received: by mail-wm1-f70.google.com with SMTP id i23so3250333wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=po6yZvLzvGuf/JKHed4MQOE6rYLICxK0ouM8np6WEEM=;
        b=IDDtj7fY4vA66aGfqhqYOX7HAnCvZB7yFA6lKEky63pPBdhlUD7dM/ZxxFzg9yCAbT
         YL5AEpDwXidZWRQu4jn5Ho3I1JjQQhtzR6yzWm5Ws4L99P2uBVVbv1xotkZdDLHazd7F
         zwRVxx++MaGzGq1/HkXqyB7VBzMWnfHv469dU/xCuE9pxLKumfrubRp6Xv+ISfphq4RO
         fVUUElofKpCfomDheqd1rFd1qwWgVCV7qbtvpsDkgTArO/B6/zV1bjZtaqWewCUZ+Fff
         enp7hSyOg7qsMp4MUlSM7vGnXxcxK6rlnHVVA96BLEJiGP9akEXO79gGNq4mnz64zK6S
         0BAg==
X-Gm-Message-State: APjAAAUawquTNfeDV0wEkFWs4FrF1clc+QBnXHpcdhZJOJ21ccKggrPp
        VgymoxBCjZdyw+23enrskG0mmZ93JpGwt45+4uepmPys+FRFdmmt4e6Glm2kTpRFG+yZ0Yxq7Et
        at0n6KcuvGFk2MCDuyMoYbVB7
X-Received: by 2002:adf:f303:: with SMTP id i3mr17763765wro.157.1574438144393;
        Fri, 22 Nov 2019 07:55:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3Ym/QJzF0VsZ+bxyGSaEG8bsBdY02wNjVW2H429sAlCSh7TBbG2/cUOsZz1Hvz6mpRG647w==
X-Received: by 2002:adf:f303:: with SMTP id i3mr17763734wro.157.1574438144138;
        Fri, 22 Nov 2019 07:55:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:804c:6f01:8c0d:ce14? ([2001:b07:6468:f312:804c:6f01:8c0d:ce14])
        by smtp.gmail.com with ESMTPSA id i25sm3682356wmd.25.2019.11.22.07.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:55:43 -0800 (PST)
Subject: Re: [PATCH v7 2/9] vmx: spp: Add control flags for Sub-Page
 Protection(SPP)
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, sean.j.christopherson@intel.com,
        yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-3-weijiang.yang@intel.com>
 <d6e71e7b-b708-211c-24b7-8ffe03a52842@redhat.com>
 <20191121153442.GH17169@local-michael-cet-test>
 <58b4b445-bd47-d357-9fdd-118043624215@redhat.com>
 <20191122152331.GA9822@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8e43dab5-e07e-03a3-fa0d-dd9457fb17b9@redhat.com>
Date:   Fri, 22 Nov 2019 16:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122152331.GA9822@local-michael-cet-test>
Content-Language: en-US
X-MC-Unique: nj-aXOQeMfmQGGl3xMgaiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/19 16:23, Yang Weijiang wrote:
>> QEMU for example ships with a program called vmxcap (though it requires
>> root).  We also could write a program to analyze the KVM capabilities
>> and print them, and put it in tools/kvm.
>>
> OK, will update vmxcap to add SPP feature bit, thanks!

It's already there. :)

Paolo

