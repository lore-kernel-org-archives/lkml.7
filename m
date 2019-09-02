Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD080C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7674422CF7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SbLtlhuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfIBXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:23:08 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:49787 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfIBXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567466588; x=1599002588;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=lGheQen1Wn72+UoD9cLdAC+01YcqiKgrVMaI6FRsVC8=;
  b=SbLtlhukg3ytv+YJ/R8v1bBUBUa3H2hqdPwCMT7n0wSdOZIz+6gbaC6/
   8O+JCv43D+u37nhHH4wl4gbs8zcSAa2p9DYGXNZhxKbA/ZmYW10ftRu+j
   DtWCyS3KwVFqBRn9xm43SFQg2twNXuo857siQ4LKjtIb2zF+R6Rh3nw9z
   ovu7gx5zUCeGuPIGMTKyrK66aJrvz9CcbVdw9V4cYqXLzo+EBb184VDXR
   Nt/HJ77+95ge/dwnpBnDZUjjleO/Z6pvyX3ifxfgHzQECtANvn09z6BxT
   nAtqHuV322upW5YakX3od/NlB53YkmuFV1HKBxVqFk1yTv9+PJ8T1fKXc
   Q==;
IronPort-SDR: iDRoxpWPE5/MSqP19njuzSqOin+TWOrYrFwWrCYNBDPUyDdKifS7c6WbFUHfiE3LW6+4vEllHC
 0pn89nnc4cEXj+RblJe7lnQFQx6nXuvJ8eOtAG3ks6IHaOFl31m2Ix58tcPI1wClkI0bBCSsG3
 CtRPidBz8jG4W9C3WQ0WqIXSHBczY5X/wPFE0zbyp6E/p6FYL0lB/GvdQqD2nKAQyQOzauntq4
 5zR8tyvJWlvJRPKTE+LYXlu0ESt+vJkYIFmv3P+uhrK4Olk7XHkTYYAMkb+1xvFTCjh1+9b+a9
 HOs=
IronPort-PHdr: =?us-ascii?q?9a23=3AVLTmaByMP4ygix/XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+gVIJqq85mqBkHD//Il1AaPAdyBrasb0qGM6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmjaxe65+IReroQneqMUanZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dKQ8RfWDFbAo6kYIQPAegOM+ZWoYf+ulUAswexCBKwBO/z0DJEmmP60bE43u?=
 =?us-ascii?q?knDArI3BYgH9ULsHnMrtr1NaYTUeCozKnP0D7MbPNW1i386IPVdR0gofCNXb?=
 =?us-ascii?q?JqfsrQ1UUjCw3Ig06NqYP5JTOZzPoCvHWG7+d5U++klmApqwZ0oje1x8csjJ?=
 =?us-ascii?q?HEhoELxVDe8yV23oI1Kce/SE5hbt6pFoZbuSKCN4ZuXM8uX2VltDw5x7AGo5?=
 =?us-ascii?q?K3YSkHxZY9yxPdd/CKdZWD7Aj5W+aLOzh4gWpoeLe4hxmv70et0vb8Vsyo0F?=
 =?us-ascii?q?ZSqSpFj8XMumgN1xPN7siHTeNw/kK71jaO0wDf8+VEIU4pmabCJZ4swKI8mo?=
 =?us-ascii?q?AcsUTEGS/2l0H2g7GMeko4/eio7vzrYrTgppCCK495kh/yPrgql8ClAuk1Mh?=
 =?us-ascii?q?ICU3Wa9Om+zrHu/1H1TK1PjvIsk6nZtJ7aJd4cpq68GwJU0oci6xalADenzN?=
 =?us-ascii?q?gUgXcKIUlYeB2blYjlIU/BL+3lDfunmVSjjC9rx+zaPr3mGpjNKnnDkLH8fb?=
 =?us-ascii?q?dy8kJcyxQ8zcpZ551KDrEMO+zzWkDvu9zCFBM5MBK7w/zhCNpj0oMSQ2WPAr?=
 =?us-ascii?q?WWMPCajVjdz+QjMqG3ZIILszbwLfsir6rni3Mo30QdcLei3ZYRa3eQEfFvIk?=
 =?us-ascii?q?Hfan3p1IQvC2AP6zs/Xuz3jxWwUTdSLyKjTaI152ljU6q7Bp2FS4yw1u/SlB?=
 =?us-ascii?q?ynF4FbMzgVQmuHFm3lIsDdA68B?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FuAAAyo21dhkanVdFlHgEGBwaBVgY?=
 =?us-ascii?q?LAYMEUjMqhCGPDIFtBR2JYZE0AQgBAQEOJwgBAQKEPQKCbSM3Bg4CAwgBAQU?=
 =?us-ascii?q?BAQEBAQYEAQECEAEBAQgLCwgphTUMgjopARRNawEBAQEBASMCDWQBAQEDEhE?=
 =?us-ascii?q?EUhALCw0CAiYCAiEBEgEFARwGEwgagwABgWoDHQUKnVuBAzyLJH8ziA0NTAE?=
 =?us-ascii?q?IDIFDBhJ6KIt4gheEIz6CGi4ZBBiEUoJYBIEuAQEBixGCM4cWbJRiPwEGAoI?=
 =?us-ascii?q?NFIZzhTyEMIN8G4Izi1OKYC2VPoIDjmoPIYFFgXszGiV/BmeBToJODgkViE6?=
 =?us-ascii?q?FXyMwAQmPZQEB?=
