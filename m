Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F438218BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfHSSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfHSSdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:33:20 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE7FAC009DCD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 18:33:19 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f9so5661334wrq.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8jHC20YAO7i3dX79rngQOnV9bwJPBl1SY2fxabeqEHk=;
        b=CquUoPmOpp6t0BTZVktih1oFiu4qLE4Flkir/BJbYIDR4GBuNDYRzLRxvxLwRHolIS
         beLpg803L2wCHv65YXR2WhAxIWgZnN1P1IWaQFf98h+e3mYn2QliHUvJu3+4PscQp/mt
         KpjdpBhuiqJZ3a4232RgO2aJpKLeeD3eJyZevw1rledbznAbww8A+dIZR7Nda7FzMezM
         v5Y+E3G/qddQ+bbbl6OZL7BpAcWFy0KZSm7hEc0rq2NyORDSQnQDAXFLjNtFm9ZRL9Pr
         DR7LNqaVpM8/3ttN8E9sfLbAwUT46ER3UW1BcYlTR6gFAbtXs8mc3I638z5NiZ+SidOO
         fEnA==
X-Gm-Message-State: APjAAAUVREYl9mHnDc1zKsP3y1CT6HYuMUnDifkIC0s7vMOAF5s25h7n
        NrTqJX6G6GdRT4lSP5Tgr/xOKU5mYOGzx44+T4Wv6Bc/nAaIcMXqvOrSQwQL7x0VPuZbOwVrkx5
        EocVb8roWrchjIW493dKuldy/
X-Received: by 2002:adf:fc87:: with SMTP id g7mr28697374wrr.319.1566239598418;
        Mon, 19 Aug 2019 11:33:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRzgvRxefwBW4gtKRSSnETPE93k3WsITQv4FasqWWtMUx0D0FuzwoHIAa9Z4TfsJ8CTnhFbQ==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr28697362wrr.319.1566239598177;
        Mon, 19 Aug 2019 11:33:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240? ([2001:b07:6468:f312:399c:411e:1ccb:f240])
        by smtp.gmail.com with ESMTPSA id d19sm21489395wrb.7.2019.08.19.11.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 11:33:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: x86: fix reporting of AMD speculation bug CPUID
 leaf
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
 <1565854883-27019-2-git-send-email-pbonzini@redhat.com>
 <CALMp9eQcRbMjQ_=jQ=qaYmh1Lavc3PYvm4Qcf3zY+N8j3zZe-w@mail.gmail.com>
 <0e29f624-10f5-7ab5-1823-280f32732b68@redhat.com>
 <CALMp9eT2uo+_tbV=Z3-pyzjU76kaEU-BNvVriEHU6yGMsiy5Dw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9097ee53-e681-60ef-b389-6603bcb52041@redhat.com>
Date:   Mon, 19 Aug 2019 20:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eT2uo+_tbV=Z3-pyzjU76kaEU-BNvVriEHU6yGMsiy5Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/19 20:30, Jim Mattson wrote:
>>> Perhaps there is another patch coming for reporting Intel bits on AMD?
>> I wasn't going to work on it but yes, they should be.  This patch just
>> fixed what was half-implemented.
> I'm not sure that the original intent was to enumerate the AMD
> features on Intel hosts, but it seems reasonable to do so.
> 
> Should we also populate the AMD cache topology leaf (0x8000001d) on
> Intel hosts? And so on? :-)
>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Thanks.  Note that I plan to send v2 tomorrow, and I've also done the
part that reports Intel bits unconditionally.

Paolo
