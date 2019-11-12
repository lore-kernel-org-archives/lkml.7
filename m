Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF42FC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3C21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IO6FTn0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKLKFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:05:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbfKLKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573553109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=zaxY5J3/zid6+mm6T5LBsRnX0vbfQ+NA4YG4KZqtl3s=;
        b=IO6FTn0UyG1u9hIXfdRp4TFC+qg8OZtgz6UDL51fjafT90OilFesQ7llidFp4SBj59cb/B
        7SxuzhhNwG0wADBFfn/+lO3VT+blYqsBBJwbqqPpEmCNgS7036ISc0tPzqub0YY9W73Dia
        8N+1qYLHCKtwzklihG8vsoySjNQwy1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-GKnU8YDjNjeno52lAtlLuQ-1; Tue, 12 Nov 2019 05:05:08 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so11556039wrs.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uz22t3us6UOXuTBBd914qusqZHasXCof2NK3Mmej/N4=;
        b=o2py5XeKc6K2Jw+a2cHU4k4FNV0itNTgmOgMU7jC88Ww7qxaUWCmj+UMTfGyO+i/2K
         8Rn04+b4xZIbH8vPlM7XdNSHeYUGdXFlJ7l7KM93SQ/x+GcJZN+7cF6AVR/fPMiXcXTA
         ByLmHfgVuUtuUPkGUFEm1oJ1eTz7Nwx7OPl3kH0H+9VXIMdX9a4tZK9eRfmJonNbnzza
         aP+JV5N0RrcTeqJrqwngMPU9GWc8p8F3WiJjO2xIolI1didXZ5tc3H4O5E313VkY+5z6
         WwIPauVwqUIGHriHZdYIqaMtIuRz90FHIe1rg7ybIouf9guHTS309owXco9geSneGLXG
         TevQ==
X-Gm-Message-State: APjAAAUEgO//J6hmReLyWlUf6MYMdt9duvWJxTV0qA3yXE8eK3QgGhI7
        hY2nDRSF1g+sDAvIOPTr0dfHCei5jdmSk5ThoUGaecGTWrx8afG3sKWzCJj10jp9epDheu97q9Y
        oU6CRfWkcawhKgvZGWRx3a2Rq
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr2983880wmm.35.1573553107275;
        Tue, 12 Nov 2019 02:05:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+kXgPM49/wgPfghKBn4fo/65O4WMKY0rdb5DS7qwHuBolbNNhHThEHDs1lESzLgJuVGskBg==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr2983857wmm.35.1573553106948;
        Tue, 12 Nov 2019 02:05:06 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id x7sm49840508wrg.63.2019.11.12.02.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:05:06 -0800 (PST)
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
Message-ID: <1a6a7948-37a1-e416-17df-346ebcfee95b@redhat.com>
Date:   Tue, 12 Nov 2019 11:05:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dcbc78f5-c267-d5be-f4e8-deaebf91fe1f@linux.intel.com>
Content-Language: en-US
X-MC-Unique: GKnU8YDjNjeno52lAtlLuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 07:08, Like Xu wrote:
> Hi Paolo,
>=20
> On 2019/10/29 0:43, Peter Zijlstra wrote:
>> On Sun, Oct 27, 2019 at 06:52:37PM +0800, Like Xu wrote:
>>> For perf subsystem, please help review first two patches.
>>
>>> Like Xu (6):
>>> =C2=A0=C2=A0 perf/core: Provide a kernel-internal interface to recalibr=
ate event
>>> =C2=A0=C2=A0=C2=A0=C2=A0 period
>>> =C2=A0=C2=A0 perf/core: Provide a kernel-internal interface to pause pe=
rf_event
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>=20
> Would you mind to revisit the following patches for upstream ?
>=20
>>=C2=A0=C2=A0=C2=A0 KVM: x86/vPMU: Rename pmu_ops callbacks from msr_idx t=
o rdpmc_ecx
>>=C2=A0=C2=A0=C2=A0 KVM: x86/vPMU: Introduce a new kvm_pmu_ops->msr_idx_to=
_pmc callback
>>=C2=A0=C2=A0=C2=A0 KVM: x86/vPMU: Reuse perf_event to avoid unnecessary
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pmc_reprogram_counter
>>=C2=A0=C2=A0=C2=A0 KVM: x86/vPMU: Add lazy mechanism to release perf_even=
t per vPMC

Queued, thanks.

Paolo

> For vPMU, please review two more patches as well:
> +
> https://lore.kernel.org/kvm/20191030164418.2957-1-like.xu@linux.intel.com=
/
> (kvm)
> +
> https://lore.kernel.org/lkml/20191105140955.22504-1-like.xu@linux.intel.c=
om/
> (perf)
>=20
> Thanks,
> Like Xu
>=20

