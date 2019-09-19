Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9AC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FE221929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uoos2eUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbfISMN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:13:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390227AbfISMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568895200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=8upZbcqH4fXkVaLOW2dy/iZBybRVQ5oETpjiRcdE6KE=;
        b=Uoos2eUmdiKzuQlXofjnhJ3p1Nwl4lVhuWcraNySJQ9Fpnp7iV8TrTcjMxZgrhJ8FW/iQg
        qmCr1g3ZwdqZfsKwbbFuIGoPYSZ73Vw1mUsR0mc+m+79Y9uqU76+/hg6BlyRPz+qY1gC8Z
        IFTWZqCdNGHCbFXvTreHZvd6SyWyY9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-o4gALb9vM5GWynNYnhGTnA-1; Thu, 19 Sep 2019 08:13:18 -0400
Received: by mail-wr1-f71.google.com with SMTP id f11so931948wrt.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8upZbcqH4fXkVaLOW2dy/iZBybRVQ5oETpjiRcdE6KE=;
        b=tIBR9SjRrbOiaXpt4GF8rhYATIXWlUPqNjr1NyphPuIQifT5IUAyq+IDy2T1LlReX3
         VtHpB/KsCed2v4etC7ikefFwEaNddPIgjxBgGDvJLMZxgGsKJRwp2mTzZOo0V9ahZQLy
         isIE6ZSlqqPsQ383ccy0XUUEb8W30d8kbwuLm45l72UUu95QeIMPxxUDw5zyZ9iJeCS0
         O5nleRFAgurA7GJMNgXJhYUgOxA7h+TUscYaB+ERH47ZwKJQFRx5M3cSXyRNGBv8Jhrd
         LcvTdnqZ2K3D1avlGbUy/SxOY0oETuQBBCKIuXyNRE6qs09ld8e3AoNUcjgOJVj211JF
         jN8g==
X-Gm-Message-State: APjAAAWIUaWSlG61ARCGr3vIrEpBTmtzy041gJ3gJdwhgGXT5p8znSP/
        V1DKoqEeUb67XOCjTFqsv3lJhUX95Yp64t1XmN9+c2CPy4Ymtm5Xt05ftYOxRnTdv4ebdh5Fmwo
        SHuHsf9CP0xXX7oZphjMKmR/j
X-Received: by 2002:a5d:6088:: with SMTP id w8mr6995242wrt.31.1568895197142;
        Thu, 19 Sep 2019 05:13:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoqc728vUxzk+PlHiWZtsz6cgGkTTAs+KWHYRvgq+doGCowWOVSB7hkXrBEQJmElppYJsNwA==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr6995221wrt.31.1568895196846;
        Thu, 19 Sep 2019 05:13:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id x6sm7878924wmf.38.2019.09.19.05.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 05:13:16 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
To:     Marc Zyngier <maz@kernel.org>,
        "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190918080716.64242-1-jianyong.wu@arm.com>
 <20190918080716.64242-5-jianyong.wu@arm.com>
 <83ed7fac-277f-a31e-af37-8ec134f39d26@redhat.com>
 <HE1PR0801MB1676F57B317AE85E3B934B32F48E0@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <629538ea-13fb-e666-8df6-8ad23f114755@redhat.com>
 <HE1PR0801MB167639E2F025998058A77F86F4890@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <ef6ab8bd-41ad-88f8-9cfd-dc749ca65310@redhat.com>
 <a1b554b8-4417-5305-3419-fe71a8c50842@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <56a5b885-62c8-c4ef-e2f8-e945c0eb700e@redhat.com>
Date:   Thu, 19 Sep 2019 14:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a1b554b8-4417-5305-3419-fe71a8c50842@kernel.org>
Content-Language: en-US
X-MC-Unique: o4gALb9vM5GWynNYnhGTnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/19 13:39, Marc Zyngier wrote:
>> I don't think it's ugly but more important, using tk->tkr_mono.clock is
>> incorrect.  See how the x86 code hardcodes &kvm_clock, it's the same for
>> ARM.
> Not really. The guest kernel is free to use any clocksource it wishes.

Understood, in fact it's the same on x86.

However, for PTP to work, the cycles value returned by the clocksource
must match the one returned by the hypercall.  So for ARM
get_device_system_crosststamp must receive the arch timer clocksource,
so that it will return -ENODEV if the active clocksource is anything else.

Paolo

> In some cases, it is actually desirable (like these broken systems that
> cannot use an in-kernel irqchip...). Maybe it is that on x86 the guest
> only uses the kvm_clock, but that's a much harder sell on ARM. The fact
> that ptp_kvm assumes that the clocksource is fixed doesn't seem correct
> in that case.

