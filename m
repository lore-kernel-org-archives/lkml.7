Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A8CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nGFTvmzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfHLKmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:42:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35562 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfHLKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:42:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190812104216euoutp02a5b950719405037bfeb4aad988b08c31~6Jtmgxsjn2250122501euoutp02k
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190812104216euoutp02a5b950719405037bfeb4aad988b08c31~6Jtmgxsjn2250122501euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565606536;
        bh=FS72VoJ4j9I/0KoqeF6uHZUuKZul+sKw2fk3JxjZjDE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nGFTvmzntgkHfcXL0rC1nQgjHsfB6rieFb2+6QD6KIo9+c45A21k88Y03Mk+BlBd/
         gBJiv2qS3qQzAMCyoBHJa9bQXFv53uTNgSYmu41AUrVobzHKjPXZW8vvtqPiXIrOGZ
         Lz+DOnDnVwcagWmOvLSuof0OyJPcfiFe3ccpUpb0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190812104215eucas1p132f1c48cbfb27c2446e7a4ed3f6833c0~6JtlzeRZd2991929919eucas1p1p;
        Mon, 12 Aug 2019 10:42:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.5E.04309.782415D5; Mon, 12
        Aug 2019 11:42:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190812104215eucas1p2d2714be68f9c407dd28c861b210f870e~6JtlFcdCk1905319053eucas1p2D;
        Mon, 12 Aug 2019 10:42:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190812104214eusmtrp28a352dc6d0e2ddf42828f8fe386bf877~6Jtk3ZLzX0672406724eusmtrp2V;
        Mon, 12 Aug 2019 10:42:14 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-89-5d5142879a27
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.0C.04117.682415D5; Mon, 12
        Aug 2019 11:42:14 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190812104214eusmtip2319ec221c769b841d79b043f0f656748~6JtkchpFD1621316213eusmtip2u;
        Mon, 12 Aug 2019 10:42:14 +0000 (GMT)
Subject: Re: [PATCH v4] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4729c030-549e-8797-f947-1620cd61d516@samsung.com>
Date:   Mon, 12 Aug 2019 12:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d9fa8aca-62a4-5d4a-b63f-bdd628e6b304@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87rtToGxBrPmKlqsvtvPZvHs1l4m
        i9nvlS2O7XjEZHF51xw2i93v7zNaPGz6wGQxt3U6uwOHx+Gvm9k8ds66y+5x+Wypx6HDHYwe
        B8+dY/T4vEkugC2KyyYlNSezLLVI3y6BK2PBkzOsBa38FdePfWRsYGzj6WLk5JAQMJGYvmop
        cxcjF4eQwApGiS8Ln7BBOF8YJfrXHWQCqRIS+Mwo8fJCIkzH6UfHoIqWM0psunqBCcJ5yygx
        eV8/I0iVsECgxOKrS9lBbBEBOYmPrVcZQYqYBbYxShw9/QoswSZgJTGxfRVYA6+AncSvxVeZ
        QWwWAVWJJ6sOgsVFBSIk7h/bwApRIyhxcuYTFhCbU8BWYsnPl2D1zALiEreezGeCsOUltr+d
        A/aQhMA+doknP08BJTiAHBeJf6uEIV4Qlnh1fAs7hC0j8X/nfCaI+nWMEn87XkA1b2eUWD75
        HxtElbXE4eMXWUEGMQtoSqzfpQ8RdpTYt3QZC8R8PokbbwUhbuCTmLRtOjNEmFeio00IolpN
        YsOyDWwwa7t2rmSewKg0C8lns5B8MwvJN7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeu
        l5yfu4kRmJRO/zv+ZQfjrj9JhxgFOBiVeHgjfgbECrEmlhVX5h5ilOBgVhLhLfkLFOJNSays
        Si3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cCY4feF3zHCyOkywy81
        /1emjYfZRCQfbPrrwtlaXqMx74TCfpmKWJHoINXtvjXbCn+lB25jqDG58iDEocjUscRA5srE
        1Dufsv+/ebvOxXtR4vJrH29NEMs7/XzLtatqE7O48+XjP348ven24fdf3kXUvW6UL/7/8dsT
        kR2/NyXuE+bumRC2xu26EktxRqKhFnNRcSIA0KUhzUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7ptToGxBuca9SxW3+1ns3h2ay+T
        xez3yhbHdjxisri8aw6bxe739xktHjZ9YLKY2zqd3YHD4/DXzWweO2fdZfe4fLbU49DhDkaP
        g+fOMXp83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl7HgyRnWglb+iuvHPjI2MLbxdDFyckgImEicfnSMrYuRi0NIYCmjxPw3L4AcDqCE
        jMTx9WUQNcISf651QdW8ZpTYdOkvE0hCWCBQYvHVpewgtoiAnMTH1quMIEXMAtsYJb5em84I
        0bGTUWLJmUtsIFVsAlYSE9tXMYLYvAJ2Er8WX2UGsVkEVCWerDoIFhcViJA4834FC0SNoMTJ
        mU/AbE4BW4klP1+C1TMLqEv8mXcJyhaXuPVkPhOELS+x/e0c5gmMQrOQtM9C0jILScssJC0L
        GFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbhtmM/t+xg7HoXfIhRgINRiYc34mdArBBr
        YllxZe4hRgkOZiUR3pK/QCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aIvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjIqiX1uuvZijpD416KDV04rZV39u
        nruk4eenZ0lpf//Pia1dMs9h0wOpVfUGHkan9/WG5J/lnP6SfZqBRZFhm6WljPJh/xcKUUr3
        QnQPK61+r5VXah+gOu/229sKEjsWcmsZcsW1cXQJ3y7u8dJN8XJilCmWiW2849T2nZ8vsD/k
        d/My29iNSizFGYmGWsxFxYkAcTcqgNkCAAA=
