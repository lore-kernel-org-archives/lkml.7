Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B0C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601452145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XCnwkJcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfGOUEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:04:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39966 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfGOUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:04:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so8836952pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIPyDfoq1gwRudrbDTccKZudDae1M5NUkYhO13RvCO8=;
        b=XCnwkJcGTSsbD1QlYvVmmZou9pO4Xdmopodsbu5bDdLcXb4/DppyDYJbW/tNUitYEU
         VS8CQ+xsSJHdUNFDZijyBQ2+nLJwYnLmA/Lq9qa71ER4SklfCAyGQgfBexBNUWE5yNXD
         +fCorfXpSGV+QQvSuR2fRaAAPvXyp/Iz8H2Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIPyDfoq1gwRudrbDTccKZudDae1M5NUkYhO13RvCO8=;
        b=uoaikmnmbOruocbcssYPfH1apBfFcYAb4fMcfXYfGQ8TCkbgv9b/Zmt0JWR1CroqvU
         SuhalV0nvtnXpwxv+IWr2nSemo3YKqRu/a39fDz1Rs0ap/U2evIHn8zeYLwcZ3alv+Dj
         QWbIyonM0lkyoZg0saHdkzWs8sFC/oLGdrN3r2eeLvc+UYcE3TP2qcHL66mi3VMXIeD3
         QQt0HFnBfCmbVVlwN1A6MibJD6V53JOYO93pARldgG5JDi/a5AfWLe3DHn9/TBWEpYqB
         zWZpdaSjw0FWXpUfnRU0kXCTQ2WxiNrQXPprKAgnF1ZbeB+IZYNAp98nGwL/Jx9weB/M
         hvXg==
X-Gm-Message-State: APjAAAUa6u5sYTx4c3K89XFC6yWk8s/m/TKWh1bdUt7mhbyqF2X76fD6
        EAg2Sjtra71P7ePLOVQwwPwSpZWEOeg=
X-Google-Smtp-Source: APXvYqzMAJ2wz7SBpHh5twreK8C3CywfrhNKClEHSgK7C7hvFJ2aLckjbJJyjuc4NRQwVyTtmvojFQ==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr29800609plc.186.1563221090153;
        Mon, 15 Jul 2019 13:04:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y12sm20924087pfn.187.2019.07.15.13.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:04:49 -0700 (PDT)
Date:   Mon, 15 Jul 2019 13:04:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Benson Leung <bleung@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
Message-ID: <20190715200447.GT250418@google.com>
References: <20190715191017.98488-1-mka@chromium.org>
 <20190715195557.GA29926@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190715195557.GA29926@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On Mon, Jul 15, 2019 at 12:55:57PM -0700, Benson Leung wrote:
> Hi Matthias,
> 
> On Mon, Jul 15, 2019 at 12:10:17PM -0700, Matthias Kaehlcke wrote:
> > Before doing any actual work cros_ec_accel_legacy_read() acquires
> > a mutex, which is released at the end of the function. However for
> > 'calibbias' channels the function returns directly, without releasing
> > the lock. The next attempt to acquire the lock blocks forever. Instead
> > of an explicit return statement use the common return path, which
> > releases the lock.
> > 
> > Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 46bb2e421bb9..27ca4a64dddf 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_CALIBBIAS:
> >  		/* Calibration not supported. */
> >  		*val = 0;
> > -		return IIO_VAL_INT;
> > +		ret = IIO_VAL_INT;
> > +		break;
> 
> The value of ret is not used below this. It seems to be only used in
> case IIO_CHAN_INFO_RAW. In fact, with your change,
> there's no return value at all and we just reach the end of
> cros_ec_accel_legacy_read.
> 
> >  	default:
> >  		return -EINVAL;
> >  	}
> 

I messed up. I was over-confident that a FROMLIST patch in our 4.19
kernel + this patch applying on upstream means that upstream uses the
same code. I should have double-checked that the upstream context is
actually the same.

Sorry for the noise.
