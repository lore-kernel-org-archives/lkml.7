Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7751C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1D82073F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrY9+zrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUKCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:02:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726014AbfKUKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574330523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEzzNkobngto7A7JkTiA2JRstWm/Qwf1aRo6Iv3/3m8=;
        b=JrY9+zrKYQ4lU35o1TthZ7NwWNE1m8g2qERBIvydwD74QV3j41fz0F3RRPuoTr78cAKY4c
        2m289oWySaD/ANnq1rvOyLzW4QI4i1cpAPY8W7T1BELVkPjI2vVCpHRfAbAaPCeYsg2h3A
        M9tyjo5eULZLcpLSQy3P3+eIDaEcRCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-960pRAP1O06vnwrlXtV4UA-1; Thu, 21 Nov 2019 05:02:00 -0500
Received: by mail-wm1-f71.google.com with SMTP id m68so1537684wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFqAKgUAsSLJXhwvvIOsI4T22gRsWSmbmVmEZ/F0Ht4=;
        b=FM1jsfoXyTXiIWF1tIkwGLm0rgK5gCV/zW+WNlvWRajqI43nSe16gklQ7wl0uuoFcp
         2UsesdrxCGIGByPDbXkpuwmGcqy3thpmq01w2/3j0EkXRQlOMZcZfebLoWv2BWU8l6AS
         H71J9AVTY12w5anBKi1+oYHNU9LyG7pURMxvX+EAzf6jD/BtuJ6q+Fx9Zb3QGhGIcZIC
         sTP74VDRf44sPX1kG95Au4CCyJShzou3MpTJEnQUN1HYkkYzS8t7xkcqEaupwaNGGWdE
         mr5/nnZLVTZFlx0BFNdVV1aK8OLzU5M8pKzPcr+Y89Iu54/PjsJMy7bnIU2J0v3zCG2j
         jKqA==
X-Gm-Message-State: APjAAAUmQtEU1Zg+mTeQCS0UVV63qUm7QkSWcT4NEdlfMLhZyeb8BU52
        ZZFJpfXjz3mr5y677Hie+itstFjATKnjAMnfTk9JZFvIy/Xi2YdovM189u7lWYvIvsEf8fawMSj
        U0IV0TFn9sRlYui/JCzTk+V/m
X-Received: by 2002:adf:db8e:: with SMTP id u14mr274453wri.274.1574330519204;
        Thu, 21 Nov 2019 02:01:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxy6brRF1ev/m1DKBfFjA6HTGnTBIhroRW1ilhIuPxww1/cdIQc+e2rt6PwX9NqSCpO1cJSPg==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr274435wri.274.1574330519006;
        Thu, 21 Nov 2019 02:01:59 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id f188sm2272358wmf.3.2019.11.21.02.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:01:58 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:01:56 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH net-next 5/6] vsock: use local transport when it is loaded
Message-ID: <20191121100156.v4ehwmstlhujrviv@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-6-sgarzare@redhat.com>
 <20191121094614.GC439743@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121094614.GC439743@stefanha-x1.localdomain>
X-MC-Unique: 960pRAP1O06vnwrlXtV4UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:46:14AM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 19, 2019 at 12:01:20PM +0100, Stefano Garzarella wrote:
> > @@ -420,9 +436,10 @@ int vsock_assign_transport(struct vsock_sock *vsk,=
 struct vsock_sock *psk)
> >  =09=09new_transport =3D transport_dgram;
> >  =09=09break;
> >  =09case SOCK_STREAM:
> > -=09=09if (remote_cid <=3D VMADDR_CID_HOST ||
> > -=09=09    (transport_g2h &&
> > -=09=09     remote_cid =3D=3D transport_g2h->get_local_cid()))
> > +=09=09if (vsock_use_local_transport(remote_cid))
> > +=09=09=09new_transport =3D transport_local;
> > +=09=09else if (remote_cid =3D=3D VMADDR_CID_HOST ||
> > +=09=09=09 remote_cid =3D=3D VMADDR_CID_HYPERVISOR)
> >  =09=09=09new_transport =3D transport_g2h;
> >  =09=09else
> >  =09=09=09new_transport =3D transport_h2g;
>=20
> We used to send VMADDR_CID_RESERVED to the host.  Now we send
> VMADDR_CID_RESERVED (LOCAL) to the guest when there is no
> transport_local loaded?
>=20
> If this is correct, is there a justification for this change?  It seems
> safest to retain existing behavior.

You're right, I'll revert this change in v2.

Thanks,
Stefano