X-CMS-MailID: 20190812104215eucas1p2d2714be68f9c407dd28c861b210f870e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5
References: <20190811153643.12029-1-max@enpas.org>
        <CGME20190811192838epcas1p16ec0d26fc6282e92da6aa82cdea330a5@epcas1p1.samsung.com>
        <d9fa8aca-62a4-5d4a-b63f-bdd628e6b304@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/19 9:28 PM, Max Staudt wrote:
> Replying to my own patch with two more questions:
> 
> 
> On 08/11/2019 05:36 PM, Max Staudt wrote:
>> -		/* allocate host */
>> -		host = ata_host_alloc(&z->dev, nr_ports);
> 
> Actually, this is an issue even the existing pata_buddha has: ata_host_alloc()> will dev_set_drvdata(dev, host) which is fine on Buddha and Catweasel, bu> conflicts with zorro8390's own dev_set_drvdata() on an X-Surf board. Thus,
> if both pata_buddha and zorro8390 are active, only one can be unloaded. The
> original ide/buddha driver does not have this problem as far as I can see.

ide/buddha driver cannot be unloaded currently (it lacks module_exit()).

> This should be resolved once we get around to MFD support, as Geert suggested.
> 
> Shall we leave this as-is, as it's not really a change from the status quo in
> pata_buddha?
pata_buddha also cannot be unloaded currently (also lacks module_exit()),
I think that we should leave it as it is until MFD support is added.

>> +static int __init pata_buddha_late_init(void)
>> +{
>> +        struct zorro_dev *z = NULL;
>> +
>> +	pr_info("pata_buddha: Scanning for stand-alone IDE controllers...\n");
>> +	zorro_register_driver(&pata_buddha_driver);
>> +
>> +	pr_info("pata_buddha: Scanning for X-Surf boards...\n");
>> +        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
>> +		static struct zorro_device_id xsurf_ent =
>> +			{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF};
>> +
>> +		pata_buddha_probe(z, &xsurf_ent);
>> +        }
>> +
>> +        return 0;
>> +}
> 
> This is suboptimal, as we don't release memory in case pata_buddha_probe()
> fails. Any suggestions?

It should work exactly like the old code in case of X-Surf,
what do we need to release?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
