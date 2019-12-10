Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F945C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E05D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWRkiskB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLJOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:32:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727370AbfLJOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575988377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oltekNksYL0JppEwk+sb0PIOexNRJT7sk8bU9jqVsg4=;
        b=ZWRkiskBw/d0lGCC7HXUKd4YzaDPk2LJlthG3QXJ87Mv93yP/4sYmmY/0AeECYGAT6F/XH
        z3hhDooY1xgmkmd+vL4lpph1odPEPk6j7DsnCdKSZnu+ZWvy5yYh3NweQKyZJCcmwLQl5p
        EE28odVXIGnHRlcJdUm5Saew6ViciJk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-lTtq-4QUPIWcuYJ8os2KzA-1; Tue, 10 Dec 2019 09:32:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id i17so1084459wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 06:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZX5clcawRs9HvyErreGyUr6byz6y4hiLe4x5yy5XB+w=;
        b=idlXTdBAcVnKphe7XnK4FGVi0DF0zKYRW+s0tLo34fGr/XzeGirRebjk1tmsi31FaS
         X4WwmDI4DZL5A8mISlBwrMtEYWQRKgQH2FSTwGdK8dkq2OnOlWqcvLWeQOZ2594waf3V
         CMeRNDRbBZzXly3IDkPT9ZBnK1fpDTE3V5WUXIuL0YLZ8xF1FxtGr7I8cFKbFBBWd2Nk
         tKaWXlCd0UGcB82kTM5KsIreD9O1xhlnY54QPt9CcEiUKGYlUQLcG/U15kzAKhAMaDBe
         gBTFJexU4tW+FUNAvrRwqV8smKGmUiSk9NrPA46mGaEl0kHrT73tcoI7t5NAmjbT+B1q
         q/yw==
X-Gm-Message-State: APjAAAVvp6WtHPoXtiG0egvvCfm3AGiBzhOjkogO/cw5c9Vpybfq9MI2
        rm7ItoPQ0Pw5Bt+UEkW/+ESlrY/1t2VGRbpvZ59YGpcKOib0qzxRAaHvxDNahbOvbZbh/YJV83V
        3+wIKYJ2jrKkvqgWu7Ycb3wTI
X-Received: by 2002:a05:600c:2947:: with SMTP id n7mr5228104wmd.156.1575988374114;
        Tue, 10 Dec 2019 06:32:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5osq8iXaghf+DSPEJ+fI9zhfAtq/jAq/Ozou/cbeXTMCvexsR8V2x1X6t2Pp1+8eyRY0ljg==
X-Received: by 2002:a05:600c:2947:: with SMTP id n7mr5228075wmd.156.1575988373894;
        Tue, 10 Dec 2019 06:32:53 -0800 (PST)
Received: from steredhat ([95.235.120.92])
        by smtp.gmail.com with ESMTPSA id b185sm3483015wme.36.2019.12.10.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:32:53 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:32:51 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <20191210143251.szkicty23b6pojxh@steredhat>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191210090505-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191210090505-mutt-send-email-mst@kernel.org>
X-MC-Unique: lTtq-4QUPIWcuYJ8os2KzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:05:58AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > When we receive a new packet from the guest, we check if the
> > src_cid is correct, but we forgot to check the dst_cid.
> >=20
> > The host should accept only packets where dst_cid is
> > equal to the host CID.
> >=20
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> what's the implication of processing incorrect dst cid?
> I think mostly it's malformed guests, right?

Exaclty, as for the src_cid.

In both cases the packet may be delivered to the wrong socket in the
host, because in the virtio_transport_recv_pkt() we are using the
src_cid and dst_cid to look for the socket where to queue the packet.

> Everyone else just passes the known host cid ...

Yes, good guests should do it, and we do it :-)

Thanks,
Stefano

