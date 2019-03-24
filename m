Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87384C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FAB2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHerTSJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfCXQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:34:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53633 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:34:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so6508958wmj.3;
        Sun, 24 Mar 2019 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fuo3OdaP9Fj8q0H/hp1yvVXCACMOULY+ZkpOchTeiW8=;
        b=PHerTSJLaoOF8YlfqSKG+mHCbf+rd19ftABT4xpRsG0np0Vf5q8nkJmcCN5fNcPHqz
         I0hISWn35P83AdnSXTe2Ga9cM+/q/b+x2bAJ7V0fguSRxyI1h6CLkMp5X15anSpTdINY
         qcYwqri8bbB+fUuELJO0eM+K8J1kpuO4y6XfgPHeuD59Ql3sdbYhvaXzGve5Yjlr2b0h
         0KzpAEvG4E6IYRJhpmRO3q3EwBIOn4ugfUnD+xn74JEsH5vcf9H8TxHszfQVHFNl2VZL
         J5BkctfMGLn6ElX1HPltBSleUS+vIMaBOnLEuX7UFQ9GoVBn2UqehGJ3OgGRzzYhKEmt
         3gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fuo3OdaP9Fj8q0H/hp1yvVXCACMOULY+ZkpOchTeiW8=;
        b=TsLjq08Jc3qy3LpM1fiUUgGAGJ2+zDxdQp4kqP9+0wB/fP/R0N8SQaohrawdBRaMmS
         kgcieoUxXG3ED8X0tjSbGOim6HD8O+mb3D3iJzm0RhNBvF4gJW1qTqAWqyBbwLukTZC6
         TGg5hPRvaZgXVloVj0Uk1Cuf33HPioCjMjEGkFoeutEvmMsOmZLuccTjSql7S6Nz2AEV
         kBYa+8SAExnRyiOq/yqRcb65LtSsLX0xozo24TBurVh44XYSBLUfwvtmTxzwOuXo86H1
         iB9cDvbpQOo1O2mymt5OZInZGPUqRHdn2NiciZrhATN3vhtunTGtyJ2bTE7CLb3r/YzZ
         ckKw==
X-Gm-Message-State: APjAAAWjl6bn72KXf+vhxa8OgNIn0tWZtqIXfv3IoqlrdodFh1Zye+Zg
        x7eXJEurODRXeO/JD9hpRrE=
X-Google-Smtp-Source: APXvYqy5y01k9DNJFx7yy5yra7PbG4CSnZIKZzJmU5NVrmXw1KKo1Mib5NaHoHssR9UKcRiVuxAQUQ==
X-Received: by 2002:a1c:9694:: with SMTP id y142mr8710696wmd.98.1553445254620;
        Sun, 24 Mar 2019 09:34:14 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id y5sm11873722wrw.23.2019.03.24.09.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:34:14 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:34:12 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: iio: adc: Tab alignment
Message-ID: <20190324163412.GB791@peano>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
 <cover.1553366098.git.sicilia.cristian@gmail.com>
 <70101e0eaa253140218d833223e0862d8851c01d.1553366098.git.sicilia.cristian@gmail.com>
 <20190324123552.4b4ad025@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324123552.4b4ad025@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:35:52PM +0000, Jonathan Cameron wrote:
> On Sat, 23 Mar 2019 20:21:36 +0100
> Cristian Sicilia <sicilia.cristian@gmail.com> wrote:
>
> > Aligned some parameters.
> >
> > Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index d9df126..55b5879 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -830,30 +830,30 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  }
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > -           in_voltage-voltage_thresh_low_value,
> > -           0644,
> > -           ad7280_read_channel_config,
> > -           ad7280_write_channel_config,
> > -           AD7280A_CELL_UNDERVOLTAGE);
> > +                        in_voltage - voltage_thresh_low_value,
> Firstly, that isn't in your description and secondly you just
> broke the userspace ABI.  Take a very good look at what is happening here.

Yes sorry, it will badly stringify, I fix it


>
> > +                        0644,
> > +                        ad7280_read_channel_config,
> > +                        ad7280_write_channel_config,
> > +                        AD7280A_CELL_UNDERVOLTAGE);
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > -           in_voltage-voltage_thresh_high_value,
> > -           0644,
> > -           ad7280_read_channel_config,
> > -           ad7280_write_channel_config,
> > -           AD7280A_CELL_OVERVOLTAGE);
> > +                        in_voltage - voltage_thresh_high_value,
> > +                        0644,
> > +                        ad7280_read_channel_config,
> > +                        ad7280_write_channel_config,
> > +                        AD7280A_CELL_OVERVOLTAGE);
> >
> >  static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> > -           0644,
> > -           ad7280_read_channel_config,
> > -           ad7280_write_channel_config,
> > -           AD7280A_AUX_ADC_UNDERVOLTAGE);
> > +                  0644,
> > +                  ad7280_read_channel_config,
> > +                  ad7280_write_channel_config,
> > +                  AD7280A_AUX_ADC_UNDERVOLTAGE);
> >
> >  static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> > -           0644,
> > -           ad7280_read_channel_config,
> > -           ad7280_write_channel_config,
> > -           AD7280A_AUX_ADC_OVERVOLTAGE);
> > +                  0644,
> > +                  ad7280_read_channel_config,
> > +                  ad7280_write_channel_config,
> > +                  AD7280A_AUX_ADC_OVERVOLTAGE);
> >
> >  static struct attribute *ad7280_event_attributes[] = {
> >     &iio_dev_attr_in_thresh_low_value.dev_attr.attr,
>
