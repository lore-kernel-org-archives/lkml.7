Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0319FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC741207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pETy2f8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0Sim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:38:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37603 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Sim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:38:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so22252258qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=wdp1lywqmKgyuKU1G9KHrqyijHJooeS6kbCPCzKFfhw=;
        b=pETy2f8iLffpdhZh+eVuVvnU3GhOO1uvMItulY+h7B3z85q6xdoNYd4SKAstjtNEvB
         8BJ5NgiNYX/Fio5ruP0etID8HD3CQP+lpSz1GKxz74Vo0ee9rgUHWK/kIDavvhRzf+Si
         vuOKZi2OE49OG9mPUdlJfMRkEE3ZYcTtRGC2uYBTv6reipUO2En4vIHVcCSI9e+Mo9ms
         0AFi67qx/YHk4j1ZfaKdoYBxt1nk6PWRNsS10d15FWf5FwYEiuH77ac6cCzKjMDOwu6/
         ISiJMPFZW02dTFvIEvRdQ6jJxYGiTscLb8e4fXne/hIccz8E+BkRJyV+ckSXg4rghckV
         /e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wdp1lywqmKgyuKU1G9KHrqyijHJooeS6kbCPCzKFfhw=;
        b=g93H9lwz/ENF4fr+J/TUFbSRYGPRstLxRJKoilnKoIiBk8h5C1qExC4Mrso1M8UXZK
         zWytshpNdWH4V713GVc++N9J6E6cnhi0jX1hq+BLk6LBl33/DEEHeeMevrgrLaotW3L0
         CXbr4NUiLSwZTvPrkBFnyFmv+1qtqqH1VK2H5NKY1Q2Nfr1hswl0QbmviK1RKF1Soful
         ejrpETZQaJFsspnauEPVVzx5jkIjIkYhf20INBuXR1vlvMwHU62mzVQuKbTLV60a6gQC
         /WEk5c9y1CwyPP3CBc695X6yGrnA8CRvMfwKeLx78ztCSti+T8HUrGITQFv/ECqSE+u9
         PFHg==
X-Gm-Message-State: APjAAAXmT0Kpw9UuRobUDAdOOuabWTsI/oRjIDOdlDhFQWQ/FltbKWH4
        HZWth7C6a1uFH4h4Ad3uH4hewQ==
X-Google-Smtp-Source: APXvYqyqhtOn92/ve8YTh8k7+IFMsV1kDxuJs8W1r/wyRn3LTpEBKCwZy8HajcqXt77kdv+Abk7yaQ==
X-Received: by 2002:ac8:7612:: with SMTP id t18mr30473363qtq.143.1574879921076;
        Wed, 27 Nov 2019 10:38:41 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o62sm2739257qte.76.2019.11.27.10.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:38:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] iommu: match the original algorithm
Date:   Wed, 27 Nov 2019 13:38:39 -0500
Message-Id: <FD54B9BA-53FE-4CF0-954F-8DC8418DAE3F@lca.pw>
References: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
To:     John Garry <john.garry@huawei.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 1:01 PM, John Garry <john.garry@huawei.com> wrote:
>=20
> I haven't gone into the details, but this patch alone is giving this:
>=20
> root@(none)$ [  123.857024] kmemleak: 8 new suspected memory leaks (see /s=
ys/kernel/debug/kmemleak)
>=20
> root@(none)$ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff002339843000 (size 2048):
>  comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<000000001d2710bf>] kmem_cache_alloc+0x188/0x260
>    [<00000000cc229a78>] init_iova_domain+0x1e8/0x2a8
>    [<000000002646fc92>] iommu_setup_dma_ops+0x200/0x710
>    [<00000000acc5fe46>] arch_setup_dma_ops+0x80/0x128
>    [<00000000994e1e43>] acpi_dma_configure+0x11c/0x140
>    [<00000000effe9374>] pci_dma_configure+0xe0/0x108
>    [<00000000f614ae1e>] really_probe+0x210/0x548
>    [<0000000087884b1b>] driver_probe_device+0x7c/0x148
>    [<0000000010af2936>] device_driver_attach+0x94/0xa0
>    [<00000000c92b2971>] __driver_attach+0xa4/0x110
>    [<00000000c873500f>] bus_for_each_dev+0xe8/0x158
>    [<00000000c7d0e008>] driver_attach+0x30/0x40
>    [<000000003cf39ba8>] bus_add_driver+0x234/0x2f0
>    [<0000000043830a45>] driver_register+0xbc/0x1d0
>    [<00000000c8a41162>] __pci_register_driver+0xb0/0xc8
>    [<00000000e562eeec>] sas_v3_pci_driver_init+0x20/0x28
> unreferenced object 0xffff002339844000 (size 2048):
>  comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)
>=20
> [snip]
>=20
> And I don't feel like continuing until it's resolved....

Thanks for talking a hit by this before me. It is frustrating that people te=
nd not to test their patches properly  with things like kmemleak.=
