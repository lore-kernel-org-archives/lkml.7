Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A10C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA1E21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRK2HZDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKKNG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:06:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbfKKNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573477618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nIfQxqLHF8WJH+rEaKW6Wt3dYLJAu1w6JfOqOMD8TI=;
        b=VRK2HZDqMjCOZJaP107O+VzKJFetiqMs0fr9SNJk4neAWpK2/I4Xt17S2+xiAXuvU69j2d
        wGz8y3p7M77jXMEzvOQUnDIaAMX+9fikPhZ+5zQ/WPfxITuib/erXXczYMel3cRteBl9ev
        t38be5nXrvNe8IAv/DJajVDENDRP+tw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-22L5RAfJMgG7Pxd9cNt5QA-1; Mon, 11 Nov 2019 08:06:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id t203so6830195wmt.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 05:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4OAS54iB143xVEPD/7rq6ekQ537whRG3Ob2iaMwvFJk=;
        b=uDeX4Rj5YRP9N4kUBBeH1npu1Kwvgp4XbvFRY+4LiHN8C18CVEEwj7bCBkpeUb7HEi
         GVyI1zQjZ2pxj1AFTjVL2VTe4TgC7Px/Rg7L7aHh4kTttEg+e8vI4QRX9BhQKH31C7da
         vrOpzHeDkGCsn83Ki2+3hQ7pBSojxU3BD9WDUPXpTJkvpDBwtqOmxbbi7H16Ard2/WLw
         /4krOQ1DEHEzX7uo4fHzmXubl9qQOChuxr71YIPQdw2dptiZ6NFjw+MQDofWwtwSJu9V
         p0Aved5EMaY9r4LT3+zRnHCEarwLduRc9VL8K7vRhnMc0namq6GJPLNVnegUhc2CpVO+
         saBg==
X-Gm-Message-State: APjAAAW/J8Gv+Pt7Re9nlvPg7L9Tw0dgbN4gaDy837TTkJR5lgCUpFs0
        l1Ufy0kOlP4HcJoIIyrn7SRjB+XMI8kOPOQr/A1LtEHgrworemBnlbKEEfppHOPxR7w+ZJdoqy9
        S/LYJi9W6aphUw8D+Hml1R2+S
X-Received: by 2002:a5d:6585:: with SMTP id q5mr19749280wru.158.1573477614479;
        Mon, 11 Nov 2019 05:06:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwK2Cvl8KVfnsUhyxsRzcj2clNeIUa936ISnpCpoXkcJmOTBt3FjGd2Dp3SQ4hPmqtyC6A7zA==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr19749257wru.158.1573477614262;
        Mon, 11 Nov 2019 05:06:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w10sm13512097wmd.26.2019.11.11.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:06:53 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: X86: Single target IPI fastpath
In-Reply-To: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
References: <1573283135-5502-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 11 Nov 2019 14:06:52 +0100
Message-ID: <87mud2sgsz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 22L5RAfJMgG7Pxd9cNt5QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> +
>  static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> @@ -6615,6 +6645,12 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  =09=09=09=09  | (1 << VCPU_EXREG_CR3));
>  =09vcpu->arch.regs_dirty =3D 0;
> =20
> +=09vmx->exit_reason =3D vmx->fail ? 0xdead : vmcs_read32(VM_EXIT_REASON)=
;
> +=09vcpu->fast_vmexit =3D false;
> +=09if (!is_guest_mode(vcpu) &&
> +=09=09vmx->exit_reason =3D=3D EXIT_REASON_MSR_WRITE)
> +=09=09vcpu->fast_vmexit =3D handle_ipi_fastpath(vcpu);

I have to admit this looks too much to me :-( Yes, I see the benefits of
taking a shortcut (by actualy penalizing all other MSR writes) but the
question I have is: where do we stop?

Also, this 'shortcut' creates an imbalance in tracing: you don't go down
to kvm_emulate_wrmsr() so handle_ipi_fastpath() should probably gain a
tracepoint.

Looking at 'fast_vmexit' name makes me think this is something
generic. Is this so? Maybe we can create some sort of an infrastructure
for fast vmexit handling and make it easy to hook things up to it?

(Maybe it's just me who thinks the codebase is already too complex,
let's see what Paolo and other reviewers have to say).

--=20
Vitaly

