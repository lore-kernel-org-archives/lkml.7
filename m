Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F8C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226720882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501997AbfIWQvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390796AbfIWQvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:51:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB92D5859E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:51:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h6so5087484wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RbYm8r31nf5/CgoKO2hq1IVIw3F2t6/IIFZwh76KkU=;
        b=rj+9yS0920taGBgKX5Km/v4bIDdCfOvzKMTWE3c9LfgMZ3VJB7KdZh41UhgfXOZ10C
         1wBhh9HNQrRHDInQd03S/E0LgBWGbaQvvJvo+eZV32a0YdyTkEnY+tfvtXnRKz9AhtBt
         h9OnuE8NBDBVFmO+KXMEp9o2jmy5yYgfbF9YfyZIZ1KBdkoIYxql0egnJiHhSEUILyDg
         IjJGkz+dsfwfE7i0Jv5Zsswf4uYz5Mt2tZolh2P0qjd6157/rwuqDoaXl5cGXrIJLa/6
         3CRVriFXpqdm2RTmWzI34Fin8wIUrDnfQ6NkVHozMtp8Utevp+U3haDSX0RxBnM46asg
         BqTQ==
X-Gm-Message-State: APjAAAWeYEvXWRemEop+m7iyFDGXRmU7FW1FycJ2Tp5SAAzrD3j3Wczq
        UOuA+UCr8jQBw88WAxLv2wS2/vV5GJ5R2azDs3xsjm5fwX8AqiMc+oivuriUePrOYngm6TRylhp
        0cD9Evtwg+uRnyk8YkvjNO6gD
X-Received: by 2002:a5d:430f:: with SMTP id h15mr289722wrq.177.1569257506294;
        Mon, 23 Sep 2019 09:51:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyajlkv9A6Ku4HYClKecGn3/36UfGhv+IfcMvF2aTqfZ8o+21QEdB5W3/2BDE+bNBaUn3Nghg==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr289702wrq.177.1569257506049;
        Mon, 23 Sep 2019 09:51:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id n2sm10154924wmc.1.2019.09.23.09.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:51:45 -0700 (PDT)
Subject: Re: [PATCH 02/17] KVM: monolithic: x86: convert the kvm_x86_ops
 methods to external functions
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-3-aarcange@redhat.com>
 <9b188fb8-b930-047f-d1c0-fe27cbe27338@redhat.com>
 <20190923161352.GC18195@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0ffed044-c5e1-4cc9-365a-ae51c4d2b2cb@redhat.com>
Date:   Mon, 23 Sep 2019 18:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923161352.GC18195@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 18:13, Sean Christopherson wrote:
> Alternatively, what if we use macros in the call sites, e.g. keep/require
> vmx_ and svm_ prefixes for all functions, renaming VMX and SVM code as
> needed?  E.g.:
> 
> 
>   #define X86_OP(name) kvm_x86_vendor##_##name
> 
>   int kvm_arch_init(void *opaque)
>   {
> 	if (X86_OP(supported_by_cpu())) {

Please no, the extra parentheses would be a mess to review.

Paolo
