Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F109ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DE720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om5iI9Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJPHn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:43:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388138AbfJPHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571211803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=2TZPYczZMoe38v6J5VmGL4LQBizJV5OWL5TaFj5ByLo=;
        b=Om5iI9WseTp9t7edt2mzqSKHHF69YxxrDy/Md2+rPgWq2uwrQ1K6tgOk4cre5o3Nv7hd0w
        2ByvO53o5J1dJaPFHPeWU1jSpsbH9Ev/weuwTTG3shk/Yj469XYnNtAxFLgX78YMH9akeB
        F0tVX3j88+zHKdH51GOjaXWLZwRZaHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-njNYzjgUNwKUxpiM21edSg-1; Wed, 16 Oct 2019 03:43:20 -0400
Received: by mail-wm1-f72.google.com with SMTP id q9so782598wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2TZPYczZMoe38v6J5VmGL4LQBizJV5OWL5TaFj5ByLo=;
        b=ivP+I9cN0MK0JJXoCBTHZavKtmwl8SmFucUwiFqxoYDa5YTGVZ+rvoY8Ysv5bj9Hjr
         9wstFBZlJI05UC4MIsM42SYBdzOD3kNIQxnOPIFMETrzUZEw+soW3AKhgMTEL41uEYIj
         8l/uK3FT0YCwPPw74ANDR5X5nS/G8PZR6zD+Xfh6Yp4tH3jJVsDMggEg3Nk6NVq+fuuQ
         m1Gaa4alTFEIpflZJ/2oQVPg26D/smeS7GTVzqxer4SFIsN1jIT0RTo7+TOqBTnt7ho/
         LbSTT0c6+j4XgGSLz+xHMT/aATNY6FIxxWUet0v7quLjb7sMob8yda3Oir0w3fzbaI3t
         XLNQ==
X-Gm-Message-State: APjAAAUxCrh4pOhqoaFsu3VOcnv6zIsHwpoy3FwYO2EEmJjDi2yBTfsF
        pzjyCL2dmi7ns1mRusf206UXkHU/TqLmW9BLPbpOfbgPcuzCNxh15xR3AqpoEtu7tBw5St+Uq/F
        NNSo7TQGw2bj6UR4ldcEqdzSh
X-Received: by 2002:a5d:6203:: with SMTP id y3mr1414790wru.142.1571211799705;
        Wed, 16 Oct 2019 00:43:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYE+zEFsYqXUGvnl9sFNQ8c4wx17KGf+Az81W3+WtMXjrT9dBRLwLjKr90BAhiAxvpImSuwQ==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr1414773wru.142.1571211799459;
        Wed, 16 Oct 2019 00:43:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id d78sm1595639wmd.47.2019.10.16.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:43:18 -0700 (PDT)
Subject: Re: [PATCH v5 4/6] psci: Add hvc call service for ptp_kvm.
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
 <20191015104822.13890-5-jianyong.wu@arm.com>
 <9641fbff-cfcd-4854-e0c9-0b97d44193ee@redhat.com>
 <alpine.DEB.2.21.1910160929500.2518@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5e344920-1460-337c-9950-858165d37d14@redhat.com>
Date:   Wed, 16 Oct 2019 09:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910160929500.2518@nanos.tec.linutronix.de>
Content-Language: en-US
X-MC-Unique: njNYzjgUNwKUxpiM21edSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 09:31, Thomas Gleixner wrote:
>> 3) move the implementation of the hypercall to
>> drivers/clocksource/arm_arch_timer.c, so that it can call
>> ktime_get_snapshot(&systime_snapshot, &clocksource_counter);
>
> And then you implement a gazillion of those functions for every
> arch/subarch which has a similar requirement. Pointless exercise.
>
> Having the ID is trivial enough and the storage space is not really a
> concern.

Ok, good.

Paolo

