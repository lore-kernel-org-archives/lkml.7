Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16225C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2EA2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Farj7uCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKZW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:27:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbfKZW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574807249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NicO9dQ03Zmo4PQMvYh38X/weC3beZzf/9LJxgQLW2o=;
        b=Farj7uCdKsRjWVhcEjJbDYur89AzplvgJY8G/4Z5VeUFtHYABhzwOPGJh5FIa2XKXVTv5L
        6PlTf2LYXuf13hGOX+O90z0EetnennnxyK334z4TOBdauQ6Tc3mEHk9jYctN4OZna87Kpf
        p3Zlq33aYxLN3C9SGOmEv/FR0wBpHak=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-BOdfleXoPVODvg38cm_vjQ-1; Tue, 26 Nov 2019 17:27:24 -0500
Received: by mail-qt1-f198.google.com with SMTP id m8so11025268qta.20
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 14:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbHOMzuh71lzkXaVrHGstWzxDJlihkJE/87ycwZQB+w=;
        b=PB+lPH0/p0uicr1AQIpX63fZBMMkfT5nMjePTNWzq+sHg3GWJMLOF6/xdLsjO58Ukf
         8ZRH1v3dw5zaOKH+JAEgsDK8tCJ9h0z9JEzEAuKuENCafu4uAeC725NpC5OVmognID5S
         urxcclrL4ai7AvaKfgXROpPhcFGOaC/UGRkExQSs3WrXKseFVqHTaZ351JqKppKdhazk
         C5VTw4sfJBUrHQfqkzRHcccM86koBOI4nTBhotry9t0jGI+KorjLWXdmR/BLsUkJgIaP
         PZfznfZY2aEsTyTqorEVh3qphPtT4xRv76vXxfxjlynKSk0tcol5ZveiLCck5rhdAbv6
         BRgw==
X-Gm-Message-State: APjAAAVODhXtw+xQ4QbYVc3e8N0/SOwVX5tKGpS/GvsdmYJ5b5OO8Prl
        i44KwET9kwaKeCIIxGvAahpHV/E6jdi7NLgKFpMl3ko6y00hyG/3WrILc0iVvoaEtPEWl86on9M
        p6hblP7mnoWXWbGPk+5nP8IEb
X-Received: by 2002:a05:620a:816:: with SMTP id s22mr878663qks.48.1574807244077;
        Tue, 26 Nov 2019 14:27:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6UQQWiuLZ74PXNzTPA2SAstnnTg0lc7LDU8i0zr8BODQKEqgqe0zdRaJekr2JvT+wcx6iOA==
X-Received: by 2002:a05:620a:816:: with SMTP id s22mr878636qks.48.1574807243765;
        Tue, 26 Nov 2019 14:27:23 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id f35sm6617602qtd.35.2019.11.26.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 14:27:23 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:27:21 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] KVM: Unlimit number of ioeventfd assignments for real
Message-ID: <20191126222721.GB14153@xz-x1>
References: <20190928014045.10721-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190928014045.10721-1-peterx@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: BOdfleXoPVODvg38cm_vjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 09:40:45AM +0800, Peter Xu wrote:
> Previously we've tried to unlimit ioeventfd creation (6ea34c9b78c1,
> "kvm: exclude ioeventfd from counting kvm_io_range limit",
> 2013-06-04), because that can be easily done by fd limitations and
> otherwise it can easily reach the current maximum of 1000 iodevices.
> Meanwhile, we still use the counter to limit the maximum allowed kvm
> io devices to be created besides ioeventfd.
>=20
> 6ea34c9b78c1 achieved that in most cases, however it'll still fali the
> ioeventfd creation when non-ioeventfd io devices overflows to 1000.
> Then the next ioeventfd creation will fail while logically it should
> be the next non-ioeventfd iodevice creation to fail.
>=20
> That's not really a big problem at all because when it happens it
> probably means something has leaked in userspace (or even malicious
> program) so it's a bug to fix there.  However the error message like
> "ioeventfd creation failed" with an -ENOSPACE is really confusing and
> may let people think about the fact that it's the ioeventfd that is
> leaked (while in most cases it's not!).
>=20
> Let's use this patch to unlimit the creation of ioeventfd for real
> this time, assuming this is also a bugfix of 6ea34c9b78c1.  To me more
> importantly, when with a bug in userspace this patch can probably give
> us another more meaningful failure on what has overflowed/leaked
> rather than "ioeventfd creation failure: -ENOSPC".
>=20
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Ping - just in case it fell through the cracks.

--=20
Peter Xu

