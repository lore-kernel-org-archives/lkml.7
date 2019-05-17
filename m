Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB6C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FC82087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OPimjJDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEQLYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:24:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33161 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfEQLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:24:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190517112452euoutp010694a5e78823722996830f8fcbaca725~fdK9S-sSy0777707777euoutp01b
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190517112452euoutp010694a5e78823722996830f8fcbaca725~fdK9S-sSy0777707777euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558092292;
        bh=s5xn7k0/PVouqiLEPICwHZnbldv3z7LESLoslwe+Fug=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OPimjJDfUpGJ864Co3ggSgU0rAlm/mVajf5gCTl78zCtWMk5m8RwAex8gdbHD8jia
         2D95RJuuiuD2oD8OK4jwkhQtJA5FjMBR4XwWVaqb40RxFO96ueMprGoVO86ZsHUgk7
         OeBUtWW/7s5NK4wNHNKVQ6+bavLP45RXP2q8cqZU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190517112451eucas1p2cb66814f7d5b3db55da07e65459ce182~fdK8jo9Bb1635116351eucas1p2v;
        Fri, 17 May 2019 11:24:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.AD.04325.30A9EDC5; Fri, 17
        May 2019 12:24:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190517112450eucas1p2d987b7b6bcb6058af76d435a9fe79158~fdK70Td812524425244eucas1p2d;
        Fri, 17 May 2019 11:24:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190517112450eusmtrp22af6d099881ef87ee4651f77e1a3f0fa~fdK7mP8As0539105391eusmtrp2v;
        Fri, 17 May 2019 11:24:50 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-a0-5cde9a03ce46
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.F6.04146.20A9EDC5; Fri, 17
        May 2019 12:24:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190517112450eusmtip26bf5615b51f217ab73c7d60def838c43~fdK7SddQ02003220032eusmtip2L;
        Fri, 17 May 2019 11:24:50 +0000 (GMT)
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <782f3255-3a25-4620-e97c-2f742e733f32@samsung.com>
Date:   Fri, 17 May 2019 13:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426145946.26537-1-ghalat@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjt9bvsczh5nSufzApGGQlpluDUkiKJESVFBZUjW+1jSt7avPtH
        CS+sEFNBXVpSeS9dZs4bRhOckmlOTEu8gWWJOsELmJfy81Py33mec85z3gMvQ4iLKWcmNCKa
        1UQow6S0kKxvX+4+RuhHFMfT8yWy8uZZJHv4soaW5RrmbGQdmXOUrK+pkJZNV/TYnKHlH4pe
        C+TW1n5aXlPXT8rnaw9cJm8JT6nYsNBYVuPhf0cYMvIzlY5aEcY/XzEIktEUo0MMA9gLllIS
        dUjIiHE5go6lBVqHbDeGBQRNPT48MY+gO/cV4gjOMJ79m+KJMgQpqc1bwwyCoQELyakcsRre
        DxgJDkuwK3R9a0KciMAtCBbnxwQcQWNfeJJeuXlWhP0hy9i/aSDxYZjOL6I4vBvfgNF2A8Vr
        HKCzYGIzwBZ7Q1pRpw2HCewE3yeeb+GDYJwpJLgwwJUCMPWuUnzRAKgtTuArOMKUuU7AYxf4
        28h5OX01grWMX1tmI4KynHWaV/lBm7l38xCBj0JNkwe/Pgtt1jbE37eHwRkH/g32kF2fR/Br
        EWSkiXm1KxhKDfR2rK6xgshCUv2OZvodbfQ72uj/5xYjshI5sTHacDWrPRnBxrlrleHamAi1
        +73I8Fq08W8+rZsXG1Dr6l0TwgyS2onwxWGFmFLGahPCTQgYQioRGaxDCrFIpUxIZDWRwZqY
        MFZrQvsYUuokSto1FiTGamU0e59lo1jNNmvD2DonI/cX8jVMfnx2YhJPHgncn+9jufL1fI6d
        JM9887ZX3R5VaYvwdJcnq64araN9Jy1d565S8R6DRfmzj6IqgueTfiy3vIOA4T+XSlLzBA5e
        9iXeb68pqtuDrF8sT93U6kxR495DF64Hfm4IlHpV+fU9iCtxeTNGRRfoylQpeHym7LGU1IYo
        Pd0IjVb5D+mQp04zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7pMs+7FGPy8o2yxYvc7RovmxevZ
        LKZs+MBkcaLvA6vF5V1z2CzerDzP5MDmsX/uGnaP9/uusnms33KVxePzJrkAlig9m6L80pJU
        hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHvPWtkKfnNVzP+9
        gb2B8RVHFyMnh4SAicTDSS9Zuxi5OIQEljJKXPq4k72LkQMoISNxfH0ZRI2wxJ9rXWwgtpDA
        a0aJK7sMQGxhgXSJrde3M4PYIgJqEmdu7mIEmcMssI9RYse5H1BDuxglFr45DNbNJmAlMbF9
        FSOIzStgJzFh+1WwbhYBVYk3M+aygtiiAhESZ96vYIGoEZQ4OfMJmM0pYC7RNvckE4jNLKAu
        8WfeJWYIW1zi1pP5UHF5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwwrYd+7l5B+OljcGHGAU4GJV4eAV87sYIsSaWFVfmHmKU4GBWEuHd8P52
        jBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA6M/ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQ
        QHpiSWp2ampBahFMHxMHp1QDo0rDZLaP29/ffdUQZ/xIZMqEzBcOWy6fPWIdZCDmFfl8dQ/D
        zIQJT9s2slnJ7WWpP6z4o6z9xZ/yJWKaR4M/h3q0uEkm+Rd2qMQJrTctW/F6raBd8fP2+2Hz
        /Z5wc+ec3yRcpnP4jVqeUscS3+dvpz3Mvnl77c669x0OMj48U5PPS549+DGVS4mlOCPRUIu5
        qDgRANn0/lLGAgAA
