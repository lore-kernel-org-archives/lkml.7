Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4650F2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRlCOU9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgAHUGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:06:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAHUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578513972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74hOkbtq8ouxtUc90++pV1soqHOiP2RiIHBC4eJpr5M=;
        b=ZRlCOU9mJe9nPltJQjfZ5P92ZUbU+LrleseOqGqOnjy+Bl/j4yra4F9ECAAquEpe6UbJul
        qV2OrhbwiElPUsy+lCilmgEekkCUmWZhtT+VwZS4lVtcdkrn/4ETuMXzNHsskLkg4N4zUX
        t9UuT2JU0HKQkAsDQTm9Zh+6DE+4q2U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-RDlPUE79NDSKmhlqyCLnTQ-1; Wed, 08 Jan 2020 15:06:10 -0500
X-MC-Unique: RDlPUE79NDSKmhlqyCLnTQ-1
Received: by mail-wm1-f71.google.com with SMTP id 18so70151wmp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=74hOkbtq8ouxtUc90++pV1soqHOiP2RiIHBC4eJpr5M=;
        b=AP2XhFmSgqtewBECB8P8CnmGsNPq7CQlfGEE3mcphaZ62kQAOiYd+qEFhbf7L5N2wa
         eGWP7lw2+vKDT1lYSyZgH1dvN1htaU5fRDtkQJmVQ6agWacz4AL7Q1gXN6XeMv72UHUu
         h01KWsgC6xjLNifIh7hmtQy5G+eWJ/SMf9AHz8AW+EJc65Sn3h/8Msef2EG5Re7AMh/O
         JiW+bF8XtL500LGee7HjERaeIMDq7AnMwMSYWOcLGeRWSQuQI89SVSZP7uUXeh+TTaKc
         SGAIiSkBVD+hH7f+qG3D6kGTpfr0gJte/kOrv/4LSOq0ih38YqquUPTss4MFvSHsfFCl
         dxBw==
X-Gm-Message-State: APjAAAV69/GeGywoUzxm5iQ9K4QOGnzLBoa3pr6HOgUQRw19NsTs7Z/U
        UrkCWGMSXcJN90cDH5LrnHxRVs/Ki61deca5mQxRTN4VgqLb/rQAM7T6HJnWx63EvOWS+9c5Zir
        eq6A0uXyf8ov354AHB8RFmSEx
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr6222581wrw.370.1578513969406;
        Wed, 08 Jan 2020 12:06:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl7RMYaGBDLZSP0rJ2jOO3l1LBIbKtQJORY1x4b2ENg/eMA59bDQeu/JPmKQdNZIqnfOvPUg==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr6222557wrw.370.1578513969170;
        Wed, 08 Jan 2020 12:06:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id z187sm235072wme.16.2020.01.08.12.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:06:08 -0800 (PST)
Subject: Re: [PATCH RESEND v2 08/17] KVM: X86: Implement ring-based dirty
 memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-9-peterx@redhat.com> <20200108155210.GA7096@xz-x1>
 <9f7582b1-cfba-d096-2216-c5b06edc6ca9@redhat.com>
 <20200108190639.GE7096@xz-x1>
 <03e0cc7c-f47b-bdfa-8266-c77dc0627096@redhat.com>
 <20200108195953.GG7096@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81d1c4da-a065-4cd8-ba30-0df30cd40b2d@redhat.com>
Date:   Wed, 8 Jan 2020 21:06:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108195953.GG7096@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 20:59, Peter Xu wrote:
> On Wed, Jan 08, 2020 at 08:44:32PM +0100, Paolo Bonzini wrote:
>> On 08/01/20 20:06, Peter Xu wrote:
>>>> The kvmgt patches were posted, you could just include them in your next
>>>> series and clean everything up.  You can get them at
>>>> https://patchwork.kernel.org/cover/11316219/.
>>> Good to know!
>>>
>>> Maybe I'll simply drop all the redundants in the dirty ring series
>>> assuming it's there?  Since these patchsets should not overlap with
>>> each other (so looks more like an ordering constraints for merging).
>>
>> Just include the patches, we'll make sure to get an ACK from Alex.
> 
> Sure.  I can even wait for some more days until that consolidates
> (just in case we need to change back and forth for this series).

Don't worry, I'll keep track of that.

Paolo

