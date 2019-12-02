Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B5BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB522070A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtANF2Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLBXJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:09:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725834AbfLBXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575328193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oz1cQV94PxiM/G4Z+sfRgat5IvN2eDSa2rOtbBG/y8Q=;
        b=EtANF2Y2tev7dGkNYfuZHO1XIzL73eQfoodfij3QnSoJksHfLuBcHK0doEqlzjhaQwpwpi
        /7P145VXv0BleEotIHVZ3rIQ8WaEq5ke56fcSjS26V9zCKcOVkCcRhCllY/HXxyBvq2hlJ
        7DWcIMcYfS2FveveDYg3nOyMLKgwnLQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-W0guguh8NA2vsL0R1NQ1Hg-1; Mon, 02 Dec 2019 18:09:52 -0500
Received: by mail-qv1-f71.google.com with SMTP id y9so893875qvi.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9BgLL41orfOTnHN7A5fR49RzpkIGJdIaBnfhTFr7uM=;
        b=c/suXnYqXDs9AwGbXwoc+hFYpDw5IXqCOPOmCN1snhRgJCbR2cxOlUH18ImdtBRHRW
         gOa8TND8dzHmmWitjpNBTZSWJmWAT74Gu2wh2A9R8jaB+8MyBJUx57KWw1KI35/f2NfM
         Kzs/E/ir/6+kWbNSRkQkHshVOUHlONzEd1ZCvH0REjmF73LhzhmIAGAfF+kI5bc4/DXA
         EgRGh1bB2oxwv2YBg28klDdGLOoTUCHXSJGxBUdiHap8Ukhf/9ccUdbkMACw7UBgao36
         aobli8pFxjDCJmZyxMdE8jwxnCgyws/65IMoLBSf4cNITILqakoUqBeU7w37+7FwoQjb
         +l2w==
X-Gm-Message-State: APjAAAWxG5TJAWxZyEKLZgkoykMWX7/uPJ8cqG9v31kvKmIaFIL/rJxB
        ERfS//KjbHmFJW3Xch0+IPGkyOq8Xz5DAjZS/wxDYmti0CIRNpKTczOivBkI2neD4D/+MdZrMLr
        2zC2zBm1Ah84Y13IeuAb+57HO
X-Received: by 2002:ae9:e704:: with SMTP id m4mr1728809qka.153.1575328191342;
        Mon, 02 Dec 2019 15:09:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJBdXbKG+70OVb9A6rS8j4VSkatuTLwLDrgfnPaKyofNW1dVPXpxed1YOlrLiBUcYsh8+ObQ==
X-Received: by 2002:ae9:e704:: with SMTP id m4mr1728769qka.153.1575328190930;
        Mon, 02 Dec 2019 15:09:50 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
        by smtp.gmail.com with ESMTPSA id z62sm601538qtd.83.2019.12.02.15.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:09:50 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:09:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191202230948.GI31681@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com>
 <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191202215049.GB8120@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: W0guguh8NA2vsL0R1NQ1Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 01:50:49PM -0800, Sean Christopherson wrote:
> On Mon, Dec 02, 2019 at 04:16:40PM -0500, Peter Xu wrote:
> > On Mon, Dec 02, 2019 at 12:10:36PM -0800, Sean Christopherson wrote:
> > > On Fri, Nov 29, 2019 at 04:34:54PM -0500, Peter Xu wrote:
> > > > Currently, we have N+1 rings for each VM of N vcpus:
> > > >=20
> > > >   - for each vcpu, we have 1 per-vcpu dirty ring,
> > > >   - for each vm, we have 1 per-vm dirty ring
> > >=20
> > > Why?  I assume the purpose of per-vcpu rings is to avoid contention b=
etween
> > > threads, but the motiviation needs to be explicitly stated.  And why =
is a
> > > per-vm fallback ring needed?
> >=20
> > Yes, as explained in previous reply, the problem is there could have
> > guest memory writes without vcpu contexts.
> >=20
> > >=20
> > > If my assumption is correct, have other approaches been tried/profile=
d?
> > > E.g. using cmpxchg to reserve N number of entries in a shared ring.
> >=20
> > Not yet, but I'd be fine to try anything if there's better
> > alternatives.  Besides, could you help explain why sharing one ring
> > and let each vcpu to reserve a region in the ring could be helpful in
> > the pov of performance?
>=20
> The goal would be to avoid taking a lock, or at least to avoid holding a
> lock for an extended duration, e.g. some sort of multi-step process where
> entries in the ring are first reserved, then filled, and finally marked
> valid.  That'd allow the "fill" action to be done in parallel.

