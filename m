Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F04C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BD721D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5c1xZPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLQQtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:49:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26633 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfLQQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576601343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inntMxAK2pexTlpzWJhiTSeRZ9YPjzrPzvHQ9NYkXSU=;
        b=F5c1xZPt3y7KLOJ6TNWgCSCxZpOYBulxjg34Tj2oWTaRB1uOJbQKfxeIzuTEiHyg7k6bZE
        qMhLhSz8/YwdD6qiGlyDj4huMJZI069MLPcaeWef8HOS/OOuDJKh7s9n5OyMDHQlf+EbLi
        +LBkc23yFMJYiqVAbcFpJ5axVwcqLKw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-k1Bh073CML2C0qceuj5lNg-1; Tue, 17 Dec 2019 11:49:00 -0500
X-MC-Unique: k1Bh073CML2C0qceuj5lNg-1
Received: by mail-wr1-f69.google.com with SMTP id u12so3891252wrt.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 08:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inntMxAK2pexTlpzWJhiTSeRZ9YPjzrPzvHQ9NYkXSU=;
        b=JUHGHodGZzFXP2YgEuJMVpkLVoOPwoupyxg017ezYOx+032kv3ySL9Kxn8G0uNK9Ni
         +dIM0uV6kGO8bP+PghyoMcfVX8Bwq4Od94J8ktWwTZ2z4He9IvpfRVngKipMdsFmK0km
         XGKXRm0u0B4PKj4bLoy6obaL4vPfR83SLafBKvkhbCv5V4smDXnTQ9299+IRRoMEvyKy
         FWYVHsruxC9Umn4htNQtO7LXRTFJEkmPGn2pUF1gf7aFqxaRfbLJZE8g65NEMH5eOpRU
         07UTcYn1IBzkLkxNKFq4c8cSHrBJ+FXsHL6dRA1gwbwCf9160yV+ETTgp1Vndh0B9BIp
         G/5Q==
X-Gm-Message-State: APjAAAVnt8BlJThvgNd6HrBdp/kumbDi44g2UaBAXGef7iOpiMpTtlEe
        Lg3JbU9ZVSFZ649RwW9MZAwMkpGtG8DngjPoXu0K7ZPHT8n1swc/CnHjdtGHcT4M5Lra7OQEOgL
        ixMqhb6mpVAp8cM2XhOORqm97
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr6106784wmb.17.1576601339222;
        Tue, 17 Dec 2019 08:48:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqx76pZ2UcGbn63XX4R4mlXgxOp67LblWwPXb/NG1+fS2tu+dMszUBFiT4MoSrPMR5Uz8a85tQ==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr6106762wmb.17.1576601338997;
        Tue, 17 Dec 2019 08:48:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a? ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
        by smtp.gmail.com with ESMTPSA id f1sm26022621wro.85.2019.12.17.08.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:48:58 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com> <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <E167A793-B42A-422D-8D46-B992CB6EBE69@redhat.com>
 <d59ac0eb-e65a-a46f-886e-6df80a2b142f@redhat.com>
 <20191217153837.GC7258@xz-x1>
 <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
 <20191217164244.GE7258@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6d00ced-64ff-34af-99dd-abbcbac67836@redhat.com>
Date:   Tue, 17 Dec 2019 17:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217164244.GE7258@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 17:42, Peter Xu wrote:
> 
> However I just noticed something... Note that we still didn't read
> into non-x86 archs, I think it's the same question as when I asked
> whether we can unify the kvm[_vcpu]_write() interfaces and you'd like
> me to read the non-x86 archs - I think it's time I read them, because
> it's still possible that non-x86 archs will still need the per-vm
> ring... then that could be another problem if we want to at last
> spread the dirty ring idea outside of x86.

We can take a look, but I think based on x86 experience it's okay if we
restrict dirty ring to arches that do no VM-wide accesses.

Paolo