X-IPAS-Result: =?us-ascii?q?A2FuAAAyo21dhkanVdFlHgEGBwaBVgYLAYMEUjMqhCGPD?=
 =?us-ascii?q?IFtBR2JYZE0AQgBAQEOJwgBAQKEPQKCbSM3Bg4CAwgBAQUBAQEBAQYEAQECE?=
 =?us-ascii?q?AEBAQgLCwgphTUMgjopARRNawEBAQEBASMCDWQBAQEDEhEEUhALCw0CAiYCA?=
 =?us-ascii?q?iEBEgEFARwGEwgagwABgWoDHQUKnVuBAzyLJH8ziA0NTAEIDIFDBhJ6KIt4g?=
 =?us-ascii?q?heEIz6CGi4ZBBiEUoJYBIEuAQEBixGCM4cWbJRiPwEGAoINFIZzhTyEMIN8G?=
 =?us-ascii?q?4Izi1OKYC2VPoIDjmoPIYFFgXszGiV/BmeBToJODgkViE6FXyMwAQmPZQEB?=
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; 
   d="scan'208";a="74329029"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 16:23:07 -0700
Received: by mail-lf1-f70.google.com with SMTP id a1so1580746lfi.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 16:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixtBQSIhZ95/XjU68XL0kInTF2o0/WoGeiMYDT4l6k8=;
        b=jlByqbZ2OR0X2LGFgJL3XxJuZA44BGNtUdVKLHquFSJ6/aRI4W4t1uenoOyAzu8Rxz
         VGoOg+Fo/QjlTB32O7Bc9G+hmoc6WiLlNxX62xq67w4fSUe+VXkUI1oeg7A7YqF2WN5R
         HmFCacEbeTHL1TmYeFokO6xKlSF0BH2KZFE9l0MoApy+PG5wdkaD3590Ko9MvKehs5So
         dQ6adWAHMKmEioC7dVoVrmLwX5rWtMHiO0IcXw/mR+6ZtwKKtKoWbr58Vt/jRQlPLSzl
         ++T+EI8LhD2TMJPkjwC3ZHAe7JHz4J5TmxziCwM+7H4CIJ8eGLpWQvxxQhDaumeCJSn9
         57Qw==
X-Gm-Message-State: APjAAAW0wVwUMgQzJwl25FjbgfhUgDddXh3V/wQ6Md/5vUDoh2Y1k7pn
        lkDIFXhjsMtw5M4hxKH4rm7qrNyRUsMlVGEziVuw6RlQ26Fmn/3oS7WeCe4u/iOuPPXv989FNnX
        2pJkGBXfqjUj22JVlRCme1HkMKaHvi3zKX1g5Xo4PTQ==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr5338591ljj.234.1567466585228;
        Mon, 02 Sep 2019 16:23:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvFOGJhWHMMIYUOiKS4CgTZ9i4lPdNzP057ERk89Xz+cqhWNuG8bA1oOvUIvM1W82msid/1BdBWPjTAKrL55Y=
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr5338579ljj.234.1567466585053;
 Mon, 02 Sep 2019 16:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190902224132.20787-1-yzhai003@ucr.edu> <CAHp75VcWA22y2Diinp9rnq1GGR_YFHvaunYCS3eAVcrAuccP8Q@mail.gmail.com>
In-Reply-To: <CAHp75VcWA22y2Diinp9rnq1GGR_YFHvaunYCS3eAVcrAuccP8Q@mail.gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 2 Sep 2019 16:23:35 -0700
Message-ID: <CABvMjLTJNBZgfuPY9XxhZepuD1gpZM87RKsLh3YVvZd5165LSA@mail.gmail.com>
Subject: Re: [PATCH] extcon: axp288: Variable "val" could be uninitialized if
 regmap_read() fails
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "csong@cs.ucr.edu" <csong@cs.ucr.edu>,
        "zhiyunq@cs.ucr.edu" <zhiyunq@cs.ucr.edu>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy, sorry for the inconvenience, I will check the log more
carefully next time.

On Mon, Sep 2, 2019 at 3:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Tuesday, September 3, 2019, Yizhuo <yzhai003@ucr.edu> wrote:
>>
>> In function axp288_extcon_log_rsi(), variable "val" could be
>> uninitialized if regmap_read() fails. However, it's ued to
>> decide the control flow later in the if statement, which is
>> potentially unsafe.
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=d72e3dc7915fc6c54645772c13f4afc0e676c7e2
>
>>
>> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>> ---
>>  drivers/extcon/extcon-axp288.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index 7254852e6ec0..54116a926ab6 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -135,6 +135,11 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
>>         int ret;
>>
>>         ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
>> +       if (ret) {
>> +               dev_err(info->dev, "failed to read AXP288_PS_BOOT_REASON_REG\n");
>> +               return;
>> +       }
>> +
>>         for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
>>                 if (val & BIT(i)) {
>>                         dev_dbg(info->dev, "%s\n", *rsi);
>> --
>> 2.17.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
