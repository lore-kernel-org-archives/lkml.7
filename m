Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACFECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1352067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuzUEzG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbfJOWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:36:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389950AbfJOWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571179007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=wSh+n+8u5QLmMxe2hYGq+Rqu0J/BQ5npWNcVhzyY+e4=;
        b=IuzUEzG5PSs+A6S0zsKEgzprSAVGFF+2/D6gIZTt+pjQjZ4/bjVzXWVmU4B3mwtYq8PAGN
        66CTtYiMkR/DRcoKKB9QdJKmBXe/oDFVZUxaJSoMQj+aykaZb1QGdmX5m56050DN64UQoc
        2sVVXnEKrndBwN3yvoE+bZbQ1Z90iEA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Syb5-5TWOvy31NOxaMT41g-1; Tue, 15 Oct 2019 18:36:44 -0400
Received: by mail-wr1-f69.google.com with SMTP id z17so10828746wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwwAcBIi9gz4rDVsHFX2Q7ZJ02GG7jdgtvkZrgQZWFY=;
        b=K/+YTwj0cnuxtQZFQebR20O2C7zW3VZYU9+HsI9CEZY4MJQZ39KNgcvfbg7oELdO0i
         xgk8cRJQgsVKB9PEKwaiqSHFx2UPyII29oT6pBhGDdqKtnihjNrH8PGd0vezLNhR7KD5
         YSOeLsfK1jJPfyP+2s0Mk0R9AMz3MSKakF+zV+lHPZeOFbSjzctgR4zRODlgQk788L/2
         YH7rmol13UDLUV0Wg4Ecp22XiV3kvC4WSMLFGDaiTG8DCLkIflRR2XWDwDUI2sUz/J2J
         Sje3HLV10UsGM54rdKZfZ3k3uqBA1p91qErMsqGRS3RHo0z1Tf33PzsWwfNbfvlqmh+V
         r6XA==
X-Gm-Message-State: APjAAAUujYaaaLmozHYPdUUAWjwY4BQ0K8pvrBRaXjvgrmqJIpssf6Bg
        iaLctgH7mr6aCbciInr0GD3hv7giPa+1lS+FDjUyCSVzdpPhmgyR8FyTYUWUIDKai3cK7EznsQw
        Cg/10fMzB/UjebZAcowaQiVjj
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr537724wmd.134.1571179003420;
        Tue, 15 Oct 2019 15:36:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyR41EszL4/UT/53Ec9vQZG6o/Omkzfs8QOJ0pfXMxxw7MFiXPeS9FywecPK4MHNGK9zwKlCQ==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr537711wmd.134.1571179003137;
        Tue, 15 Oct 2019 15:36:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id c18sm20828908wrv.10.2019.10.15.15.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:36:42 -0700 (PDT)
Subject: Re: [PATCH v5 3/6] timekeeping: Add clocksource to
 system_time_snapshot
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jianyong Wu <jianyong.wu@arm.com>, netdev@vger.kernel.org,
        yangbo.lu@nxp.com, john.stultz@linaro.org,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Steve.Capper@arm.com, Kaly.Xin@arm.com,
        justin.he@arm.com, nd@arm.com
References: <20191015104822.13890-1-jianyong.wu@arm.com>
 <20191015104822.13890-4-jianyong.wu@arm.com>
 <9274d21c-2c43-2e0d-f086-6aaba3863603@redhat.com>
 <alpine.DEB.2.21.1910152212580.2518@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aa1ec910-b7b6-2568-4583-5fa47aac367f@redhat.com>
Date:   Wed, 16 Oct 2019 00:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910152212580.2518@nanos.tec.linutronix.de>
Content-Language: en-US
X-MC-Unique: Syb5-5TWOvy31NOxaMT41g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/19 22:13, Thomas Gleixner wrote:
> On Tue, 15 Oct 2019, Paolo Bonzini wrote:
>> On 15/10/19 12:48, Jianyong Wu wrote:
>>> =20
>>>
>>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> You're sure about having reviewed that in detail?

I did review the patch; the void* ugliness is not in this one, and I do
have some other qualms on that one.

> This changelog is telling absolutely nothing WHY anything outside of the
> timekeeping core code needs access to the current clocksource. Neither do=
es
> it tell why it is safe to provide the pointer to random callers.

Agreed on the changelog, but the pointer to a clocksource is already
part of the timekeeping external API via struct system_counterval_t.
get_device_system_crosststamp for example expects a clocksource pointer
but provides no way to get such a pointer.

Paolo

