Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBF3ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13787206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDzjY1Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfJIU6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:58:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731751AbfJIU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570654720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXdPrh5SQBY2g5E44Kbwxu0eoL2g32/Mh7xHjPoo0bo=;
        b=DDzjY1ExwKEPZZmKtHEVW/0RBeF+JkCi1f+hefgD1PZnv8y4awPx1wCGlFEs4L97pGkbvW
        i3bNktf+5++yZZzOqu5WQPKoV34kP4SCqEqgHR2qBbr1gffKxEm9PaA9jE2t14phlTeSU7
        lkNQkguH8mZtCtrOTGpRkKAVDy7pnDA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-1twHgEDhPqCRqmAPWzI-QQ-1; Wed, 09 Oct 2019 16:58:39 -0400
Received: by mail-wm1-f70.google.com with SMTP id o188so1587978wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZCiTiFbtDiMRheTU38K9dij6O6J26jyHcq0IPo3YkI=;
        b=SNet6b1axJNHuNSWyQRMjh3LMsgApdX3mwP6AVk7Hv6el1hMutc4K6Y/L3jcvrRQB0
         JQeQ+B4MEfgO2wKF0ifuxUsHPsS8OzoreH6hQcAhCp4zn49AkEP658UWFjSsnFZJDpRs
         SOKX0GmlUpqWnc4l6ZlofZCxUpR7YPIhnv1JpDOrpnnlvff2n1LfitddVho8SO4ov55q
         fs0uH9twHrJmUlHKq1+NIcwGlGcDTOW4gmKdl6BHXPSbiQnZvlMsCaGlsWTKDufmYsAT
         O/9yNLgMgOR8Btfm/G10YsIs6zQOkPDbveWBVJ/9meSt0244HyM9CJ02v24UeAqkL6Fe
         bVGw==
X-Gm-Message-State: APjAAAUqqVCRpW2kEoBUd1XVb3QZoHhLMU7EpmAFbm9rb+Yo5ys70pqa
        GrTVfgTGIf2Kh67pvULUXBh/Kw4KFtJ4l29946uI9/1o8/clt1N7OLqAfTwFOh8OF+gi5pQwheE
        xK5hZDGUp1t4brZkBFZbOEu9C
X-Received: by 2002:a5d:544a:: with SMTP id w10mr2258716wrv.271.1570654718003;
        Wed, 09 Oct 2019 13:58:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxX7JfRvkV9uOOZ0iYaYnAdc1Oax5CH0j4BaeLo2KW73O0Nr1ynOw/1ZdsltoZnfUbPMApWTw==
X-Received: by 2002:a5d:544a:: with SMTP id w10mr2258693wrv.271.1570654717701;
        Wed, 09 Oct 2019 13:58:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5? ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
        by smtp.gmail.com with ESMTPSA id o9sm5463455wrh.46.2019.10.09.13.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 13:58:37 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.19 08/26] kvm: x86: Improve emulation of CPUID
 leaves 0BH and 1FH
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Marc Orr <marcorr@google.com>,
        Peter Shier <pshier@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
References: <20191009170558.32517-1-sashal@kernel.org>
 <20191009170558.32517-8-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fcb0e38-3542-dd39-6a1c-449b4f9f435e@redhat.com>
Date:   Wed, 9 Oct 2019 22:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009170558.32517-8-sashal@kernel.org>
Content-Language: en-US
X-MC-Unique: 1twHgEDhPqCRqmAPWzI-QQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 19:05, Sasha Levin wrote:
> From: Jim Mattson <jmattson@google.com>
>=20
> [ Upstream commit 43561123ab3759eb6ff47693aec1a307af0aef83 ]
>=20
> For these CPUID leaves, the EDX output is not dependent on the ECX
> input (i.e. the SIGNIFCANT_INDEX flag doesn't apply to
> EDX). Furthermore, the low byte of the ECX output is always identical
> to the low byte of the ECX input. KVM does not produce the correct ECX
> and EDX outputs for any undefined subleaves beyond the first.
>=20
> Special-case these CPUID leaves in kvm_cpuid, so that the ECX and EDX
> outputs are properly generated for all undefined subleaves.
>=20
> Fixes: 0771671749b59a ("KVM: Enhance guest cpuid management")
> Fixes: a87f2d3a6eadab ("KVM: x86: Add Intel CPUID.1F cpuid emulation supp=
ort")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/cpuid.c | 83 +++++++++++++++++++++++++-------------------
>  1 file changed, 47 insertions(+), 36 deletions(-)

This is absolutely not stable material.  Is it possible for KVM to opt
out of this AUTOSEL nonsense?

Paolo

