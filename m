Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEA9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B1620872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HG7sNlNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUKcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:32:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31494 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbfKUKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574332343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElyN+sySj2vrmERpqpr9y3yrG2GGb+YKg2VUilmEol4=;
        b=HG7sNlNELlxuqMi8rN1ZJeYLTXUzCEL+FR+NPEfvm7P3cX4KyD7+LmGsVP+uNdWL7RsO9v
        DZx/c0rUzLr4e+mGE5KvLEUxEY7q0FqE+CGqGfJ61xnrkGeekMkL5KFK00wgOctwslqgRH
        yWqlQ3bjdHbjCMiB8scl+BoVjrB5bfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-dfJdk_OxNn2LLh4W9ChPww-1; Thu, 21 Nov 2019 05:32:21 -0500
Received: by mail-wm1-f72.google.com with SMTP id i23so1366220wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G440xlK0s+uloxeJR1VxHFZ4nRPuPOBSPLFeR2hRYM4=;
        b=hGphJ+JR154dYa7HW3aQgtVGhJ4f5EfZWcK/vStkyfv08mpWIqmHLUX4zpvwOtPyve
         pHM2VXtS+Fmv1pP/Lr8e0vPXBRjoax1cXd9837l8iUfHQ+QZBY0MG/5G+1WVgJ1yfSrO
         n6ZobejYBO8RK1Pcz6kF4d/6ZPjKrFrD5Wl5fRN41dSLpwQnyQjLaPiJOm+a+DeDd5Zy
         gjr1heSZGFhkn7o0nE07Lfzis3Z6CFwlirvuLfhGFCWrY9AqyUsXTkrd62UX52GbKdbh
         dRaPvRERBRsFvKA+2LFcfo4+Wd+EZIoilhkfT0XYYl+HshGPo1MRLqvHhLFMQBOFJoLV
         3fPw==
X-Gm-Message-State: APjAAAUEq98C0rsuBNkaejGhzWWiNqqDo6QXhVYyNt/A591x7ZSsMX4Y
        S6XCApm22SkYopF0tRH1slNYhMpbqi7X+sonsAsJE8RZ9oLvyln9CYKffP3VaKICEtY7L6xlbxK
        TdGb0gl3JYrPId5hCaq0TotC3
X-Received: by 2002:adf:978c:: with SMTP id s12mr9339809wrb.47.1574332340576;
        Thu, 21 Nov 2019 02:32:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKZh9kkJD8hfx2gvhV/y7La1WwVigFfE5/zMpUK4HVpNjGITyxTxnxC0ch0GWbElRX6dSUFg==
X-Received: by 2002:adf:978c:: with SMTP id s12mr9339763wrb.47.1574332340277;
        Thu, 21 Nov 2019 02:32:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id p15sm2359907wmb.10.2019.11.21.02.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:32:19 -0800 (PST)
Subject: Re: [PATCH v7 3/9] mmu: spp: Add SPP Table setup functions
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-4-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6898c9fe-6cd7-8820-78c0-9fc4969b48f1@redhat.com>
Date:   Thu, 21 Nov 2019 11:32:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-4-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: dfJdk_OxNn2LLh4W9ChPww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> +=09=09=09if (old_spte !=3D spp_spte) {
> +=09=09=09=09spp_spte_set(iter.sptep, spp_spte);
> +=09=09=09=09//kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +=09=09=09=09kvm_flush_remote_tlbs(vcpu->kvm);
> +=09=09=09}

Please do not leave commented code in the middle of the series.

Paolo

