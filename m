Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8266DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730020872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1zvNif8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUKcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:32:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbfKUKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2LDZt6nZQHHH1FrYL2g9MKCC3YAvWLT/E1GHIFcizM=;
        b=f1zvNif8aQbpLg1f80n+vZpgi33T2Sov99RhNT9HjZn34AQJ00NqWCZsM6jt2DtydZRu4Y
        aKAt6ngKJV/9LO34I2CuE56E9p2KfeV7YVkE1MDqqaW0SS/qDED0+z3tNWUFxXXaMsaV5i
        z2XFlH5R2EWbJIlIYT+rL0pLjk4aeLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-2uxADx0wPsCPRCPifNQuLQ-1; Thu, 21 Nov 2019 05:32:24 -0500
Received: by mail-wr1-f71.google.com with SMTP id k15so1794633wrp.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RCefIYme6aC+9QN5HQO2IUHc5f9eX+/leRuEDcD7AXs=;
        b=DBGQE65OWBu9FsaR4qk/676Jb/RmOszMwWa0qi+eqYZwquoG1VBElMMi0JqpDN/1kf
         QJeUw8QZjIHEtpPMpMe/zug2LsBiIT0TDvelP5Yk662q1IZJjjA+BKu04Uhkmjx/0e9t
         zZk9d0gkm7CgHi9D/RahGACnaFZpztNzLeXFSVbonVWN7pbsydQfhE3B6Ricdlco0YQF
         UabLOOdWlL5zOmG5uFgsYm8vQUxEvdQI9Ic75DsjVSHjdqoT9oTv6P/RBLqgQ8x0bt8m
         ZWsS6yaIMvGH3xYg0vwbbfb/40NFdDIWqn/80qHMoZb0h8lRN8HMmFrNWOM7PcBBGYaQ
         +nZQ==
X-Gm-Message-State: APjAAAXgwGXmx6e6mnSXpNb8xaps7/wh2QVZeuzzJKQDptcmWn1tuUOa
        DNVJArQKqaO8nmhhFDrlyWLaYz2SO3AwgBXWdIJzaxgfLaIDAru5+hlF5OMOxOE6X6FlzTNGvAz
        q0gbG5A54tqa7aH/dIbOFman5
X-Received: by 2002:a1c:e915:: with SMTP id q21mr9238796wmc.164.1574332343498;
        Thu, 21 Nov 2019 02:32:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvXDq5rFnE9rr8q7oymU/5CiGqw7gSv8pDuc8DAo5L5cbB5Pc0QJ+smg7kQvVgP8C6NIlFSg==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr9238755wmc.164.1574332343227;
        Thu, 21 Nov 2019 02:32:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id g74sm2153099wme.5.2019.11.21.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:32:22 -0800 (PST)
Subject: Re: [PATCH v7 6/9] vmx: spp: Set up SPP paging table at
 vmentry/vmexit
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-7-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b67b07bf-7051-7dbc-2911-9268d72f0b70@redhat.com>
Date:   Thu, 21 Nov 2019 11:32:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-7-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: 2uxADx0wPsCPRCPifNQuLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> @@ -5400,6 +5434,10 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_=
t cr2, u64 error_code,
>  =09=09r =3D vcpu->arch.mmu->page_fault(vcpu, cr2,
>  =09=09=09=09=09       lower_32_bits(error_code),
>  =09=09=09=09=09       false);
> +
> +=09=09if (vcpu->run->exit_reason =3D=3D KVM_EXIT_SPP)
> +=09=09=09return 0;
> +

Instead of this, please add a RET_PF_USERSPACE case to the RET_PF_* enum
in mmu.c.

Paolo

