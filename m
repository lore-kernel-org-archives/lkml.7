Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568FCC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8C120B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfJIKus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIKus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:50:48 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30A12859FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:50:48 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c17so915256wro.18
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bmn/r0BsJ/ckLkCEhbCCOJ9mUA04B3GjpaUyic1itQY=;
        b=M8ANC+WwMGvqbVU7ujzpozTS/YE3PGt6XMsAwOin9idvzgkA5ATaK5k+8aoHa10prH
         mugySxZEtOt33LFJUal/sSvgEVOw4ASbY7H03pBhaC1MtLsKmU0AHiaa3ACOV2k6Yy7d
         xKN3EIfooIqpkYiSmLVTpynmKQxkFwoliEsHmN4x0mq4G4dhMrMQsnsXyzYM/AYVAkS+
         2O1EALH7plf1ejhaqub/DY7vaPgkdG68aSOXee1Ltd6GibZMEdMdMLNqVXEOgObWvCxg
         kkvsC+NJ/DQQPcWMlB2Oqi3pFABCXK3tW8ui+p1jcKI9MzwydcBeWmqNNVFZwsKSNF6G
         KSVA==
X-Gm-Message-State: APjAAAV1wOt7M6X+5P++K3BwKLvFWszDWciwEVjTuTt2RNN3EHZPgc8J
        yM3x9bcKbjx5OAqBu3gAFYQCGrgzwXoWRdA4+9tU9Ec2wxeCbUIiLJRcFcKu4Ifi9JxbUkXIVBk
        wcOLPHpcMDYPYOmkpQhEfpjHS
X-Received: by 2002:a1c:990a:: with SMTP id b10mr2059256wme.39.1570618246852;
        Wed, 09 Oct 2019 03:50:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhBZEvSW0EUo/Gi5mU/wgwGG9A2c5aEjG6Esfy9ahvDY3vtdaKuBgF6plJ2JQLOMY1Q38/Fg==
X-Received: by 2002:a1c:990a:: with SMTP id b10mr2059238wme.39.1570618246602;
        Wed, 09 Oct 2019 03:50:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527? ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
        by smtp.gmail.com with ESMTPSA id n1sm2469406wrg.67.2019.10.09.03.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:50:46 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] KVM: x86: Add WARNs to detect out-of-bounds
 register indices
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-6-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9e4570a4-1da1-1109-32d3-1fba25de1963@redhat.com>
Date:   Wed, 9 Oct 2019 12:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927214523.3376-6-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/19 23:45, Sean Christopherson wrote:
> Open code the RIP and RSP accessors so as to avoid pointless overhead of
> WARN_ON_ONCE().

Is there actually an overhead here?  It is effectively WARN_ON_ONCE(0)
which should be compiled out just fine.

Paolo
