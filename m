Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00796C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C562320675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0hns1Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfLDSst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:48:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbfLDSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575485327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4AOyFS7+D4FhhTpdjL37PUMrrBBkYmpN5co4ha1RY8=;
        b=J0hns1Hj92loK8D6dX3j3qFxfxdNclprtfB86+mcM6NjdSeqRO2x7TnLFEihWic2yZW4x/
        HF2lUQswtxi37tA6B9B6EQpaK2E0Gq+qwKNZVNfrn0D/dKckNCeEROWMJP3Z7Ee4mAeflL
        CR3/LlkaZPVcMpvUb8lHtljFnUfKsb8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-JX_GfQRnN6Ouzna1jXcBEQ-1; Wed, 04 Dec 2019 13:48:46 -0500
Received: by mail-qt1-f199.google.com with SMTP id q17so576652qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMp6tLzNoP1+pwDQEtsvP5wdwSsl9VcVUyq5Q7+GZQ0=;
        b=QVILaqOxUpcNLr5EbqBr8oLkogvbEOeROkvMitk2WSn2LXBPkuaFe42LrmdlpLhrBM
         DRlnVGuUyADk31Ir7RVSwupVubJ5qWkrlS3J+VfEf6QaK9pnIKvI9BHWm9ta/w9cvhMa
         PVtdSpGjenJyPdJa/K1w87q0HoI2hGmtZz64n4BzKkkGS0Q8HcKvpK/XMXy/LfXd61l/
         VakVVBGX6naWSCJBSRZx4hJhRECCcrSm9Pfw0vL/GUBdV+bwUH8RqcbmbSRUK9F+B/ZC
         kasMIIwJ2KI50iD8utlQuWrBkcHWxi+Busw526TKBD+32ozRqK3tvU+nv9Rkg9LLWyH5
         Q4pA==
X-Gm-Message-State: APjAAAWAPkgToWOxB8mMIIIIZlCkHrrFLzB5xfmNb2LD7g8/rXM0U9Bg
        mD379hQXEjwqLi1geN/8vkUhQbYHtvl+8TyDtxVfrH2jVocMXWH08RNDbMwFSmsBTHsGTQtLCja
        GsdOAQHRGGoiJcZIbNO0kZv7V
X-Received: by 2002:a05:620a:2094:: with SMTP id e20mr3944847qka.415.1575485326173;
        Wed, 04 Dec 2019 10:48:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiJyJa8neSnXDhV+jOnH/y9B9gMOIPLiIEQnc6q9WbiSvu9A5l5lpBJ7/5aZLvRVtDkzOfTw==
X-Received: by 2002:a05:620a:2094:: with SMTP id e20mr3944817qka.415.1575485325874;
        Wed, 04 Dec 2019 10:48:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 3sm4193045qth.2.2019.12.04.10.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:48:45 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:48:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 3/6] KVM: X86: Use APIC_DEST_* macros properly in
 kvm_lapic_irq.dest_mode
Message-ID: <20191204184844.GA19939@xz-x1>
References: <20191203165903.22917-1-peterx@redhat.com>
 <20191203165903.22917-4-peterx@redhat.com>
 <20191203220752.GJ19877@linux.intel.com>
 <20191203221519.GI17275@xz-x1>
 <20191203222036.GL19877@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191203222036.GL19877@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: JX_GfQRnN6Ouzna1jXcBEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:20:36PM -0800, Sean Christopherson wrote:
> On Tue, Dec 03, 2019 at 05:15:19PM -0500, Peter Xu wrote:
> > On Tue, Dec 03, 2019 at 02:07:52PM -0800, Sean Christopherson wrote:
> > > On Tue, Dec 03, 2019 at 11:59:00AM -0500, Peter Xu wrote:
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm=
/kvm_host.h
> > > > index b79cd6aa4075..f815c97b1b57 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -1022,6 +1022,11 @@ struct kvm_lapic_irq {
> > > >  =09bool msi_redir_hint;
> > > >  };
> > > > =20
> > > > +static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode)
> > > > +{
> > > > +=09return dest_mode ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> > >=20
> > > IMO this belongs in ioapic.c as it's specifically provided for conver=
ting
> > > an I/O APIC redirection entry into a local APIC destination mode.  Wi=
thout
> > > the I/O APIC context, %true=3D=3DAPIC_DEST_LOGICAL looks like a compl=
etely
> > > arbitrary decision.  And if it's in ioapic.c, it can take the union
> > > of a bool, which avoids the casting and shortens the callers.  E.g.:
> > >=20
> > > static u64 ioapic_to_lapic_dest_mode(union kvm_ioapic_redirect_entry =
*e)
> > > {
> > > =09return e->fields.dest_mode ?  APIC_DEST_LOGICAL : APIC_DEST_PHYSIC=
AL;
> > > }
> > >=20
> > > The other option would be to use the same approach as delivery_mode a=
nd
> > > open code the shift.
> >=20
> > It's also used for MSI address encodings, please see below [1].
>=20
> Boooh.  How about naming the param "logical_dest_mode" or something else
> with "logical" in the name so that the correctness of the function itself
> is apparent?

Ok, will do.  Thanks,

--=20
Peter Xu

