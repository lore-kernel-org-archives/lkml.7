Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31063C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C07205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DF+7cSLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLBUnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:43:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725853AbfLBUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575319433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4Ittu/hSmdCI2AmJTvWeXqR6mPDprHDT/ECsEOFBW8=;
        b=DF+7cSLV2P7mtzazvIh3kCoWZ3wP7TRZkKQ676BVtaf8zMMrHRgYUdvSa5IGxdFcn5r8CP
        YIZbZ3z7ruH2cA+hwdkgs8YCx0pYAHk7cFTCIBbMUvjmJ7OdgG9qkq5rp3+jOmf0TkKTX2
        dOh6Va476lSMdrn9UWnCWKeL+SdUtYw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-_8VivcW4PYi1t23xw-pDHA-1; Mon, 02 Dec 2019 15:43:46 -0500
Received: by mail-qv1-f69.google.com with SMTP id g9so589554qvx.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=USlZJP//e42ZzE68GTx4OckfDz65LYntsCtyMUYxiWU=;
        b=RjHrbB31+9uWS2+vkn3wabmcaMOahAH5oGySjuslNN/oEEtuq3bZk1ZS+XWJfslOU/
         K4R7Ui7nntyzcCLGkp5v/o6/sZ0WRVoiwoS1e5BhphU4I7/fgT0fVVia9VznWZdxsdQb
         LmoQAu6YZEWypzXm4osNqbl2c8tzNeGqB4RYvHiuD6nUTDmiUW9JOGEymbW80ltZTK6g
         QiZRS5YgAy5s0hvJPdRCi4UltFIF3FOzqYAv8LNB1XvqRncwP2/YJbkJroB6e4JOPj7K
         5Z8HzJg3esLsD2eE7v5cLE0njvEBGVRUXVlB72Qtuy0abufiJj00pIT0qe4QuBd+VCdi
         1cZQ==
X-Gm-Message-State: APjAAAXgwK9SjGjIsKBWf4u0VFr1HRLELakLIBpsZ0FPnK2nhCffyYVv
        CLBr0HZfUix7z7uLxziKt2b4EQKXUnDEGEFs6Eoe1EfxK7+y6XjoW2af7/xxDo0jDP5fb64xy4O
        vPyPMh4rB2hcWX+K04A9JmV/J
X-Received: by 2002:a37:8185:: with SMTP id c127mr984218qkd.43.1575319426231;
        Mon, 02 Dec 2019 12:43:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXLMQ+eAjfkBW0QjP715vnDdPiiQiUKGC+SVAkoNMre5VxloNR3M7CcaO1XLRCCzkF2ZFHpA==
X-Received: by 2002:a37:8185:: with SMTP id c127mr984192qkd.43.1575319425943;
        Mon, 02 Dec 2019 12:43:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l7sm395150qtf.84.2019.12.02.12.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:43:45 -0800 (PST)
Date:   Mon, 2 Dec 2019 15:43:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
Message-ID: <20191202204344.GB31681@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
 <20191202202119.GK4063@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191202202119.GK4063@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: _8VivcW4PYi1t23xw-pDHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 12:21:19PM -0800, Sean Christopherson wrote:
> On Sat, Nov 30, 2019 at 09:29:42AM +0100, Paolo Bonzini wrote:
> > Hi Peter,
> >=20
> > thanks for the RFC!  Just a couple comments before I look at the series
> > (for which I don't expect many surprises).
> >=20
> > On 29/11/19 22:34, Peter Xu wrote:
> > > I marked this series as RFC because I'm at least uncertain on this
> > > change of vcpu_enter_guest():
> > >=20
> > >         if (kvm_check_request(KVM_REQ_DIRTY_RING_FULL, vcpu)) {
> > >                 vcpu->run->exit_reason =3D KVM_EXIT_DIRTY_RING_FULL;
> > >                 /*
> > >                         * If this is requested, it means that we've
> > >                         * marked the dirty bit in the dirty ring BUT
> > >                         * we've not written the date.  Do it now.
> > >                         */
> > >                 r =3D kvm_emulate_instruction(vcpu, 0);
> > >                 r =3D r >=3D 0 ? 0 : r;
> > >                 goto out;
> > >         }
> >=20
> > This is not needed, it will just be a false negative (dirty page that
> > actually isn't dirty).  The dirty bit will be cleared when userspace
> > resets the ring buffer; then the instruction will be executed again and
> > mark the page dirty again.  Since ring full is not a common condition,
> > it's not a big deal.
>=20
> Side topic, KVM_REQ_DIRTY_RING_FULL is misnamed, it's set when a ring goe=
s
> above its soft limit, not when the ring is actually full.  It took quite =
a
> bit of digging to figure out whether or not PML was broken...

Yeah it's indeed a bit confusing.

Do you like KVM_REQ_DIRTY_RING_COLLECT?  Pair with
KVM_EXIT_DIRTY_RING_COLLECT.  Or, suggestions?

--=20
Peter Xu

