Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53A32067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYz/wu9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgAIUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:42:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24963 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727876AbgAIUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578602566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdAv7lKgnlnMnq5dqOLheLY3zrBzh9h1Kyp8yaJhNcU=;
        b=BYz/wu9Vp8W7mt5CVgyMn0jYiC7Hg1iSI+Id2Pv06K2t1OyqKUxWB05X0JaplQDaVqoynJ
        O37VT8RSfvFPmLCk/9cynjaPlIgAZI++0QErnnfeODJDXEQe86CiRfCNRZP3OHwCB91jl9
        o7DXRO1gACYHt5LaV0g7F/RP+Yt6VAk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-cHSWtndwNmGiP8Hi8h1OUg-1; Thu, 09 Jan 2020 15:42:45 -0500
X-MC-Unique: cHSWtndwNmGiP8Hi8h1OUg-1
Received: by mail-wr1-f70.google.com with SMTP id u18so3328324wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdAv7lKgnlnMnq5dqOLheLY3zrBzh9h1Kyp8yaJhNcU=;
        b=tFWCa3XWsN8ZRnRwOAQpSX92PJCq/u5P2QN35nkJ12wX1l3qIWg/JlMqtNu6Tmk/XW
         y6IDcub1x0u51MLGvHXKZMFhtLjp9U8RLXtIXUZ5sK6WcC5a7FRTlaRiUv3cgFN5F9QI
         LMFQv/MpJC6xlqAtfM0CjFIU1HqNVqsks7D6NTFDDVES9U94GjE1AN9TK0pr+D9QdaEI
         EuOvd+kjOBTc2V2QZhHgqkFvhOc7xX/LxcB/Zs1GfjoMwXbdzBjGbVe9gmVGlPRYkA7h
         R9oqPX2ZIzBKOIevWsqYAY/oa2R5GRYvbJVntIrMLI1pDMTsOxLmmNKHV/prfBo9lgoV
         F53w==
X-Gm-Message-State: APjAAAUOYGuST/J1ULCCxUaT/QeesUXzz5n2qLu6aG3MOfVLl1Z6HirV
        RodfJpVcMxC2jYv5DEJBh5Dufdsyx7YJVXm1rH/0Szqp7LEn6zh/ZKndAQC6cPnVQiI4u4RelWD
        SHsQcasDwYZ2ufGKERMfhs4nT
X-Received: by 2002:a7b:c246:: with SMTP id b6mr6741143wmj.75.1578602564088;
        Thu, 09 Jan 2020 12:42:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1t6zfqCwAvmxF4OHqO9fEvSUg0HmaguZItEhVTs8HnJAmnsgGasy5nJRLYI1VkcpABnjpog==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr6741120wmj.75.1578602563882;
        Thu, 09 Jan 2020 12:42:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bc4e:7fe8:2916:6a59? ([2001:b07:6468:f312:bc4e:7fe8:2916:6a59])
        by smtp.gmail.com with ESMTPSA id 18sm3931764wmf.1.2020.01.09.12.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 12:42:43 -0800 (PST)
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
 <20200109161742.GC15671@xz-x1>
 <20200109113001-mutt-send-email-mst@kernel.org>
 <20200109170849.GB36997@xz-x1>
 <20200109133434-mutt-send-email-mst@kernel.org>
 <20200109193949.GG36997@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <583d04b4-73d2-0ba7-fda6-10e15071a3c4@redhat.com>
Date:   Thu, 9 Jan 2020 21:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109193949.GG36997@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 20:39, Peter Xu wrote:
>>
>> IIUC at the moment KVM never uses huge pages if any part of the huge page is
>> tracked.
>
> To be more precise - I think it's per-memslot.  Say, if the memslot is
> dirty tracked, then no huge page on the host on that memslot (even if
> guest used huge page over that).
> 
>> But if all parts of the page are written to then huge page
>> is used.
>
> I'm not sure of this... I think it's still in 4K granularity.

Right.  Dirty tracking always uses 4K page size.

Paolo

