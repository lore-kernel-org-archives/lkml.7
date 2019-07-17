Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFA020651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcIblSSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfGQWRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:17:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:17:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so3000166pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=ZErEVvJ8JYXA3iwdIxlVCJMYGvo02bLUG34j47nMryY=;
        b=mcIblSSWf5ikEHP4UXr6+aGbHZ5mkPRydF0lr7zooN55M3vESs8uRUSSEpDlP7iK8U
         B59fdDgrNmpranJaP1PUCiwe/DOBSjKgXnclVGjM4ZK2dyRnuTnuxaI7KD2Fyf9s20mi
         6vy1W2HOQv81gXfyJKbN/M9dAyW77DYZx6UpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=ZErEVvJ8JYXA3iwdIxlVCJMYGvo02bLUG34j47nMryY=;
        b=pdb7PzHHPRDwNmZ4kTXDUgbbtytdNDUTusUzPyXN/eSC9FIfX8qT1i3tpfSgjJ8Pt8
         Bc4/LwaaKATlxKT1bzXh8y6eyNJ10qtCzEr/Gocj8NO5qW7PUNIN0MNVYdzQmk1MObBk
         WHfhhmqvCDMoHitRNaO2+l/9pz1s7qUuRpyE+f2/ZzubWZnuZLTnrRbiGYk/JnEpFpGu
         9sT8zgptHuXe6O0AiifIfC9KCpbbkwB9yHYFtvvftq4VeKCe1eDa4ZNxCWdW3r2ehwLu
         iTE/U2ToY3GiVvhNQpQjRIbDybRfqzDsBbiaUHOiZrEF44e0AnJEdR8WEmj8xKiqO5vz
         /qGQ==
X-Gm-Message-State: APjAAAV33zmb0X+uy1upGU2Byj3GbUjFlbh8LNNkgI8ev25emuRN7pMU
        3Qxrmam1HMfQzZJSQ926VUFaqA==
X-Google-Smtp-Source: APXvYqw7c35PhAMwlt994MttKuE5saXN+0D4ZP4wuF6qoM7MrH3ycgcxlhbEujoUx2xHbLj0H/dvXQ==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr46455908pjg.90.1563401833612;
        Wed, 17 Jul 2019 15:17:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r75sm27395801pfc.18.2019.07.17.15.17.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 15:17:12 -0700 (PDT)
Message-ID: <5d2f9e68.1c69fb81.6e01c.27fe@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d2f955d.1c69fb81.35877.7018@mx.google.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com> <5d2f955d.1c69fb81.35877.7018@mx.google.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 15:17:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-17 14:38:36)
> @@ -131,6 +303,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *=
data, u32 addr, u16 len,
> =20
>  exit:
>         spi_bus_unlock(phy->spi_device->master);
> +       phy->last_access =3D jiffies;
> +       mutex_lock(&phy->time_track_mutex);

This should be mutex_unlock().

