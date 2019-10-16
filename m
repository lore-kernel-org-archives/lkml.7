Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78395ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED4720872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObKkU029"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJPHZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:25:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59174 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbfJPHZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571210702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5d0V9S8ommJVGUrWAIephbxJ0dHyW1i5xgUqQkwiWw=;
        b=ObKkU029A3p3gcJHGZO7LILvF3UvVjX0lyObVvFRyVrbkn1YS90mfOTRhzasYefXfbbgoL
        2jpBvZidJGeDsv6BJLDbGMktZevpfjXi7aI0T1K+SuKVtJ/KOgVr0/62XHnAu/Ka17ojY4
        PSWXH/tJxLBE9ftzttqoCLCxmCb+UOM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-8Q_jLAJNNSClGvZXJr3zhw-1; Wed, 16 Oct 2019 03:25:00 -0400
Received: by mail-wr1-f69.google.com with SMTP id 7so6047147wrl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7pVDKMRb0iY8vtAwjOLtISUgtFuBYzCTEpSdAuatOfE=;
        b=FR2Js9yhZYL9jzr1pULFdBOutnFMbNs4rpmf6Q44PWhaXyrdY6UqarlUvLuluyB1ta
         JdnfxMiFn1GQXfD2m4CwSOvlbW/soeUUwGcUc6cEuajJXC8sldFILDnaeyzIsotCI+S1
         i4hne9ODfarBtk8S5TqAJZCZW3fzAh9TJ76X2cUtnMq6DDosMM68mqyOwd094lgmNTe9
         jnLQtVPjdQ4yumaZ80wHIfzEjzOP5yo9s59FlhUfdUW/mYhQ9j4kA5pVU86GwJp+aEFv
         /cvtlrHd8VZ/IwC7aF/poVAERNaejk3uFZtLDyzfh7mBZVrLYFCJeiCdJiFxZPCLePL2
         LKTQ==
X-Gm-Message-State: APjAAAVR6+VSpnpPBVwOLKyUfzwD9kTD9ugh0puONRgeFBppmIKfB+ZI
        TsvN5wzyUMrrxkWNadv2nCPivVshJh4FDnueb74l7YxdEFzpdeayufXy7prF7dm8DtBdscajCzN
        yiXnZT4/NV4vkjL6ZBQVOFxbn
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr1925355wmt.108.1571210699186;
        Wed, 16 Oct 2019 00:24:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5Hnm/FlYZhsbogxc96HRPT50pfLfmeGENB2+vf8pJDNEMgxSNXlDgdpTAAP/g6kRKVCeDyw==
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr1925322wmt.108.1571210698895;
        Wed, 16 Oct 2019 00:24:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id f20sm1474636wmb.6.2019.10.16.00.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:24:58 -0700 (PDT)
Subject: Re: [PATCH v5 4/6] psci: Add hvc call service for ptp_kvm.
To:     Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
        yangbo.lu@nxp.com, john.stultz@linaro.org, tglx@linutronix.de,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        nd@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-5-jianyong.wu@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9641fbff-cfcd-4854-e0c9-0b97d44193ee@redhat.com>
Date:   Wed, 16 Oct 2019 09:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104822.13890-5-jianyong.wu@arm.com>
Content-Language: en-US
X-MC-Unique: 8Q_jLAJNNSClGvZXJr3zhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 12:48, Jianyong Wu wrote:
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
> index 07e57a49d1e8..3597f1f27b10 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1634,3 +1634,8 @@ static int __init arch_timer_acpi_init(struct acpi_=
table_header *table)
>  }
>  TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
>  #endif
> +
> +bool is_arm_arch_counter(void *cs)
> +{
> +=09return (struct clocksource *)cs =3D=3D &clocksource_counter;
> +}

As Thomas pointed out, any reason to have a void * here?

However, since he didn't like modifying the struct, here is an
alternative idea:

1) add a "struct clocksource*" argument to ktime_get_snapshot

2) return -ENODEV if the argument is not NULL and is not the current
clocksource

3) move the implementation of the hypercall to
drivers/clocksource/arm_arch_timer.c, so that it can call
ktime_get_snapshot(&systime_snapshot, &clocksource_counter);

Paolo

