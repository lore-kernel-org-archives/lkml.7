Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BBF20880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfGRNaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:30:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51295 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGRNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:30:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so25620918wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZE7qeIo+WhLKExx8RJE14kSmCWYHFTAnkh+UlLH0SC8=;
        b=CX0ytiPbMkBZk2u9RECIIeHIcPFARCnB7oxWVyq0NqXCOpFbcSESwnbpneZnlYVELq
         ZEtx8IFLlyFH8N7NH23MeMY/7OPtm34EAGOGNSaSb2lckC2GnIGybRTx6eCdE7sxBErn
         YWub+Dsg0mZAVL9J3Xz96SGETTc1xBeEB/ZTrIhEVTK1QjmMXWJKLsLnJWxRBBq05+gU
         +r1G2XBb8exoHYPx8ZcjrV6k6oARAFq5zHEgvesekjZUnBM4YztBA8lilcuqkhP4Ikrr
         FobgDU+A6xpJZm6l/GGOl+WZQp2VKYTAVOXPdQgNFwSpmMmDn1g1JySdp4rrndUFSwlh
         yRiQ==
X-Gm-Message-State: APjAAAV0cbTgZWje/MyfHEzyzsWO6dTWXJHd3T6vrjbzM7oda6Jek0jy
        9pU1C4doDCpiOqIPgK93Ni082g==
X-Google-Smtp-Source: APXvYqx3V5p2CKlfwWpWyhN/va1NPlp3PYMM04M8eSKtHjS8zhgid38VQPsLoaAWTYKhki9qOPdqrw==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr42485323wml.84.1563456618835;
        Thu, 18 Jul 2019 06:30:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id k124sm42226579wmk.47.2019.07.18.06.30.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:30:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: Boosting vCPUs that are delivering interrupts
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Marc Zyngier <maz@kernel.org>
References: <1563449947-7749-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c4c23d93-879b-1783-afa5-b6e053f32990@redhat.com>
Date:   Thu, 18 Jul 2019 15:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563449947-7749-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 13:39, Wanpeng Li wrote:
> -	if (kvm_vcpu_wake_up(vcpu))
> +	if (kvm_vcpu_wake_up(vcpu)) {
> +		vcpu->ready = true;
>  		return;
> +	}

Why here and not in kvm_vcpu_wake_up (which would allow further
simplification of s390 code)?

Paolo

Paolo
