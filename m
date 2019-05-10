Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F589C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="umxrHH80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEJCVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:21:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34633 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfEJCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:21:14 -0400
Received: by mail-it1-f194.google.com with SMTP id p18so6448444itm.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Tp3A1HqkaYqPPsTWL7+ahBUw9fqMa6q/M4oCRraR6I=;
        b=umxrHH80RYhOBiTsV3B4M/Uxz4aTJ4aASrnbnYZ2YkvTegxriWRTYW+SIm+7Zsl+TF
         mUe2veiyhK1Uc0+rjfEh1fqBxEAIzmiu0devtVTqPK5s2KBBzlhUCrWx2KRbgT+F9W4e
         ivbhiGlUapMGm8J6hDw0Nk97aboVibHoboKvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Tp3A1HqkaYqPPsTWL7+ahBUw9fqMa6q/M4oCRraR6I=;
        b=hJHF/9NvCf1uQJyumuVv+wuKxJZ98bZpGEHSAhfo5k/Y9MAC5lo0hxw9GmcBtiDI1r
         3gkh4dQ3vSL81AtkMt6VVkbGeVtiybO+as3wYaYMR4IBNGoJT+PVhfUGQgtKVYHn6HlL
         5Nel/vb9hYmIv+RDHHS3EhLgNf9noTxCNYKpWBa8pYXqJEdD1v05uqr8PqDtP4ug+JHK
         8n0Fuzf/HgKOhY1Vte3B8LDMhNFSWZTSKiDLmXt4vrIePGy9vn24e3s68wdFGz9YmaB3
         Wxbngjq4yWlVkuM6MDe+jpdGa+qcd9Cwl3KTCrL3ooZ8atXYB+HYKml1+kgt6Y8t0zjO
         P85Q==
X-Gm-Message-State: APjAAAW3tfUVcL+kPeBHTwj71dWgdsMg+Kvsxjg/cWASW7wJB1hfQj+M
        WBfclUFausnPMuQlPESFXBdu7pSUiKh+f15JhuQTyrsi4/9sIxnz
X-Google-Smtp-Source: APXvYqxcmQLKLzTB/D743xQIshga/tSYISns0c8/zehIacxiLCb0Yfy8T0iBU5X5Fdf4Ep+YwUfwff/c08VbjwKhtNo=
X-Received: by 2002:a24:c545:: with SMTP id f66mr5619946itg.114.1557454873514;
 Thu, 09 May 2019 19:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
 <1557344128-690-3-git-send-email-eajames@linux.ibm.com> <CAJCx=gn0Yv+oP56HQQNm-9JbH2aoZuEQ-73b1grLTVNfbYsDsg@mail.gmail.com>
 <5217daa3-4f43-0fce-5d1f-438f8c9e47bb@linux.vnet.ibm.com>
In-Reply-To: <5217daa3-4f43-0fce-5d1f-438f8c9e47bb@linux.vnet.ibm.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 10 May 2019 10:21:02 +0800
Message-ID: <CAJCx=gk3EwF_CTjVm=Ktx408iqcYUgZCSbZABXBSuGjfAjwXQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: dps310: Temperature measurement errata
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, joel@jms.id.au,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:17 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>
>
> On 5/8/19 10:09 PM, Matt Ranostay wrote:
> > On Thu, May 9, 2019 at 3:36 AM Eddie James <eajames@linux.ibm.com> wrote:
> >> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> >>
> >> Add a manufacturer's suggested workaround to deal with early revisions
> >> of chip that don't indicate correct temperature. Readings can be in the
> >> ~60C range when they should be in the ~20's.
> >>
> >> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/iio/pressure/dps310.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> >> index 7afaa88..c42808e 100644
> >> --- a/drivers/iio/pressure/dps310.c
> >> +++ b/drivers/iio/pressure/dps310.c
> >> @@ -221,6 +221,9 @@ static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
> >>          case DPS310_MEAS_CFG:
> >>          case DPS310_CFG_REG:
> >>          case DPS310_RESET:
> >> +       case 0x0e:
> >> +       case 0x0f:
> >> +       case 0x62:
> > What is with the magic values? Are they not documented to what they
> > are, and hence not defining enum values for them?
> >
> > - Matt
>
>
> Thats correct. These don't show up in the data sheet so I left them as
> raw values. Chris, do you know what the source for these values was?

Please at least make a comment in the code stating as much.

- Matt
>
> Thanks,
>
> Eddie
>
>
> >
> >>                  return true;
> >>          default:
> >>                  return false;
> >> @@ -237,6 +240,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
> >>          case DPS310_TMP_B1:
> >>          case DPS310_TMP_B2:
> >>          case DPS310_MEAS_CFG:
> >> +       case 0x32:
> >>                  return true;
> >>          default:
> >>                  return false;
> >> @@ -314,7 +318,7 @@ static int dps310_read_raw(struct iio_dev *iio,
> >>          .writeable_reg = dps310_is_writeable_reg,
> >>          .volatile_reg = dps310_is_volatile_reg,
> >>          .cache_type = REGCACHE_RBTREE,
> >> -       .max_register = 0x29,
> >> +       .max_register = 0x62,
> >>   };
> >>
> >>   static const struct iio_info dps310_info = {
> >> @@ -322,6 +326,47 @@ static int dps310_read_raw(struct iio_dev *iio,
> >>          .write_raw = dps310_write_raw,
> >>   };
> >>
> >> +/*
> >> + * Some verions of chip will read temperatures in the ~60C range when
> >> + * its actually ~20C. This is the manufacturer recommended workaround
> >> + * to correct the issue.
> >> + */
> >> +static int dps310_temp_workaround(struct dps310_data *data)
> >> +{
> >> +       int r, reg;
> >> +
> >> +       r = regmap_read(data->regmap, 0x32, &reg);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >> +       /*
> >> +        * If bit 1 is set then the device is okay, and the workaround does not
> >> +        * need to be applied
> >> +        */
> >> +       if (reg & BIT(1))
> >> +               return 0;
> >> +
> >> +       r = regmap_write(data->regmap, 0x0e, 0xA5);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >> +       r = regmap_write(data->regmap, 0x0f, 0x96);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >> +       r = regmap_write(data->regmap, 0x62, 0x02);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >> +       r = regmap_write(data->regmap, 0x0e, 0x00);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >> +       r = regmap_write(data->regmap, 0x0f, 0x00);
> >> +
> >> +       return r;
> >> +}
> >> +
> >>   static int dps310_probe(struct i2c_client *client,
> >>                          const struct i2c_device_id *id)
> >>   {
> >> @@ -383,6 +428,10 @@ static int dps310_probe(struct i2c_client *client,
> >>          if (r < 0)
> >>                  goto err;
> >>
> >> +       r = dps310_temp_workaround(data);
> >> +       if (r < 0)
> >> +               return r;
> >> +
> >>          r = devm_iio_device_register(&client->dev, iio);
> >>          if (r)
> >>                  goto err;
> >> --
> >> 1.8.3.1
> >>
>
