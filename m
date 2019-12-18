Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA242C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1172176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAqAO/4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLRWtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:49:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfLRWtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576709351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nf6EXNQmn8TpdxJ/EIE1aLJ/0BdX93FyA2E4p7ENAvw=;
        b=WAqAO/4X2KSQYh8jLBa/4eqdOFXVtLlw+Fn9c9b82AMwvgkiQxg7FX9Cuqv8kiaNzkX8Zo
        5zGLyFf9DWdVvi/94wU+0PmVyzhRC/jrvgjveLnDwK+P+bbpaldVMqw5Id+2EolpM0gjcF
        fNmxUHA7xvLS5S1Yc+8J9Y+jqOAt1OU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-RWqTwNX7OrO2p998oHr8jA-1; Wed, 18 Dec 2019 17:49:10 -0500
X-MC-Unique: RWqTwNX7OrO2p998oHr8jA-1
Received: by mail-qv1-f70.google.com with SMTP id 75so2409871qva.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nf6EXNQmn8TpdxJ/EIE1aLJ/0BdX93FyA2E4p7ENAvw=;
        b=G44dc9y35qNKwgTUBSxAElCK9TW7eD8W4C4i3AA8lD6PQ93z5RX/BrcONfQ5WVWaoR
         PK4KyWw4k6h1odUyoIzST0IWGG0iDxJgpOSfKm8SiqRlGhvhmjMWdmHTtjRH/FQFtauJ
         2hdJyXVcitU1AvtKEpmJ3b1T+3Lly4hiI5mA3E8RgKpo6S9TkR5GnxNfE2TZNN/bhUvN
         3TnAAl22Gx+rZdl/nkwkkb2WZDD7GR3g4YW34d4QY6zQUA7jgr91gKsEBUf/ujIzH/ps
         TAuCxXAjBcqwcB9YlUhbg2WxJwxXiVtSlKXN6XsBSDgl5+pUuqrkjr3Ni45WlBUgLmuY
         nuPA==
X-Gm-Message-State: APjAAAX+S38CPB7xJKZB9uDb8WRZLtpdBMYK4vwGdmIgXjVfalEsDWbd
        ogsh7kZRNmIdKp05ptsmalia7HxtHDVqZOZPOYYwWJfwktIQsWHPWH1Jc0EXk9mjJFrIeYZiwUO
        R8PPq37l9ALTQ/O0X8XvAa07j
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr4909965qkg.489.1576709349681;
        Wed, 18 Dec 2019 14:49:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJYEnTMcc5Qoc+53HJycTqW8W2yptSG0zaEwIAaR+VXvS1NKbEi6l+HjJNYWOy2aB23avJ/Q==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr4909944qkg.489.1576709349446;
        Wed, 18 Dec 2019 14:49:09 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id y7sm1207004qto.82.2019.12.18.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:49:08 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:49:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191218224907.GF26669@xz-x1>
References: <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
 <20191216185454.GG83861@xz-x1>
 <815923d9-2d48-2915-4acb-97eb90996403@redhat.com>
 <20191217162405.GD7258@xz-x1>
 <c01d0732-2172-2573-8251-842e94da4cfc@redhat.com>
 <20191218215857.GE26669@xz-x1>
 <20191218222420.GH25201@linux.intel.com>
 <77b497c8-3939-58d1-166f-6c862d3a8d5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77b497c8-3939-58d1-166f-6c862d3a8d5b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:37:31PM +0100, Paolo Bonzini wrote:
> On 18/12/19 23:24, Sean Christopherson wrote:
> > I've lost track of the problem you're trying to solve, but if you do
> > something like "vcpu_smm=false", explicitly pass an address space ID
> > instead of hardcoding x86 specific SMM crud, e.g.
> > 
> > 	kvm_vcpu_write*(..., as_id=0);
> 
> And the point of having kvm_vcpu_* vs. kvm_write_* was exactly to not
> having to hardcode the address space ID.  If anything you could add a
> __kvm_vcpu_write_* API that takes vcpu+as_id, but really I'd prefer to
> keep kvm_get_running_vcpu() for now and then it can be refactored later.
>  There are already way too many memory r/w APIs...

Yeah actuall that's why I wanted to start working on that just in case
it could help to unify all of them some day (and since we did go a few
steps forward on that when discussing the dirty ring).  But yeah
kvm_get_running_vcpu() for sure works for us already; let's go the
easy way this time.  Thanks,

-- 
Peter Xu

