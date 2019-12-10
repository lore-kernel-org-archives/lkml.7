Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCF420637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNOxeqlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfLJVtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:49:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfLJVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576014547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRHP/YZ/v5tZHq+EqyHv9Q8ygSXDpE+zmhmcnk0K+/0=;
        b=JNOxeqlHEC08WO5wGiSoU9DljQe27/LzVkjKMFzIj/BHDY1pv/QTjHqQQKuAFrlHCV/98G
        CbQqkqxfWsb7SZzwwJUAvj7go01nO321gZxgnEqHVu8JC+bOUgCT0F4rNVTHX26MwnkAv9
        GcPhEZ2wMuOZQuOUZZIHT4zGI+w1fic=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Rbcpxl4wOzGYCgd-CnalEg-1; Tue, 10 Dec 2019 16:49:06 -0500
Received: by mail-qv1-f71.google.com with SMTP id r8so7804979qvp.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Fvh9KfncyRLodCGVx6CNMB0xHcL2ji/SSHmtcQvIBc=;
        b=Ul0lXjvLlLVZQBYZHSEQZySC1N8N0n5KaAafrxz1uGaV8ITsgaFV0PCZCXTI02bapu
         nvGU04+fUpgGszxHkPXRPx0eog0D+NBXypeyw5erigKSLZKZwEMQt+o6fJyhs2haxKdU
         hPW6Qzj4dTssedzr9GYxTQrR/g0dJz/Xga/ieXLnUZf+V0SHMWP5o0IOT6FbnijyqoYC
         rd1ZlylSYB8mHZs/kXicNnq7R0uiVOkiJFNsCqzma9oiOwqXUxWvxdnCzJpo1iCdO3PU
         c7juWqwF7GDJQlKdVCX+1JOVqiRdjptXEoXh8UjG98n/EzbPrppuUecA8/moz3ZUXgWi
         s/mA==
X-Gm-Message-State: APjAAAX6oTIKYmw+dr1tM8LKgTVu+z79N6OAkEeAaze2dPRo5d5Yoxas
        BYeV/kBC4ISN28hTUHcXnnICgeuUN+WBC2wpISELYyalV3aCf/UPAOvfsSPqOq1H1L7UHxom8RG
        77+NPZDae4BHyszcdf84bAJGa
X-Received: by 2002:aed:2270:: with SMTP id o45mr32168456qtc.217.1576014546120;
        Tue, 10 Dec 2019 13:49:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyldUBQOIrNb9JapJRKo8/NDw9CDZXTYIbAMF4XhDN0GqGA/Bm5av5bHhivcOXCrRenuFKEBg==
X-Received: by 2002:aed:2270:: with SMTP id o45mr32168443qtc.217.1576014545942;
        Tue, 10 Dec 2019 13:49:05 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 68sm1373605qkj.102.2019.12.10.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 13:49:04 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:48:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191210164749-mutt-send-email-mst@kernel.org>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
 <20191210081958-mutt-send-email-mst@kernel.org>
 <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
X-MC-Unique: Rbcpxl4wOzGYCgd-CnalEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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

Didn't look at the design yet, but flow control (to prevent overflow)
goes the other way, doesn't it?  That's what used is, essentially.

> > If you did and it's not a good fit, this is something good to mention
> > in the commit log.
> >=20
> > I also wonder about performance numbers - any data here?
>=20
> Yes some numbers would be useful.  Note however that the improvement is
> asymptotical, O(#dirtied pages) vs O(#total pages) so it may differ
> depending on the workload.
>=20
> Paolo

