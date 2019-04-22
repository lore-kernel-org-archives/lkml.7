Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC5C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7529920857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555925485;
	bh=7HE6Ei9WMA0o+XSKb1qWctZsitK14uuE9OeCN320fmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yenwiK3K62Glt8QWVzDK+WGC1SftWbEr9M9Ve7kVjfhIJ/F3OZ2EogNpYgYEDFsmw
	 25wms17s3pI4/lwKKDlS2o7Bzo1hZud2Sp0fdhfYoH93zJHkegXIuYvYlgwwBHkk7z
	 7H3YTcgkOe+o/aNrytJV297T3lCDSWlP2btx/55M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfDVJbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDVJbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:31:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B0E206A3;
        Mon, 22 Apr 2019 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555925480;
        bh=7HE6Ei9WMA0o+XSKb1qWctZsitK14uuE9OeCN320fmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGydbsjtcFKEStSwigeW1LmFGDCh3Q0tjdocrw/CPmPsicZcaImC77C4duyAoece3
         V5Sr0WyG80uFuo7KO2+Brqq2qKUcY5fq2CAt5BZFAKw8d7I55Tl+dC1FJBgfDRwjfm
         yYh14a9bYPJyhS1jKuPkJVytszBdLvQQPCyvN0Zc=
Date:   Mon, 22 Apr 2019 10:31:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@gmail.com>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        lars@metafoo.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5758: Modifications for new revision
Message-ID: <20190422103115.50e2e902@archlinux>
In-Reply-To: <CAC+2QaGbUtoSRnkcD-LrHC27t-m1NBY_v86w2iAwdpkHisPrJQ@mail.gmail.com>
References: <20190409133521.24828-1-mircea.caprioru@analog.com>
        <20190414140220.75133382@archlinux>
        <CAC+2QaGbUtoSRnkcD-LrHC27t-m1NBY_v86w2iAwdpkHisPrJQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 13:36:55 +0300
Mircea Caprioru <mircea.caprioru@gmail.com> wrote:

> Hi Jonathan,
> 
> 1. Any changes to functionality that might break users of the older
> > revisions?
> >  
> From what i have found out there are no users of the older revision since
> it has not been available for purchasing. Only this new revision.
> 
> > 2. Any userspace visible changes?
> >  
> There are no userspace visible changes.
> 
> > 3. Do we want to think about back porting to older kernels?
> >  
> This could be a benefit, but i don't think the impact will be significant.
> 
> > 4. Should we support this explicitly by detecting or describing the
> >    hardware revision in some fashion?
> >  
> Yes I could use the CHIP_ID register to check the revision and do a V2.
> Just wondering if it is needed if there are no older revision chips in use.

