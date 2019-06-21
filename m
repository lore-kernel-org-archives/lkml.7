Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C84C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F2921537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfFUInf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:43:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55099 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfFUInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:43:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so5536225wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RGP6lrdFeiyCR8bFc4y9TBM1FWLgB81TixkDIMIJnYg=;
        b=Huue2Fwh+OM4NVaxQZ4/Fjgh4zwrJ69PC/72s55q9bsF5RkqNhk1a24k6oHCTOidMh
         TEy0moYae3uRk76cT4Pie6DxQt/VISg91XCtYEg6Hv6lrkHxgTNRpQRaw0A57TvKQGAw
         dNnIqZ7hS3Zh43UyQ0cFqix4zthoiBtCARZBRnnwQthYF1Xr8yJBLeHWKuLYyUlYDTvK
         72UqKTpogQ28YmyiE3okyL8kchQXt1uhdzby9D6P0XKPdLsGYJzex/qIzrSRaghdjwyF
         k+sfctQs8RFLuFRY5dK73/5mXI7R3p+jgjQToQvOOR7EHTwXI+oMPLnXd5IddnwO/1gQ
         pvbA==
X-Gm-Message-State: APjAAAWk/aNCLyCwsi+Z2uw1lVdU7kr0dNaP4z1LGYcHHcKwqQbV4/pM
        JmIzxaGnWF3NqUawNkfPqOSboA==
X-Google-Smtp-Source: APXvYqwZFutXN6BvKeDJNb/D/OOiLk+eQ4ygcLMq6gGb3r3C2Sg0Vxxr+txQdjtA94eBouvi/KXLLw==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr3293812wmc.89.1561106611736;
        Fri, 21 Jun 2019 01:43:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-31.net.upcbroadband.cz. [89.176.127.31])
        by smtp.gmail.com with ESMTPSA id r4sm2447702wra.96.2019.06.21.01.43.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 01:43:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all paths in skip_emulated_instruction()
In-Reply-To: <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
References: <20190620110240.25799-1-vkuznets@redhat.com> <20190620110240.25799-4-vkuznets@redhat.com> <CALMp9eQ85h58NMDh-yOYvHN6_2f2T-wu63f+yLnNbwuG+p3Uvw@mail.gmail.com>
Date:   Fri, 21 Jun 2019 10:43:30 +0200
Message-ID: <87o92rfhvx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Thu, Jun 20, 2019 at 4:02 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Regardless of the way how we skip instruction, interrupt shadow needs to be
>> cleared.
>
> This change is definitely an improvement, but the existing code seems
> to assume that we never call skip_emulated_instruction on a
> POP-SS/MOV-to-SS/STI. Is that enforced anywhere?

Hm, good question. I'll try to check before v1.

-- 
Vitaly
