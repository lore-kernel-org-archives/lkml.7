Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE592C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E3320645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mwPlN3yB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF1NDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:03:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60280 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1NDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:03:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628130334euoutp027f09eb5ca90d0dbbf50a446aae1a9070~sXnH7N0Cw1181711817euoutp02r
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 13:03:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628130334euoutp027f09eb5ca90d0dbbf50a446aae1a9070~sXnH7N0Cw1181711817euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561727014;
        bh=VbBmh0lqoFIOdVgmHOPMjXBb/1mrJ2U1b6I2moJwAto=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mwPlN3yBBU2PLxXQujGpz6gas1jzJ7a4jayeGBkTn5sIzg5RbJioLEWjPJhrBIkb0
         skaI2rgerQgpkgNFLQ+qI76Lm85PpNuboRHzwhp2DtulRUxtaIEvV1jzWp9sL91h3h
         6pqkp8naXK4UFMZSf1/tEbj5wUOmmd+gfYG+hWm0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628130333eucas1p10bfb6c7946045e775963fb75e2007b62~sXnHPeKHD0052100521eucas1p1V;
        Fri, 28 Jun 2019 13:03:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EB.46.04298.520161D5; Fri, 28
        Jun 2019 14:03:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190628130332eucas1p2b302e7dfdae6ee7a73c650f7e10d3f6e~sXnGT8QcT0994209942eucas1p2X;
        Fri, 28 Jun 2019 13:03:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628130332eusmtrp1b48d12dbc245b313516d2fc7055c34b0~sXnGF071t2018320183eusmtrp1M;
        Fri, 28 Jun 2019 13:03:32 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-6c-5d16102504fc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.0C.04146.420161D5; Fri, 28
        Jun 2019 14:03:32 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628130331eusmtip20a23949761c8468302efce2c8937874b~sXnFlrF7y0827408274eusmtip2X;
        Fri, 28 Jun 2019 13:03:31 +0000 (GMT)
Subject: Re: [PATCH 07/12] fbdev: da8xx: add support for a regulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8c9f36c1-1c55-a2af-8b2f-4c6811e029f3@samsung.com>
Date:   Fri, 28 Jun 2019 15:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-8-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7qqAmKxBrP7JC2+zD3FYrHrwTY2
        izNv7rJbLGoQs7jy9T2bxYovM9ktnm5+zGRx/+tRRospf5YzWWx6fI3V4kTfB1aLy7vmsFns
        793A5MDr8f5GK7vH4mu3WT12zrrL7rFpVSebx6f+k6wed67tYfO4332cyWPzknqP4ze2M3l8
        3iQXwBXFZZOSmpNZllqkb5fAldH85jtrwSGWiqsrn7A3MD5i7mLk5JAQMJG43fGRqYuRi0NI
        YAWjxPNLq6CcL4wSL6c2M0I4nxklDv/6xwbT8unUI3aIxHJGiZsX+qGq3jJKvDu1mAWkSljA
        RWLm5o1gS0QE1CUWrLsHNpdZ4CizxMvLq8FGsQlYSUxsX8UIYvMK2EkcuwjRzCKgKrH5+Xqw
        GlGBCIn7xzawQtQISpyc+QSshlPAWOLThlYwm1lAXOLWk/lMELa8xPa3c5hBlkkItHJITLjc
        ww5xt4vE7I5jUG8LS7w6vgUqLiNxenIPC0TDOkaJvx0voLq3M0osnwzztbXE4eMXgc7gAFqh
        KbF+lz5E2FFiZdMvFpCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9g
        VJqF5LVZSN6ZheSdWQh7FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMeaf/Hf+0
        g/HrpaRDjAIcjEo8vD94xGKFWBPLiitzDzFKcDArifBKnhOJFeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cDY7nZxt8bua3/rYxT9f/9Zq8YV/6st3H3W
        +1wh499XbKWiFGo/LL9xP3i/xXknxRMzb/vmTf/3J1m/pi3F7fv+eMEVImJ9LnNuvyyRVee7
        c6jh6ifTs7Fzb1ZOWvBQuvOB55mNvKt/LXPYzcazayP/y9ebDCrNM/bcXp/xWd5Rwj3tSFm/
        elKgEktxRqKhFnNRcSIAtY1X63UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7oqAmKxBss7pC2+zD3FYrHrwTY2
        izNv7rJbLGoQs7jy9T2bxYovM9ktnm5+zGRx/+tRRospf5YzWWx6fI3V4kTfB1aLy7vmsFns
        793A5MDr8f5GK7vH4mu3WT12zrrL7rFpVSebx6f+k6wed67tYfO4332cyWPzknqP4ze2M3l8
        3iQXwBWlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l9H85jtrwSGWiqsrn7A3MD5i7mLk5JAQMJH4dOoRO4gtJLCUUWLbevEuRg6guIzE8fVlECXC
        En+udbF1MXIBlbxmlGhb8AKsV1jARWLm5o1gtoiAusSCdfeYQIqYBY4zSyx8MQWqYz2jxP3N
        3xhBqtgErCQmtq8Cs3kF7CSOXVzMAmKzCKhKbH6+ng3EFhWIkDjzfgULRI2gxMmZT8BsTgFj
        iU8bWsFsZqBtf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqml
        xbnpucWGesWJucWleel6yfm5mxiB8b3t2M/NOxgvbQw+xCjAwajEw7uASyxWiDWxrLgy9xCj
        BAezkgiv5DmRWCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aevJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjOJe8rPaa3WOeqR/s184terPkoWvP2/vt9ye
        99fZSkW8zeuSyG/Vw/K1iksEj/+8JBRpZa09Kyzufuyz16Er+UJWnhRgi1a5nHjMN+vxdpFv
        Czbu49W0kV2tuOTe8ZQFCy6+7ViX+tVo2al3fQv2H/yhnjcv/6GrpPQH645TIhJPsx8e+3V0
        f6cSS3FGoqEWc1FxIgD3ihLoBQMAAA==
X-CMS-MailID: 20190628130332eucas1p2b302e7dfdae6ee7a73c650f7e10d3f6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163511epcas1p20ccb516dce9a56e222779ecfd0a1084f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163511epcas1p20ccb516dce9a56e222779ecfd0a1084f
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163511epcas1p20ccb516dce9a56e222779ecfd0a1084f@epcas1p2.samsung.com>
        <20190625163434.13620-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to remove the hacky platform data callback for power control.
> Add a regulator to the driver data and enable/disable it next to
> the current panel_power_ctrl() calls. We will use it in subsequent
> patch on da850-evm.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
