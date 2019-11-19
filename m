Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F53C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5574221850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLkWeI8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfKSM07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:26:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726555AbfKSM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574166416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3mOxYKpBUtrD3Eqhq7wj1DaBWOdzGNG7B02AqP8/hk=;
        b=NLkWeI8ucX14T04b25xPQAKDIVsvWm9r1sJU41iuRVI49PqH1o5Ad4zOpTPB4kSmeM9SAX
        IBhDlH60NDojRgnI0GooYVT/1Dspzp9W36KkyyY1yj6iDGhsLvB3VeQjhmjtPXyRo20jUg
        NR8RdD0j920ad7nYgX41fxKb6tQKcbg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186--gp4uBufNUSA0e-H8apqKw-1; Tue, 19 Nov 2019 07:26:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id p4so18100002wrw.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 04:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=awmu6I9Y99dmJSWRPIQLmc8tQlVRK2cI0mOpA3pzvDw=;
        b=Zy+SYI1hkaWUcjnIOr2TN+QGkGx1tsC/91RKEgbpGkN502aX1wtLm3BNuoovfT1FYZ
         AeHnrmqWV7W7cvB6g30M/itRO6su6+1jMoGEPozcDbqFcZ5i64//blJYWlufG0Z21mAz
         obGZxOnQwRLKFJ6sMh4HcocS2piR2ArtHK9y+DqTdTIAY2PtiplVehE6FStVxcEgBNbY
         uvB/d7+ciWudLyoccw6PJY4bKckBJ4bRT3EHl2wgC2dA6x2eaSvEd3zzEBQTqIlGrCc1
         1NEs86/WVM/8g6DsbXk63Sb3ZzbQO+nbw7ijvSNUMCT2A/OLTrQfXksllgRM4pWunkIg
         jBow==
X-Gm-Message-State: APjAAAW1c6jAYuTUrtDu1i9Re8mCzuCFj7XjuFyWyISGIDDUxDUNNgAD
        M4RJStinFpA9Jpf3mENNG9CK0FtpTnfPTPKCEOXTyuAXUN78gF0HV2WFTouIHCnFPl5pH6hUJUR
        hvXQ8DSkY3evnqNgROcJtNhpw
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr24376672wrv.216.1574166412579;
        Tue, 19 Nov 2019 04:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzB7t6Kre2ZE9oFyNHnTMEuPPAI1X0nkDnc5BMRHHjljrglZNrSttKN8ypZKLm/cv+A52kMjQ==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr24376651wrv.216.1574166412383;
        Tue, 19 Nov 2019 04:26:52 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n13sm2816854wmi.25.2019.11.19.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:26:51 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] KVM: VMX: FIXED+PHYSICAL mode single target IPI fastpath
In-Reply-To: <CANRm+CzcWDvRA0+iaQZ6hd2HGRKyZpRnurghQXdagDCffKaSPg@mail.gmail.com>
References: <1574145389-12149-1-git-send-email-wanpengli@tencent.com> <87r224gjyt.fsf@vitty.brq.redhat.com> <CANRm+CzcWDvRA0+iaQZ6hd2HGRKyZpRnurghQXdagDCffKaSPg@mail.gmail.com>
Date:   Tue, 19 Nov 2019 13:26:51 +0100
Message-ID: <87lfscgigk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: -gp4uBufNUSA0e-H8apqKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> On Tue, 19 Nov 2019 at 19:54, Vitaly Kuznetsov <vkuznets@redhat.com> wrot=
e:
>>
>> Wanpeng Li <kernellwp@gmail.com> writes:
>>
>> > From: Wanpeng Li <wanpengli@tencent.com>
>> >
>> > +     if (lapic_in_kernel(vcpu) && apic_x2apic_mode(vcpu->arch.apic)) =
{
>> > +             /*
>> > +              * fastpath to IPI target, FIXED+PHYSICAL which is popul=
ar
>> > +              */
>> > +             index =3D kvm_rcx_read(vcpu);
>> > +             data =3D kvm_read_edx_eax(vcpu);
>> > +
>> > +             if (((index - APIC_BASE_MSR) << 4 =3D=3D APIC_ICR) &&
>>
>> What if index (RCX) is < APIC_BASE_MSR?
>
> How about if (index =3D=3D (APIC_BASE_MSR + 0x300) &&
>

What about ' << 4', don't we still need it? :-) And better APIC_ICR
instead of 0x300...

Personally, I'd write something like

if (index > APIC_BASE_MSR && (index - APIC_BASE_MSR) =3D=3D APIC_ICR >> 4)

and let compiler optimize this, I bet it's going to be equally good.

--=20
Vitaly

