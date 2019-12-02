Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E352071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn08Nirf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLBWkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:40:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbfLBWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575326440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwCovQ1A2FIuM4qGkGFZtb5WeOCUje3jnQT4pB8ARrA=;
        b=Mn08NirfqtBIoTt+22IJb0WDQpmiRj+Mk1Q/y/xpzwBpGXEmolK9NQnv/aCJPQev2yHbf5
        lVa4b0V974cWnSzWvklZTiyyKNArre/cE8kzR3/VNxEqwpNBfa5BCNSvIXFPFXIm7+qVpx
        c/pB9BgJ8JSbpjVXk3x17KlKA+d0Bc0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-xLTYbVsjPT2jmUjaQ1GSiA-1; Mon, 02 Dec 2019 17:40:38 -0500
Received: by mail-qv1-f72.google.com with SMTP id d38so849838qvc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 14:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A88TYrr+6QOTlvqShlweWdE3g666CkKb/QVajbFrpQI=;
        b=nkPPCjoNK1w7g5kZLXRvVDwUCp3uwixIoUVFZP8yBVbRsr8Ipsugr2W/qFekcvb9UP
         Rg8aXqbf7+YAIZUhMijcSTMO2jK5uZnXgXGRPKZ/RBN75mm79Vhi/Re7nJnFAnHF/Pk0
         C0Gv5N8TLpRW8M2YGYY7xqbyWaehCmSKAqD+DAPW9IoaoXOby+OzBTwLJ2Mg1hmeYbZw
         X2Ye2643xq2l6X3ciKk2zTpgrodDNV1iV9+8DT4zrXPDcqk3cGXKMEsUxgSBOyRFvrAW
         Ew1WEhDaRiMJovzwMIDFzOakO4re/Ixe5LY2bPHdldqBMErppvKag51NVSwRytzYaL10
         kyNQ==
X-Gm-Message-State: APjAAAVmgWoi7zO6XAc5zj77EWer+QUAFz4vC+fLU9/YejEjoDDEhVCv
        3XmsWjzdt/tksLlmT52HbxD93FYEgjWifqpgZCFdx+H3vwyoQO/O4fkf8Ocurr4PyIV5DW9BbAc
        f+Amn2ks1Unt0GoXrhYGAcO/G
X-Received: by 2002:ac8:2632:: with SMTP id u47mr2029168qtu.54.1575326437883;
        Mon, 02 Dec 2019 14:40:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0JXhcvRX7e044tXudZta8UN6SWffpQCBnM5ZwWBduteqD4RVUl21bTGrSw2DHFn+vpV/4cA==
X-Received: by 2002:ac8:2632:: with SMTP id u47mr2029148qtu.54.1575326437538;
        Mon, 02 Dec 2019 14:40:37 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
        by smtp.gmail.com with ESMTPSA id o10sm519593qtp.38.2019.12.02.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 14:40:36 -0800 (PST)
Date:   Mon, 2 Dec 2019 17:40:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 03/15] KVM: Add build-time error check on kvm_run size
Message-ID: <20191202224034.GH31681@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-4-peterx@redhat.com>
 <20191202193027.GH4063@linux.intel.com>
 <20191202205315.GD31681@xz-x1>
 <20191202221949.GD8120@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191202221949.GD8120@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: xLTYbVsjPT2jmUjaQ1GSiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 02:19:49PM -0800, Sean Christopherson wrote:
> On Mon, Dec 02, 2019 at 03:53:15PM -0500, Peter Xu wrote:
> > On Mon, Dec 02, 2019 at 11:30:27AM -0800, Sean Christopherson wrote:
> > > On Fri, Nov 29, 2019 at 04:34:53PM -0500, Peter Xu wrote:
> > > > It's already going to reach 2400 Bytes (which is over half of page
> > > > size on 4K page archs), so maybe it's good to have this build-time
> > > > check in case it overflows when adding new fields.
> > >=20
> > > Please explain why exceeding PAGE_SIZE is a bad thing.  I realize it'=
s
> > > almost absurdly obvious when looking at the code, but a) the patch it=
self
> > > does not provide that context and b) the changelog should hold up on =
its
> > > own,
> >=20
> > Right, I'll enhance the commit message.
> >=20
> > > e.g. in a mostly hypothetical case where the allocation of vcpu->run
> > > were changed to something else.
> >=20
> > And that's why I added BUILD_BUG_ON right beneath that allocation. :)
>=20
> My point is that if the allocation were changed to no longer be a
> straightforward alloc_page() then someone reading the combined code would
> have no idea why the BUILD_BUG_ON() exists.  It's a bit ridiculous for
> this case because the specific constraints of vcpu->run make it highly
> unlikely to use anything else, but that's beside the point.
>=20
> > It's just a helper for developers when adding new kvm_run fields, not
> > a risk for anyone who wants to start allocating more pages for it.
>=20
> But by adding a BUILD_BUG_ON without explaining *why*, you're placing an
> extra burden on someone that wants to increase the size of kvm->run, e.g.
> it's not at all obvious from the changelog whether this patch is adding
> the BUILD_BUG_ON purely because the code allocates memory for vcpu->run
> via alloc_page(), or if there is some fundamental aspect of vcpu->run tha=
t
> requires it to never span multiple pages.

How about I add a comment above it?

  /*
   * Currently kvm_run only uses one physical page.  Warn the develper
   * if kvm_run accidentaly grows more than that.
   */
  BUILD_BUG_ON(...);

Thanks,

--=20
Peter Xu

