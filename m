Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02938C5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5620861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfGHGSX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:18:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60212 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfGHGSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:18:23 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1hkMyj-0007Kd-8u
        for linux-kernel@vger.kernel.org; Mon, 08 Jul 2019 06:18:21 +0000
Received: by mail-wm1-f69.google.com with SMTP id u19so3857126wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 23:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ni/ZsRUHJQeGte3cJaCva9RYqIeypB1jmcG6EYYS4M0=;
        b=dzGUSMS7NzFs6G5RdLmMjB70WtLj4dRk/ubaB0SjCqVEMT+Aaw/Xr8lVASqP02N0ce
         X3vTp598zxgJtzNP7SbedZErONPM5j/Su6yhSka8NUGxpZ+EqUPMo3IqWv6y87tPMeds
         8DLGDZrR+qJjGeCKXClpeSF67uuzNkF0jr1Ymuk3ladKvkxzynDXpzqajPjgSSldZe7o
         rl+6AowsgijktIQhXThxgzqxIhL1TsUVUPZSInUg7gecZM6MgX624kuBxITp+0+Hg1ts
         hZV1ffAmxPEdZ/sNLtYSsESW0yaMs01vaxR6TG5A72bJMRRDNsVrtgbcXYzOIvzI5DKx
         qsFQ==
X-Gm-Message-State: APjAAAWuRAZGaldZVGksFV86SVvZsvM1bRsIei/y11LpL9F2DIR09cn3
        OIOaGZ8GyJiMvx6T/357eUzke+stCaG3Ga+Edu6FC+Gl4vMgScs6wsRN/g+Ym+d9dVTbAhL82yu
        FSj42f2VmaaPlMJ2FBVBlsKB65UlycitVlEVpIRrDkVvjNekGebxVO0zhbg==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr16856900wrn.165.1562566700888;
        Sun, 07 Jul 2019 23:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwig7hgNaptLx4qBqsvR/0MyqEqHKYxSDJDbwqswzvIlF/Euk+VlLhQjiYtbYlLVahTH/1T47u6IHnv1+zpsmk=
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr16856867wrn.165.1562566700631;
 Sun, 07 Jul 2019 23:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190625083051.30332-1-acelan.kao@canonical.com>
 <a3469010-829c-16dc-be83-6fe9b3021530@linux.intel.com> <CAFv23QnaKMs9bjS9ry_L4K7wskUqNR2AsgDG-v+fah2XO7EpKw@mail.gmail.com>
 <5c14537d-b6aa-b478-fdd8-29f690b15e07@linux.intel.com>
In-Reply-To: <5c14537d-b6aa-b478-fdd8-29f690b15e07@linux.intel.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 8 Jul 2019 14:18:09 +0800
Message-ID: <CAFv23Qmo_f=FEVM2ZOfL-8SvP624doY-OxU_T091uweKwJJ7QA@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: Add disable runtime pm quirk
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Sorry, I lost track of this thread and didn't understand what you want
me to try.
I'm willing to try it if you can explain it more.

My colleague comes out another solution for this issue
   https://lkml.org/lkml/2019/7/5/17
and it explains why it takes up to 100ms to wake up.
This solution is more aggressive to zero the d3cold_delay and it looks
like the delay is not necessary.

Anyway, we have two different proposed solutions now, my proposed
solution is specific to the listed platforms, but we may have to
extent the list(platforms which uses the old firmware),
the other proposed solution from my colleague is generic and apply to
all platforms which loads intel-lpss-pci driver, it may lead to
unexpected regressions which we don't see now.
Please give some suggestions, thanks.

Best regards,
AceLan Kao.

Jarkko Nikula <jarkko.nikula@linux.intel.com> 於 2019年6月26日 週三 下午2:27寫道：
>
> On 6/26/19 5:32 AM, AceLan Kao wrote:
> > Adding I2C_HID_QUIRK_NO_RUNTIME_PM quirk doesn't help on this issue.
> > Actually, Goodix touchpad already has that PM quirk in the list for other issue.
> >          { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
> >                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> > I also modify the code as you suggested, but no luck.
> >
> Yeah, I realized it won't help as the i2c-hid device is anyway powered
> on constantly when the device is open by the pm_runtime_get_sync() call
> in i2c_hid_open().
>
> > It's not Goodix takes time to wakeup, it's designware I2C controller.
> > Designware doesn't do anything wrong here, it's Goodix set the interrupt timeout
> > that leads to the issue, so we have to prevent designware from runtime
> > suspended.
> > But only on that bus where Goodix is connected and open by user space.
> What I mean something like below:
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c
> b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 90164fed08d3..bbeaa39ddc23 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -795,6 +795,9 @@ static int i2c_hid_open(struct hid_device *hid)
>         struct i2c_hid *ihid = i2c_get_clientdata(client);
>         int ret = 0;
>
> +       /* some quirk test here */
> +       pm_runtime_get_sync(&client->adapter->dev);
> +
>         ret = pm_runtime_get_sync(&client->dev);
>         if (ret < 0)
>                 return ret;
> @@ -812,6 +815,9 @@ static void i2c_hid_close(struct hid_device *hid)
>
>         /* Save some power */
>         pm_runtime_put(&client->dev);
> +
> +       /* some quirk test here */
> +       pm_runtime_put(&client->adapter->dev);
>   }
>
>   static int i2c_hid_power(struct hid_device *hid, int lvl)
>
> --
> Jarkko