Thanks for the info.  I've applied the patch as it stands with a line
added to the description noting that no customers have the previous
version so there is no need to support it going forwards.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> Mircea
> 
> On Sun, Apr 14, 2019 at 4:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 9 Apr 2019 16:35:21 +0300
> > Mircea Caprioru <mircea.caprioru@analog.com> wrote:
> >  
> > > This patch will ensure compatibility with the new revision of the AD5758
> > > dac converter. The modifications consist of removing the  
> > fault_prot_switch  
> > > function since this option is no longer available, and enabling the
> > > ENABLE_PPC_BUFFERS bit in ADC_CONFIG register before setting the PPC
> > > current mode.
> > >
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>  
> > Hi Mircea,
> >
> > Talk me through the implications of this change.
> >
> > 1. Any changes to functionality that might break users of the older
> > revisions?
> >  
> 2. Any userspace visible changes?
> >  
> 3. Do we want to think about back porting to older kernels?
> >  
> 4. Should we support this explicitly by detecting or describing the
> >    hardware revision in some fashion?
> >  
> 
> > Thanks,
> >
> > Jonathan
> >
> >
> >  
> > > ---
> > >  drivers/iio/dac/ad5758.c | 55 +++++++++++++---------------------------
> > >  1 file changed, 18 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> > > index 2bdf1b0aee06..a513c70faefa 100644
> > > --- a/drivers/iio/dac/ad5758.c
> > > +++ b/drivers/iio/dac/ad5758.c
> > > @@ -72,8 +72,6 @@
> > >  #define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)       (((x) & 0x1F) << 0)
> > >  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK    GENMASK(6, 5)
> > >  #define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)        (((x) & 0x3) << 5)
> > > -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK   BIT(7)
> > > -#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)       (((x) & 0x1) << 7)
> > >
> > >  /* AD5758_DCDC_CONFIG2 */
> > >  #define AD5758_DCDC_CONFIG2_ILIMIT_MSK               GENMASK(3, 1)
> > > @@ -84,6 +82,10 @@
> > >  /* AD5758_DIGITAL_DIAG_RESULTS */
> > >  #define AD5758_CAL_MEM_UNREFRESHED_MSK               BIT(15)
> > >
> > > +/* AD5758_ADC_CONFIG */
> > > +#define AD5758_ADC_CONFIG_PPC_BUF_EN(x)              (((x) & 0x1) << 11)
> > > +#define AD5758_ADC_CONFIG_PPC_BUF_MSK                BIT(11)
> > > +
> > >  #define AD5758_WR_FLAG_MSK(x)                (0x80 | ((x) & 0x1F))
> > >
> > >  #define AD5758_FULL_SCALE_MICRO      65535000000ULL
> > > @@ -315,6 +317,18 @@ static int ad5758_set_dc_dc_conv_mode(struct  
> > ad5758_state *st,  
> > >  {
> > >       int ret;
> > >
> > > +     /*
> > > +      * The ENABLE_PPC_BUFFERS bit must be set prior to enabling PPC  
> > current  
> > > +      * mode.
> > > +      */
> > > +     if (mode == AD5758_DCDC_MODE_PPC_CURRENT) {
> > > +             ret  = ad5758_spi_write_mask(st, AD5758_ADC_CONFIG,
> > > +                                 AD5758_ADC_CONFIG_PPC_BUF_MSK,
> > > +                                 AD5758_ADC_CONFIG_PPC_BUF_EN(1));
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +     }
> > > +
> > >       ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> > >                                   AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
> > >  
> >  AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));  
> > > @@ -444,23 +458,6 @@ static int ad5758_set_out_range(struct ad5758_state  
> > *st, int range)  
> > >  
> > AD5758_CAL_MEM_UNREFRESHED_MSK);  
> > >  }
> > >
> > > -static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool  
> > enable)  
> > > -{
> > > -     int ret;
> > > -
> > > -     ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> > > -                     AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
> > > -                     AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
> > > -     if (ret < 0)
> > > -             return ret;
> > > -     /*
> > > -      * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is  
> > 0.  
> > > -      * This allows the 3-wire interface communication to complete.
> > > -      */
> > > -     return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> > > -  
> > AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);  
> > > -}
> > > -
> > >  static int ad5758_internal_buffers_en(struct ad5758_state *st, bool  
> > enable)  
> > >  {
> > >       int ret;
> > > @@ -585,8 +582,8 @@ static ssize_t ad5758_write_powerdown(struct iio_dev  
> > *indio_dev,  
> > >  {
> > >       struct ad5758_state *st = iio_priv(indio_dev);
> > >       bool pwr_down;
> > > -     unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> > > -     unsigned long int dcdc_config1_msk, dac_config_msk;
> > > +     unsigned int dc_dc_mode, dac_config_mode, val;
> > > +     unsigned long int dac_config_msk;
> > >       int ret;
> > >
> > >       ret = kstrtobool(buf, &pwr_down);
> > > @@ -602,17 +599,6 @@ static ssize_t ad5758_write_powerdown(struct  
> > iio_dev *indio_dev,  
> > >               val = 1;
> > >       }
> > >
> > > -     dcdc_config1_mode = AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode)  
> > |  
> > > -                         AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
> > > -     dcdc_config1_msk = AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> > > -                        AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
> > > -
> > > -     ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> > > -                                 dcdc_config1_msk,
> > > -                                 dcdc_config1_mode);
> > > -     if (ret < 0)
> > > -             goto err_unlock;
> > > -
> > >       dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
> > >                         AD5758_DAC_CONFIG_INT_EN_MODE(val);
> > >       dac_config_msk = AD5758_DAC_CONFIG_OUT_EN_MSK |
> > > @@ -841,11 +827,6 @@ static int ad5758_init(struct ad5758_state *st)
> > >                       return ret;
> > >       }
> > >
> > > -     /* Enable the VIOUT fault protection switch (FPS is closed) */
> > > -     ret = ad5758_fault_prot_switch_en(st, 1);
> > > -     if (ret < 0)
> > > -             return ret;
> > > -
> > >       /* Power up the DAC and internal (INT) amplifiers */
> > >       ret = ad5758_internal_buffers_en(st, 1);
> > >       if (ret < 0)  
> >
> >  

