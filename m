Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398BC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC37F20730
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYkKWHKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfKSM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:28:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58694 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727805AbfKSM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574166517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/Tpur5Jg0w8dOS4DWpqDeh25xiVTStCvikKzJwd37M=;
        b=bYkKWHKvdQaIgFH/Uq56HDtPtBSUKPzUrpAz5Z4/7Y3MC0oZsJsfGeGC0AeI8hvi2ImnGP
        mpwu9//EwulMLc2ftyGv6/WUa4ryv1nvSZlmBTLEmwI8WpgJ2BD++eEGVh6DTWZ0ZDFqtl
        BXvPev84KEiZed/E7almc3n/4VAP6GU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-2dvqYbAkOFWfXXkIR-9kaQ-1; Tue, 19 Nov 2019 07:28:35 -0500
Received: by mail-wr1-f69.google.com with SMTP id f8so18197246wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 04:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tbeowhQzRKjB6uF0t4WazsD0mnFA+By287e2iOh8qGc=;
        b=aFGiVULo+kqajLIpQAXEETK+CLoUG11te8xJ+P/JbuHN56zA0jOhy9jUZNkeOMp1kp
         u7NFRiI16IDgyDD6dWR1g5nwcqJDhB9BJ391jNGLpBP/U3+oLQ9dCnZTsPhDmRNxwPAs
         wvWRcwWA+L8M21MHPbt7L9b2/VyEzmPuPNoej+uSoiHXIt8rwxPm3Wp618NUaslDJALI
         zkJXkTlkJmwX5uP6VyZd3hObcqu+37HrMZSluNT2owEY9clUMrHFCv+IkxTGnDswc3u3
         yqeJs6lXAP/Z9S6fNd2VS6R4omYPmtjFVQbpesQ4QJh5uUQwebNKOum+B0s0ExTHiCB8
         1oYw==
X-Gm-Message-State: APjAAAVU1diKotWoRw6PmyTDZHYSVEGKBTbLQMbdpbtgKjeI4jhmyqjO
        qmE+t4IdwUnTnhlNqN4hbi9GxXr6DbaM7aOWWN51xjWQwQ2mDlrcz2Hq8t5bF6repz7nTOnPg1a
        w93WSwYFwNHZNL/OAL/oM50A8
X-Received: by 2002:adf:f10d:: with SMTP id r13mr34941141wro.173.1574166514820;
        Tue, 19 Nov 2019 04:28:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNbb0ckuHE7IWjv7bqXQZrlL7jwUoHv2U/gZjQfxbd5CUks+dI0LHAyXvstzObqiu1EB+nTQ==
X-Received: by 2002:adf:f10d:: with SMTP id r13mr34941123wro.173.1574166514611;
        Tue, 19 Nov 2019 04:28:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i71sm29755065wri.68.2019.11.19.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:28:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mao Wenan <maowenan@huawei.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] KVM: x86: remove set but not used variable 'called'
In-Reply-To: <20191119121423.GB5604@kadam>
References: <20191119030640.25097-1-maowenan@huawei.com> <87o8x8gjr5.fsf@vitty.brq.redhat.com> <20191119121423.GB5604@kadam>
Date:   Tue, 19 Nov 2019 13:28:32 +0100
Message-ID: <87imnggidr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 2dvqYbAkOFWfXXkIR-9kaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Tue, Nov 19, 2019 at 12:58:54PM +0100, Vitaly Kuznetsov wrote:
>> Mao Wenan <maowenan@huawei.com> writes:
>>=20
>> > Fixes gcc '-Wunused-but-set-variable' warning:
>> >
>> > arch/x86/kvm/x86.c: In function kvm_make_scan_ioapic_request_mask:
>> > arch/x86/kvm/x86.c:7911:7: warning: variable called set but not
>> > used [-Wunused-but-set-variable]
>> >
>> > It is not used since commit 7ee30bc132c6 ("KVM: x86: deliver KVM
>> > IOAPIC scan request to target vCPUs")
>>=20
>> Better expressed as=20
>>=20
>> Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to targe=
t vCPUs")
>>=20
>
> There is sort of a debate about this whether the Fixes tag should be
> used if it's only a cleanup.
>

I have to admit I'm involved in doing backporting sometimes and I really
appreciate Fixes: tags. Just so you know on which side of the debate I
am :-)

--=20
Vitaly

