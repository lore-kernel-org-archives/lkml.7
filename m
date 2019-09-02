Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1414C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC8021881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fFDtwZha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfIBXVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:21:36 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:49696 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfIBXVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567466496; x=1599002496;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:cc;
  bh=2tF0euXR3VYfwevVZ1jCeatrtkAWORyVRWQSZY/zVZs=;
  b=fFDtwZha9ea9qra9b+6sRP15xg2qPaQF7Bv6DzFGAXNi72oucvD9h1Bf
   LtXk2C4irwN5AHyG/UZsNYcFVC8trVHlE4FDaPBsNLdSHw0SWcrRhVABP
   Mxidea39aFsbIgzSsDJY9smpf7gt6HlmTtwX86wz4St+D1Vw/M7pAztj/
   sgbrwrxcLWOEmdltpEyniT1s8b5a0sAVsXJzpsFFG84P6Lkh/4xDjCIUY
   S6YR3r2VMQERKc9sSHWoyaSDU9JNZqgTuS70iEz1WQv33/LHgv6X2MilL
   BVwx4J5n7ucuk9yj+lLWBlIJPT2hqsoDHeqYFwvNmqmfc66WRXJvMVN+x
   A==;
IronPort-SDR: uxJfzeV1h84exQyy7dUrQ4tMQTAEbilDfTh6petoqkBmvKlJKP7nYP06w/5wxeXUOqXaMYjGQj
 ff84h5W/NhRi0haGKwz7aPy4gvXlbSBsBThU3lUdjUfP9KXbjFgGsyerweZuC/JkM+K8F0RkqZ
 3pduensCkMgDAVNayKfwFEP9hfdBDf4BMiFWprqK2VYTZFmNaFyd+KXKQ0pWRF18nggDi7B2mk
 w7jGVV6Xdy5H+v3yjbxz0aMo7ukriVVuWdZ/jVwAPYs7oLI94NLDWg594Iu/+I0YIXJh6G8+f1
 DAU=
IronPort-PHdr: =?us-ascii?q?9a23=3Ahx/WFxZR21Lv1imukHENFvb/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMuzbnLW6fgltlLVR4KTs6sC17OM9fm/ACdaud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8sLjYdtNKo91g?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFBB4K8b5AUD+oAO+ZYoJT2qUUXoxCjCwmsBf3gyjtViXTr2aE33f?=
 =?us-ascii?q?gtHQTA0Qc9HdwBrW7Uoc36O6ccU++7zKfGwzbeYfxKwjr99JTEfwo9rf2QQb?=
 =?us-ascii?q?59c8zcwlQvGQPfiVWQrJToMDGU1uUMs2ib8u1gXv+shG4nsQ5xoyWky8Asi4?=
 =?us-ascii?q?jIhoIa0FHE+TllzIs7PtC4VVJ0YcS+HJROqi6aKpJ7T8U/SG9roCY30qMKtY?=
 =?us-ascii?q?K/cSQQy5kqxwTTZ+GGfoWK+B7uVvudLDFlj3x/Yr2/nQy98U24x+35Ucm7zU?=
 =?us-ascii?q?hFozJektnJqnANzxvT6tWbSvdl/keuxzKP1wfL5+FBO080lK7bJ4clwr4+i5?=
 =?us-ascii?q?YfqErDEy3rlEnsg6+WcUIk+ues6+v5eLnpupicN4pshgH/NKQhhNC/DPwmPg?=
 =?us-ascii?q?QSW2WX4+ex2b358UHkQbhHjOc6n6vEvJzCIMQUvK+5Awtb0oY57Ba/Ci+r0d?=
 =?us-ascii?q?QZnHkHNl1FeQ6Lg5TnNlzVPfD3Ee2/j06ynzh22vDKJqfhDYnVLnjfjLfheq?=
 =?us-ascii?q?5w60pdyAo10NBe6ItYCrIfL/LpXE/+qtjYAwQnMwy73ennEs9x1oAAVmKVBK?=
 =?us-ascii?q?+WLqfSvUWP5uI1LOnfLKEPvzOoGvk35+PpxU05kF5VKbi73ZIWMCjjNultOQ?=
 =?us-ascii?q?OUbWe60YRJKnsDogdrFL+is1aFSzMGIinqUg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FaAAAyo21df0enVdFlHgEGBwaBVQc?=
 =?us-ascii?q?LAYNWMxoQhCGPDIIPiWqBCYV6gwmFJIF7AQgBAQEOLwEBhD8CI4JKIzYHDgI?=
 =?us-ascii?q?DCAEBBQEBAQEBBgQBAQIQAQEJCwsIJ4VDgjopgmAJAQEBAxIRBFIQCwsNAgI?=
 =?us-ascii?q?fBwICIhIBBQEcGSI5gkiCCgWdZYEDPIskfzOIZgEIDIFJEnooi3iCF4QjPoQ?=
 =?us-ascii?q?Ng0IUgkQEgS4BAQGNRIcWlg0BBgKCDRSML4gsG4IzhzaEHYpgLaYrDyGBNgq?=
 =?us-ascii?q?CADMaJX8GZwqBRIJ6ji0jMI0bglQB?=
