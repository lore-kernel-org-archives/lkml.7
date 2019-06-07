Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F0AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3AB20684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s+/hX2/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFGJmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:42:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35128 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfFGJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:42:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607094202euoutp0241f64bca9f88d51cb87faa5f3f20ffbc~l4UKqJLJQ1097610976euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 09:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607094202euoutp0241f64bca9f88d51cb87faa5f3f20ffbc~l4UKqJLJQ1097610976euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559900522;
        bh=i04fqGKSBitdACcC66GRsSl53dxqFLrFmmFEFzkxRcg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s+/hX2/ZKygoTzMu47BlvFgOF7VkiCK3Dsm3j4RnIEFTCJOHbIp6yRmj3ivp+ncdK
         j+hXkk+VR+7rZuiXqsft+BqGXkA8cTurSO8TrF1BJ7Sqm4Yuth6QjwXQ5bzLm01tVb
         BGfhb/agrTW9wFf/wQdozOiwAhlyPZIjtPadLbl8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607094201eucas1p17e5c03dfe2482d91ddbce03fca522640~l4UKPik6l3276132761eucas1p1r;
        Fri,  7 Jun 2019 09:42:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 36.D1.04298.9613AFC5; Fri,  7
        Jun 2019 10:42:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607094201eucas1p2385e3db42eea3bde5f3d8ce372fc32b5~l4UJb_v2y2838028380eucas1p2n;
        Fri,  7 Jun 2019 09:42:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607094200eusmtrp288b5a00caa558dbc90834b94998a37c3~l4UJKsYgf0906509065eusmtrp2B;
        Fri,  7 Jun 2019 09:42:00 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-af-5cfa31695515
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.B4.04146.8613AFC5; Fri,  7
        Jun 2019 10:42:00 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607094200eusmtip1452cfc5dce846486ecdeae0406ea94c8~l4UIcGpYr1414914149eusmtip1i;
        Fri,  7 Jun 2019 09:41:59 +0000 (GMT)
Subject: Re: [PATCH][next] drm/bridge: sii902x: fix comparision of u32 with
 less than zero
To:     Colin King <colin.king@canonical.com>, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <60c72c12-472b-0b07-610b-f9edab4679c2@samsung.com>
Date:   Fri, 7 Jun 2019 11:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603142102.27191-1-colin.king@canonical.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13f3YdbW4TmNPGkazPxZpg35cyixBY+Qf+9PEJjb1oqJO2dWV
        aaRYMRVDrTCnpGCiZKTO1DSy8GusVKYJmqgTWjiskd9oZeZ2V/nvPOc5533OgZfCJN2EL5Wi
        yWK1GnWajBThnUNboydT5D9Up/Q7AUzpqFnA/GwuJZmdznKMmVj/TjIlRXqC6Zj2Y4rKnwqZ
        jz015AVKYcgvJRVvNupwRbW+ilB0bcwTCmuJSaAwTXUJFKtG/yhhjCgkkU1L0bHa4NBromSH
        +TOW2Si6MVYxS+SjdqoYeVJAn4amyjlhMRJREroJgWWgFeeHNQS/ZpoIp0pCryJoeCD851ix
        C3hRIwLz3CzBDw4EM5Yql8ObVsHOxn2Xyoe2IRiZ6MacC4wOgxe1M7gTk3QgbLd/Ip1YTIfC
        8tS2y4zTx6ByeNKlOUhHg3WoleA1XmCusrl4z129wzLufvMIFHZUu7EUpm21rsNA9wnh7nC+
        gM8dDm3D79zYGxZNL919DsNOd62bvw3WpjsYb9Yj6GjlUwN9FvpNY7spqN0LgdDSE8zTYVC3
        1IU7aaAPwJTDi89wACo6KzGeFoP+noRXHwXrSIf7QSk0WNbJMiQz7Glm2NPGsKeN4f/dOoQ/
        Q1I2m0tPYjm5hr0exKnTuWxNUlBCRroR7X6oD79NK6/Q+nh8H6IpJNsvVgi3VBJCreNy0vsQ
        UJjMR6yzbKok4kR1zk1WmxGnzU5juT7kR+EyqTjXY/6qhE5SZ7GpLJvJav9uBZSnbz4qF5z3
        73XUTmJhxufehugYhtJ/e7J+KzaiPk9pjO+89NiIFUfJ8+JOVJguat4X2Psjt1PqUxMi7I2L
        lwtKMkM27bLBK8PhX3V6ZeyCh2zwXPVy7r5km0qbKtQVfilzRL7G1oi25pY5ZbeZDHiLDnED
        wY+WHjbUnFHKexes0zKcS1bLj2NaTv0HiAUOO0wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7oZhr9iDHpbNSx6z51ksvi9upfN
        4v+2icwWV76+Z7Po7uxgtdh6S9qic+ISdovLu+awOXB4zGroZfPY+20Bi8fsjpmsHtu/PWD1
        uN99nMnj+I3tTB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZbw9+Zi5YDlXxcVJd1kbGDdzdDFyckgImEis+PSCqYuRi0NIYCmjRNP3
        f8wQCXGJ3fPfQtnCEn+udbFBFL1mlDj2/BgrSEJYIEbi/7c+sG4RgSeMEldX/2UCSTALOEqs
        m3+HBcQWEpjIKLG5SxbEZhPQlPi7+SYbiM0rYCfx8cZfsEEsAioS089cB6sXFYiQOPN+BQtE
        jaDEyZlPwGxOoPq3Fy4xQ8xXl/gzD8aWl2jeOhvKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYF
        jCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNy27Gfm3cwXtoYfIhRgINRiYfXgeFnjBBr
        YllxZe4hRgkOZiUR3rILP2KEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YLvJK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAKNpTHqjB27I9mXDz9ZU/miQOR
        j60W1a5bfGFj94OqusLIUAs7uZNueQ6W13sW5fCHhy1VTVrxZYFUk/Peo3r9r+bEqvp973u/
        OWTrZeMD2jpvbT5uz5b/W6mk4nZI9AHrU44p8+rWrlyzK77u4d20TeKntp+VYzZb3lCz9v88
        k4uTJhVuaBZTYinOSDTUYi4qTgQABHO8dN8CAAA=
X-CMS-MailID: 20190607094201eucas1p2385e3db42eea3bde5f3d8ce372fc32b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190603142108epcas2p4625777c1aaea18257804ca86bcb64454
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190603142108epcas2p4625777c1aaea18257804ca86bcb64454
References: <CGME20190603142108epcas2p4625777c1aaea18257804ca86bcb64454@epcas2p4.samsung.com>
        <20190603142102.27191-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.2019 16:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The less than check for the variable num_lanes is always going to be
> false because the variable is a u32.  Fix this by making num_lanes an
> int and also make loop index i an int too.
>
> Addresses-Coverity: ("Unsigned compared against 0")


Is there a rule in Kernel of adding such tags?

I have spotted only: Addresses-Coverity-ID?


Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index d6f98d388ac2..21a947603c88 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -719,7 +719,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  		.max_i2s_channels = 0,
>  	};
>  	u8 lanes[4];
> -	u32 num_lanes, i;
> +	int num_lanes, i;
>  
>  	if (!of_property_read_bool(dev->of_node, "#sound-dai-cells")) {
>  		dev_dbg(dev, "%s: No \"#sound-dai-cells\", no audio\n",


