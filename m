Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBC4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75C2206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRPJF2yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfJNRXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:23:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfJNRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:23:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so20677223wrv.7;
        Mon, 14 Oct 2019 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGGdaz7JChYl4JPWAU70Za+RRAZ6S/LKBm6uuB4+/Xc=;
        b=RRPJF2yb4XFeB7uEMgAAHug959rwOOi8I/aMvVs+16qpBMg/xi88CdeE9Z0H9RouJ+
         fuML1Z9e9rjBfDAPLO3vADPa3LKcP9qnEf/xpsiWQnNh+luQFiGV3tK5aWSEkUPYzdfA
         KpZpZ+iy0Yoy/NcKo/yZtrnc6V+97GtwBpJroCZjdetayH+gySMvQCYQhbhgEwH6uh48
         WPbN59RIfr0Ttxd+BL05PY62ls2843A5TDjRJu5P2+VWH3gHHPu5bJlTNgtK5BrOavSZ
         bJycA88kKLnGA677mFQ8W/bpEIMLoXR5m1yU1geUzd8TFe+sPFHy6SrFhwmpW0BGfxq4
         DNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGGdaz7JChYl4JPWAU70Za+RRAZ6S/LKBm6uuB4+/Xc=;
        b=SvitF9CzvT9Th5XrcJd1BSyRmyD+ZgCEbnUZzB6F4HY3oDLsRuUcqpWHxA6ARHv8j5
         7Kq0LFgnaWIGzZkO3BdFZfqqgl1qwb7oyRL2aS8tjH6LGfYhPTWsLABX5v4+BE+8X3o3
         a+MPcixyqNnAva00X4ssWXzkbBUXCZWCpLrf0QbsyPvvgqaiA09XXsJH6G5NU7sYowVx
         sdamSAB5H0T8x5035ufXMJkGaw4B/0MKLOIv88yfOneS2h+9V/7ebOWDP4LBLVKaOYfT
         z+vHzC71XrRFbQM0RQZFyEulIDYZbR1TuH9/PFueEj7cjdxvezo3vow5zCBeVdQ9UtZO
         kAig==
X-Gm-Message-State: APjAAAVRaIijLQ6I3eDTRK/w6mbuPGEztFmhcxr5DK46Yb4gnqhCKT+P
        BVJsxcs7LbsJgX95jpOGSss=
X-Google-Smtp-Source: APXvYqwzHqNY1eXa8Wf7T+/uPb0SEQxKfUwA6RcA+GYW/wDuACvWvp5czJ0hnFuczXqrqbCUluKYlA==
X-Received: by 2002:adf:e403:: with SMTP id g3mr24811494wrm.294.1571073784104;
        Mon, 14 Oct 2019 10:23:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id u11sm17480327wmd.32.2019.10.14.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:23:02 -0700 (PDT)
Date:   Mon, 14 Oct 2019 18:23:01 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        cohuck@redhat.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com
Subject: Re: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
Message-ID: <20191014172301.GA5359@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191011081557.28302-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20191011081557.28302-6-jasowang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2019 at 04:15:55PM +0800, Jason Wang wrote:
> + * @set_vq_cb:			Set the interrut calback function for

s/interrut/interrupt/

s/calback/callback/

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2krvUACgkQnKSrs4Gr
c8hIpQgArOf5wNMCOOx9mrAoFEfDyFDnQGYWa6Ce2/25rBYZVN1BIaLrZLwRk4Za
aM65SiUsAMIh+UTdezqEPyUZCoRZbcxFRWUtyQZqHLCVg3yrwM++9xtTFclrIY0p
hP+v2ZVAMUT/1BQiaAo3+qlItEYbUDwtSl+wsSwzlvu9nFRlHjjdbUZAJmU78zv0
Y50LNaXQf3+E9GqPDj6nJEUSxpww44C1FOgxh9SErmqG8j7ReyAfng0loRKNdZbv
6g7U1I0J+vNgzcCxTSipVRS8EH0bOEY07w3OggpIoIRnOx6voaXYz8SMEQZ8tiRu
k0SSOtAyZ48s1BaOt3vREX8uYFlt0A==
=/ZZN
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
