Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9652CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CD620659
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfJUNJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfJUNJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:09:35 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1DC734CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:09:34 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i10so7274954wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5TfDqwP3GoBFi7aXPlCU/8+7pDpDx0r2JS4CfEtHxg=;
        b=Cgz3VonP4w0YceiCXjj7+KK6s2qz42xUkgPGRD+kGQRJaoRRQ0IsF44Ld2l0e9btDP
         +KyRSSrNaMdZ+macJDYXQWyXqMT9i+tukNG82MSpkGJ9Na/+f335hTWRLkRzOhKEOZUd
         V4Aa78w6d1oEjtpYuRVfH89hYkOFdZrIBJBvzGHW/5rnUa2sQCi4j+u0eg/G4rSylCWs
         Go5MOz4Z5bE5im4PUxgM+LRhN6vpVfwEXKLhnH+6ajW98Nf0gBp/vdJWWWAWZ9KUJhle
         DCqjptYqqC9za72WCelU39cD7oZazXucLXOH6eOt6TPXGSJAkVW+DGCpekwqJrnWaOEL
         KX+g==
X-Gm-Message-State: APjAAAXhtb+3Yo6KDWYrvLIuKAJojSGCMxXQBEDyQPEG2ZNIDLBW5e2n
        yMCrcKQrvs6o8KUGNGJTtp7OALhQD9Op5VnbDjHwOQJJ5IGfIYy1YZAaBJsWEoG/KxLITgzrCr/
        WEui11I3aXpqk5JSYPLH/JHlb
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr6879879wmk.24.1571663373340;
        Mon, 21 Oct 2019 06:09:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdfuBdeAwNUF9K0Edxm6DaLP4wj3yivSMIHRIOq6f468UL6EjyTuW5I6laVCpJfdImZK6ycw==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr6879867wmk.24.1571663373087;
        Mon, 21 Oct 2019 06:09:33 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g5sm12740898wmg.12.2019.10.21.06.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:09:32 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
 <d14d22e2-d74c-ed73-b5bb-3ed5eb087deb@redhat.com>
 <6cc430c1-5729-c2d3-df11-3bf1ec1272f8@intel.com>
 <245dcfe2-d167-fdec-a371-506352d3c684@redhat.com>
 <11318bab-a377-bb8c-b881-76331c92f11e@intel.com>
 <10300339-e4cb-57b0-ac2f-474604551df0@redhat.com>
 <20191017160508.GA20903@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c2e40175-4d17-f2c5-4d92-94cedd5ff49c@redhat.com>
Date:   Mon, 21 Oct 2019 15:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017160508.GA20903@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/19 18:05, Sean Christopherson wrote:
> On Wed, Oct 16, 2019 at 11:41:05AM +0200, Paolo Bonzini wrote:
>> On 16/10/19 09:48, Xiaoyao Li wrote:
>>> BTW, could you have a look at the series I sent yesterday to refactor
>>> the vcpu creation flow, which is inspired partly by this issue. Any
>>> comment and suggestion is welcomed since I don't want to waste time on
>>> wrong direction.
>>
>> Yes, that's the series from which I'll take your patch.
> 
> Can you hold off on taking that patch?  I'm pretty sure we can do more
> cleanup in that area, with less code.
> 

Should I hold off on the whole "Refactor vcpu creation flow of x86 arch"
series then?

Paolo
