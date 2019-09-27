Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE36C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531482075D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fYnQUV9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfI0JUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:20:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37416 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfI0JUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:20:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so1382870lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUJ1/Iwwp/mWKX1v6738rug/Uwulg67MH6fF2LkIHoU=;
        b=fYnQUV9aHYiNDRG0ybNWFU/6abt78WerVfUTzWshQ7e1bblOYhLBDafRZrDnXFV55j
         5PJQgGUdwzn0Iy4m1el8QIV1iolOzPuYN8+EuXFNmCo4UL24h5Qng08HNEHJpI/E/ZKg
         07tLg877fK5O/XHo9kLAzHdxN8xnw3Zso3rMnyu0SqQvM8/jFGnGsys3PStlTFcQJTDi
         71kh9G7Cr3kOlRrNjt010xNmqHm/5tIAwYiiK4Ag/US4I/Xc39F4Kq6S+9Ivhs6ArJho
         FJduxbBX7qveLEe7UlrGWHtaMw5etZ3DtAP4BEoYARJQL843vFrcQi/99OAVbzyZDWkF
         MlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUJ1/Iwwp/mWKX1v6738rug/Uwulg67MH6fF2LkIHoU=;
        b=lFa5P/VGh7bd5j+c+/Hwx9BGdSmxwgltIxreLQWWWL9GCj6q8NqAvEfI3C/GgbGJe1
         Ly/EyAwdKngwNC9Ba/27bT2TR/Uey7shP8rKGZQ6lPbgihOcfCWmuNCEXFw8JIEcoRRP
         WPMxcjEbGbxPY4tnOTnVBFcyuFoCaBYUH+MwY0lc1x87gp9KT0SHpHyn28FdLAPoXhR/
         PaaB/Zmg2U61WtLwcwiGeX0DV93+KaScvSUnjeEnDWKGwn4mKvR9sdUcUQNiziaensx1
         FLkcuasahgtV6AH5YfdjMlDpS4XnKWn7tvGlgWffk0i8AMeZayq5BzwA0EwZtNgp7ySJ
         Urzw==
X-Gm-Message-State: APjAAAXide6rvf6qu8lESnRjscsWJI94TaseNJrou+N254VVJ0yVT2Dh
        4/u4NLasAWWLDfPNAxmFuI9HFw==
X-Google-Smtp-Source: APXvYqyaCrwz/qm98j1MtO5pqAPgEl3ED11Gh+OFBBX48Aefnwmp87aL9fjMp6c5WyO4uFR7GlAuDA==
X-Received: by 2002:a19:f247:: with SMTP id d7mr1946420lfk.191.1569576037260;
        Fri, 27 Sep 2019 02:20:37 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8df:57d9:c46b:3c97:5028:3a4f? ([2a00:1fa0:8df:57d9:c46b:3c97:5028:3a4f])
        by smtp.gmail.com with ESMTPSA id q3sm341838ljq.4.2019.09.27.02.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 02:20:36 -0700 (PDT)
Subject: Re: [RFC PATCH v4 3/5] psci: Add hvc call service for ptp_kvm.
To:     Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
        yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        maz@kernel.org, richardcochran@gmail.com, Mark.Rutland@arm.com,
        Will.Deacon@arm.com, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        nd@arm.com
References: <20190926114212.5322-1-jianyong.wu@arm.com>
 <20190926114212.5322-4-jianyong.wu@arm.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3586ca5b-7abb-12b2-2368-cbc09fe3777f@cogentembedded.com>
Date:   Fri, 27 Sep 2019 12:20:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190926114212.5322-4-jianyong.wu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 26.09.2019 14:42, Jianyong Wu wrote:

> This patch is the base of ptp_kvm for arm64.
> ptp_kvm modules will call hvc to get this service.
> The service offers real time and counter cycle of host for guest.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>   include/linux/arm-smccc.h | 12 ++++++++++++
>   virt/kvm/arm/psci.c       | 18 ++++++++++++++++++
>   2 files changed, 30 insertions(+)

[...]
> diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
> index 0debf49bf259..3f30fc42a5ca 100644
> --- a/virt/kvm/arm/psci.c
> +++ b/virt/kvm/arm/psci.c
[...]
> @@ -431,6 +433,22 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>   	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
>   		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
>   		break;
> +	/*
> +	 * This will used for virtual ptp kvm clock. three
                     ^ be?                            ^ T

[...]

MBR, Sergei
