Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DACC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0DB215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dudrmnfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJDHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:22:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729548AbfJDHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570173765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=ZZFTUGEUKAOtLqz6071gHP1dbpBLVQ8hfKF55tUq/KQ=;
        b=dudrmnfWDZfvhgo17RR3h8JfPkFMsvD3yDqgJeSt/s+dTZPnULwpBnCqq/v/cBqjc73SWY
        c329r3/lBQbinPP8awTW7osqObt7aFAAjqVR9NBvo7VRqLa27D2sStk0AqsZ8VfkzVxiMJ
        F1nO1S1PBStrWhzT3pspNZrktUGG+XM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-BNVYoja6Mj-SFHpO4z-qPA-1; Fri, 04 Oct 2019 03:22:44 -0400
Received: by mail-wr1-f72.google.com with SMTP id f3so2279899wrr.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 00:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILNTMth44lhyhVxp81yLHyMCFOzyjpLW4hR5n2e7NXY=;
        b=EeK1rWDH6C6GU+2/AeF7WGbn2lh/1B5tzlgcXYMPs5eHxSPVdScxuw5dtFl3HBb5De
         QSWFWHMmnGU1ISntkWvgbTgYO4Za564F5KgEVJaA74HDL/X1J2lB0xr1KkStdy1RF8+3
         g/n3HXLvJp6DqPHyED+PZS+a3uuDliaLKFzbi8KEAisAm2XyNsQqr23fsx22RTWbkyk+
         vswkti/M0BOhHAdCvHVqiNQ6+YnheS8/dqg/mPlcPWTp1KL7Ky+XfXDIRWm4e+06PkK3
         r3zqOS94ysIdl/KCcTlwjK+Tkp4I0DDMH7G4k6GjpY0Y2m8hr+8cVSfA+L25H835h+BX
         DPgw==
X-Gm-Message-State: APjAAAXxfvQqyNkzOLKazk/L3DOur8agSCwX+ZpGFicdT/nNMDxKUEcY
        4utReWouxFY2Q5BxXxv2seChI94Iz4ccC75douNQ4mV+0XcV0OIYvppiud6y/hfntLtMOm83h2r
        JovTmzAzmeYYtYby2nD2FKgpz
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr10778929wrw.314.1570173763355;
        Fri, 04 Oct 2019 00:22:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEDGvpXlmcBz9oOFWe0DyzE8bVjNOqBDdH/xvILz6ksCyS5v4csWDZufvLcv4gql6PnY37oA==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr10778904wrw.314.1570173763052;
        Fri, 04 Oct 2019 00:22:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e56d:fbdf:8b79:c79c? ([2001:b07:6468:f312:e56d:fbdf:8b79:c79c])
        by smtp.gmail.com with ESMTPSA id r20sm9288291wrg.61.2019.10.04.00.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 00:22:42 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] XOM for KVM guest userspace
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        luto@kernel.org, peterz@infradead.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, deneen.t.dock@intel.com
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bc025a4f-2128-24ed-e5b7-76802f22cd53@redhat.com>
Date:   Fri, 4 Oct 2019 09:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
Content-Language: en-US
X-MC-Unique: BNVYoja6Mj-SFHpO4z-qPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 23:23, Rick Edgecombe wrote:
> Since software would have previously received a #PF with the RSVD error c=
ode
> set, when the HW encountered any set bits in the region 51 to M, there wa=
s some
> internal discussion on whether this should have a virtual MSR for the OS =
to turn
> it on only if the OS knows it isn't relying on this behavior for bit M. T=
he
> argument against needing an MSR is this blurb from the Intel SDM about re=
served
> bits:
> "Bits reserved in the paging-structure entries are reserved for future
> functionality. Software developers should be aware that such bits may be =
used in
> the future and that a paging-structure entry that causes a page-fault exc=
eption
> on one processor might not do so in the future."
>=20
> So in the current patchset there is no MSR write required for the guest t=
o turn
> on this feature. It will have this behavior whenever qemu is run with
> "-cpu +xo".

I think the part of the manual that you quote is out of date.  Whenever
Intel has "unreserved" bits in the page tables they have done that only
if specific bits in CR4 or EFER or VMCS execution controls are set; this
is a good thing, and I'd really like it to be codified in the SDM.

The only bits for which this does not (and should not) apply are indeed
bits 51:MAXPHYADDR.  But the SDM makes it clear that bits 51:MAXPHYADDR
are reserved, hence "unreserving" bits based on just a QEMU command line
option would be against the specification.  So, please don't do this and
introduce an MSR that enables the feature.

Paolo

