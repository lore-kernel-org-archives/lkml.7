Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B02ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011DE20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfJOQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbfJOQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:45:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1058D2CE955
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 16:36:16 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o8so8908350wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SU2iYxBpciwSkgWiOL6iZkMAxSRBo4v5NF0FEchK38=;
        b=Q/+fk9bK0bushYjNLqjEXk26G9RovYAYyPgT0i+Wskuq9l4TEQepYhkggV5uLqUvFu
         +HeBj4769krhjs2FG9D8kWREr/7kNParbCM0/DeC7Z48GPtMQtvTvgR7w4n+Q2eumqlz
         26McIZCnP/BaMmM0nvnFkY9/ShW9MOngXG68viPAKnvCB2VDGB7VM63dGDSIPjnnVJV6
         6HOE0EYmIuL7w0ZMbgy/QN7UqzMJ6zo+hZqCovqPSB0qn6C7dC3How6u6S7lr5NZ+lDH
         aBuQiE1sQTZPb4rTfO80/JR6JRZeI5xlYkNZOrufxsB4LG/ekRMksFRs0iZyixVHX4f8
         d6NA==
X-Gm-Message-State: APjAAAUT5LwSfjeCdhq5dbD36qWU0youd8znfvcnrIFS3BnzI9DbL9fc
        TWIqiuGv4+zQVf3bYFp3ls4eYCwc/fJs+T+Tg64HUI1VYGaFIiRsEscyRnJPSPAf0CbdZmo+mbY
        cSirMHmLUEymOb/B/OtaRx7/e
X-Received: by 2002:a1c:e086:: with SMTP id x128mr19487201wmg.139.1571157374398;
        Tue, 15 Oct 2019 09:36:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzIfVMIbG+6mpdFJ1PD9Fm1XVFu7mH9sLaGR+C1rC7u9raqVC9mEMICjHeKjSaYaX9uuQ3HNA==
X-Received: by 2002:a1c:e086:: with SMTP id x128mr19487181wmg.139.1571157374101;
        Tue, 15 Oct 2019 09:36:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id a4sm19159768wmm.10.2019.10.15.09.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:36:13 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
 <20191014183723.GE22962@linux.intel.com>
 <87v9sq46vz.fsf@vitty.brq.redhat.com>
 <97255084-7b10-73a5-bfb4-fdc1d5cc0f6e@redhat.com>
 <87lftm3wja.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f00edd02-7d25-54f4-0972-c702e8254016@redhat.com>
Date:   Tue, 15 Oct 2019 18:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lftm3wja.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 16:36, Vitaly Kuznetsov wrote:
>> On 15/10/19 12:53, Vitaly Kuznetsov wrote:
>>> A very theoretical question: why do we have 'struct vcpu' embedded in
>>> vcpu_vmx/vcpu_svm and not the other way around (e.g. in a union)? That
>>> would've allowed us to allocate memory in common code and then fill in
>>> vendor-specific details in .create_vcpu().
>> Probably "because it's always been like that" is the most accurate answer.
>>
> OK, so let me make my question a bit less theoretical: would you be in
> favor of changing the status quo? :-)

Not really, it would be a lot of churn for debatable benefit.

Paolo
