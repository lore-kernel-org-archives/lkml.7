Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF94E21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VZ2SnT8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404148AbfHHQOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:14:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44243 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404099AbfHHQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:14:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808161437euoutp022ead9dbdc184772880e6ef0a1705575c~4-qpPRrur0076100761euoutp02L
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 16:14:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808161437euoutp022ead9dbdc184772880e6ef0a1705575c~4-qpPRrur0076100761euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565280877;
        bh=+OFpBIQXe8AzTZ9E6Ie3xtaC1OJyOZwAOC3itL5oTV0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VZ2SnT8jTORebJ/D2T9+hWY+Lu2PzA8nVv0Qche056OZVAPvgzVjCU6s0gkKpTF3E
         tM+OBLxGZb0zcVPeUMpj/PnxP0XoEfGQmurCz62Zy2R2MgSaw0rZgjebVc0RSd/hGs
         YM7LoWpbXHi+ig2nbIlhlHDCIjHrG1QW9ChrdmC8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808161437eucas1p206867fd1bcd75f38d00dd5ad3c0604f7~4-qodMYx23063030630eucas1p2I;
        Thu,  8 Aug 2019 16:14:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.84.04469.C6A4C4D5; Thu,  8
        Aug 2019 17:14:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808161436eucas1p115acf23cd4e2a7e734a34ade5e73080f~4-qng_Jqs2381623816eucas1p1a;
        Thu,  8 Aug 2019 16:14:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808161435eusmtrp180cb830b3dc83d9c1139e644b2a6db8b~4-qnSt-yt2552925529eusmtrp1k;
        Thu,  8 Aug 2019 16:14:35 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-67-5d4c4a6c7ee9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.A3.04117.B6A4C4D5; Thu,  8
        Aug 2019 17:14:35 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808161435eusmtip103766fa9e2541b918e47f65c6014ad24~4-qm9RoJu0109701097eusmtip1H;
        Thu,  8 Aug 2019 16:14:35 +0000 (GMT)
Subject: Re: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during
 clk_register()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <a5b98edc-2a22-0c45-cc77-a07efd248fe1@samsung.com>
