Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28761C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CEE20835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jU3hx/nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCCURo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:17:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfCCURn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:17:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so2703369wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZNDb1tzRmVE//jhcHz24P2cagympgseX/EccDf+3u8=;
        b=jU3hx/ncxukoybi/xe47taG4wqt6p7DfjU4Nh9Q7UT/O1+xU9mykblUMS7NVAKW5o7
         ETkOiHWRfYq1RiDAzySJuK3KU8YOSuxJJHibqaRNivapwvwBErkbePjIe4tjPJs4C7WC
         qmM1WuHgeOiYoQkVjim4o6kPFScNVT27fjhFmKc7Ohk0cA44EkEQv7PeqiwWdpST2/Cr
         0urHZlnOYUQ6RDH5JeWYrhzA5JOfqFPewypvN3geHt+uWasgVFAqt5A2g9hcL1Dxc4bi
         YYwx7VklCluVGE83FGh1oYdLVvUxDZl6tSewXMv7z3KRsFjb5BvB0aAmx39mPq9+JuDw
         cDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZNDb1tzRmVE//jhcHz24P2cagympgseX/EccDf+3u8=;
        b=cu4rQyqAVJVqV4K3tpFBF2RDkh2WQBbC3nyrfOEkY/Ch0/pwtxGv5yU/IaBR9D4+FM
         WzWCfWkF0HZj+rjsO7qcs0sHhVlzL2dx4ZeL+jYVOCD85dncSJzVbj32HHllfxbmHDdi
         9YKthjxYEFD6iuAAmgOs1VQfU8Sw+poRIExYHWiL6fZ1lE2L0W+JLCQqCDnlP2/vx7bd
         cHeNeigxQtdgqNaHPy4IhPqOcdOxkN/4v7Mxb9gI9pJGyAvtl9kd/TV8xxS0kFRrmkWr
         EseesOV5cjuEUBR3P6MfnnkriPxuUAZ+Oy+Bac0ZLzXKxIA9ucJOCBULPpq4YABhuCPO
         n3Vw==
X-Gm-Message-State: AHQUAuaTZbRaHc8sXJERYM47SbHoAiJHHoh8jG4atkeU3WqSehZY571z
        bZK4XFDPOy4yqaU42Ev27e/twGw76XuhxOmggp9Ksw==
X-Google-Smtp-Source: APXvYqzHuf19KOzl4Wik89y984Hjv9fJaesfa8+GSNLzg8p6QErog/W4/keVSoM2vNh66CJI0AB+ux/YQrHqNmMI9CA=
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr9585948wme.115.1551644261851;
 Sun, 03 Mar 2019 12:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-11-chenyu56@huawei.com>
In-Reply-To: <20190302090505.65542-11-chenyu56@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Sun, 3 Mar 2019 15:17:29 -0500
Message-ID: <CALAqxLVSiWB-HRJWd-aBWNZ-u3JpK4WVR84DSEKRNV1Kzom8pg@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Yu Chen <chenyu56@huawei.com>
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        "Liuyu (R)" <liuyu712@hisilicon.com>, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com,
        Li Pengcheng <lipengcheng8@huawei.com>,
        songxiaowei@hisilicon.com, YiPing Xu <xuyiping@hisilicon.com>,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        Zang Leigang <zangleigang@hisilicon.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 4:05 AM Yu Chen <chenyu56@huawei.com> wrote:
> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *root = dev->of_node;

Minor nit: root is unused and generates build warnings.

thanks
-john
