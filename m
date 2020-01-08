Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD21620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQebebDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAHRlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:41:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49089 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727537AbgAHRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578505272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sTGKEIISyGluaZPtnr2/ulkq7UdSDvBR5TeoAxjPMQ=;
        b=BQebebDVBR/v1BThfwz7eNBJEU+3p19eqUb2fRuA/jFae/YY7O1P8QB8lEGxGOX6jKHAni
        osk1mZRp4Kxap59x3xTieGFnhOJE+eeFqQxEC9nraonSgek/SzlY+AFa+BufXc5nIrIg5s
        1QVnRO9gp43ZssQ9GM27PcbDrTj+Hk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-mzPkE4cFN1mr2xOc0jp-iw-1; Wed, 08 Jan 2020 12:41:10 -0500
X-MC-Unique: mzPkE4cFN1mr2xOc0jp-iw-1
Received: by mail-wm1-f69.google.com with SMTP id 18so1105426wmp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0sTGKEIISyGluaZPtnr2/ulkq7UdSDvBR5TeoAxjPMQ=;
        b=EqbreegSDJ7NRy/hJkJaNss+yNto+uuV7BuSfN1tjJals6BS8hlkERzATiY36dExTr
         8IaPB+obZiBWAFG0z5MzfBEzReP60s3xi3wbhN/8wqnZcIL2nPsSnHtS50Al8zxl3XQO
         9qYQMHLDUfLNGPGo4de5KCS/LSrogKsZ7VZq+y1n5y6OWyKE1phiX0gLn4R/bP0FR4mV
         8zuBdho03DnR+xPAOIUKJbcGch+5T9Ho2XtTaBracg8aAr70zmqgy78yE3wX+B+E3hfE
         BIDpJe0+T2gD4QCmg+5ggQuJdWXG2D6N2ZYb1jekjIVPEXOwnwTU8EHVWqQt5Rr/pVVK
         6zdw==
X-Gm-Message-State: APjAAAWyohBl9bhYXfVjqzvkhxxvxzFrSwS68sXC+OCphkvRINf9J2Zb
        EH0uHhPIEDhuYSLevrsKgOYc//xkCY2SNGH15SUCOPk14moB16rYHJ16GDpLO0cY+6k+XPQI/qc
        iaHS8/G6khhk0X23gnmaXp0FR
X-Received: by 2002:adf:e290:: with SMTP id v16mr6250479wri.16.1578505269428;
        Wed, 08 Jan 2020 09:41:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPQtvQ+CfdZxLPT34g2/xZ1MRZci6Z0IM3bcacXC6lg/3LGlEHM0jH40To5MeilhL7Rjg5Fg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr6250452wri.16.1578505269112;
        Wed, 08 Jan 2020 09:41:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id k13sm4808771wrx.59.2020.01.08.09.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:41:08 -0800 (PST)
Subject: Re: [PATCH RESEND v2 08/17] KVM: X86: Implement ring-based dirty
 memory tracking
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-9-peterx@redhat.com> <20200108155210.GA7096@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f7582b1-cfba-d096-2216-c5b06edc6ca9@redhat.com>
Date:   Wed, 8 Jan 2020 18:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108155210.GA7096@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 16:52, Peter Xu wrote:
> here, which is still a bit tricky to makeup the kvmgt issue.
> 
> Now we still have the waitqueue but it'll only be used for
> no-vcpu-context dirtyings, so:
> 
> - For no-vcpu-context: thread could wait in the waitqueue if it makes
>   vcpu0's ring soft-full (note, previously it was hard-full, so here
>   we make it easier to wait so we make sure )
> 
> - For with-vcpu-context: we should never wait, guaranteed by the fact
>   that KVM_RUN will return now if soft-full for that vcpu ring, and
>   above waitqueue will make sure even vcpu0's waitqueue won't be
>   filled up by kvmgt
> 
> Again this is still a workaround for kvmgt and I think it should not
> be needed after the refactoring.  It's just a way to not depend on
> that work so this should work even with current kvmgt.

The kvmgt patches were posted, you could just include them in your next
series and clean everything up.  You can get them at
https://patchwork.kernel.org/cover/11316219/.

Paolo

