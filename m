Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B0FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ECF2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQmOsWdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfDDOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:14:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42799 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDOOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:14:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so3988635wrx.9;
        Thu, 04 Apr 2019 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1dW+POBgnuR0MeTzLr9c6mBaCETUnfY9abvmwlbqbI=;
        b=PQmOsWdJUm9aSLH5QOMbDa9GgOzIkm0FDvhMJykd2UhwtgmVyNQa20+44VVRX2/2fH
         x204u6z3Q9VxAvj9oMVDyLKPEcSHqxzDhyNzxkDvYtx4Y+7NJxWd282aYYSisaftETca
         mAR4IyNTLUYSWteb2GgIk+0W1CUuJI1ELid/87djXbCykMFRP0gu4Os1jCs/yl0vTkFK
         zZiltaw5RQX22Tf6sxDqT+KO7KE3xtA4oj1DwC60LVjIyYHBu7UqpQlgx7OPMKc/80+8
         d6/ZnP5W4RV3j9SWfdHWLe6g0SQXWJYiBU3OBHFbeRtN+pC4gLmhf805MVdwXSAxNDVG
         vbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1dW+POBgnuR0MeTzLr9c6mBaCETUnfY9abvmwlbqbI=;
        b=tm71ygfkJVFwtv5Kn0BKBWUDwI47Gx0eQ9nkyUl8ylfFIciWljb2+jvq6dFPgSNGh2
         BnwcVSehZB/pQ3R2oUpRYm3i0JsluBvPdB9RTHoTIA0GSCfwlOmVXmywzyNdD6u5SLfv
         KnOBngWmc7TPuteXoEFjvtVt7dbRqmrbhslK4y5kJ6GykbK8WqaCt0D7q5UBwuwysHC7
         KigZM2SQ6IoLWwH5vNtCMPa+3UiMgBzoDjh8FSxzJbiEz+o6gwVNoYLsMp4j2H8QwORW
         KRbo7erNaSSm6e0GLnG0AxCOpu+TukaGPzH732hFpK9KZX1nfQffhRlAFVVflmlF4W8+
         0BVQ==
X-Gm-Message-State: APjAAAUk15aNlKKy7DwKEZZwuRuE6aQjlN42q9914Q6IQh6/ENQDx+Gm
        RnHwe16t53zuT6DWsCxRp2E=
X-Google-Smtp-Source: APXvYqwHhdHZSurx1pYaqJEiUHZ54CAGQPe+WjNK7oN3iwuAp+T4vv6zxhJEULqiKeQU6wvKrkUT3A==
X-Received: by 2002:adf:e94d:: with SMTP id m13mr4701799wrn.141.1554387252480;
        Thu, 04 Apr 2019 07:14:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id g3sm13491831wmk.32.2019.04.04.07.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 07:14:11 -0700 (PDT)
Date:   Thu, 4 Apr 2019 15:14:10 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190404141410.GA25152@stefanha-x1.localdomain>
References: <20190404105838.101559-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 12:58:34PM +0200, Stefano Garzarella wrote:
> This series tries to increase the throughput of virtio-vsock with slight
> changes:
>  - patch 1/4: reduces the number of credit update messages sent to the
>               transmitter
>  - patch 2/4: allows the host to split packets on multiple buffers,
>               in this way, we can remove the packet size limit to
>               VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
>  - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
>               allowed
>  - patch 4/4: increases RX buffer size to 64 KiB (affects only host->gues=
t)
>=20
> RFC:
>  - maybe patch 4 can be replaced with multiple queues with different
>    buffer sizes or using EWMA to adapt the buffer size to the traffic
>=20
>  - as Jason suggested in a previous thread [1] I'll evaluate to use
>    virtio-net as transport, but I need to understand better how to
>    interface with it, maybe introducing sk_buff in virtio-vsock.
>=20
> Any suggestions?

Great performance results, nice job!

Please include efficiency numbers (bandwidth / CPU utilization) in the
future.  Due to the nature of these optimizations it's unlikely that
efficiency has decreased, so I'm not too worried about it this time.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcphEyAAoJEJykq7OBq3PI3fQH/iwehSG1C1HktNyFHXS6s/zt
4G9rovQaFOnHHIa4i0DnqHRZKZ2SyrAZNy7BI8102ULb7aviSx9fK6dmxojv9tSp
wvxg1Y5E/fF21gfYfIOR6DTXt+loSsCeBmCWVMPa2nfRqJVJJzMQfHx1xVE8chE5
ESiA6QGGt3tj+P8F2YfDl3r3twJh1OcO6WZoKT4GxIpUfzNvlJMk99iXJz3e0E+C
14XHoU1qhct6PWRP6R6cMEbRLmKZV6wxDERubCxPnmf+BR99z7ydDUdEZPRpjeot
n8C4zFoJz3Fw/0q/C3XuhLpfLah+3hvF4CbJP/bjnLaZ7TwYP56RO63pakhEjjE=
=zvVe
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
