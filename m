Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70234C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DDB206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFzV9mhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKUKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:18:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbfKUKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574331535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gek0hQ8ZLdLms7wGQFlBpywg0Dh4Rzi7CF4EhMq+qI=;
        b=hFzV9mhHRxO/DZs4lCxQlSxVOOuYrX1ZeeJL9gqobRgVUojk2EKXban9y/bgKGqQcLpSql
        Nn8mqsF1KCKnjvCRfYmZJRJ4HJK5O7uSYI4m7wm0i/67ChfSKAqhoRrwGYkEE2HnmZ2U1k
        IgPMKoFUWnsLolr+GwG9xpWGTjEOxEg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-NdyqBLAFMX2hMosav7yxmw-1; Thu, 21 Nov 2019 05:18:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so1792571wrs.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLr6hs+2kbTqnRRA4/wKkKRGchRZdYPhFr9/x9KHzBY=;
        b=AlYj7Q0uwbS8sEGn7j3Z641FmbTtUaepqw2Hwo6EDmbpC6Oa3f2lmNBn2Tch2Y8Lb2
         olF/vSQTqfOQbZVDQGqT+SgrSibhP7wnM3NuxDSBbqzXVdkZTmaFLAgX8x/w1VflKVA4
         FHU9/maZO3CoMusvWO0hw7IcwJ60/aG9FXf+lNf/DzwD9RybCbeB0CnRQ+jAWVbaoxyR
         LnGlSYGUNpQAAZNZb8t68/V1ELpqpVN9MRipL6MWZqhHM1wdZRk/DxnIeGYeY84REQFq
         Wsm/+qQbiK6E6N2Kqa/XmlnBStHGu8MgL/foQ7pTuhvg+Oh7ShR85tTm7UaqQo6K6cxr
         +HOg==
X-Gm-Message-State: APjAAAVCYKC1MtmZNUDBFw1jr2U3xX6z2BqICzkiFTI+92GGc83CeJ/P
        Ffj8uKIVUmPuuhvUytamdGVuhQpP6zJIfU4MsfRChddl1AxFhGGunt4y/jTiShb+IFJtSY3TEe9
        XljGBpbfhPL1RZgLEDYIdLj34
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr8486650wma.119.1574331530232;
        Thu, 21 Nov 2019 02:18:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1iABHZAx/K/IiCjLw7xRZnkNUg1zfGJVjoWHiAW0VkGqID4bxFvDIq/LBBkZR+P28g3p1Lg==
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr8486628wma.119.1574331529928;
        Thu, 21 Nov 2019 02:18:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id t134sm2468758wmt.24.2019.11.21.02.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:18:49 -0800 (PST)
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
Message-ID: <a7ce232b-0a54-0039-7009-8e92e8078791@redhat.com>
Date:   Thu, 21 Nov 2019 11:18:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-7-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: NdyqBLAFMX2hMosav7yxmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> +=09=09=09if (spte & PT_SPP_MASK) {
> +=09=09=09=09fault_handled =3D true;
> +=09=09=09=09vcpu->run->exit_reason =3D KVM_EXIT_SPP;
> +=09=09=09=09vcpu->run->spp.addr =3D gva;
> +=09=09=09=09kvm_skip_emulated_instruction(vcpu);

Do you really want to skip the current instruction?  Who will do the write?

> +=09=09pr_info("SPP - SPPT entry missing! gfn =3D 0x%llx\n", gfn);

Please replace pr_info with a tracepoint.

> +=09=09slot =3D gfn_to_memslot(vcpu->kvm, gfn);
> +=09=09if (!slot)
> +=09=09=09return -EFAULT;

You want either a goto to the misconfig case, so that there is a warn

> +=09=09spp_info.base_gfn =3D gfn;
> +=09=09spp_info.npages =3D 1;
> +
> +=09=09spin_lock(&vcpu->kvm->mmu_lock);
> +=09=09ret =3D kvm_spp_get_permission(vcpu->kvm, &spp_info);
> +=09=09if (ret =3D=3D 1) {

Can you clarify when ret will not be 1?  In this case you already have a
slot, so it seems to me that you do not need to go through
kvm_spp_get_permission and you can just test "if
(kvm->arch.spp_active)".  But then, spp_active should be 1 if you get
here, I think?

> +=09pr_alert("SPP - SPPT Misconfiguration!\n");
> +=09return 0;


pr_alert not needed since you've just warned.

Paolo

