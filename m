Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911612064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553799052;
	bh=nWB8DdTWcPAdApx9TMg8UTUSTSHFU8nghgpm1GMhY/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nGq2RBloWXXjm2qxQpXGQib2hTO+bZya42TWp9VcGX6bo2AdEOqRSIBQmNjkCB6yY
	 8aHN2nP4qDOgp1BFSyP3TF1XL4rfFXm4n3j/MD8MDR2VkRvENX5fEVDe9BSYAWM8pF
	 IF/2P5MUpvj3EeqDXGJCb1uUN1HhCPQp3ZxBpwB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfC1Suv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1Suu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:50:50 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEBD2173C;
        Thu, 28 Mar 2019 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553799049;
        bh=nWB8DdTWcPAdApx9TMg8UTUSTSHFU8nghgpm1GMhY/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mCHKJTDWFk/RWsCwJa1Eehmh3ehwlGbE+XgOKiiLu0TY/0zXqbqJQH/0kgi68mZ1H
         s82wPg3kGHXlxo/IwbhjP5Mi9rP6KQIOpreBtr/98nlWT07Ayk8KrwOMs7X2oCM8iQ
         8qYUpfknPHnyrK2y+FVaCeG2ZsztpCFMJA/TJF/M=
Received: by mail-ed1-f44.google.com with SMTP id x10so18063305edh.11;
        Thu, 28 Mar 2019 11:50:49 -0700 (PDT)
X-Gm-Message-State: APjAAAX/PECjdy6uZ4oX9dkmhN0AiJVF/cZQyFLOWBQUJNJtPW8ameVW
        G59iv3s+VXizVow5BNYrP/uQ7PCQ8IxO4V5Xg2g=
X-Google-Smtp-Source: APXvYqy0XtT22lBq9eoqqVHyFm92F42gFVIa93O8W0SeS6oaEuHRzAxRzNUu9ev9u3R3MLPo4BskVP0lszHEiJUYnyU=
X-Received: by 2002:a50:b65d:: with SMTP id c29mr4327881ede.184.1553799048100;
 Thu, 28 Mar 2019 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-3-git-send-email-hao.wu@intel.com> <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
 <20190326002852.GA2901@hao-dev>
In-Reply-To: <20190326002852.GA2901@hao-dev>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 28 Mar 2019 13:50:11 -0500
X-Gmail-Original-Message-ID: <CANk1AXRZWgZFrShr=AVeoW2SP8zGA_Gv4eOw4Dvko_hXi_ivHQ@mail.gmail.com>
Message-ID: <CANk1AXRZWgZFrShr=AVeoW2SP8zGA_Gv4eOw4Dvko_hXi_ivHQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] fpga: dfl: fme: align PR buffer size per PR datawidth
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:44 PM Wu Hao <hao.wu@intel.com> wrote:
>
> On Mon, Mar 25, 2019 at 12:50:40PM -0500, Alan Tull wrote:
> > On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:
> >
> > Hi Hao,
> >
> > Looks good, one question below.
> >
> > >
> > > Current driver checks if input bitstream file size is aligned or
> > > not per PR data width (default 32bits). It requires one additional
> > > step for end user when they generate the bitstream file, padding
> > > extra zeros to bitstream file to align its size per PR data width,
> > > but they don't have to as hardware will drop extra padding bytes
> > > automatically.
> > >
> > > In order to simplify the user steps, this patch aligns PR buffer
> > > size per PR data width in driver, to allow user to pass unaligned
> > > size bitstream files to driver.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>

Thanks,
Alan
