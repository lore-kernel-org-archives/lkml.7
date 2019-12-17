Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE5421582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNeTp5Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfLQQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:31:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbfLQQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576600312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4Hn2/T4wztJ+c4sVZ6jA7HB4xZQZPe/kIKj1uFgRVk=;
        b=hNeTp5GkdBEOR7hIwvl+ypDHOC1HcZ99wV69r7OSBGcpKnLoy79v+NfGAdvv8uk6bTs+sI
        rMlD0eSaUKrC31oLqUyAp+iBAsSirS0XlPSNgX4bzsxqh0U6uCoyWoWc2PNJbBHX+eWZvH
        pxrRYBk2toAk4RHLPCTFvY2U+fiuBfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-yI00vp-CPyO38eBUCfzmug-1; Tue, 17 Dec 2019 11:31:51 -0500
X-MC-Unique: yI00vp-CPyO38eBUCfzmug-1
Received: by mail-wr1-f72.google.com with SMTP id d8so4906976wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 08:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4Hn2/T4wztJ+c4sVZ6jA7HB4xZQZPe/kIKj1uFgRVk=;
        b=YKcBG5M0LltC0Y0cw0TsBimrf/1MHTamcr82KLkYkmW0DPXfogqxsm0Q0RMiV8KXuL
         PDU68VBHwsIP0y9HI+/H16gjUZOsaM9exh4khmELhjDe6VoVMAxKU8oPzVMRbygmvYnF
         fgomkDgCGbFvGNs3JSFhHwgVzPbk/3+KgA49npzytgY3cRcCMxf4jGYL6fFXMucPpTDI
         8iMW9PbW4IqB9Rs10+oUN0LLx03B4MRLJhb6uo7YLNeLA7XO3OdW4KGn+711SCy++oTN
         31q9Cxg7Z3iwUwbkHAKDT1MbBCImXsjdJDPwscpvJ6bQHZBSlABVHG+zJl6kKPD0o5FR
         /54w==
X-Gm-Message-State: APjAAAWswfdgoreplxIODALvvyhFUhzxJtAVTMIBeAsi9i6d3SrmaIx0
        QXEg+TF8+HuhdwoZW6/e61Xrk9u9vpGu1txVCFAERv6opeTUxjasBK/+7BzwW1LqHvVRCvFr76W
        F1U7RoewCYu4g/rc08I5Bxllk
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr6245436wmj.57.1576600309957;
        Tue, 17 Dec 2019 08:31:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyC2rukHVDQgKq/ZtQIpGm8enAFSLAsGkp7zQE3V9/knw3xd0UFSkx6c2y3sZBvaw/ULjXKEw==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr6245415wmj.57.1576600309736;
        Tue, 17 Dec 2019 08:31:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a? ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
        by smtp.gmail.com with ESMTPSA id h2sm27209915wrt.45.2019.12.17.08.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:31:49 -0800 (PST)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
Date:   Tue, 17 Dec 2019 17:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217153837.GC7258@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 16:38, Peter Xu wrote:
> There's still time to persuade me to going back to it. :)
> 
> (Though, yes I still like current solution... if we can get rid of the
>  only kvmgt ugliness, we can even throw away the per-vm ring with its
>  "extra" 4k page.  Then I suppose it'll be even harder to persuade me :)

Actually that's what convinced me in the first place, so let's
absolutely get rid of both the per-VM ring and the union.  Kevin and
Alex have answered and everybody seems to agree.

Paolo