X-CMS-MailID: 20190517112450eucas1p2d987b7b6bcb6058af76d435a9fe79158
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190426145959epcas3p452b4b80025c58916331820abbb0060ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190426145959epcas3p452b4b80025c58916331820abbb0060ed
References: <CGME20190426145959epcas3p452b4b80025c58916331820abbb0060ed@epcas3p4.samsung.com>
        <20190426145946.26537-1-ghalat@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/19 4:59 PM, Grzegorz Halat wrote:
> After memory allocation failure vc_allocate() doesn't clean up data
> which has been initialized in visual_init(). In case of fbcon this
> leads to divide-by-0 in fbcon_init() on next open of the same tty.
> 
> memory allocation in vc_allocate() may fail here:
> 1097:     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> 
> on next open() fbcon_init() skips vc_font.data initialization:
> 1088:     if (!p->fontdata) {
> 
> division by zero in fbcon_init() happens here:
> 1149:     new_cols /= vc->vc_font.width;
> 
> Additional check is needed in fbcon_deinit() to prevent
> usage of uninitialized vc_screenbuf:
> 
> 1251:        if (vc->vc_hi_font_mask && vc->vc_screenbuf)
> 1252:                set_vc_hi_font(vc, false);
> 
> Crash:
> 
>  #6 [ffffc90001eafa60] divide_error at ffffffff81a00be4
>     [exception RIP: fbcon_init+463]
>     RIP: ffffffff814b860f  RSP: ffffc90001eafb18  RFLAGS: 00010246
> ...
>  #7 [ffffc90001eafb60] visual_init at ffffffff8154c36e
>  #8 [ffffc90001eafb80] vc_allocate at ffffffff8154f53c
>  #9 [ffffc90001eafbc8] con_install at ffffffff8154f624
> ...
> 
> Signed-off-by: Grzegorz Halat <ghalat@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
