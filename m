Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213C206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6eDGvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLCQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:21:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41442 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726330AbfLCQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575390116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krr7ZwxuAitCp24WVDOUedZ/Q7sKuIWyB1AA5BQo0EE=;
        b=MF6eDGvB00E3ILHQgVrxZsx7PlKMgM65N9uglVegZcJUo47HDztjNxWTqDqEo1M+c2g6Sp
        cxUQAZfqb2DKS9Uwc2XQon8VBcTi7OXuZy11uozyk3GHTmR58rg/D6S9M3Uk3lwOzSWWhJ
        J5fifXNv7MHXc946rJfotfbYssYf2M4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-l4XJTMoMOEi2dnXyjt8vZQ-1; Tue, 03 Dec 2019 11:21:53 -0500
Received: by mail-qt1-f197.google.com with SMTP id h14so1114553qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBbNGfvUlTYS0yIz8xLqE+mI2O2biBkly1Uwosv+Za8=;
        b=f8kJrd4CNhip4tQ75Kg58eApKJl9tevm5ZQC4TSirUYw99Y41ptow/ql033HVJEZZw
         LDsdGszf905JrL5gk3VLxycPkLu7wc1gd9UkrhJn53L8J6JatQvlIcaJQ1hLKMW4la9/
         1Txq4kQN0/agyRtKG+SwfqOmvt1SSi2f6paROVzN05HXCnhlQDSgpPcw2siyT3ocBSWF
         b9oMp3shxtkq9t6ynKE6VQjZXoFhGuBFILhy3B6wjMjdMCcwZXOSJd/mQjvvyf3YJ+OV
         EMO5kb6NGmCGjl+hyduAvxPuZCNU5oKRWmWCMrN0kw5SJu9RrpAKzr76GrBl7IK4Ognh
         Ijpw==
X-Gm-Message-State: APjAAAV6QOcVcG6lt3p+KmW8Y5gydNeIVCr5mIop1uXpsgRemXciXhGw
        JgXGlDYvcsp6vWRIYHrBu6Wer84aErOE3B9A7mq3ygC9zKVqpuLeQgisGNfrjPiQIyodOnmmGF7
        AAeCc3xxHx73ZgKHYJdka+wF1
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr5917403qkk.491.1575390112972;
        Tue, 03 Dec 2019 08:21:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+ctfQIoW78w8OdbCo+kvI8ncqL4KHBecGiT6GAly/K7HMAi0YO7NohD2Vyk8qsxsJQy1OLQ==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr5917372qkk.491.1575390112700;
        Tue, 03 Dec 2019 08:21:52 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h203sm2024678qke.90.2019.12.03.08.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:21:52 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:21:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] KVM: X86: Drop KVM_APIC_SHORT_MASK and
 KVM_APIC_DEST_MASK
Message-ID: <20191203162150.GC17275@xz-x1>
References: <20191202201314.543-1-peterx@redhat.com>
 <20191202201314.543-5-peterx@redhat.com>
 <87tv6hbl7v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87tv6hbl7v.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: l4XJTMoMOEi2dnXyjt8vZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:19:16PM +0100, Vitaly Kuznetsov wrote:
> > @@ -4519,9 +4519,9 @@ static int avic_incomplete_ipi_interception(struc=
t vcpu_svm *svm)
> >  =09=09 */
> >  =09=09kvm_for_each_vcpu(i, vcpu, kvm) {
> >  =09=09=09bool m =3D kvm_apic_match_dest(vcpu, apic,
> > -=09=09=09=09=09=09     icrl & KVM_APIC_SHORT_MASK,
> > +=09=09=09=09=09=09     icrl & APIC_SHORT_MASK,
> >  =09=09=09=09=09=09     GET_APIC_DEST_FIELD(icrh),
> > -=09=09=09=09=09=09     icrl & KVM_APIC_DEST_MASK);
> > +=09=09=09=09=09=09     icrl & APIC_DEST_MASK);
> > =20
> >  =09=09=09if (m && !avic_vcpu_is_running(vcpu))
> >  =09=09=09=09kvm_vcpu_wake_up(vcpu);
>=20
> Personal taste but I would've preserved KVM_ prefix. The patch itself
> looks correct, so

KVM apic uses apicdefs.h a lot, so I was trying to match them (APIC_*)
with it.

>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks for the reviews,

--=20
Peter Xu

