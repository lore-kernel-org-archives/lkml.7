Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73DB2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557338378;
	bh=b5K64YXT7/sSRzaEq78fChRqJJ4XU1m70tof6WpAG0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2OuUThK7cknbLRTyKSx2LPZ8VhXmNBo2dTIqxXJ1LOVo9MPG2iUnAxSZCISgRvpqI
	 tIjgoxCRqbpOylgZ1c0guiegND/gYiuLjlSsIa3RG8gltI5AZ3SvXtIS8MnlWCTXMK
	 8rgXKyE9Jx7OTWBRaVCJe5vnZ8Nn9zbE+J2h7i2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEHR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfEHR7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:59:37 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625E4216C4;
        Wed,  8 May 2019 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557338376;
        bh=b5K64YXT7/sSRzaEq78fChRqJJ4XU1m70tof6WpAG0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rWmn8Mr+YPTa3635iOLHVkNMUruBEji6pJ6mseb6pKa9/D199fcFhEezGXV3fJiM2
         HzlrDLrDTX0EQvnnv1OVfu+I21ukIHtvNcNr4jSrOXpA7J5kyNd+tdHpE4If5xl3Q7
         hyR4jVEoI7159KcfDjLkPxxz0aqAOuM0cFpU+HLQ=
Received: by mail-ed1-f47.google.com with SMTP id n17so22922230edb.0;
        Wed, 08 May 2019 10:59:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUMz/RtV/QVLrcsI+BsBJse/sDFVGzF0ZvKTHBfvfEbjqD+MRBc
        6D7JQsUX7PJyZHo0b5A8JScCessWSN1IixjHnRc=
X-Google-Smtp-Source: APXvYqxiCprp37hvq0CcehqS2sfXkAO7NXuzCP2m2lJotPqwABvFcdB9HmD3dH/r3gKHsAcxuymbZoeaUyx82vUVYqo=
X-Received: by 2002:a50:8803:: with SMTP id b3mr41531239edb.153.1557338375023;
 Wed, 08 May 2019 10:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-3-git-send-email-hao.wu@intel.com> <20190507172545.GA26690@archbox>
In-Reply-To: <20190507172545.GA26690@archbox>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 8 May 2019 12:58:59 -0500
X-Gmail-Original-Message-ID: <CANk1AXQW-BhHgaYkvYKU3tHRiFvj9_O3xteTh9cmfna2JKYauQ@mail.gmail.com>
Message-ID: <CANk1AXQW-BhHgaYkvYKU3tHRiFvj9_O3xteTh9cmfna2JKYauQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] fpga: dfl: fme: remove copy_to_user() in ioctl
 for PR
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 12:26 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> On Mon, Apr 29, 2019 at 04:55:35PM +0800, Wu Hao wrote:
> > This patch removes copy_to_user() code in partial reconfiguration
> > ioctl, as it's useless as user never needs to read the data
> > structure after ioctl.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Alan Tull <atull@kernel.org>

Alan

> > ---
> > v2: clean up code split from patch 2 in v1 patchset.
> > ---
> >  drivers/fpga/dfl-fme-pr.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> > index d9ca955..6ec0f09 100644
> > --- a/drivers/fpga/dfl-fme-pr.c
> > +++ b/drivers/fpga/dfl-fme-pr.c
> > @@ -159,9 +159,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >       mutex_unlock(&pdata->lock);
> >  free_exit:
> >       vfree(buf);
> > -     if (copy_to_user((void __user *)arg, &port_pr, minsz))
> > -             return -EFAULT;
> > -
> >       return ret;
> >  }
> >
> > --
> > 1.8.3.1
> >
