Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BAC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXTO0GXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfJPHKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:10:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfJPHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571209840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atkKBE+OhbQ4pOII4N38Iv93WpWN9YTy8W/dwEibJvo=;
        b=JXTO0GXnmDTd8ADD0ABb8mNP/39+TLlqX7isew7arN/30FXyoLSIvFu3MaTEKI6os8OprW
        PtlUTOmLYLESVAy1WRrinakAlsj5Gs+7O0x4VSMD+pQnQD6kMGgYXP7u6vqEx722/kJqUA
        b/NLf9Nb8zG1Q1Mf002GvUbLaiIuMoU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-S15e7qXXNPWQsXXxXCzWxw-1; Wed, 16 Oct 2019 03:10:39 -0400
Received: by mail-wm1-f71.google.com with SMTP id q9so747148wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KmZ9tmpXlk46xmJUogDKwLZzCFViFGNnmxsywrkhr4=;
        b=Jzxh8QYwekaPtVi7f35f9fi0PG9obUD9pajRJb42RHXwIcw3oKVLj8+1yMEE9mMSwi
         jYBKfw+zdoZMPnAZ9ZTButmRrsqr0XPvgyHZb/BvBhfk/VSw/yoUntW57RDenqnoxp4i
         UlijmhxVpedLSNzw4avpbNaUI8fheKroaEThrItyoDR2GrE/Qzk60sik1KUv5Zn9u/lq
         blqA0gBEO3Z8FOMoRRSTSdGW4FCb7kcN154HdNac6mYa13rZNIwiI52yV8Ss1nQstBul
         zwIpePDtPKYwF6hPy1fQZnfZOz5BvBfz+ybFGs5t/jM/Cczm9jzp7EG0L4cP9LcYsBC6
         dKWw==
X-Gm-Message-State: APjAAAVL+6JjwcUw+2Er4COch6duX+mtsMqKUGVejEgyHNu88HD/WAbM
        E+NGC7kslDSMebf/yCO+YFozhuMJC8DDRj9XU/pMDTDcMkRL7367Qir3Xl+1XyFHSrFz3SOM1y+
        nMDB42J1e66dojC3dC99j44iu
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1344881wrj.301.1571209837021;
        Wed, 16 Oct 2019 00:10:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMkepD45un/zag7gKTc+lFp9N0/XMwW6mC1kmyUCBXgrwtYogoeP8y+AmUc8Y9iVF713Y8IQ==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr1344860wrj.301.1571209836713;
        Wed, 16 Oct 2019 00:10:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id z189sm2973051wmc.25.2019.10.16.00.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:10:36 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] ptp: arm64: Enable ptp_kvm for arm64
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e9bfd40-4715-74b3-b5d4-fc49329bed24@redhat.com>
Date:   Wed, 16 Oct 2019 09:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0801MB167654440A67AF072E28FFFDF4920@HE1PR0801MB1676.eurprd08.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: S15e7qXXNPWQsXXxXCzWxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 05:52, Jianyong Wu (Arm Technology China) wrote:
> This func used only by kvm_arch_ptp_get_clock and nothing to do with
> kvm_arch_ptp_get_clock_fn. Also it can be merged into
> kvm_arch_ptp_get_clock.
>=20

Your patches also have no user for kvm_arch_ptp_get_clock, so you can
remove it.

Paolo

