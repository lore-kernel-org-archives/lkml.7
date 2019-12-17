Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF787C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF39421D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAwPlPFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfLQQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:30:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbfLQQas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576600247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ap670LPy12Q7/8a16LjycNst+xdpGA3dsChug73d5nU=;
        b=RAwPlPFVOFnCvlvS29sQNfIV3r1O+u4sauDHlvec7aMbtr4io6zClXnE3YBrOg30s48T4U
        FpmIpE3TvCAi/xB+WGtuRxxw9Dec9oMdbH4W7MwfLekfIgBv7R39ITh21IZxDXRbi/jQY5
        MIZMabOCLrkBCGgc0frL+XljcdwlFRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-2MTth8rMOfeqzg_XIzMnCA-1; Tue, 17 Dec 2019 11:30:46 -0500
X-MC-Unique: 2MTth8rMOfeqzg_XIzMnCA-1
Received: by mail-wr1-f69.google.com with SMTP id h30so5565392wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 08:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ap670LPy12Q7/8a16LjycNst+xdpGA3dsChug73d5nU=;
        b=BYJ9jpbvgP+MB3B7UYfOn2RsdPcfA/tkNXpjIGtSZiBHnNv6j47Pv8QKXQ5BQY4mhi
         THqFmJ2rANNVUtiHHWv+U3d7cKtyN3Wr2pFNqdmhe3W2FIXAo8LRuRwIf+tGpkMM0BEW
         FZ9LVlRA6htxEgQmwLzUpfPll0Ytnu+kv2MVNzxfxnG3TPj6w+Y7Fovuau+RkN4mXLYq
         4IoyVmeuCGD+SwE5CPw6CuzczY/NsyeMTyvivCkuePeeqX5s4AvCM9ijsDDeKNYKje9e
         USe8G9IqMW8XX2Xo5NquXGU87eZXhTqcuUsrCS6TYvyhnLSVIJYBachLLrfmMJcSO+yw
         SrhA==
X-Gm-Message-State: APjAAAXXM2iLCHlD7NBe791hIhPzfY+ulUFBv1k1crQXa6gOg1lZ1JHH
        Sn3uqxuQXTo0mACm9i8eFZVAMHG/GAYIuhLEpWlQ9wcC0zagW3rBDt4x0xus8xlHrKSFEsfdhFV
        QgJaf6YNT4DypNtH33Ec5RujQ
X-Received: by 2002:a1c:18e:: with SMTP id 136mr6629643wmb.53.1576600245051;
        Tue, 17 Dec 2019 08:30:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqympyH0YgvfHQF/+r2TKl3XLNPcDWYbY9gSaina8WVxwgLNBW8wAR3QILILNbDyVG9ju439Kg==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr6629615wmb.53.1576600244834;
        Tue, 17 Dec 2019 08:30:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a? ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
        by smtp.gmail.com with ESMTPSA id s128sm3518280wme.39.2019.12.17.08.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:30:44 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Peter Xu <peterx@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20191202201036.GJ4063@linux.intel.com>
 <20191202211640.GF31681@xz-x1> <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D645E55@SHSMSX104.ccr.corp.intel.com>
 <20191217091837.744982d3@x1.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10cc6fc6-c837-1a1a-a344-df97793b5ff5@redhat.com>
Date:   Tue, 17 Dec 2019 17:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217091837.744982d3@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 17:18, Alex Williamson wrote:
>>
>> Alex, if you are OK we'll work on such interface and move kvmgt to use it.
>> After it's accepted, we can also mark pages dirty through this new interface
>> in Kirti's dirty page tracking series.
> I'm not sure what you're asking for, is it an interface for the host
> CPU to read/write the memory backing of a mapped IOVA range without
> pinning pages?  That seems like something like that would make sense for
> an emulation model where a page does not need to be pinned for physical
> DMA.  If you're asking more for an interface that understands the
> userspace driver is a VM (ie. implied using a _guest postfix on the
> function name) and knows about GPA mappings beyond the windows directly
> mapped for device access, I'd not look fondly on such a request.

No, it would definitely be the former, using IOVAs to access guest
memory---kvmgt is currently doing the latter by calling into KVM, and
I'm not really fond of that either.

Paolo

