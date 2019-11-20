Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9894C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944D222445
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/ilQoZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfKTJAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:00:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728062AbfKTJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574240416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df2jZGkaKYIX8XGP45379iKP8na141nKrPLZMKk0bUg=;
        b=F/ilQoZVp+JWRDAwyJOnKsgprtNC1zi9PeKxiiwDW7+ahJBAH9SiwgvR6zRTk/b24bURKU
        EIo9/rLP158Pmffr01kYW6heo9LgfHLtX6BnMSvwg1/jG3ikkq2seY/5Vd7LgiL3E97oKI
        c13ebqfGIg0ShmAfXB6ZB4uGW+RVRRY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-eR3fDIFtNJibupG0o-ICCQ-1; Wed, 20 Nov 2019 04:00:13 -0500
Received: by mail-wm1-f72.google.com with SMTP id h191so4772032wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 01:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+y/mrfI8ftCAoV6iK00SrByVRSNZiEo0o81DOjJrmQ=;
        b=mzZxKp8wibrqfVovd+WgSvh5OlNA6m4yNkgRTHFv4jSJ+mdDkVTe0DhNch9xa37mSv
         gaJQslqVybQRxUJVpAp8OTnxinKF/1NVOOiOMAmQPdyEtpZrnt1BA9sJ2hQ6JVvvfu7g
         OxD8Jy55a3h+kC9fwboAcR90E7VPi1XkzHGvctDlgDvCJpH4DXtqkmik+eoyo9njUBI7
         i2FR/qGj4q+x6/QHfRXuLNyNrA1KqhdRw+eC+RSKE6lS+LNWL5WofNYHYiuZSORd2Ypk
         XHqHulqfBItmvEZOg/bYN2/yfYhgJzdnhAWmysQ1G3KLpCWmJ4qV68wE0/xeTOXK5/91
         h+7g==
X-Gm-Message-State: APjAAAVOZcwxXCOaPEktU55jUkWYoSW79v3jXfsM1OrReS3G5Da7BUCn
        2nb6vw0CSdYTPe5mirbo3aFRgbCL4N4lRKJfmXgLggE8wSZptdt9dj+x2jbi9cdyubex4S/+a9x
        iUu5+XMq055+55pAnlUYGeQMW
X-Received: by 2002:a5d:640b:: with SMTP id z11mr1744248wru.195.1574240412214;
        Wed, 20 Nov 2019 01:00:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzH0Kdjailo9KhJjoLt6nJgWn1k9d4qaEv02JFRBV4exDlOdZ6AoQZwxtxq6bSHolNraKXzJA==
X-Received: by 2002:a5d:640b:: with SMTP id z11mr1744217wru.195.1574240411959;
        Wed, 20 Nov 2019 01:00:11 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id m16sm5646172wml.47.2019.11.20.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 01:00:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:00:08 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        decui@microsoft.com, stefanha@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jhansen@vmware.com
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Message-ID: <20191120090008.qlfc3lnzwl6yudsf@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
 <20191119.171501.666690660172999834.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20191119.171501.666690660172999834.davem@davemloft.net>
X-MC-Unique: eR3fDIFtNJibupG0o-ICCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:15:01PM -0800, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Tue, 19 Nov 2019 12:01:19 +0100
>=20
> > +static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> > +{
> > +=09struct vsock_loopback *vsock;
> > +=09struct virtio_vsock_pkt *pkt, *n;
> > +=09int ret;
> > +=09LIST_HEAD(freeme);
>=20
> Reverse christmas tree ordering of local variables here please.
>=20

Sure, I'll fix in the v2.

Thanks,
Stefano

