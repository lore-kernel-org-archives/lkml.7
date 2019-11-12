Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49FC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F02196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWZdIq3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLKJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:09:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfKLKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573553360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=rm+SpsgER6q0ZzJGxmttnhDXfih8qrCKpsGq3yb+Vgs=;
        b=OWZdIq3y/bIAj39GVfMWVolDWj1kg4YXzq2Vw3KBZ6XKfde4arrH9vkFiHvQu2d4MgSX0J
        RkzZoD1b7kuuHTk006uF8SC4LeHFOEtkZolsf4d0Gp973OedS6WC3s3f23NpVDxQpmaGGN
        GdSVWyl0ptTp0ghyqII6yQk9SU79hsw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-Ng-hEyGFPDaVnavp_JwT1A-1; Tue, 12 Nov 2019 05:09:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id v8so963034wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/T+UqvDPJA0ruFuxC0ui4R1v70oUmaDOHs4UxSNtf/o=;
        b=DyLaizry99FnF/6KKhRGQbJ+ulBBwCMDdlFDXFSljuGw+g0VD5w8z/WkRY8Qr46gt6
         aV+r2AUZlKa9f8U8r5eKHdvFxrJFkcvkuNgfl4MXARhqOKSkVy04zOrHjZRZKn2WwzUq
         on7oOhPoWAFYnK3R+Urx1ZgF/vTSYoM+3BeQ6CiFrtDdEWLD7hq3clyUcPYhoaFnELL8
         wslQTq062qjEHA4dd/8w19/lp0q1uMd8OunjV0K1/n4P2ujcjIW6GLO8l6jkGL8OQBHG
         Prkf4moEStlOrJdD6perdNqStDknTdlIq2Bh8RDjyq/r5xaABox55ASJb1l9v/WT74jP
         MlPw==
X-Gm-Message-State: APjAAAWEfGWQNPzNs4VpQyThnORE8z7ckK26TNag4/LcKlW8CLf4HnxZ
        bYtDj+rmTPnSwUByRm4EXAczLG69qDhE7Pgc5BEw56AsiDac7UwcWDigk6M8fxDEF48SL/eRtTt
        AcaAXZxBMcMWHueiw4D+4FejR
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr3211639wmg.117.1573553355857;
        Tue, 12 Nov 2019 02:09:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxieILYD7Oki2LtPWxGLPvRXneVlPzXp94IaP9x7iQbDbM7jR4WAKOfSK+ZLP0yVwAzUEp3zw==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr3211614wmg.117.1573553355624;
        Tue, 12 Nov 2019 02:09:15 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id q15sm10709704wrs.91.2019.11.12.02.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:09:15 -0800 (PST)
Subject: Re: [PATCH v4 0/6] KVM: x86/vPMU: Efficiency optimization by reusing
 last created perf_event
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20191027105243.34339-1-like.xu@linux.intel.com>
 <20191028164324.GJ4097@hirez.programming.kicks-ass.net>
 <dcbc78f5-c267-d5be-f4e8-deaebf91fe1f@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <21372ed6-b8c1-3609-1ab8-2d566a4319e6@redhat.com>
Date:   Tue, 12 Nov 2019 11:09:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dcbc78f5-c267-d5be-f4e8-deaebf91fe1f@linux.intel.com>
Content-Language: en-US
X-MC-Unique: Ng-hEyGFPDaVnavp_JwT1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 07:08, Like Xu wrote:
>=20
> For vPMU, please review two more patches as well:
> +
> https://lore.kernel.org/kvm/20191030164418.2957-1-like.xu@linux.intel.com=
/
> (kvm)

If I understand this patch correctly, you are patching the CPUID values
passed to the KVM_SET_CPUID2 ioctl if they are not valid for the host.
Generally we don't do that, if there is garbage in CPUID the behavior of
the guest will be unreliable.

Paolo

