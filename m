Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613DECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5A02089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7uU5/qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408917AbfJQKkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:40:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392759AbfJQKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:40:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so1739565wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/6DDVX5d7vla6YdRzzXi4A/aTsU47xXCqt0sHgvNJI=;
        b=b7uU5/qVvchaiINd/RS0pySCibpjekZMTg/nCw+/HXBI9+Pgl7stu+UXnaTclMwT2c
         1eSJ6U8y/kb8M1WgcPZOLSTv6OXOcO25YZcQZG2grBznUUDslBfqnFr9Jlw/4MLtKFPD
         7aA7N4g/X4vxA9wQOr6VyDwq4TihE4t4c4sDW44y7O4yXnVgH1sLhn5Nja2QNct+rj3F
         K0z8IIOiatmGjZycmkdmpMbojJoje8yEnfzRdaJDKnTCTvw9HSQesdS7n8mrM7dn7Kmb
         tP7FGCYPvfvjF2uD16kWYro16YyetybjigpBNCUbWxJHvm5vKma38U0cAvyntr+HK2Ot
         qQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/6DDVX5d7vla6YdRzzXi4A/aTsU47xXCqt0sHgvNJI=;
        b=KpCPTdhLb/oyVm+pR2qnB7zccxrWXdOT1cqhkSSFET+by+RpyyU6LCBdDaLwci0hEE
         49M/9o3jK5cMj6N/0C3Yh+hLaB8x8sLBS/rnw+raaxbDRceuovuSk3ukPfkE0749lrV5
         dkbIpWlaKwHQ6Rtul5+vk8V6+xFXgDDkro2zgtsFng5G396jrSJa02s4R9bSLl0oUSGV
         GOp6ZJ+oaWzYVR0DFln6g243QgA5NwbLort/WaBgkcbJxDbtcHxHBrj0y1hCr/GF8XR4
         2I9UB2SHHTmEz47WbowrWoQ3fP9zdRnZgx1aYJ6gpbw/kuAJvcVSFIXJjne5uvyWZezK
         yrYQ==
X-Gm-Message-State: APjAAAV7rI27SeEF0CVBSB9u7lWlwH4q9ZLFvjRxFN402F+JUIXwVzmM
        xedaTrdztt5I3JSpZatjWYY3GpduKkLsjOm/xvodjg==
X-Google-Smtp-Source: APXvYqyC2edEc9qfn+I1WvpyzxwBarwmlWbf4ewvcSmG/uzwfHbxRt8+59/qqTKVy660i6Wd6+svULPi91Gp2L9gNog=
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr2393112wrl.113.1571308820493;
 Thu, 17 Oct 2019 03:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191011103902.3145-1-wuxy@bitland.com.cn>
In-Reply-To: <20191011103902.3145-1-wuxy@bitland.com.cn>
From:   Tomasz Figa <tfiga@google.com>
Date:   Thu, 17 Oct 2019 19:40:08 +0900
Message-ID: <CAAFQd5Btb22tdJD74bmwYqaCYukeoX=aRUdoobpBdXX1W67LdQ@mail.gmail.com>
Subject: Re: [PATCH] media: ov5695: enable vsync pin output
To:     wuxy@bitland.com.cn
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dongchun.zhu@mediatek.corp-partner.google.com,
        Nicolas Boichat <drinkcat@google.com>,
        wuxy <wuxy@bitland.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingyu,

On Fri, Oct 11, 2019 at 7:39 PM <wuxy@bitland.com.cn> wrote:
>
> From: wuxy <wuxy@bitland.corp-partner.google.com>
>

Thanks for the patch! Please see my comments inline.

> For Kukui project, the ov5695 vsync signal needs to
> be set to output,from ov5695 datasheet,the related
> register control methods as follows:
>
> 0x3002 Bit[7] FISIN/VSYNC output enable
> 0x3010 Bit[7] enable FISIN/VSYNC as GPIO controlled by register
> 0x3008 Bit[7] register control FISIN/VSYNC output
>
> TEST= boot to shell
>
> Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
> ---
>  drivers/media/i2c/ov5695.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
> index 34b7046d9702..71f0eae6037b 100644
> --- a/drivers/media/i2c/ov5695.c
> +++ b/drivers/media/i2c/ov5695.c
> @@ -300,6 +300,9 @@ static const struct regval ov5695_global_regs[] = {
>   * mipi_datarate per lane 840Mbps
>   */
>  static const struct regval ov5695_2592x1944_regs[] = {
> +       {0x3002, 0x80},

The original value of 0xa1 that was in ov5695_global_regs[], has the
0x80 bit set already.

> +       {0x3008, 0x80},
> +       {0x3010, 0x80},

Doesn't this configure the pin to an always-1 output GPIO? I believe
the correct settings for both bits should be 0 and 0 for the pin to be
driven by the hardware vsync generator.

Best regards,
Tomasz
