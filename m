Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35A7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8310A20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c80/i8+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfF1NFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:05:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60866 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1NE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:04:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628130458euoutp02df646bb45df2bb811454e66732612113~sXoWXqyS31239412394euoutp02r
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 13:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628130458euoutp02df646bb45df2bb811454e66732612113~sXoWXqyS31239412394euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561727098;
        bh=azJ0h6ZVhBwbAHngYmcrBwHJm9Bf5q4qoO5kz4/kjtg=;
        h=To:Subject:Cc:From:Date:In-Reply-To:References:From;
        b=c80/i8+sDotncj2R+VBFeHyvnbfO5CzFJg84o1bdOzxLXm0r+89189J7v8NY8E3MR
         hc5sAhOSaTbbSS/+s1qjqY4LDQUi1QPn53etqNqb7o8Un3EKJWcaaHfUrrbREXW7rn
         8UiG17wgeqwjuG6ny3Jd6rZx8ElkrjZLQ4EpruQY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628130457eucas1p11b07b8522b1efb5aea30bce4fc5480e4~sXoVlntXp0068300683eucas1p1j;
        Fri, 28 Jun 2019 13:04:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3A.73.04325.970161D5; Fri, 28
        Jun 2019 14:04:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628130457eucas1p1d35ba783154258f803c027c93c2fb552~sXoU5u6OE0065000650eucas1p1A;
        Fri, 28 Jun 2019 13:04:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628130456eusmtrp10bb31dbc43c50b404d0533e529f67cb8~sXoUrmyDQ2089920899eusmtrp1f;
        Fri, 28 Jun 2019 13:04:56 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-09-5d161079319f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.3C.04146.870161D5; Fri, 28
        Jun 2019 14:04:56 +0100 (BST)
To:     undisclosed-recipients:;
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190628130456eusmtip18b5d49eeac50f43f6cdfe3e974afce51~sXoUGs2d_1045810458eusmtip1b;
        Fri, 28 Jun 2019 13:04:56 +0000 (GMT)
Subject: Re: [PATCH 10/12] fbdev: da8xx-fb: use
 devm_platform_ioremap_resource()
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <791c1eed-ad83-3155-8736-9c199f27ad3e@samsung.com>
Date:   Fri, 28 Jun 2019 15:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-11-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVcRjud8/HPe66+rnEm6za2bJpQ61WJ5nV1h/nr9b6LqOOnGEhuycK
        FW2Fbt/dDJeKkiupfDQiYaxuxTSl6640RImyqy5tFZZ7z7X897zP+z6/533e/RhC84nyZmLi
        j4jaeCGWpVVkzfPfHf7J2DNs5Y1hlhu//ork6vtqaK79+0cldyvdk+uasNJc6XiekvtcPaDg
        eieeIe7apFHBVQ2YKe7FxTGKe1tfQHNNFyoUG9W81XJGyd82f6D4OsNHJV9Vdpbmf156SfE9
        5gaa7z1nUvDVxWm8yVKr4G1VS7aq9qmCI8XYmCRRGxhyQBVdVqJHCX3EsencUjId5RA65MIA
        XgOVb3IVOqRiNLgUQXaGlZKLcQSWd8NILmwIPgz9pmclOdk9tNwwIigx9jve8sA+cD1/wCkf
        RTDScM6hcMfbwGSqJOwNAo8QYDmd51DQOAiuZJYhO1bjEOjO6HXwJF4Omc21SjteiPdA7/MK
        Sp5xg5d5g6Qdu8ys0XamyMET2AveD95UyHgp1I4WOMwAn2JAPzGmlPfeDMa3N5yx3WHE9MjJ
        +0Cb/jwpCx4gmMr66lTXIjDqp52pN0CrqXPGjpmx8IOH9YEyvQme/B1w0IBdwTLqJi/hCldr
        7Ce202rIytDI075QUVJBz9rq6u4SlxFrmBPNMCeOYU4cw3/fQkSWIS8xUYqLEqXV8eLRAEmI
        kxLjowIOHo6rQjM/r23aNPEYNU5GtCDMIHa+ulDlGaahhCQpOa4FAUOwHupFHR5hGnWkkJwi
        ag/v1ybGilILWsyQrJc6dV5fqAZHCUfEQ6KYIGpnuwrGxTsd7bAabY+8bSfvrB3KWhaU9W5Z
        M+WjDje7875d9/w12zon2d1KM9tQ+WtKCk+07mrUp8UuHm4tzjyY7x2SiSO26Jp2fiFK7rss
        +jHVGBxx9lnKixPrYso9W9dTTRBaHJnaI1hHOt3wUHlH+/bjRbDSd6/Q/frpt76uBTZJ5/en
        nyWlaGHVCkIrCf8A6+4jNHUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7oVAmKxBhsb9Sy+zD3FYrHrwTY2
        izNv7rJbLGoQs7jy9T2bxYovM9ktnm5+zGRx/+tRRospf5YzWWx6fI3V4kTfB1aLy7vmsFns
        793A5MDr8f5GK7vH4mu3WT12zrrL7rFpVSebx6f+k6wed67tYfO4332cyWPzknqP4ze2M3l8
        3iQXwBWlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l7Fq2WTGggfMFf9mrGBpYJzO3MXIySEhYCIxfeodti5GLg4hgaWMEm3TTjGCJEQEZCTmzn7M
        2sXIAVQkI3F8fRlEvbDEn2tdUPWvGSXezb0DVi8sECRx/PhGZpAEs8AbZomvZ5+xQlRtAJq6
        djJYFZuAlcTE9lVgNq+AncT1tvtgZ7AIqEq0H9jODmKLCkRInHm/ggWiRlDi5MwnYDYn0Kmn
        WxeygtjMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqml
        xbnpucWGesWJucWleel6yfm5mxiBEb7t2M/NOxgvbQw+xCjAwajEw7uASyxWiDWxrLgy9xCj
        BAezkgiv5DmRWCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByafvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjBO3P7PYY69ak3XwjpdEsem2c+bu7Ym7j9WX
        NjdmH5rrKH0mwGhR4eNtZou4c9imPYvkW1YpL6a86sWaWauWxH9Wq57JyLKsf2Jq7t9WPsGv
        n/8fjz6qMd+WzZL91g2XEIHv1QbtUjdzxZ8x+etsqM3Zcs03OrHmdv731w+mf2W6cFFwgXrH
        bSWW4oxEQy3mouJEAA2MUigGAwAA
X-CMS-MailID: 20190628130457eucas1p1d35ba783154258f803c027c93c2fb552
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163506epcas1p26885f2898ef4b47cc0449344aea947e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163506epcas1p26885f2898ef4b47cc0449344aea947e9
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163506epcas1p26885f2898ef4b47cc0449344aea947e9@epcas1p2.samsung.com>
        <20190625163434.13620-11-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Shrink the code a bit by using the new helper wrapping the calls to
> platform_get_resource() and devm_ioremap_resource() together.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
