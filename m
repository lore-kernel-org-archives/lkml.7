Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D01C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE9222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLQtEiSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfKSNZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:25:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbfKSNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574169945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuIFrepTI5XGjnmu7SZRBXm2ypngTSYro2lLoyi+D9U=;
        b=JLQtEiSI+NwnDBeKKHxGV7Dn6VNrdnoyJjvOcG08/jhiAad552Dw2oWGSfk9jyK1rZ09MD
        in5WpOznWffBqUBfz+Q6RFJClDxegOI4sIIcoDZRSUh/Sf+jIFJvUleQZkMjTHTJXqnyNK
        EL24j8nv+9mM1AY4CYwA00kiMTnj+Lg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-LaAHyvGnOVuYRfY2r0REjw-1; Tue, 19 Nov 2019 08:25:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so18230228wrs.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UWribs4bV+tz4KZQ/7HRXELXyhGEq0/rpuN5CPg+cLU=;
        b=CXCJZLOqlZeAt/nwsa2ZU0FK2WzCOIMDvta4fSXkyvTkEqGKaG9BX9iCnLDS+UZd9C
         Y3n9mpe26b9RA2V9hO7UqX0vzrenKO1Do0Z4GysKrHOK8l5ePqss6HNnUdkHo7rmwg1o
         n9/KaD1AdmAzf6WexxVJpx3OXKIdqGzETIDGy85oNts81zy+cizLV4EgwuUWO17WCBbC
         Nb5TxWhPxaoSyCUFXxxYjIhUi685UQbnxsGiZx6iZ2A7H+6bXmIIuutI+ASmcuQ0bZT/
         zQKYiD2C0L4w38CFGrf7GTQPt9QWa/HANyZcpqmRf7nFwOFdFum0j9r+PafG1LscK0c/
         Eo6Q==
X-Gm-Message-State: APjAAAUEvQDf2DI86AkirUVvjuusXL90IAUqlT/lfVZpWooKTaC1VoiL
        n5o9nn1iu2Dmv6RBtpF5ceGQcswklPV593CQTNMKu3DXY6/U24H3bHeea9XV+OhEYKIPr/PhTXN
        9+1UztAYKjM8GknPVApfrEWOf
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr26061342wrx.310.1574169942739;
        Tue, 19 Nov 2019 05:25:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyt0XLcdpHWEe/n4GPIDIIm1F1+q8ZirrEBw+e15nvX+SUzCfY2GLvuKgW2pCfMt5pAjJsTA==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr26061309wrx.310.1574169942433;
        Tue, 19 Nov 2019 05:25:42 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u13sm2968880wmm.45.2019.11.19.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 05:25:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mao Wenan <maowenan@huawei.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] KVM: x86: remove set but not used variable 'called'
In-Reply-To: <20191119123956.GC5604@kadam>
References: <20191119030640.25097-1-maowenan@huawei.com> <87o8x8gjr5.fsf@vitty.brq.redhat.com> <20191119121423.GB5604@kadam> <87imnggidr.fsf@vitty.brq.redhat.com> <20191119123956.GC5604@kadam>
Date:   Tue, 19 Nov 2019 14:25:40 +0100
Message-ID: <87a78sgfqj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: LaAHyvGnOVuYRfY2r0REjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Tue, Nov 19, 2019 at 01:28:32PM +0100, Vitaly Kuznetsov wrote:
>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>>=20
>> > On Tue, Nov 19, 2019 at 12:58:54PM +0100, Vitaly Kuznetsov wrote:
>> >> Mao Wenan <maowenan@huawei.com> writes:
>> >>=20
>> >> > Fixes gcc '-Wunused-but-set-variable' warning:
>> >> >
>> >> > arch/x86/kvm/x86.c: In function kvm_make_scan_ioapic_request_mask:
>> >> > arch/x86/kvm/x86.c:7911:7: warning: variable called set but not
>> >> > used [-Wunused-but-set-variable]
>> >> >
>> >> > It is not used since commit 7ee30bc132c6 ("KVM: x86: deliver KVM
>> >> > IOAPIC scan request to target vCPUs")
>> >>=20
>> >> Better expressed as=20
>> >>=20
>> >> Fixes: 7ee30bc132c6 ("KVM: x86: deliver KVM IOAPIC scan request to ta=
rget vCPUs")
>> >>=20
>> >
>> > There is sort of a debate about this whether the Fixes tag should be
>> > used if it's only a cleanup.
>> >
>>=20
>> I have to admit I'm involved in doing backporting sometimes and I really
>> appreciate Fixes: tags. Just so you know on which side of the debate I
>> am :-)
>
> But we're not going to backport this hopefully?
>

In case we're speaking about stable@ kernels, 7ee30bc132c6 doesn't look
like a good candidate (to me) but who knows, it may get pulled in
because of some code dependency or some other 'autosel magic'. And
that's when 'Fixes:' tags become handy.

--=20
Vitaly

