Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6906C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736292077C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TodBXMiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfG2BV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:21:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61394 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfG2BVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:21:54 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190729012151epoutp01bfdd94050d38325edde8e6919fea99a5~1vCTTqMWL0849308493epoutp01X
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:21:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190729012151epoutp01bfdd94050d38325edde8e6919fea99a5~1vCTTqMWL0849308493epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564363311;
        bh=6DR3fTdlt0boV+AzGWvP5T7Xmgn/l959r2ivP+jLWFY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TodBXMiDOvjK8YJ6XUGQba4ECLtwyXBQtDgvCqawx+TyEfccCfxr6SS9tVbLlEm0o
         zgFtFvpdBXFFjAS0OXBuDhZV4YMitrvuq58wZOPPrRuHh+KSuy54PfQBmhF2C9eDkA
         OZ6JMC+aKELOALiCQQFnGfjD/u7XeqmzPSJcs9z4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190729012151epcas1p2bc5e0d4a7036682106f8f527ad798cfb~1vCS9VEOz2297622976epcas1p24;
        Mon, 29 Jul 2019 01:21:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45xhjn1K51zMqYkY; Mon, 29 Jul
        2019 01:21:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.30.04088.D2A4E3D5; Mon, 29 Jul 2019 10:21:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190729012148epcas1p4cc94c1e47ae819e4ad36837fb1678a6f~1vCQVUiAH1835118351epcas1p41;
        Mon, 29 Jul 2019 01:21:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190729012148epsmtrp1541c577b61d19aaf57a19c6370382f09~1vCQUkJVB2310823108epsmtrp1f;
        Mon, 29 Jul 2019 01:21:48 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-cd-5d3e4a2dce6b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.91.03706.C2A4E3D5; Mon, 29 Jul 2019 10:21:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190729012148epsmtip1874a4fd2d0ad5d0246f55b6a0b8af269~1vCQIj0a30040100401epsmtip1l;
        Mon, 29 Jul 2019 01:21:48 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] extcon: axp288: Add missed error check
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ramakrishna Pallala <ramakrishna.pallala@intel.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6b03a817-edd9-f76a-9322-43cb1a4fb3d0@samsung.com>
Date:   Mon, 29 Jul 2019 10:25:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726121820.69679-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRiGM7vt0hKra0X85IfWRRMlAbrASlGKF9EG+YFHjFEJrnQDhHbb
        dAsR8QdivAggxisUFLEYBQ8IIgE8MEWDjfFEBO+LKKLQBIVAPHDbhcifyTPfvO+8882MAldX
        EUGKDN7O2XjWRBH+ssa2RdrQ0IS4ZO0Jh1JXlH8S031vF4eOlnJC92rPBUJX+f0Fpht1PcKW
        E4a6jxflBueNr5jhtHudwXOrkzAUN9Qgw4/6OUnElszYdI41cjYNx6dajBl8mp5auyFlVQqz
        WEuH0jG6aErDs2ZOT8UnJoWuzjCJp6A02awpSywlsYJAhcfF2ixZdk6TbhHseoqzGk3WGGuY
        wJqFLD4tLNViXkJrtRGMKNyemX69rQ5ZhxQ7666W4HnorF8BUiqAjALP0A3My2qyCcGfMaoA
        +Ys8iKDubT8hTYYR3O17gE84xmo6cGnhJoKjrvPjdg8Cd6HGyzPIldD+rt7PKwog7yJoGv7m
        c+NkNAy+d8i9TJAh0NrbTXh5GjkPOkc+IS+ryDgoHeyVeVlGLoAPXcO+gJnkZtHbJpc008Fd
        2uPTKMk1UNk3JJf2nwUveyowiefC3mtlvpMC6SGg3/MUSS3EQ39FmUziGdDX3jB+GUHw9fD+
        cc6FavcdQjIfRNDQ+lguLURC67mjYoJCTFgEtS3hUnkeNP86haTgqTAwVCj3SoBUwcH9akkS
        DB3v32ASzwbngUNECaIck9pxTGrBMakFx/+wM0hWgwI5q2BO4wTaSk9+7Xrk+6EhTBM69jDR
        hUgFoqaoep/rk9VyNlvIMbsQKHAqQNVALU1Wq4xszi7OZkmxZZk4wYUY8baP4EEzUy3if+ft
        KTQTERkZqYuiFzM0Tc1SVY7oktVkGmvnMjnOytkmfJhCGZSHWoreOV86f8dm1DD4KLOQ57t3
        Y6s016pXzm/elx/j2XzPmBBsKu1xmf+2PdtalaTBerKdn0fPBexo119ZFt6nyTuS21UYu97p
        znxSUlu+bVNtY8Lx260VypNuS2DeHYZtjn/1Onhge/WXy+ctG9f+rF7hubT11OD9Mr+L0cXd
        5TdJSiaks3QIbhPYf+ENWva3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTlfHyy7W4MdkNYvepulMFm+OA4nL
        u+awWdxuXMFmsfDNTSaLn4fOMzmweWx4tJrVY/Gel0we804Gerzfd5XNo2/LKkaPz5vkAtii
        uGxSUnMyy1KL9O0SuDJ2H97AWPCVo2LD5gnMDYyL2LsYOTkkBEwk/q+6zNzFyMUhJLCbUeL3
        gbVQCUmJaRePAiU4gGxhicOHiyFq3jJKHLv7mBGkRljASeL4/U3sIAkRgaOMEgufTWYBSTAL
        mEt8ejCLFcQWEpjFKNF0rB7EZhPQktj/4gYbiM0voChx9QfEIF4BO4mZn16A9bIIqEo8vP6N
        CcQWFYiQOLxjFlSNoMTJmU/AajgF3CUWvvrKCrFLXeLPvEvMELa4xK0n85kgbHmJ5q2zmScw
        Cs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHE1amjsY
        Ly+JP8QowMGoxMPrcNM2Vog1say4MvcQowQHs5II7xYl61gh3pTEyqrUovz4otKc1OJDjNIc
        LErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGFWMt90O+7/k35u9i8vfST9b9Ojozf/feG+F
        y96dUxwg5TjjP5uARanJOU73NyvuGn5e1Myz4UjWrxTxbI7nb2Ydt2b9FHpwXcCh8N4EtRjW
        fdeUEy473pr1/nhEosBe7fLgmwteX1smqdkVuuB50tqTdm0T0j6sOT8r9oXirp6YIjefbU9m
        NpxWYinOSDTUYi4qTgQAmt6BhaICAAA=
X-CMS-MailID: 20190729012148epcas1p4cc94c1e47ae819e4ad36837fb1678a6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190726121827epcas5p36e03788323eb0c805f9c340f7c6f7944
References: <CGME20190726121827epcas5p36e03788323eb0c805f9c340f7c6f7944@epcas5p3.samsung.com>
        <20190726121820.69679-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 26. 오후 9:18, Andy Shevchenko wrote:
> It seems from the very beginning the error check has been missed
> in axp288_extcon_log_rsi(). Add it here.
> 
> Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - added error message (Chanwoo)
>  drivers/extcon/extcon-axp288.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 7254852e6ec0..694a8d4a57ff 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -135,6 +135,11 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>  	int ret;
>  
>  	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
> +	if (ret < 0) {
> +		dev_err(info->dev, "failed to read reset source indicator\n");
> +		return;
> +	}
> +
>  	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
>  		if (val & BIT(i)) {
>  			dev_dbg(info->dev, "%s\n", *rsi);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
