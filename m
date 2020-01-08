Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38634C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0042220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjWCO7+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgAHT77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:59:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726411AbgAHT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578513597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lrH+CvY+umiABT8oEZ0qBtd1gDpx5+wmHlz5SzS8p+g=;
        b=BjWCO7+GsLPfyuBp5F8R1bFOYwX2xyDJTsOtfDRYIdNy8yMguZKcgZEO1KnWAbk/LiiRP4
        k23G0TstLK7i9aDIu5RBHXdHpaGMAuiOdOAEvA1BwnRoHJEqXbz9KCQQPkqB5s5YQTjOa6
        WJFE/EExQDbdJn3S3KzOIM0PFKRkfTs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-0lDi6OdQPdGYyIIrHxvnCg-1; Wed, 08 Jan 2020 14:59:56 -0500
X-MC-Unique: 0lDi6OdQPdGYyIIrHxvnCg-1
Received: by mail-qk1-f197.google.com with SMTP id f22so2633376qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lrH+CvY+umiABT8oEZ0qBtd1gDpx5+wmHlz5SzS8p+g=;
        b=NYEojioDBfTD9JFbIkM08RHqTElmsgEmAK/wrmPtMeB2A7ZtQq21IxwON6mcGpbRBe
         d+mfzRWhjkQUI7aJzE1/s8rY5XtZm10AAnH6E++MVAnvgPCXo7psLcgkOwBj5HOOHlVQ
         qq3+v/swvL8yC8I5HV6PY77PYlR59j4ycgEcbPuJ1Rd/jWStgKJ8Of+1mGaNZQDx2mf1
         COnd1XNVA6u51B4vPMseEnDMQaVhd50dTDo0tRZXWGRVLpAd7m8vvp116cNcmayGV97f
         vxgFyI2uTdbD8TfV2eVaqcwNa/ap7y9DjgenesdiAOioFTCh7WeAEQhgJAweE8PbGM6C
         r4ng==
X-Gm-Message-State: APjAAAW32hHzWLQzJ8jTC+wD8NC9NYhRXiyoS5O7nISy+UjCQ52c10+O
        tbGxzU285gIskKvGcoqh975GwqrywNtiAudUIvvR6Jhu9+keJJEY5Q/vP7xz9Mzbud5/tGMjOxe
        JQXyRdqboMWqu/CrVKcEVW3zn
X-Received: by 2002:ac8:4513:: with SMTP id q19mr5046110qtn.253.1578513595782;
        Wed, 08 Jan 2020 11:59:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqydEHy1yoL7GzWNo5dB4mqtpMIXjcNPaxhKor9S4La4aC0MoUtLA3yz1z9FpFnruD55s/uIjA==
X-Received: by 2002:ac8:4513:: with SMTP id q19mr5046098qtn.253.1578513595594;
        Wed, 08 Jan 2020 11:59:55 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id r44sm2206424qta.26.2020.01.08.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:59:54 -0800 (PST)
Date:   Wed, 8 Jan 2020 14:59:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH RESEND v2 08/17] KVM: X86: Implement ring-based dirty
 memory tracking
Message-ID: <20200108195953.GG7096@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-9-peterx@redhat.com>
 <20200108155210.GA7096@xz-x1>
 <9f7582b1-cfba-d096-2216-c5b06edc6ca9@redhat.com>
 <20200108190639.GE7096@xz-x1>
 <03e0cc7c-f47b-bdfa-8266-c77dc0627096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03e0cc7c-f47b-bdfa-8266-c77dc0627096@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:44:32PM +0100, Paolo Bonzini wrote:
> On 08/01/20 20:06, Peter Xu wrote:
> >> The kvmgt patches were posted, you could just include them in your next
> >> series and clean everything up.  You can get them at
> >> https://patchwork.kernel.org/cover/11316219/.
> > Good to know!
> > 
> > Maybe I'll simply drop all the redundants in the dirty ring series
> > assuming it's there?  Since these patchsets should not overlap with
> > each other (so looks more like an ordering constraints for merging).
> 
> Just include the patches, we'll make sure to get an ACK from Alex.

Sure.  I can even wait for some more days until that consolidates
(just in case we need to change back and forth for this series).

-- 
Peter Xu

