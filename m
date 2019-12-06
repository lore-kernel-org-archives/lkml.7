Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42829C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E6020659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h35bHDNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFJ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:58:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbfLFJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575626337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0F+lzQ0icwJGjPRIoluqter/tV86KGOaRnZsDGwu88Y=;
        b=h35bHDNtETnJ0xyMOf5UkPFXfa0t/EoCjb6uUTExozsGq6r3OtxJAPar4IAoE0ZSzH39mt
        IuyCw7w+YYR9EmnsQWiLDmF898yN1iiiK1CF6wp65xvm/7Ztuw7ijXFfK6DrUiiT6pMJNE
        uhqV+9hNi92DjfQhU9ho5wMIm/y9/bI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-fNiMlqAnO3ixfuXeQHV3RQ-1; Fri, 06 Dec 2019 04:58:56 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so2883878wrm.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cpaQm+0+937DKjCOTLRMzPIARAMl3LKNy0NaEqKVcw=;
        b=DVYBmQi1rZpfV+i/bsfVViXsDlSn6H6bOvMKBPn0WtmCn3cIxLTFW2DVac27MHObh4
         paFzsc1jS7ZwVwBMiLqs/EM9KRMW06X4jcBHR6WX9vzisXQqLBPkwoJ9uqyrXnQhVLGU
         3hBre+5yNMdsmd6AnqwA/3hMhCtTTPRymdzno0t3vzpuktKtG78GisEq7hcw8xcR+P3b
         xe1KqDkdsRuAnGVpF6y9EnakyJnhO7ZUIqwZDpJ29mOkY52AeoG5vjn20eU6HlQqhfcE
         61UAcBuJnZop2aj+j3USClEFBrIRNr735CkmItJ4PjORzpukNd1idB3z3Fhw2Hc+XgUs
         xpog==
X-Gm-Message-State: APjAAAXo/hVlte2kP+AXkir5zZUNgXkCp1bxA0/n1IjbyauD3XmOa5c8
        tSiDd9Cxfdq61cLV1VbzNe5g2IX1BnAKvuWpp9qo02j9jnlyPxr0SrERz0XXbZIKaw9GqdHlChx
        eHL6/Xc2oOiHHWDgi92hqE17H
X-Received: by 2002:a5d:6048:: with SMTP id j8mr14780036wrt.41.1575626335374;
        Fri, 06 Dec 2019 01:58:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAezlll6D3MHh/Vw7ZdARixd/jtxnH59A2S8YY3RSIVP/dx+eZEXyTv/h9t/gVpui8sdd/Qg==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr14780004wrt.41.1575626335092;
        Fri, 06 Dec 2019 01:58:55 -0800 (PST)
Received: from [10.201.49.168] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id z8sm15558731wrq.22.2019.12.06.01.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 01:58:53 -0800 (PST)
Subject: Re: [PATCH] KVM: vmx: remove unreachable statement in
 vmx_get_msr_feature()
To:     linmiaohe <linmiaohe@huawei.com>, Wanpeng Li <kernellwp@gmail.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <6c7423896f6f49f2a2b439afe809db08@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7b20a96-0b75-32a4-0448-30c6061fc6cb@redhat.com>
Date:   Fri, 6 Dec 2019 10:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6c7423896f6f49f2a2b439afe809db08@huawei.com>
Content-Language: en-US
X-MC-Unique: fNiMlqAnO3ixfuXeQHV3RQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 04:41, linmiaohe wrote:
> Wanpeng Li <kernellwp@gmail.com> wrote:
>>>
>>>>
>>>> I personally just prefer to remove the =E2=80=9Cdefault=E2=80=9D case =
and change this =E2=80=9Creturn 0;=E2=80=9D to =E2=80=9Creturn 1;=E2=80=9D.
>>>> But it=E2=80=99s a matter of taste of course.
>>>>
>>> Yes. As what " Turnip greens, all have love " said. ^_^
>>
>> Actually it is a great appreciated to introduce something more useful in=
stead of tons of cleanups, I saw guys did one cleanup and can incur several=
 bugs before.
>>
> I'd like to introduce something more useful, but side corner cleanups may=
 be hard to
> found out something to introduce. And such cleanups can also be validated=
 by code inspection
> to avoid something bad. Many thanks.
>=20

Yeah, I think you have been doing a good job.  Usually, when the
cleanups introduce bugs there are many other "suspicious" things.  For
me it's clear that you're learning the code and not just messing around.

Paolo

