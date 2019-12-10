Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDFAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F3D2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuIV1+Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLJQCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:02:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34039 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727178AbfLJQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575993738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmrUnVVfu+gicASXeQuwmvLpG3WehUtcphinC4uDACQ=;
        b=HuIV1+Ek93v8YrmszcRQSMP5jPFmftm2y0Ll6UO2PMvXQw105Yfb6fie1lj9EV0DhzN7bo
        hR1yLPSx58ZEYjVzrnEfb2mM6CeJgQVIZm+uwAcBxK91le4ssXUL5vwQmylH1NkpNfyLsv
        H8kJMeAfnuntIr6RwGUzo7BdONcKzGY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-pTaC3PbkO2Ce38KtfAAO_A-1; Tue, 10 Dec 2019 11:02:14 -0500
Received: by mail-qk1-f200.google.com with SMTP id u10so3866423qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 08:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTRO4sKa0TSsx0s4k8rd2usE0Lc8/iEKmdicKPLyJcY=;
        b=HZVrJqMKMqNCBkB+n3AeCkuoEqHWaV5qKlpHYu3cyJAma6yH37rfX7ukGb3cDSnTph
         mB4SvgPwkX3hy0JnGehs3lnw/bhrpq3g5Xe3qBcOujMnI7q9+BDQJyENxv/kDUUwp1rM
         swS4jgIMrreJEcbxt/kJSZhrLWEADJXJvsVFesbHBS0NveXvVvrad5GsUF9M+3IICoU7
         Lropt8gUFY9JtlgQxBbUco8sBs1qjb8GE1JoCyi3MaORvrOd1Ur49NlI1a70METZanzX
         DEMrv2XajxACLVLaqFL5kJ1xJsb1Jsuqz5ae3+JGyM1Tx5d7CqteuwuXi3MUaforAbIT
         VINg==
X-Gm-Message-State: APjAAAXUBWShBTto7B8kJ9MrnWKdhM35o7SMX3NkaoKclSAuMprTngvb
        QhJbOC8ICM686pZHou7RfOYCR/ggfZAaL1up/e4NrY7d+s4i84qW74nB0u2K7ye7NfVGLFLu4G2
        XUkKsLPUEZsDTQHeAE+ohXuKk
X-Received: by 2002:ac8:6908:: with SMTP id e8mr18354350qtr.124.1575993733844;
        Tue, 10 Dec 2019 08:02:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFY9Zu4KFA0Cgq3rNYhbKTV85FtEH60qO0JD/0nPDQokpcMpqEq1wyebMhUioLku1+qtqLKg==
X-Received: by 2002:ac8:6908:: with SMTP id e8mr18354311qtr.124.1575993733549;
        Tue, 10 Dec 2019 08:02:13 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id x32sm1237252qtx.84.2019.12.10.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:02:12 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:02:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191210160211.GE3352@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
 <20191210081958-mutt-send-email-mst@kernel.org>
 <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: pTaC3PbkO2Ce38KtfAAO_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:31:54PM +0100, Paolo Bonzini wrote:
> On 10/12/19 14:25, Michael S. Tsirkin wrote:
> >> There is no new infrastructure to track the dirty pages---it's just a
> >> different way to pass them to userspace.
> > Did you guys consider using one of the virtio ring formats?
> > Maybe reusing vhost code?
>=20
> There are no used/available entries here, it's unidirectional
> (kernel->user).

Agreed.  Vring could be an overkill IMHO (the whole dirty_ring.c is
100+ LOC only).

>=20
> > If you did and it's not a good fit, this is something good to mention
> > in the commit log.
> >=20
> > I also wonder about performance numbers - any data here?
>=20
> Yes some numbers would be useful.  Note however that the improvement is
> asymptotical, O(#dirtied pages) vs O(#total pages) so it may differ
> depending on the workload.

Yes.  I plan to give some numbers when start to work on the QEMU
series (after this lands).  However as Paolo said, those numbers would
probably only be with some special case where I know the dirty ring
could win.  Frankly speaking I don't even know whether we should
change the default logging mode when the QEMU work is done - I feel
like the old logging interface is still good in many major cases
(small vms, or high dirty rates).  It could be that we just offer
another option when the user could consider to solve specific problems.

Thanks,

--=20
Peter Xu