Considering that per-vcpu ring should be no worst than this, so iiuc
you prefer a single per-vm ring here, which is without per-vcpu ring.
However I don't see a good reason to split a per-vm resource into
per-vcpu manually somehow, instead of using the per-vcpu structure
directly like what this series does...  Or could you show me what I've
missed?

IMHO it's really a natural thought that we should use kvm_vcpu to
split the ring as long as we still want to make it in parallel of the
vcpus.

>=20
> In case it isn't clear, I haven't thought through an actual solution :-).

Feel free to shoot when the ideas come. :) I'd be glad to test your
idea, especially where it could be better!

>=20
> My point is that I think it's worth exploring and profiling other
> implementations because the dual per-vm and per-vcpu rings has a few wart=
s
> that we'd be stuck with forever.

I do agree that the interface could be a bit awkward to keep these two
rings.  Besides this, do you still have other concerns?

And when you say about profiling, I hope I understand it right that it
should be something unrelated to this specific issue that we're
discussing (say, on whether to use per-vm ring, or per-vm + per-vcpu
rings) because for performance imho it's really the layout of the ring
that could matter more, and how the ring is shared and accessed
between the userspace and kernel.

For current implementation (I'm not sure whether that's initial
version from Lei, or Paolo, anyway...), IMHO it's good enough from
perf pov in that it at least supports:

  (1) zero copy
  (2) complete async model
  (3) per-vcpu isolations

None of these is there for KVM_GET_DIRTY_LOG.  Not to mention that
tracking dirty bits are not really that "performance critical" - if
you see in QEMU we have plenty of ways to explicitly turn down the CPU
like cpu-throttle, just because dirtying pages and even with the whole
tracking overhead is too fast already even using KVM_GET_DIRTY_LOG,
and the slow thing is QEMU when collecting and sending the pages! :)

>=20
> > > IMO,
> > > adding kvm_get_running_vcpu() is a hack that is just asking for futur=
e
> > > abuse and the vcpu/vm/as_id interactions in mark_page_dirty_in_ring()
> > > look extremely fragile.
> >=20
> > I agree.  Another way is to put heavier traffic to the per-vm ring,
> > but the downside could be that the per-vm ring could get full easier
> > (but I haven't tested).
>=20
> There's nothing that prevents increasing the size of the common ring each
> time a new vCPU is added.  Alternatively, userspace could explicitly
> request or hint the desired ring size.

Yeah I don't have strong opinion on this, but I just don't see it
greatly helpful to explicitly expose this API to userspace.  IMHO for
now a global ring size should be good enough.  If userspace wants to
make it fast, the ring can hardly gets full (because the collection of
the dirty ring can be really, really fast if the userspace wants).

>=20
> > > I also dislike having two different mechanisms
> > > for accessing the ring (lock for per-vm, something else for per-vcpu)=
.
> >=20
> > Actually I proposed to drop the per-vm ring (actually I had a version
> > that implemented this.. and I just changed it back to the per-vm ring
> > later on, see below) and when there's no vcpu context I thought about:
> >=20
> >   (1) use vcpu0 ring
> >=20
> >   (2) or a better algo to pick up a per-vcpu ring (like, the less full
> >       ring, we can do many things here, e.g., we can easily maintain a
> >       structure track this so we can get O(1) search, I think)
> >=20
> > I discussed this with Paolo, but I think Paolo preferred the per-vm
> > ring because there's no good reason to choose vcpu0 as what (1)
> > suggested.  While if to choose (2) we probably need to lock even for
> > per-cpu ring, so could be a bit slower.
>=20
> Ya, per-vm is definitely better than dumping on vcpu0.  I'm hoping we can
> find a third option that provides comparable performance without using an=
y
> per-vcpu rings.

I'm still uncertain on whether it's a good idea to drop the per-vcpu
ring (as stated above).  But I'm still open to any further thoughts
as long as I can start to understand when the only-per-vm ring would
be better.

Thanks!

--=20
Peter Xu

