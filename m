Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137B7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ3NXwRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfLPPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:49:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728423AbfLPPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576511352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FUEPuE3lmiTROt831qEr7XPbzQitQcYsLEoUTolKxh8=;
        b=HJ3NXwRAbWI+6zNGah01BEcABfkEvd79YFQP21WEpPNZk7w4VSnBQGnRHlUiWzhZomKG/l
        ZuN4svGdVQZGxqYBwt8o+rbHEhgzgCHtn2/j3SR/aqL1m6H3D003nwi9WrO2XIN6pqWxH1
        uxEoFEiee9liPAtehSFBzsPXToXgF4k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-ML3euJG2M5SI6h-Qh5s9GQ-1; Mon, 16 Dec 2019 10:49:11 -0500
X-MC-Unique: ML3euJG2M5SI6h-Qh5s9GQ-1
Received: by mail-qt1-f198.google.com with SMTP id o18so4853496qtt.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUEPuE3lmiTROt831qEr7XPbzQitQcYsLEoUTolKxh8=;
        b=hf0lnGIveRoh4x5LFy7LdQ3bD89p5fZV6nA3ntJh1NnyYUwvEsa8jX2W0b3qSm+fnl
         k1FyJIvf+CznYcBORSJRN2JbWxsY7FJnZOuJY/wSGkbW5YE44upY5u8ExKIuNfcQzPcT
         /KRlhEEz5rhMsXEpcogcbXZUHMkQbJ9XxkIN4NmGXPaRyMpndVRqLzxF6xq+l1qHG1T4
         LO3GPdyNx9QwNYQzduBbLBFUqoY4J6K/KA+vxjpXG9QoB3GhrMABH18gzXw9gAU/W63i
         s2p0UkTlQoFkJuOKvTf+1Dm5UHLDpFBEtAu5aFhzRBEupXS7u6ADRphm419b/fsNK+zo
         tO/g==
X-Gm-Message-State: APjAAAU99ZYofnWEvM2JHqSRdJnWqSybHGgwhxM8VXVAHSjJsgzuCHS6
        cPRYDN4619w7fYO49AN+ZKe/wXAeZOfx+ouJBZFHZfenlBTKjehaCq2vi2zZRf1tXvw7cSjpOAb
        v9ihNX7FHwA1Q0VKdhzfFr+Nj
X-Received: by 2002:aed:376a:: with SMTP id i97mr24765828qtb.44.1576511036535;
        Mon, 16 Dec 2019 07:43:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNO+M+uMPH2PC7v8tiGPqdgQ481MGIvuyPN8mLjwyvKqfzFBQlyb23FzKFU9qaIy6pSbyfug==
X-Received: by 2002:aed:376a:: with SMTP id i97mr24765811qtb.44.1576511036310;
        Mon, 16 Dec 2019 07:43:56 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id f42sm7002645qta.0.2019.12.16.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:43:55 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:43:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216154356.GE83861@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <20191214162644.GK16429@xz-x1>
 <0f084179-2a5d-e8d9-5870-3cc428105596@redhat.com>
 <20191216152647.GD83861@xz-x1>
 <fa25d729-a2fb-85af-a968-1dedc754a55d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa25d729-a2fb-85af-a968-1dedc754a55d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 04:31:50PM +0100, Paolo Bonzini wrote:
> No u64, please.  u32 I can agree with, 16-bit *should* be enough but it
> is a bit tight, so let's make it 32-bit if we drop the union idea.

Sure.

-- 
Peter Xu

