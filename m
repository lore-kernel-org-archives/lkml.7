Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C14620B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjgoFjXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfJIWto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:49:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732244AbfJIWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570661382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=nZonk2/mRB1boKLTxfgV+UfH1DuBLDAVVaiBeToXo30=;
        b=NjgoFjXihe4mJDzp2EIGJTZTZYaTXOMzZuOwY4UiNQAxzCNFniPsYrqHbKFR9sKnWpulV6
        B05Ot9pu5bvNf8RHUmnoljar7L3LuVGYr+sb/5Ql3UwB2cjqFx2sdc68y3Y2pAcyNhu4IY
        KLvC9aauSfKgX9zRoWL60QG+ntQ5tLc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-akJNQ-SdODidHRySV3uWXQ-1; Wed, 09 Oct 2019 18:49:30 -0400
Received: by mail-wr1-f71.google.com with SMTP id k2so1771821wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 15:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DoZLlJIxnv792llQ86N6fFnpfG9V6Pvfi/VrOtQ0Pc8=;
        b=o6a/slPtmJyKd1ieGj4K8PUSrqi8+pihcSspwJ9Hrex9VUxMWdQWTv31N52DwcXAqw
         FIEwElKqIHjArm+NVCPeKpNh2GiTICsgYj0cGpmSOFjb5RTLleXupxJU18CQGul/M/vX
         t4OKpRF73/n5bvcTdwvk2oaTWivGrMRIcff/6kyXtml0hJIPAn1ds2uH+ac2dNjZKIOb
         FEUZDabtQuSzABs5haK0BZowlwLi57VLqjhRLZsuaf+aBL00J01eIEQsvD9kRV6M7ZKT
         TXIN53FIvRYtbnE/gjCIT0nniCkVDwrDEt6WCVxRE7UPwz9gJpu2P0b5U1wRW5xhHwu9
         PpmQ==
X-Gm-Message-State: APjAAAXfcuSzK97MWul/1L33lEnVpCOWdEX171trS4gXd6XmoeAdZJdb
        hv6vMnL5EX89EdkkxVAr229bMZ9cjqCu+ECBY6/it37SmjTjUnFBWAJoIoF5NtFu+XdE2fvXHkr
        vTNeOt/O0lBJRCGgxGqM5Mifn
X-Received: by 2002:adf:f188:: with SMTP id h8mr4848480wro.38.1570661369310;
        Wed, 09 Oct 2019 15:49:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCjAafIgWlXkt+EEzwJgcMSKSzRjfxUDjH4uZYPg9/cb0j2rQX3I0mCOAOmAnjEozoSdrEPg==
X-Received: by 2002:adf:f188:: with SMTP id h8mr4848462wro.38.1570661369059;
        Wed, 09 Oct 2019 15:49:29 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id z125sm4451630wme.37.2019.10.09.15.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 15:49:28 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.19 08/26] kvm: x86: Improve emulation of CPUID
 leaves 0BH and 1FH
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Marc Orr <marcorr@google.com>, Peter Shier <pshier@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
References: <20191009170558.32517-1-sashal@kernel.org>
 <20191009170558.32517-8-sashal@kernel.org>
 <5fcb0e38-3542-dd39-6a1c-449b4f9f435e@redhat.com>
 <20191009224129.GX1396@sasha-vm>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3855e044-f2d1-6371-018a-c2d32031d8fb@redhat.com>
Date:   Thu, 10 Oct 2019 00:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009224129.GX1396@sasha-vm>
Content-Language: en-US
X-MC-Unique: akJNQ-SdODidHRySV3uWXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 00:41, Sasha Levin wrote:
>> Is it possible for KVM to opt
>> out of this AUTOSEL nonsense?
>=20
> Sure, I've opted out KVM and removed all KVM patches from this series:

Thanks!

Paolo

> c1fac4516a61d kvm: vmx: Limit guest PMCs to those supported on the host
> 75b118586ec81 kvm: x86, powerpc: do not allow clearing largepages
> debugfs entry
> 06cd1710feaed KVM: VMX: Set VMENTER_L1D_FLUSH_NOT_REQUIRED if !X86_BUG_L1=
TF
> c89fc5c082aa6 KVM: x86: Expose XSAVEERPTR to the guest
> 1eec6b4068e2e kvm: x86: Use AMD CPUID semantics for AMD vCPUs
> 5c56e6ba0afc8 kvm: x86: Improve emulation of CPUID leaves 0BH and 1FH
> 94a3c6f010bd2 kvm: x86: Fix a spurious -E2BIG in __do_cpuid_func

