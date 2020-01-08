Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00CEC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A5B20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTU5hPeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgAHVCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:02:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgAHVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578517359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGgN9vS1pt4ksqqsIyVSootRX5TIRrFfQTFcrvkrQVM=;
        b=HTU5hPeFgszoB+L2kGdW5/ygjKI8DCMhDCjcGi+NjArzuYFjRFmv5ZXFskE6wxRZfhwWWh
        W2p2pSxjoAPYc3qVuRfKZieOp9uIpzLn8H+f0XmjMzOZL78+eQkXCvNX57QDiEewYMIr6y
        4esMe+aobpnoCONbYN1ZyfBbOKUvuFo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-FCZbMn3DNhGACsAyrb0bZw-1; Wed, 08 Jan 2020 16:02:36 -0500
X-MC-Unique: FCZbMn3DNhGACsAyrb0bZw-1
Received: by mail-qt1-f200.google.com with SMTP id l56so2843350qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 13:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nGgN9vS1pt4ksqqsIyVSootRX5TIRrFfQTFcrvkrQVM=;
        b=araatGU+wMZl3yu4vBLMVSVu9AKr5BMBvMqtI+Qq7aKJIQ4ZMxZ69dASEbKlY80IRf
         Ii82lcLR8QOSbm7gdxOqa7perVJM3nvjqPAU9qaAjmevrtEKyRGuaO2SHeM9mgWHBBdP
         Z7igJuNX6pRb4uZzC3BtT3XmadejUc4yuThmMRuFpsQA0T1SfC+xdN6cu6HZW2I8j0K6
         p4e+GUKEWJ+AIiY8KwF+JBW1p7zFsP3dklgetGz+KWZHuGYcy22BKLWqEPlvtOKZbOFZ
         MqmsNmhok8CjIMvMbBtKExr8Z9lgVbbOM5xUn8n8kqqsT7xLy80gMBb4eBu0IlrnylEA
         c0PQ==
X-Gm-Message-State: APjAAAXMq9L9L/CJkG/S/DFv1h9QJ6PuO6JO6EnjgIpaVbcgEMeq+PSt
        B7qcKyWdi1XaYER8bftYYr+7PTQ4S4BD2siypUb0oWaxqaTyI2zKXPFM3LtTmPw/ibbrf92A9Nl
        oJ4JVYnTPB262UDcA5EdQErMq
X-Received: by 2002:a05:620a:2010:: with SMTP id c16mr6009752qka.386.1578517355931;
        Wed, 08 Jan 2020 13:02:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYrsmBQhSUcSU8OxBGrkXOCI6I2eG4Uc4kbWRdqrSrtUE4hSkuhX6El/2K5pmjXdYiJ3dxqA==
X-Received: by 2002:a05:620a:2010:: with SMTP id c16mr6009735qka.386.1578517355755;
        Wed, 08 Jan 2020 13:02:35 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id u24sm1942858qkm.40.2020.01.08.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:02:34 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:02:33 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RESEND v2 03/17] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200108210233.GI7096@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-4-peterx@redhat.com>
 <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
 <20191223172737.GA81196@xz-x1>
 <851bd9ed-3ff3-6aef-725c-b586d819211c@redhat.com>
 <20191223201024.GB90172@xz-x1>
 <e56d4157-1a0a-3f45-0e02-ac7c10fccf96@redhat.com>
 <20200108191512.GF7096@xz-x1>
 <649c77ba-94a7-d0bf-69e7-fa0276f536d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <649c77ba-94a7-d0bf-69e7-fa0276f536d1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:44:09PM +0100, Paolo Bonzini wrote:
> Yeah, it should be okay assuming you test with lockdep.

I didn't turn it on for this work, but I'll make sure to be with it
starting from now.  Thanks,

-- 
Peter Xu

