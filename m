Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD002083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="ZvRJLHJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCSPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:45:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45650 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfCSPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:44:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so4900341pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Fjw3xHngZfnwF/TJTFhRTSP9ZNBLIfg4L43mfZOTKk=;
        b=ZvRJLHJw+Z9ORZucbD8+nowi2iYZp/bmH9bOh6JjB5VEvvi+Vy9+lZAL5009kEqDzx
         xwOEFmKX57Cpufyu0TzP49VdSmoTq+YMEAyr07pXtAiM6lFSFkcR7jPlbO2W0OFQD6vV
         tXFBg5wbq2FxM13WGpJiYd11e6F2Vsk8jXZ2yR1VqQOJYzvCfrGp3H5EIKEWHX7ZiNZf
         LZtuHK4SsFOlBhgdRocXyxeUu0qGqI9Ci17sGuI5CzXoXqEaCtmMOwAkwu8o04f3EY7B
         qdgyfqKjF+Mv/pXPxY63Mg56bMp1V2YtnWEqkVpJJLOpO3u1alUPwmac0DxbFi8fBhkh
         GG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Fjw3xHngZfnwF/TJTFhRTSP9ZNBLIfg4L43mfZOTKk=;
        b=ImagtCohaB7gvx97EzxobPzuept3pKrvqmZQGjS5K3HjZHofpHT8O1xeAPTo1rOL0y
         oD0VZ6cbMwkY+bkCtGsj/QKrWX2k/qHMTN2gS8dNJ0nVdE1VFuhNgKoyGqC9KMgxZgIa
         oOyqBI92sHbb6HjEqnr06fru3HUlsvgTGiUhaLPPUVV+EawHXkf8YHyl5FU9VB/Ro0S3
         vwToesOrVD6Cj8r7XMG+WCkqFK+h3Jl+9Dzq5EAwAWBoU5ELcir9FDUUcWnRa5sxM7FY
         S5XiVNiYvuzqx1dNMd0AnSlf2IXiiVxstZ3kgJXF7fQtF4J8DsG16dTVbfPjZkUWmCUD
         tDNA==
X-Gm-Message-State: APjAAAU9F/QpVl3gE7RiW9SEmCF4mUfvNwCefg2vdl5NZRjcTUgtrLYt
        ZsJ+3GXyiudWWhbdzwOVDexO2g==
X-Google-Smtp-Source: APXvYqwfxeQIPhxiwRWKhQgS3TV/N0MTqG6fUi9PK/5Ax3dibk2BPCcM2LSmY+dHIh7+lCrdoJONPg==
X-Received: by 2002:a62:d2ca:: with SMTP id c193mr3060661pfg.247.1553010299013;
        Tue, 19 Mar 2019 08:44:59 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h3sm14280128pfb.31.2019.03.19.08.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:44:58 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:44:55 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "wanghai (M)" <wanghai26@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>,
        <f.fainelli@gmail.com>, <amritha.nambiar@intel.com>,
        <joe@perches.com>, <dmitry.torokhov@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net-sysfs: Fix memory leak in netdev_register_kobject
Message-ID: <20190319084455.2d4b6032@shemminger-XPS-13-9360>
In-Reply-To: <18553079-7bbd-fcfe-ef1c-6717e963e0a5@huawei.com>
References: <20190319050657.61327-1-wanghai26@huawei.com>
        <20190318085724.1e0c017b@shemminger-XPS-13-9360>
        <20190318161949.GX9224@smile.fi.intel.com>
        <c1c266af-7aaa-00a7-aa7a-e61c65665741@huawei.com>
        <20190319103037.GD9224@smile.fi.intel.com>
        <18553079-7bbd-fcfe-ef1c-6717e963e0a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 20:17:01 +0800
"wanghai (M)" <wanghai26@huawei.com> wrote:

> +out:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
> +register_error:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_del(dev);
> +device_add_error:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_device(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;

Everything looks fine, but I would redo the last part without
the last goto out. Using a goto back to single return reduces
readability.

	if (error)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto register_error;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
	pm_runtime_set_memalloc_noio(dev, true);
	return 0;

register_error:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_del(dev);
device_add_error:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_device(dev);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
