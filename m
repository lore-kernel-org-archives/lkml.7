Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B692EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D60020857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTUz6BYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfCBP4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 10:56:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46798 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfCBP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 10:56:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so386205pfh.13;
        Sat, 02 Mar 2019 07:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XYSGNTVuQSlBFhuCwNoe/1S1Ik18xLByDDkKibQsNI=;
        b=YTUz6BYTlhD8rfnJNiBAvaIuJGHNr4p0rVDzDq9W3RjH0N5C0MSZRyKpYYcTRLnMC+
         qkH+CyI+UvFbBIJ6x6F5I59xwFd3B7Sgm7nHCJ+RUPrMMgy+7AgvDDYj6ap1VwoffCcb
         WUU02Tn8SmYyALX+9pjvl1rgS+5Dva855oyJk+19l8nFVnTo7QxvOGypJbduh+v+8y1t
         XllDH/er66wG5omibZ5w2saxQeXkmUiEltdGAYpc72HEWZmLip+a9XTJxqjvmjAh7pzo
         9mqmQePS/jXIgRScHMg/YRRf0NX3gAciKQAGUCU8g7MJkJeI1YVEoqUG1ZJsXk74cC+d
         WvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XYSGNTVuQSlBFhuCwNoe/1S1Ik18xLByDDkKibQsNI=;
        b=Ddk4SNSBYsf4v8Upn3/aKRk4CAgNELRWnHaEuiqxylrUpT8pVIGvz3iM8V1kkziPgR
         1A7pau8kO3bTTqUfofwNmxSXx3tMQXgyj9Y5P7WOvytAsx753D7wFDLDjH6zBPUytN8X
         xvQLS2/4DWzqfGFqv53fNYy8MHegzPWVFR7YLb9UPbSAgsw9tqZIr66WMPZ6VyAZ7TvO
         uKY0tCT+ZehZIc51M59jfIVppFGJ1I0BPt93FBwwqCj6GaLzmYQtZu7l4dnoE0J6dGg1
         HbMhZNFdJ6p/f7SOG3JMeA0I406Z3NmU9N0qlbmAzaGLCdGqf+Z6z5jWayCdkNzGwXGh
         WFJw==
X-Gm-Message-State: APjAAAX3BzBWrwQ2LN3XeGMsJ4JYK6KJFdBjzgoDWDTdH0C5Me5SbavG
        OOXa6LoZfVnP3I9CsXHhaQ0iY/C48YMikCBvSqo=
X-Google-Smtp-Source: APXvYqzg5u/pd1X+lc5BLDlBF/szgRVyuIo2O6TbcwZT/G0dVmasix0ZpNCubCF+3kr96yp4rtfOurph7s5B8IlwQ2w=
X-Received: by 2002:a63:2004:: with SMTP id g4mr10319973pgg.337.1551542188980;
 Sat, 02 Mar 2019 07:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-8-chenyu56@huawei.com>
In-Reply-To: <20190302090505.65542-8-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Mar 2019 17:56:17 +0200
Message-ID: <CAHp75VeZWQ42eaGqwUJ6r=XebKRk=nJM9c+OFaKoOT+jXxkDHw@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] phy: Add usb phy support for hi3660 Soc of Hisilicon
To:     Yu Chen <chenyu56@huawei.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com,
        Yao Chen <chenyao11@huawei.com>, fangshengzhou@hisilicon.com,
        lipengcheng8@huawei.com, songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang@hisilicon.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 11:06 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles usb phy power on and shutdown for hi3660 Soc of
> Hisilicon.

Few comments below. After fixing them, FWIW
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +#define HI3660_USB_DEFAULT_PHY_PARAM           0x1c466e3

A bit of description would be nice to have what this value means.

> +       /* delay for exit from IDDQ mode */
> +       usleep_range(100, 100);

100,100 ? I think you need to give a room to scheduler, at least 20%
margin would be good to have.

> +       /* delay for vbus valid */
> +       usleep_range(100, 100);

Ditto.


-- 
With Best Regards,
Andy Shevchenko
