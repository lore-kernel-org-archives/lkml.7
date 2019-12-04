Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92503C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6035320659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL90buFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLDLmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:42:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727452AbfLDLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575459733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGvj6ScV5HRsAf/wEpebkBxHs1qEjrfPikT5XgQ7RxY=;
        b=GL90buFCDi5EZ/7HZjwyH9i02RaJBUXN3DflM0tO3rYSvjj9iVKqFpud9If03FE7yFsUm4
        slKgiQ0tCmWHhqeRg3YtgFaobkVVN9hNxue4gcKZX1XmAnl2s5pGV3Enks9VDsRp9eiN9K
        vjS3wZAFAzyCO/LzaH2QO2eCfS4tNvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-mUikjEIFPieC40oonjWPZA-1; Wed, 04 Dec 2019 06:42:09 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so3485992wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gGvj6ScV5HRsAf/wEpebkBxHs1qEjrfPikT5XgQ7RxY=;
        b=t8mk2iuVHu8PH3G8xnA0ztHlfHMmqyLQraDbtwCRzmPofnljdyWVXFZMB+Fk0Ly28L
         qcRqiTEtxW3FCJiTImiDcIybUzEHk9S624aQVoDaL1p3R1kOkCkLbF5JhbNl7xPy4Au1
         dy5VuYhAcLjjwudFC21Jxz26QOQcGzXoi3BM+ODAloQBlY3Uq/h3zFZsCiB3k7575vZ5
         8m5NK6vBQvitaEWDtl+s+w6tDJrB7yV2BN7pVmh+J8Bw0Dx9+sTuk0MQ4J7RkGCIBSVF
         q6fn4hEcf2cD2lwfu6si08FlfxAjsiLlT9/GVzRAaMJDldD4NvGQi7PVgwmzfbOe51AR
         Z+Vw==
X-Gm-Message-State: APjAAAWG2ZLm+NgX/PPYk2iaiGWkpnf6lL8tmJCv7tJ2PNEPMH4z+7A8
        +tyL/2oP++kNGSMZIRltGMjJ6CS4AHaLeT/Y7taqPeK+n3NerNgXkCRxu3D2T7gskhCbr/YxMva
        n4h3yIgbCyRWGCQ9O0a49V+iN
X-Received: by 2002:adf:f491:: with SMTP id l17mr3457292wro.149.1575459728824;
        Wed, 04 Dec 2019 03:42:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwI3D6OXmuQavmjiI4EUh2AsnPcFg9OYIPq92kRLWefqRekueiLpkOmgD3MwTzX6W+O+gwKyw==
X-Received: by 2002:adf:f491:: with SMTP id l17mr3457258wro.149.1575459728512;
        Wed, 04 Dec 2019 03:42:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id z185sm6583513wmg.20.2019.12.04.03.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 03:42:07 -0800 (PST)
Subject: Re: [PATCH 4.19 067/306] KVM: nVMX: move check_vmentry_postreqs()
 call to nested_vmx_enter_non_root_mode()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Wang <jack.wang.usish@gmail.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Sasha Levin <sashal@kernel.org>
References: <20191127203114.766709977@linuxfoundation.org>
 <20191127203119.676489279@linuxfoundation.org>
 <CA+res+QKCAn8PsSgbkqXNAF0Ov5pOkj=732=M5seWj+-JFQOwQ@mail.gmail.com>
 <20191202145105.GA571975@kroah.com>
 <bccbfccd-0e96-29c3-b2ba-2b1800364b08@redhat.com>
 <CA+res+SffBsmmeEBYfoDwyLHvL8nqW+O=ZKedWCxccmQ9X6itA@mail.gmail.com>
 <828cf8b7-11ac-e707-57b6-cb598cc37f1b@redhat.com>
 <CA+res+Qo1mX_UFEqDD+sm80PZeW4bRN8VZeNudMDaQ=5-Ss=0g@mail.gmail.com>
 <1387d9b8-0e08-a22e-6dd1-4b7ea58567b3@redhat.com>
 <20191203191655.GC2734645@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <835e996b-711e-f6fb-a489-db3899c053a2@redhat.com>
Date:   Wed, 4 Dec 2019 12:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203191655.GC2734645@kroah.com>
Content-Language: en-US
X-MC-Unique: mUikjEIFPieC40oonjWPZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 20:16, Greg Kroah-Hartman wrote:
> On Tue, Dec 03, 2019 at 01:52:47PM +0100, Paolo Bonzini wrote:
>> On 03/12/19 13:27, Jack Wang wrote:
>>>>> Should we simply revert the patch, maybe also
>>>>> 9fe573d539a8 ("KVM: nVMX: reset cache/shadows when switching loaded VMCS")
>>>>>
>>>>> Both of them are from one big patchset:
>>>>> https://patchwork.kernel.org/cover/10616179/
>>>>>
>>>>> Revert both patches recover the regression I see on kvm-unit-tests.
>>>> Greg already included the patches that the bot missed, so it's okay.
>>>>
>>>> Paolo
>>>>
>>> Sorry, I think I gave wrong information initially, it's 9fe573d539a8
>>> ("KVM: nVMX: reset cache/shadows when switching loaded VMCS")
>>> which caused regression.
>>>
>>> Should we revert or there's following up fix we should backport?
>>
>> Hmm, let's revert all four.  This one, the two follow-ups and 9fe573d539a8.
> 
> 4?  I see three patches here, the 2 follow-up patches that I applied to
> the queue, and the "original" backport of b7031fd40fcc ("KVM: nVMX:
> reset cache/shadows when switching loaded VMCS") which showed up in the
> 4.14.157 and 4.19.87 kernels.

The fourth is commit 9fe573d539a8 ("KVM: nVMX: reset cache/shadows when
switching loaded VMCS"), which was also autoselected.

Paolo

