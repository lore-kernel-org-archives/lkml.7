Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD320896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X5ieFSrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfDAMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:04:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34280 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfDAME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:04:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401120427euoutp025dad645ad3e9f7129519407a735c58c1~RWCZGrP5I1590015900euoutp02d
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 12:04:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401120427euoutp025dad645ad3e9f7129519407a735c58c1~RWCZGrP5I1590015900euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554120267;
        bh=GUCinh58f0fmdGROh1Z32/WkaaVB5G010l2lKMQ2JDs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X5ieFSrLvuPjlZrKU3LK/X5Sb6wBJSU8HafWFURfTICY8x7cior6FIz+RWkmOfBca
         sGBG9h51tu1zYfnBUqYJLgAkDiJlRaQp1I/9RopOslLOJ68JHKowv1H1POC1w73MMg
         wVIUNG8L5MWUsRidXS2Ch+ZgTHr0Sa4+JH4RsQJQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401120427eucas1p2f8b08fceeed6faf02a1214b7392a5f70~RWCYz-iKi1988919889eucas1p2V;
        Mon,  1 Apr 2019 12:04:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 11.92.04325.B4EF1AC5; Mon,  1
        Apr 2019 13:04:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401120426eucas1p19b20d555750c540a84198cfe3ca77926~RWCYFq78y2799727997eucas1p1q;
        Mon,  1 Apr 2019 12:04:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401120426eusmtrp2853613df0412079f20c293b7c2b9c048~RWCX3qede2087820878eusmtrp2Y;
        Mon,  1 Apr 2019 12:04:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-75-5ca1fe4bd553
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.D9.04140.A4EF1AC5; Mon,  1
        Apr 2019 13:04:26 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401120426eusmtip11124b370a89e76a6a552702e4fece1de~RWCXlshrw2544725447eusmtip1n;
        Mon,  1 Apr 2019 12:04:26 +0000 (GMT)
Subject: Re: [PATCH] video/macfb: Always initialize DAFB colour table
 pointer register
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <aed176be-adce-dd80-8f54-55a1ca33a65b@samsung.com>
Date:   Mon, 1 Apr 2019 14:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7re/xbGGCyZJWBx5et7NouJvUtZ
        LE70fWC1uLxrDpvF8idrmR1YPe53H2fyONn6jcXj2cGHrB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZWxf0s1WcJu54szzdtYGxgnMXYycHBICJhL9X56zdTFycQgJrGCUONT1Esr5wihx4tl9Zgjn
        M6PEnNnLWLoYOcBals0Sg4gvZ5Q4PekhI8goIYG3jBJv34SB2MICERKblzxgAbFFBLQlJr7Z
        ATaVWaCRUWL50kWsIAk2ASuJie2rwJp5BewkNvz8B9bAIqAiMe3BelaQZaJAg/rPqEOUCEqc
        nPkErIRTIFFix7a3TCA2s4CBxJFFc1ghbHmJ7W/ngB0tIdDNLnH84gwmiD9dJG4+2MYCYQtL
        vDq+hR3ClpH4v3M+E0TDOkaJvx0voLq3A106+R8bRJW1xOHjF1khbEeJ90cmM0OCgk/ixltB
        iM18EpO2TYcK80p0tAlBVKtJbFi2gQ1mV9fOldBw95BYveYfywRGxVlIfpuF5J9ZSP5ZwMi8
        ilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzChnP53/OsOxn1/kg4xCnAwKvHwVjAtjBFi
        TSwrrsw9xCjBwawkwnumf0GMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2amp
        BalFMFkmDk6pBsbr607If6qvXHLHc6vS46MRJWnrDnS+fR7OfzJT2O2Re7rF53bd2l7dsz9/
        5W51Xb1sX6/XBY5sxrauSR82p7l13d7JkOdkefBY7eIuxcrdXrYTBBe1+JkIbpwVzN26fxZf
        w0WlM3VLYj+IVF9erRC16+/zZr5Xn42fTVGawHz9jGsem822+l1KLMUZiYZazEXFiQCaPD0J
        JAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7pe/xbGGEztkbG48vU9m8XE3qUs
        Fif6PrBaXN41h81i+ZO1zA6sHve7jzN5nGz9xuLx7OBDVo/Pm+QCWKL0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MrYv6WYruM1cceZ5O2sD4wTm
        LkYODgkBE4lls8S6GLk4hASWMkos7XjLBBGXkTi+vqyLkRPIFJb4c62LDaLmNaPE4avvGUES
        wgIREv8OvmUHsUUEtCUmvtkBVbSFUeL0uz4WEIdZoJFR4lTrerAONgEriYntq8BsXgE7iQ0/
        /7GA2CwCKhLTHqxnBbFFgabeetjBAlEjKHFy5hMwm1MgUWLHNpDrOIGG6knsuP6LFcKWl9j+
        dg7zBEbBWUhaZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAONl27OeWHYxd
        74IPMQpwMCrx8FYwLYwRYk0sK67MPcQowcGsJMJ7pn9BjBBvSmJlVWpRfnxRaU5q8SFGU6An
        JjJLiSbnA2M4ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD44Ia
        P1fXh23cMo1SKyr5Qr5eX/RosXuZufOar/NWzvz/JXXX00udIXEqf1wdV5s+TX7iuPXjF7s+
        1xQpKbWszkfVwf4NKoEHH21PmPbF484UD1HrhHvnp7A1Fu98opuUVPPSV+68SWL5nykzL+eI
        v++9J7MnRr/+UeJdLd1g+cv9zdHKicxLlViKMxINtZiLihMBs0Hfe6kCAAA=
X-CMS-MailID: 20190401120426eucas1p19b20d555750c540a84198cfe3ca77926
X-Msg-Generator: CA
X-RootMTR: 20190218224758epcas5p21d3d13ec8323a3ff3c04d45081b4cfff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190218224758epcas5p21d3d13ec8323a3ff3c04d45081b4cfff
References: <CGME20190218224758epcas5p21d3d13ec8323a3ff3c04d45081b4cfff@epcas5p2.samsung.com>
        <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/18/2019 11:44 PM, Finn Thain wrote:
> Don't skip the framebuffer CLUT pointer register initialization when
> the first dafb_setpalette() invocation has regno equal to zero.
> 
> Cc: linux-m68k@lists.linux-m68k.org
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
