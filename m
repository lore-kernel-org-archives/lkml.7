Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09402184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARoHYitU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCTLq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:46:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34957 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfCTLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:46:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so1701258wmd.0;
        Wed, 20 Mar 2019 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lEqmdZNDzTWB2b9dWzz92G+TNWKuJGorh2fWb/d6sas=;
        b=ARoHYitUjoTP/9euhu5jgSqQb6V312wZJQ1kTtTt6o1wqx1srTAOc2KtmyXJgRF+Jp
         cr4eA3WPnikJ9Df0rmXhUcbCt0uQBHYAUao1q1TDikFpCgCAzIQIo5mc796iqT/le3BK
         8cE/6BCSC3cDbKD5VssH1XGcs8YLLMpFD4Lzu66b0p95xgo5t7Q7T/RMimDXD+KA7e4I
         HW/nhEVLxYud/eB5seor4c10tSesELbqBTfAhmiwEX4AiOIIaKvt7K1sMop/Zgp+dPmz
         FdoTYvN2M76LAOTM9ete4TNVKWeToIBeQRndLBxKAXto4GHKTylqHEb38S6Dj5SZRURK
         dAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lEqmdZNDzTWB2b9dWzz92G+TNWKuJGorh2fWb/d6sas=;
        b=DGZnLQ/nt7uL48rjaKiRh9sYlt+aer9sgVw66/Yjrs/ZiyCOgs8oqTyWC+hmzH23iH
         O0x1yV9Gf0ZNS8fXUT21dvTtO7lasILGLoDpBp4M/8mT0Gv5Ks2RiJ9/arF6vdRF+Ras
         DCRvjxcWnioVkkqOCjvoWzBy/xz2kMW4Bn5mos30JwTD5eO2PhAsB9lrNvpNOFriKkbq
         kn6lNcVt+6n6pwHMYciEkezM/UAPMPrKpNduxbcF8kHv/LQ6ozvta2jjwGQsCeyv9E4C
         7Ow36o7w21WlAeTq8flR3Aj5/5cRIq9GFifLqfWR+4CYUDfjlOKkvVwUuxF5TjuiaKta
         cIUg==
X-Gm-Message-State: APjAAAVBcr0/Hhbo6h9erB13tAISPqHe0c8WmXuvTI79NbxC4RWOBYFa
        ToemQg9p77wc2cgs8RzG58M=
X-Google-Smtp-Source: APXvYqz0+ZO72NCMiDuH6wAPneojSXcvKW2aB3ANf2WTkRNUK+2trWAwO7+NCZ2BWRKcj4i/p+Y4aQ==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr7769924wmh.86.1553082384127;
        Wed, 20 Mar 2019 04:46:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id b134sm4790939wmd.26.2019.03.20.04.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 04:46:22 -0700 (PDT)
Date:   Wed, 20 Mar 2019 11:46:21 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: [PATCH 7/9] nvme/core: add mdev interfaces
Message-ID: <20190320114621.GC5542@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319144116.400-8-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20190319144116.400-8-mlevitsk@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2019 at 04:41:14PM +0200, Maxim Levitsky wrote:
> +int nvme_core_register_mdev_driver(struct nvme_mdev_driver *driver_ops)
> +{
> +	struct nvme_ctrl *ctrl;
> +
> +	if (mdev_driver_interface)
> +		return -EEXIST;
> +
> +	mdev_driver_interface = driver_ops;

Can mdev_driver_interface be accessed from two CPUs at the same time?
mdev_driver_interface isn't protected by the mutex.  The state_changed
functions below also don't protect mdev_driver_interface.

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJckigNAAoJEJykq7OBq3PIZMoH/1lNrGQjkRw1moJsaMe55jSu
lRTyTaLwuUru6Mg5TxduJLa3rUhqkboCKYw5j+ehvi8Hm4xc5l4YjvuvQK7SiT8G
eU+owbZyzGaROuJBpzSv4Zwi2UI86MycQAUqLNrgH+xX9gZSymBk6xeMqpZvcPIx
TQjI/MiXdGAGXtuzH3Al57N4PponUyQEH79+X13mCsRibbFdqHzSYM99cu2iELhw
KHW8MMc8GaG8uqtUp3gEIGFe/Mjy0OomHg7Y8vLSG42cbkCJXTtCLp4/RVz1R+Cr
C1/2gQzDs/I3YIB4db30orExFKDmOuVlLSQhqKp3hQltZNJbk8CyF5QFuJGxfME=
=tFeG
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
