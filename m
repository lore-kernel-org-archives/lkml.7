Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41301C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8732082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoJkiRSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJPHNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:13:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48753 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726875AbfJPHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571210032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+nkQRyeopKoQt4du7dFN9BRIgBaHV958j8ZBKBE5e0=;
        b=MoJkiRSZ7ZlIet1eXCiP4e23f+gbzTA/xv0TA2kzvrEm6Vw4pYbXEXQVQailc8swqM7Of0
        7B3dtyzh8sEylU2e3LD+zdFyEjevBzLD+OAWxTvc+g1A/BQHnvgD7itwFr5ovWwqm1QcP6
        j036n+wHSrM0p46brF0msc+pvC7BzWI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-J_g6NV0DNNakqDfSymvqDw-1; Wed, 16 Oct 2019 03:13:51 -0400
Received: by mail-wm1-f72.google.com with SMTP id o8so767462wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Puk2gzKjg2U5mW3uARabrgwbGmI43WYHISWUlwSLVQ=;
        b=iQFuYXC2Kow6eJeAwS45DAikbZDCuaCyOd7FAmKqGjTF3h6/T0+fLSFNjlCoLG9uBN
         khzHYqprq2bQPcHZYlLbrsxsl+F126ME4/osPLhTWmlItnt97DNq2nQhuete+H8T713l
         fPp6jcR+G5N28cA8PGaXnUiJPFP//3KmDLvB6tu+QmjQq+ErGnT/XMlCK8cOougEJI7L
         qACittvTHNu2V0auHnCXYKDRAApcm/VJm/o+kjgFDwlwBDBXj9bHRLWXbQh5iHfhufw8
         FUXi+Z317xSOyMCJvGYEjQJx4oWHElPnaE1IEW8AOp3uSF3HLuCeDI9bsdFImpwvvxaC
         /pow==
X-Gm-Message-State: APjAAAW+m73RYu/E1fKryECNauNqjYOSGdRniDimyg01bF2m26nAZjDK
        Nk+9tzvBl72MS+R/TINX8pFTVMxoIjbssNoNfvfik7H7Fp+/sAu3IqUBSsIydMYtB0KQaSV/4jl
        uTtvr/vteVbE8PyCo9jVCv4Ef
X-Received: by 2002:a1c:6709:: with SMTP id b9mr2164253wmc.14.1571210029964;
        Wed, 16 Oct 2019 00:13:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzil7ngX2+rV1FuqUIzc7TJZOMSmcjqUkdazl9Cfq2UEQrrOgM1lpUEgLCAkoYOX3c/5g590A==
X-Received: by 2002:a1c:6709:: with SMTP id b9mr2164227wmc.14.1571210029679;
        Wed, 16 Oct 2019 00:13:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id b15sm1429843wmb.28.2019.10.16.00.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:13:49 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        nd <nd@arm.com>
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-6-jianyong.wu@arm.com>
 <da62c327-9402-9a5c-d694-c1a4378822e0@redhat.com>
 <HE1PR0801MB167654440A67AF072E28FFFDF4920@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <6e9bfd40-4715-74b3-b5d4-fc49329bed24@redhat.com>
Message-ID: <140551c1-b56d-0942-58b3-61a1f5331e83@redhat.com>
Date:   Wed, 16 Oct 2019 09:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6e9bfd40-4715-74b3-b5d4-fc49329bed24@redhat.com>
Content-Language: en-US
X-MC-Unique: J_g6NV0DNNakqDfSymvqDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 09:10, Paolo Bonzini wrote:
> On 16/10/19 05:52, Jianyong Wu (Arm Technology China) wrote:
>> This func used only by kvm_arch_ptp_get_clock and nothing to do with
>> kvm_arch_ptp_get_clock_fn. Also it can be merged into
>> kvm_arch_ptp_get_clock.
>>
>=20
> Your patches also have no user for kvm_arch_ptp_get_clock, so you can
> remove it.

Nevermind.  I misread patch 2.  However, to remove the confusion, can
you rename kvm_arch_ptp_get_clock_fn to kvm_arch_ptp_get_crosststamp?

Paolo