Date:   Thu, 8 Aug 2019 18:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731193517.237136-10-sboyd@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+3kfu4qzn9PwYGE0ijJ8JISNHmaSsMSoBEMUq1teVHLTdnWp
        YYxSS53PHuLUEDSnoxJHmagQKrpqmc9MVMxCCE0tdRJmWm23yP8+55zvl9/5Hn4MIXlIuTPx
        ymROpWQTpLQD2dS90uudEBIave+nxUtmfjFPynpq22nZgnaCkg22VNCy/tfBsvXhRjKQln8d
        yRLJyzX9pNxoyKHl48NttHzJ6HGainQ4HMMlxKs5lW/ABYe4ofvlRNIPp9T3a/VIgzIdcxHD
        AN4PQ2MRuciBkeA6BHnrBYRQWBC06/NJoVhC8LG4EOUie5uj2LJAWFmC9QhW1iMF0RyCifEW
        m8gFn4WqkVrayq44DMYLH9NWEYFLEIw2VNvcNPaD/K4Cm0GMAyCzq87WJ/FOKO/9Rll5C46A
        xclOStA4w6uyKdLK9lgG00s5Nj2B3eCGpZ4SeDs8n6uwZQD8RAQNA/2EsPZx6Hm2RgnsAjOm
        pyKBt4H5jpYUDDcRaFvHREJRhOCDqepv6EPQaeqnrCcjsCc0tPgK7WPwRmsWCZd0gpE5Z2EJ
        JyhpKiWEthhuZ0sE9U5YNZTaCewOeVO/yCIk1W2IptsQR7chju7/u1WINCA3LoVXxHK8n5K7
        6sOzCj5FGetzKVFhRH8+j3ndtNiMlgcudiDMIKmjWLMjNFpCsWo+TdGBgCGkruIJ9YloiTiG
        TUvnVInnVSkJHN+BtjKk1E18bdNklATHssncZY5L4lT/pnaMvbsGqbLrUqeDTuV7X9cP6kPb
        dlm699y74rTYNOqvMOqSGvsMlcZlbH7LehxIrpGsnlT7P2L4d8rZ1ge7q1tm601F4RnOQUcV
        GdEz6fONA3mT+WdIWdinzWPfFbdWjrBln4unlIaQg1FFadXBgTUvmz1B2neu9q52vO+L12B4
        VqWuUkrycazfXkLFs78BXcUOLzgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7rZXj6xBqcP6Vuc3v+OxeLssoNs
        Fh977rFaXN41h83i4ilXi3/XNrI4sHm8v9HK7jG74SKLx6ZVnWwed67tYfP4vEkugDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PKtNnMBb/4
        Kq7/XcnYwNjC08XIySEhYCIx8ctHZhBbSGApo8S6eUldjBxAcSmJ+S1KECXCEn+udbF1MXIB
        lbxmlJhyZwcbSEJYIExiwY1lYLaIQJDErz33WEGKmAWmMEr8f/WeFaJjB6PE/WVXWEGq2AQM
        JXqP9jGC2LwCdhItR1eAbWYRUJGYff4DWI2oQITE4R2zoGoEJU7OfMICYnMKWEi8/NwJVs8s
        oC7xZ94lKFtcounLSlYIW15i+9s5zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIr
        TswtLs1L10vOz93ECIy0bcd+btnB2PUu+BCjAAejEg+vhrxPrBBrYllxZe4hRgkOZiUR3ntl
        nrFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MAnkl8YamhuYWlobmxubGZhZK4rwdAgdj
        hATSE0tSs1NTC1KLYPqYODilGhiNI5ZtLdv7VeNabtuT+oZJb1YYLHnMyqD/xPbfnanG6VoH
        Tz2uPXLSWWCl1X23/z5X9jw4VSpyiEPT5krzrt9Pg0865bgz8hx7u1e+rsRpmv2FSxuPKfkF
        HRIt0ThSmCQa5n4ydf4Nedkzqwvit+ypSloR9qojsrk5b4noici9wQ+PLra99ENViaU4I9FQ
        i7moOBEAZ3mVnMoCAAA=
X-CMS-MailID: 20190808161436eucas1p115acf23cd4e2a7e734a34ade5e73080f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190731193551epcas1p368ccad41a1dba5c32750b08d11e4b17d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190731193551epcas1p368ccad41a1dba5c32750b08d11e4b17d
References: <20190731193517.237136-1-sboyd@kernel.org>
        <CGME20190731193551epcas1p368ccad41a1dba5c32750b08d11e4b17d@epcas1p3.samsung.com>
        <20190731193517.237136-10-sboyd@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 21:35, Stephen Boyd wrote:
> We don't want clk provider drivers to use the init structure after clk
> registration time, but we leave a dangling reference to it by means of
> clk_hw::init. Let's overwrite the member with NULL during clk_register()
> so that this can't be used anymore after registration time.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>  drivers/clk/clk.c            | 24 ++++++++++++++++--------
>  include/linux/clk-provider.h |  3 ++-
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..efac620264a2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3484,9 +3484,9 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
>  	return 0;
>  }
>  
> -static int clk_core_populate_parent_map(struct clk_core *core)
> +static int clk_core_populate_parent_map(struct clk_core *core,
> +					const struct clk_init_data *init)
>  {
> -	const struct clk_init_data *init = core->hw->init;
>  	u8 num_parents = init->num_parents;
>  	const char * const *parent_names = init->parent_names;
>  	const struct clk_hw **parent_hws = init->parent_hws;
> @@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>  {
>  	int ret;
>  	struct clk_core *core;
> +	const struct clk_init_data *init = hw->init;
> +
> +	/*
> +	 * The init data is not supposed to be used outside of registration path.
> +	 * Set it to NULL so that provider drivers can't use it either and so that
> +	 * we catch use of hw->init early on in the core.
> +	 */

nit: This comment could be re-edited to not exceed 80 columns limit.

> +	hw->init = NULL;
