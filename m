Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AF5214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLZifJk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfLKOyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:54:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727554AbfLKOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576076053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTML3ZY4XajEGIMXTQF+X7InEuyoASYWfqymLI5iBaw=;
        b=ZLZifJk6o0dit61gUTp1Hd+hqFUEa+RcY3jSwIO2/DSSQeGS7gA4zCnJHwowBwGqpWHv8d
        xIYITfJW146nrfh/7eTAirsP2fzV1gDUacn1QLyZa/zu5jJNSf4ebXmZGC4OlYuv1XwWP9
        izJw1VhYi2MnQWqkGCB2GRUySGhEvnY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-DVoJXowfP86mApff4D3yew-1; Wed, 11 Dec 2019 09:54:12 -0500
Received: by mail-qt1-f197.google.com with SMTP id b24so4558289qtp.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62xWb0cf1MCXJ37uAv39v37rLn99Ssaq3pAFUpU9gao=;
        b=EJd2epFKWiBv116zyFEP3xv/wwcGDKQy6WkEXs7yzCqvKaCChX+v+1gjx1Wi+Unh5Z
         4FIKGTD8qEaMKAKoOenenKMz6DmWAtvCGtQelqGm+iIDcenX+2Dkzy+yYzzHKGWDbwZM
         QqUq93YeRTaTEXBjKBV+EDtFdYMWMZ2GhMujuhov4oa97VGwid2ffv4n2NXPl++ye1NU
         QSHbBIVcQ65uY9mW5p96CAFXboX9tnvuc9sFurABT93UiWWOKqxKYoUrx+flO5gGyxMk
         ooWXGMWtR4per2AJBfhWwadBaPJGfWtzOiNiUhvaWiqpt7P8JsdohC6arwkv4mFrCEfc
         ok2A==
X-Gm-Message-State: APjAAAU4Cqvis6YIDZEL4YBI5SXY7QopEUlGZiXZaglCuBBbPlBJ8emC
        LkLhDXwMJnj3pD+iug68y7cMEalya9z36UsX6+97DaDlVN3AM70XOG36TmJ5yk/0ebM4RETVX7a
        NmArUcgaXjZ9bu1Tk5ruXhuoc
X-Received: by 2002:a0c:d4aa:: with SMTP id u39mr3348809qvh.76.1576076052100;
        Wed, 11 Dec 2019 06:54:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6Z1czXLZJjBLnmWHepFgS8gviQBQkXR+INEflNGPDvrBHCj0nHMpXc8tT4MJlNfYGagK0Vw==
X-Received: by 2002:a0c:d4aa:: with SMTP id u39mr3348791qvh.76.1576076051828;
        Wed, 11 Dec 2019 06:54:11 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id g16sm727342qkk.61.2019.12.11.06.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:54:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:54:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191211145404.GC48697@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <1355422f-ab62-9dc3-2b48-71a6e221786b@redhat.com>
 <a3e83e6b-4bfa-3a6b-4b43-5dd451e03254@redhat.com>
 <20191210081958-mutt-send-email-mst@kernel.org>
 <8843d1c8-1c87-e789-9930-77e052bf72f9@redhat.com>
 <20191210160211.GE3352@xz-x1>
 <20191210164908-mutt-send-email-mst@kernel.org>
 <1597a424-9f62-824b-5308-c9622127d658@redhat.com>
 <20191211075413-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191211075413-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: DVoJXowfP86mApff4D3yew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:04:36AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 11, 2019 at 10:05:28AM +0100, Paolo Bonzini wrote:
> > On 10/12/19 22:53, Michael S. Tsirkin wrote:
> > > On Tue, Dec 10, 2019 at 11:02:11AM -0500, Peter Xu wrote:
> > >> On Tue, Dec 10, 2019 at 02:31:54PM +0100, Paolo Bonzini wrote:
> > >>> On 10/12/19 14:25, Michael S. Tsirkin wrote:
> > >>>>> There is no new infrastructure to track the dirty pages---it's ju=
st a
> > >>>>> different way to pass them to userspace.
> > >>>> Did you guys consider using one of the virtio ring formats?
> > >>>> Maybe reusing vhost code?
> > >>>
> > >>> There are no used/available entries here, it's unidirectional
> > >>> (kernel->user).
> > >>
> > >> Agreed.  Vring could be an overkill IMHO (the whole dirty_ring.c is
> > >> 100+ LOC only).
> > >=20
> > > I guess you don't do polling/ event suppression and other tricks that
> > > virtio came up with for speed then?
>=20
> I looked at the code finally, there's actually available, and fetched is
> exactly like used. Not saying existing code is a great fit for you as
> you have an extra slot parameter to pass and it's reversed as compared
> to vhost, with kernel being the driver and userspace the device (even
> though vringh might fit, yet needs to be updated to support packed rings
> though).  But sticking to an existing format is a good idea IMHO,
> or if not I think it's not a bad idea to add some justification.

Right, I'll add a small paragraph in the next cover letter to justify.

Thanks,

--=20
Peter Xu

