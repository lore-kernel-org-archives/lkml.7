Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E006C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AD722BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZOKe3aZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGZKcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:32:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39944 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:32:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190726103245euoutp012c907712ccc21ad07a949c25dbf2d18f~07ncO_g0x3170431704euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 10:32:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190726103245euoutp012c907712ccc21ad07a949c25dbf2d18f~07ncO_g0x3170431704euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564137165;
        bh=ZeWsLXk+YS9Yoiy28APDvI3/NlJ8HiaBiXquA6Wm64I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZOKe3aZ33dRqOp+64+OiNTsmelHHYjSwvGi+0rA/7a1hjoolmM0xsTg6AxC4MlGL5
         StRehgjVJ+GS9jhFEfNT0DibUKKrnez7C/2eyKYPoULIPDQdWsVUnhT9Y95ARY1h7s
         v4H/UJ5nWEW5hbI13VPRFiwhDc9nNL13ik326tc4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726103245eucas1p243067430d3fa9c3a3596ae6047ab8f36~07nbqcEZb0196601966eucas1p20;
        Fri, 26 Jul 2019 10:32:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 50.22.04325.CC6DA3D5; Fri, 26
        Jul 2019 11:32:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726103244eucas1p168a5d458110c6b25d6a9b7c994b91f0e~07na8LCxd2389223892eucas1p1n;
        Fri, 26 Jul 2019 10:32:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190726103244eusmtrp1dbaa18c406dcd6eaeeca6a82eb9238c4~07nauAu010348203482eusmtrp1d;
        Fri, 26 Jul 2019 10:32:44 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-b1-5d3ad6cc0d85
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.F5.04140.BC6DA3D5; Fri, 26
        Jul 2019 11:32:44 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190726103243eusmtip1ca35cb00f41769fc137927aa5d2288ec~07naODiLV2416124161eusmtip1H;
        Fri, 26 Jul 2019 10:32:43 +0000 (GMT)
Subject: Re: [PATCH] pata_ali: check the pci_get_device failure
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5999d94d-1e6b-541e-8cba-55270742613c@samsung.com>
Date:   Fri, 26 Jul 2019 12:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190725012506.17831-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7pnrlnFGqxZaGCx+m4/m8Wzxums
        FifmnWW3OLbjEZPF5V1z2Cx6T+5gttj2Rtti2pdF7A4cHjtn3WX3uHy21OP9vqtsHlcXNrF7
        fN4kF8AaxWWTkpqTWZZapG+XwJUxc80a1oIOzoqGpUfZGhg3s3cxcnJICJhI9MzpZOti5OIQ
        EljBKLF15XxGCOcLo8Tv031MEM5nRolXp/eywLTMXDkVqmo5o8SZlw+YIZy3jBLtf2Yxg1QJ
        C9hL3NzfBbZEREBfYsGDx2CjmAWWMErMePoaLMEmYCUxsX0VI4jNK2AncejeNiYQm0VAVeLV
        xvdg60QFIiTuH9vAClEjKHFy5hOwOCfQgseHnoHNYRYQl7j1ZD4ThC0vsf3tHLCLJAS2sUtM
        WL+DFeJuF4n5mzuhbGGJV8e3QINARuL05B4WiIZ1jBJ/O15AdW9nlFg++R8bRJW1xOHjF4G6
        OYBWaEqs36UPEXaU6Pr1hhkkLCHAJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0lsWLaBDWZt186V
        zBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQLT0el/
        x7/uYNz3J+kQowAHoxIPr8Yqy1gh1sSy4srcQ4wSHMxKIrxbdwCFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MPKeNL/4hyfw88rTezg9eNTfKd68M53h
        /+fNyWdOb9bpm5U1/ZV9d09v/unPovHz3f4ycszLsH6Ts1YwbPrO06urJswQ6XO+t2Uqn8Pe
        uxwqz3jbhP5v4jhyfFnd3bs80im/8szfvpD3eHFL4M7W7m+qvXkLkyKmlrZXuCn+/5yp2cS4
        XXbbLhclluKMREMt5qLiRAAxIXm9QwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7pnrlnFGrwMs1h9t5/N4lnjdFaL
        E/POslsc2/GIyeLyrjlsFr0ndzBbbHujbTHtyyJ2Bw6PnbPusntcPlvq8X7fVTaPqwub2D0+
        b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y5i5Zg1rQQdnRcPSo2wNjJvZuxg5OSQETCRmrpzK2MXIxSEksJRRounKLaAEB1BCRuL4+jKI
        GmGJP9e62CBqXjNKrLjeANYsLGAvcXN/F5gtIqAvseDBYyaQImaBJYwSD35+Z4XomMQo8eTm
        EiaQKjYBK4mJ7asYQWxeATuJQ/e2gcVZBFQlXm18zwJiiwpESJx5v4IFokZQ4uTMJ2A2J9C2
        x4eegW1jFlCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEkt
        Lc5Nzy020itOzC0uzUvXS87P3cQIjL1tx35u2cHY9S74EKMAB6MSD++F5ZaxQqyJZcWVuYcY
        JTiYlUR4t+4ACvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MC3klcQbmhqaW1gamhubG5tZ
        KInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgDBSPl3QX+nhs5cb/Vacrf73aWF1dnX284XkE
        m0rEfb45ZXXqzNuyEv6UzmI2KFzEt6DyzaYgIaeWR8ZTtar+/b7GPqOwtUZ2cxebQWr9mncN
        rE99XiYbG85L33/s3tGyoLmz/vo6J/rs3fPpPyuf86KQJwYGdt1SL9b+rJPQSHn6TG6zwHI+
        JZbijERDLeai4kQAT44Mu9MCAAA=
X-CMS-MailID: 20190726103244eucas1p168a5d458110c6b25d6a9b7c994b91f0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725012523epcas1p4b3ff8ee4cf2ceba3e6fa0ae0b568418f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725012523epcas1p4b3ff8ee4cf2ceba3e6fa0ae0b568418f
References: <CGME20190725012523epcas1p4b3ff8ee4cf2ceba3e6fa0ae0b568418f@epcas1p4.samsung.com>
        <20190725012506.17831-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 7/25/19 3:25 AM, Navid Emamdoost wrote:
> pci_get_device may fail and return NULL. This eventually will be
> dereferenced in __pci_register_driver. So null check is necessary.

I'm sorry to say this but the patch is incorrect and should not be
applied.

ALI M1533 ISA bridge presence is optional (the driver can work also
with other ISA bridges) and ali_isa_bridge is always correctly checked
for NULL before being dereferenced in the driver.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/ata/pata_ali.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 0b122f903b8a..47d9bec1f2e2 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -627,6 +627,8 @@ static int __init ali_init(void)
>  {
>  	int ret;
>  	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
> +	if (!ali_isa_bridge)
> +		return -EINVAL;
>  
>  	ret = pci_register_driver(&ali_pci_driver);
>  	if (ret < 0)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
