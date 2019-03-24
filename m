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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E0C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FCB20883
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUNbwrNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfCXQdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:33:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCXQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:33:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so3931152wrx.9;
        Sun, 24 Mar 2019 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DLrP/4yFLW4qYmAZ27RnhMVnLiCxlI1IDTxiMEsU2WI=;
        b=PUNbwrNuQkpTCXueTr0zZlvz81KfFmqHJfxaZGxe2bsjCexdEZ7KbuIaDpHwtfIqkk
         cx1+poItDnSSpYThe2a2GhiXdyrHcOHVxC2Xn5fNDH/kAE/qO6KG4GdbSOORcriNEc94
         EZXyZXx4dfCoRlYbLMd7WD1ws2vjIix1Pk8Yto4JcRLqIoOOXJBa6sX54pMlj8kYn49K
         DMuzh/wSklbZV5XcgHM1T8c6Wvf5eUWC8NpqD7JmZcP5K7ZZuR9Gv7jGr8fuPSDOHGgu
         1vSx99VF2lDvs+FtBPYGqxszXsVX7Dzu6ZUAnNkdLp2oYF62wVtr4iIdMeW/cBL9l4lK
         bCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLrP/4yFLW4qYmAZ27RnhMVnLiCxlI1IDTxiMEsU2WI=;
        b=jTu8EhHhi2vHrrAvHG6TdbswQnhodXCx5DtLrNDhT2lCRjiN3llGk73AF5Wr36gWgN
         1/RxoR78adW+IAkffopLysQYOxjOqEr1cwJwF00AQeN8/DpcGa8WdHJOxgx4hfwd6mvU
         lC34ho1yJIPLTiQse42Fnupe+oVefLwD8zjL7zOqa9OCMLURqG1Ra7mjc8suGqv6QCqn
         nAILuIB7y0PIpCFDUd2Rxom89gdz5zVNi/QGuuTs1nWk950eGrYgO/GIu1OJ94NuPAqu
         +oPiKVfWDJRKGvA61jkFzIfYctiGmTuL5O2DiN9TPo20yY+pMiwv6i7739R1MW64chwo
         X57g==
X-Gm-Message-State: APjAAAVe+PMOeaw91vWZizk/h5zpIVGADztZasEZ8k3ZRXmx6cWV6T9w
        +4SXCuqJmF4P+u8YOmUPCxs=
X-Google-Smtp-Source: APXvYqy/piVAW/0AnBZ4qne/7/SrAajTEr2OYDFXZUfm9atYNrGtYVKFEf8vCw0nSinvx1qDEicKcA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr10077036wrw.313.1553445228553;
        Sun, 24 Mar 2019 09:33:48 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id i28sm21336529wrc.32.2019.03.24.09.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:33:47 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:33:45 +0100
From:   Sicilia Cristian <sicilia.cristian@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] staging: iio: adc: Converted bool to bitfield
 format
Message-ID: <20190324163345.GA791@peano>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
 <cover.1553366098.git.sicilia.cristian@gmail.com>
 <93b82557f3610f4bf4d09d0556e502b418376420.1553366098.git.sicilia.cristian@gmail.com>
 <20190324123452.66b81183@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324123452.66b81183@archlinux>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 12:34:52PM +0000, Jonathan Cameron wrote:
> On Sat, 23 Mar 2019 20:21:39 +0100
> Cristian Sicilia <sicilia.cristian@gmail.com> wrote:
> 
 > > Changed bool format to bitfield format to save space.
> > 
> > Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> > 
> > ---
> > The strange thing is that this struct seems not populated
> > using a DTS binding function.
> Indeed and that should have definitely been a warning sign ;)
> We are looking at traditional platform data here (pre device
> tree) and generally we will want to drop it entirely for old
> drivers that we are looking to move out of staging.
> 
> I don't mind improving it prior to dropping (as it avoids
> setting bad precedence in the code base in the meantime) but
> one comment inline...
> 

Thanks for comment

> > ---
> >  drivers/staging/iio/adc/ad7192.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> > index 7433a43..87891ba 100644
> > --- a/drivers/staging/iio/adc/ad7192.h
> > +++ b/drivers/staging/iio/adc/ad7192.h
> > @@ -35,13 +35,13 @@ struct ad7192_platform_data {
> >  	u16		vref_mv;
> >  	u8		clock_source_sel;
> >  	u32		ext_clk_hz;
> > -	bool		refin2_en;
> > -	bool		rej60_en;
> > -	bool		sinc3_en;
> > -	bool		chop_en;
> > -	bool		buf_en;
> > -	bool		unipolar_en;
> > -	bool		burnout_curr_en;
> > -};
> > +	u8		refin2_en:1;
> > +	u8		rej60_en:1;
> > +	u8		sinc3_en:1;
> > +	u8		chop_en:1;
> > +	u8		buf_en:1;
> > +	u8		unipolar_en:1;
> > +	u8		burnout_curr_en:1;
> > +} __attribute__((__packed__));
> Please don't use packed for anything without a very very good reason.
> it may result in data layouts that are much harder to read from.
> That obviously doesn't matter here as I doubt it's read in a fast path.

Ok, I remove it, thanks

> 
> >  
> >  #endif /* IIO_ADC_AD7192_H_ */
> 