X-IPAS-Result: =?us-ascii?q?A2FaAAAyo21df0enVdFlHgEGBwaBVQcLAYNWMxoQhCGPD?=
 =?us-ascii?q?IIPiWqBCYV6gwmFJIF7AQgBAQEOLwEBhD8CI4JKIzYHDgIDCAEBBQEBAQEBB?=
 =?us-ascii?q?gQBAQIQAQEJCwsIJ4VDgjopgmAJAQEBAxIRBFIQCwsNAgIfBwICIhIBBQEcG?=
 =?us-ascii?q?SI5gkiCCgWdZYEDPIskfzOIZgEIDIFJEnooi3iCF4QjPoQNg0IUgkQEgS4BA?=
 =?us-ascii?q?QGNRIcWlg0BBgKCDRSML4gsG4IzhzaEHYpgLaYrDyGBNgqCADMaJX8GZwqBR?=
 =?us-ascii?q?IJ6ji0jMI0bglQB?=
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; 
   d="scan'208";a="74328903"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 16:21:35 -0700
Received: by mail-lf1-f71.google.com with SMTP id z24so2928862lfb.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 16:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=11S+72wXCThjYHgY/hYu0pdk4ZjzkGTY7Jm1Oqj+h6Y=;
        b=Vqbkek1UenJGQ5ML+Jn0Gjx+RLof9Jv58CBujDVVi5+/OBedawzG3oSnWz7mDzd1oS
         mJyPME3I1RQa5kPDOIfADzh/3+/DVCOxkRtLmEebXqiXXEGiCs9L0AAbFtOwk/p7Fz+M
         VKGAHtkkdfB9C2b74aNhldwhavnuk8pXZ4kvpt8PqI+6YFdTtC04opjwvMNvVdTeMwgA
         dBcT2K6csQkAo3QMpd35dk5jV+leSPGN1M0xEesQONaXR4tI6JtsTqkR+kCvvkgpe1f1
         31+r3a439bwPkNaHp94jLSdSMP6AnW5/RfPX4flwTKLQD3gm2EfkEXhnQ3mX4pWsXUrr
         k4UA==
X-Gm-Message-State: APjAAAW5Pg5p/j7NdXaATe+DzYfsFFbR2c84w29aQjW5wnwYzKy8z3K8
        9N4seRPJ+lIwOwCpj8718Rqar4IQeLz8QAe0bLDs0ATrg5H2jMl7SmkZ3l2RDjd5FUzEKHkl6b4
        Un5dWtgZn50+beuLgHfTA+T7kpSIYFxt6cLPXO9UOjQ==
X-Google-Smtp-Source: APXvYqykdDFlNgVuHVV+pD/0DkNVJlqBTnQsCWd4c0h3A4vfX+KwfMIiSIjo5ktF4fkgh3vwInJMZc0AthRsd8pi1Tw=
X-Received: by 2002:a2e:8806:: with SMTP id x6mr17626930ljh.190.1567466493335;
        Mon, 02 Sep 2019 16:21:33 -0700 (PDT)
X-Received: by 2002:a2e:8806:: with SMTP id x6mt12995386ljh.190.1567466493181;
 Mon, 02 Sep 2019 16:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190902231510.21374-1-yzhai003@ucr.edu>
In-Reply-To: <20190902231510.21374-1-yzhai003@ucr.edu>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 2 Sep 2019 16:22:03 -0700
Message-ID: <CABvMjLSeQjMi0DPLGH3qnoLNb=gc+P_4ZF7OQQMHa6uRMD42Dg@mail.gmail.com>
Subject: Re: [PATCH] net: hisilicon: Variable "reg_value" in function
 mdio_sc_cfg_reg_write() could be uninitialized
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the inconvenience. I made some mistake here, please ignore
this patch and I will submit a new one.

On Mon, Sep 2, 2019 at 4:14 PM Yizhuo <yzhai003@ucr.edu> wrote:
>
> In function mdio_sc_cfg_reg_write(), variable reg_value could be
> uninitialized if regmap_read() fails. However, this variable is
> used later in the if statement, which is potentially unsafe.
>
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/net/ethernet/hisilicon/hns_mdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
> index 3e863a71c513..f5b64cb2d0f6 100644
> --- a/drivers/net/ethernet/hisilicon/hns_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
> @@ -148,11 +148,17 @@ static int mdio_sc_cfg_reg_write(struct hns_mdio_device *mdio_dev,
>  {
>         u32 time_cnt;
>         u32 reg_value;
> +       int ret;
>
>         regmap_write(mdio_dev->subctrl_vbase, cfg_reg, set_val);
>
>         for (time_cnt = MDIO_TIMEOUT; time_cnt; time_cnt--) {
> -               regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
> +               ret = regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
> +               if (ret) {
> +                       dev_err(mdio_dev->regmap->dev, "Fail to read from the register\n");
> +                       return ret;
> +               }
> +
>                 reg_value &= st_msk;
>                 if ((!!check_st) == (!!reg_value))
>                         break;
> --
> 2.17.1
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
