Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4562166E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T5sIc6AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbfHWKmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:42:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52128 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbfHWKmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:42:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190823104229euoutp0130209f8913cd1e7aabf5700a8a8970aa~9hz7qcEH62159621596euoutp017
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 10:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190823104229euoutp0130209f8913cd1e7aabf5700a8a8970aa~9hz7qcEH62159621596euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566556949;
        bh=/+8sX1IwLtd70Fz4kr7IaaRknglBZi+mCocggncPzmQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=T5sIc6ALwC9iPZFhwAFv/qdzKSKIHieA5RuGoO6sc8SqRkTDZ04EwMnISK4isuLF1
         1+ZRNeel+AjN6YD9mD35qOPsEPz9u7HeabjMFlwcDdUNtMbNo8OrttcHZONSYxWeoZ
         yQ/5RdGifp+pMCyOxz1SIEldQjTAQ58jTOus1sHc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190823104228eucas1p186ef5140430ad48c986e5e56202d7b43~9hz61FU-92136521365eucas1p1B;
        Fri, 23 Aug 2019 10:42:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.92.04469.413CF5D5; Fri, 23
        Aug 2019 11:42:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190823104228eucas1p2ce9162667a7fac65d3bf4abfa38253e7~9hz6GWqJR0355603556eucas1p2K;
        Fri, 23 Aug 2019 10:42:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190823104227eusmtrp16ee00847a73b5142e0981d52aaf6f641~9hz52bcv90951109511eusmtrp1X;
        Fri, 23 Aug 2019 10:42:27 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-68-5d5fc314047d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.EE.04166.313CF5D5; Fri, 23
        Aug 2019 11:42:27 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190823104227eusmtip2e7c89f5bb809d018b40bbd2c3a1aea7b~9hz5f3nw20575205752eusmtip27;
        Fri, 23 Aug 2019 10:42:27 +0000 (GMT)
Subject: Re: [PATCH v6] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7d3c4379-23bd-ef3a-e725-86516097850a@samsung.com>
Date:   Fri, 23 Aug 2019 12:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820165715.15185-1-max@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7oih+NjDVrmylusvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC2KyyYlNSezLLVI3y6BK2Pn3ymsBU28FatX32dvYJzP1cXIySEhYCIxde8l
        ti5GLg4hgRWMEv83nWGCcL4wStxdcIkVwvnMKLH7x0d2mJa1Kz9BJZYzShzbsoQNJCEk8JZR
        YusJERBbWCBQ4tenWYwgtoiAnMTH1quMIA3MAtsYJY6efgU2iU3ASmJi+yqwIl4BO4mWZxPA
        bBYBVYmXTXuYQWxRgQiJ+8c2sELUCEqcnPmEBcTmFDCWeL1hDlgNs4C4xK0n85kgbHmJ7W8h
        4hICh9glbq2Bsl0knu5cxARhC0u8Or4F6hsZidOTe1hAjpMQWMco8bfjBTOEs51RYvnkf2wQ
        VdYSh49fBLqCA2iDpsT6XfogpoSAo8TFv7IQJp/EjbeCECfwSUzaNp0ZIswr0dEmBDFDTWLD
        sg1sMFu7dq5knsCoNAvJY7OQPDMLyTOzENYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJEZiSTv87/mkH49dLSYcYBTgYlXh4T3TFxQqxJpYVV+YeYpTgYFYS4S2bCBTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAqHLk8k6XdVd5u6JvVKv8
        VCpKbd724cCsx7VqG3w2SCrr7hEye5ovl3jp+iRJM//2U2Juu+3+nZbRW8nkmCHbfCvrR23A
        8m+OCt1N+TLSyqWr2Bb+NJ3s+iOB5eoB00N/TK6FKJpd3i3Bn9PatY9ryfkLLy8Kz1NVuN/+
        VUK9vmWB779yO4P/SizFGYmGWsxFxYkAJawZ7kUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7rCh+NjDVZd07ZYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsbOv1NYC5p4K1avvs/ewDifq4uRk0NCwERi7cpPrF2MXBxCAksZJQ5ve8LexcgB
        lJCROL6+DKJGWOLPtS42iJrXjBL3PqxkB0kICwRK/Po0ixHEFhGQk/jYepURpIhZYBujxNdr
        0xkhOtoYJe6snsIEUsUmYCUxsX0VWAevgJ1Ey7MJYDaLgKrEy6Y9zCC2qECExJn3K1ggagQl
        Ts58AmZzChhLvN4wB6yGWUBd4s+8S1C2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFp
        WcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwDrcd+7l5B+OljcGHGAU4GJV4eE90xcUK
        sSaWFVfmHmKU4GBWEuEtmwgU4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgisgriTc0NTS3
        sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCY+XwmU21jUeuOpYt/LJuS4edX
        9jDV/Nukg5EG6/3jexVY468e5T9c9Oj3/GmachqtDRMXT7xQJvSYpT7vaWbi//ubcpwN5oum
        GHe0se9YbrPpmF7KQlvHmZdEtaWlU/52TBaf4CUMjOmJDzQezDzXFFHtdvtJZ4RH48J1zz88
        e3heQ1Lz3iIlluKMREMt5qLiRAAiHiZD2QIAAA==
X-CMS-MailID: 20190823104228eucas1p2ce9162667a7fac65d3bf4abfa38253e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820165731epcas2p340cc3421251987896b857da4ec42038e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820165731epcas2p340cc3421251987896b857da4ec42038e
References: <CGME20190820165731epcas2p340cc3421251987896b857da4ec42038e@epcas2p3.samsung.com>
        <20190820165715.15185-1-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 8/20/19 6:57 PM, Max Staudt wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
> 
> v6: Only do the drvdata workaround for X-Surf (remove breaks otherwise)
>     Style
> 
> v5: Remove module_exit(): There's no good way to handle the X-Surf hack.
>     Also include a workaround to save X-Surf's drvdata in case zorro8390
>     is active.
> 
> v4: Clean up pata_buddha_probe() by using ent->driver_data.
>     Support X-Surf via late_initcall()
> 
> v3: Clean up devm_*, implement device removal.
> 
> v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
>     git diff --ignore-space-change
> 
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/ata/pata_buddha.c | 231 +++++++++++++++++++++++++++-------------------
>  1 file changed, 138 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
> index 11a8044ff..9e1b57866 100644
> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c

[...]

> +static struct zorro_driver pata_buddha_driver = {
> +	.name           = "pata_buddha",
> +	.id_table       = pata_buddha_zorro_tbl,
> +	.probe          = pata_buddha_probe,
> +	.remove         = pata_buddha_remove,
> +	.driver  = {
> +		.suppress_bind_attrs = true,

I thought that we had agreed that this is not needed?

With that fixed:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
