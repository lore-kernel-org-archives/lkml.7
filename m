Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20DCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89E620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WS1IuFsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgAHTok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:44:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30732 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728502AbgAHTok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578512679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiCJJGPdrtAtVlP+spr66I41euYYZbVu6K0JCOT1APU=;
        b=WS1IuFsy8ScdFwNCTaTGYwCOc+dLzBmo55DZt/RbGspJv7UMZLhWL8K2oolpxtmG5tF/iK
        E//FXdYn8CnVYXv7pGTFiDWJzEB0Mo+pQ2Bb2tIRUuXUxlDCdGPNGmbL/Gn7XiQSdgIxYd
        2vK/xNORlBmxvkADofj71z3K2YOqbvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-FywmG7BqMH2SIIvMoxg7xg-1; Wed, 08 Jan 2020 14:44:35 -0500
X-MC-Unique: FywmG7BqMH2SIIvMoxg7xg-1
Received: by mail-wr1-f70.google.com with SMTP id y7so1866551wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiCJJGPdrtAtVlP+spr66I41euYYZbVu6K0JCOT1APU=;
        b=M3116Rd9hccw2OmXzMWgKJRV4F/Se5f+ihMAbvK/xTdC5+aOP+ZrjA8hd3BKduikia
         q97h5/qlSkzt72ZqOHtimnO1xD8foKgkFmXXZt+jRpKmkBdEzOfkVWoezaWqBloe4WuN
         O0Gybf8nB7NFKpJABfwtpmwkgmw6LAK+45dfZwrBpX5j2P1BRSmY4j4U37cteuKyGJAJ
         T/CfPgvlmCdKVW64LxD/srR/zZAi0/G+r0vboqWsL3/5wjRzVF1qZGNYIxXhqdZKG3Vy
         8LkideOdSAi4vgH1Nf5ZDOQryG0mxzw8ObLDGv8iI0ph19Jf2aqg4NHQKyh0IoRtZgvI
         IKnA==
X-Gm-Message-State: APjAAAXs3yClP4hrPMrWIf3PuPbx/m3AsjFRPfAkD7B9/99DnmFOdwr0
        i93Itgp3shyZdHp8JRL064GiEz0VWMcPX9tPxhLL0mZMOWLVuiHrtzI5tRubqglAGI5PB8H/mHP
        CqIjpGz1+wp6Gvhzi5V925flG
X-Received: by 2002:a1c:e108:: with SMTP id y8mr206193wmg.147.1578512674495;
        Wed, 08 Jan 2020 11:44:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbBpucyM3FryruwsnJOFaae2hww/L3q+N0i/YChjVOZBufQZLIjD9QEhcVoO3V1CG6z04xig==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr206177wmg.147.1578512674295;
        Wed, 08 Jan 2020 11:44:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id o4sm5396325wrx.25.2020.01.08.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:44:33 -0800 (PST)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03e0cc7c-f47b-bdfa-8266-c77dc0627096@redhat.com>
Date:   Wed, 8 Jan 2020 20:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108190639.GE7096@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 20:06, Peter Xu wrote:
>> The kvmgt patches were posted, you could just include them in your next
>> series and clean everything up.  You can get them at
>> https://patchwork.kernel.org/cover/11316219/.
> Good to know!
> 
> Maybe I'll simply drop all the redundants in the dirty ring series
> assuming it's there?  Since these patchsets should not overlap with
> each other (so looks more like an ordering constraints for merging).

Just include the patches, we'll make sure to get an ACK from Alex.

Paolo

