Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7FC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CF921A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHbZNThA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKLKTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:19:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22569 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfKLKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573553991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=7i9+SK3hpwTsCv7dTE1Okd0YAcSg1MeSopDF9z7WqQ4=;
        b=cHbZNThAL9p+C0w7EKjJlDaChoJSfIUdBDdrqL1kq+sMq3ffy4GD/lHrA2j39vd63zJmoo
        5i33A3CZNh6J48G6F59xf8YWDAnGdzYXZrgMrJ/hrfcHlf+qL+SxMbyLjmvcXyH8RlRBTp
        hIiPOSdfpWNsSgGAUcMTQQSK0JHWF1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-mjBWfmhSNNS8aGiqHkAVtQ-1; Tue, 12 Nov 2019 05:19:46 -0500
Received: by mail-wr1-f70.google.com with SMTP id e10so9137871wrt.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YFkdWT01jyLgEtqFcC61NZ98AMX6STuxDrkyGOC4EK0=;
        b=KiN5A6T1AHuH33Wq/tueMvts8vaWXz6sYUXbAzGBmyTkywDFhnJhiegEBTU/kj/l0i
         EKg/tG0N/bWr0uC+iSlYf6nu2jdQsTi7BvYMovzqFog94IKDqJ3trGclNxBiYoLCRxHr
         V20e1zZ5AKycA659JQDf9s59XDTAf8XDEUEzHskKOLjLqjJmWugqw7CDPXwvFuFDyjFv
         CG1z5NPIZ52Yunpugb4NWB0TK3goys4mAbnU2bk+3cilr3hmgS729nKIwDGH+4JQiQpl
         Qo7lD4NpCNZwmIMUPyncX/+Oyx3ZXJQoZFu7oxmUpYHU6n7Qq1ApGFBdiLMELdtckT7t
         quqg==
X-Gm-Message-State: APjAAAVHMf8RJ0Ggu0EszJKb3+zMO0ieJatwSJSJOIYVox71FDc7OY0x
        MErsgiqp1BgJ0Kv+7VrDsBu/bEBKiD26xLxPqN2A334uTWwXHwYpMxioiWSxbg43tnpj5cIgPDM
        32JzkL/0HiCBckj1WJ+Uf1S6H
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3334689wmj.84.1573553985546;
        Tue, 12 Nov 2019 02:19:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPXIlM2Wpb56oH3XhullKKBX2spmK2zk1Sp2fiUJ3jnWYwlEaUB3yJIwf8L4roR2PgBk5NiQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3334655wmj.84.1573553985266;
        Tue, 12 Nov 2019 02:19:45 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f67sm3314680wme.16.2019.11.12.02.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:19:44 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being
 reserved
To:     Dan Williams <dan.j.williams@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
References: <1cf71906-ba99-e637-650f-fc08ac4f3d5f@redhat.com>
 <CAPcyv4hMOxPDKAZtTvWKEMPBwE_kPrKPB_JxE2YfV5EKkKj_dQ@mail.gmail.com>
 <20191106233913.GC21617@linux.intel.com>
 <CAPcyv4jysxEu54XK2kUYnvTqUL7zf2fJvv7jWRR=P4Shy+3bOQ@mail.gmail.com>
 <CAPcyv4i3M18V9Gmx3x7Ad12VjXbq94NsaUG9o71j59mG9-6H9Q@mail.gmail.com>
 <0db7c328-1543-55db-bc02-c589deb3db22@redhat.com>
 <CAPcyv4gMu547patcROaqBqbwxut5au-WyE_M=XsKxyCLbLXHTg@mail.gmail.com>
 <20191107155846.GA7760@linux.intel.com>
 <20191109014323.GB8254@linux.intel.com>
 <CAPcyv4hAY_OfExNP+_067Syh9kZAapppNwKZemVROfxgbDLLYQ@mail.gmail.com>
 <20191111182750.GE11805@linux.intel.com>
 <CAPcyv4hErx-Hd5q+3+W6VUSWDpEuOfipMsWAL+nnQtZvYAf3bg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e6637be8-7890-579b-8131-6fdbbd791fa0@redhat.com>
Date:   Tue, 12 Nov 2019 11:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hErx-Hd5q+3+W6VUSWDpEuOfipMsWAL+nnQtZvYAf3bg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: mjBWfmhSNNS8aGiqHkAVtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 01:51, Dan Williams wrote:
> An elevated page reference count for file mapped pages causes the
> filesystem (for a dax mode file) to wait for that reference count to
> drop to 1 before allowing the truncate to proceed. For a page cache
> backed file mapping (non-dax) the reference count is not considered in
> the truncate path. It does prevent the page from getting freed in the
> page cache case, but the association to the file is lost for truncate.

KVM support for file-backed guest memory is limited.  It is not
completely broken, in fact cases such as hugetlbfs are in use routinely,
but corner cases such as truncate aren't covered well indeed.

Paolo

> As long as any memory the guest expects to be persistent is backed by
> mmu-notifier coordination we're all good, otherwise an elevated
> reference count does not coordinate with truncate in a reliable way.
>=20

