Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1823CC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A9920833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="sMMIZzwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbfFJHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:20:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36373 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387541AbfFJHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:20:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so6928542ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QbPinONeSAhxrcz+ROsSQJ+J9qK6AUeYBThX16lOVD0=;
        b=sMMIZzwmKrUmXgEHG/Gl7m8V3sJQ7hD1fFxlCutQz7ydVzDczsd6kgR1lLZyhT+1Dr
         ePFyuwyeMeoqF4Q+bj1hLZlBkPgKl6z7YxtTN57zkBPxNtDWoLl9tfi8JD385eXVFJke
         qeI+g07ICtRv9z2HFoLec0ccMWpYXybUvoyt31T+D6uY+Bzrf+FpcuyFhs2K7SGY/rIW
         WXpobojMTjs/4FcT3dJ+eHHMq4naSvHTuzaYn91lo2h3n6yvIX3khpebwdoFGx9Lscwy
         v9bwlPUxeqt6a0dY0Fy8tiYkf5SnnfCimn6AXkZvwawEGzJR4v6vjPiPmeRk/7U0X80m
         4A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QbPinONeSAhxrcz+ROsSQJ+J9qK6AUeYBThX16lOVD0=;
        b=lYYgu4+POPygbgul6zzoWlwC6+F/2Tw/9YzXylvuLJNN4ewO/VTb6V1VTT7Fs47yKM
         FU3IFe2QjkJqM7HhOkDYWapex26K2eGjDuYxhOJKxO+o5/oj3MTWXIY1eFdqu0E010Hx
         Vi02CdPf8fOTvUxu5qZJGlhgmLkJ835H3vdnJRSa279J1ZBWDnXAnG0lHVI08qzU+4py
         BT2mdILDPxV/cqQVcHcmSsiBFnGG0tyXI3+QHIJ2j+LbSGr9TG+c5av4RYGmW4du8lgG
         TERoFDSPfZfDlotuYxnvnQaUqgOW206PTQqdbUNIwL5gaGT3Jlz18y+CkbiakHoxJdH1
         3HjA==
X-Gm-Message-State: APjAAAU6WMqx7Wc9A4W20lahvJnhLpsB2J2XywMcTFB4FDrP0kDWWuCc
        6Vrf6vavbBrZAi8ukghNkomak68UECCNYg==
X-Google-Smtp-Source: APXvYqxM53NwgY80Ho7rdzPBsz/YjknnZAPhNXJ3Ym+JtdWVnCyuO4S3WoSBq1sAarpMkjaiJmiZvw==
X-Received: by 2002:a2e:6109:: with SMTP id v9mr35873723ljb.205.1560151211494;
        Mon, 10 Jun 2019 00:20:11 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id p27sm1842051lfo.16.2019.06.10.00.20.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 00:20:10 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:20:09 +0200
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: kpc2000: use __func__ in debug messages in
 core.c
Message-ID: <20190610072009.w5scsjb2aqcxm2l2@dev.nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
 <20190603222916.20698-5-simon@nikanor.nu>
 <20190606125550.GA11929@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606125550.GA11929@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Greg KH wrote:
> On Tue, Jun 04, 2019 at 12:29:13AM +0200, Simon Sandström wrote:
> >  
> > -	dev_dbg(&pdev->dev, "kp2000_pcie_probe(pdev = [%p], id = [%p])\n",
> > -		pdev, id);
> > +	dev_dbg(&pdev->dev, "%s(pdev = [%p], id = [%p])\n",
> > +		__func__, pdev, id);
> 
> debugging lines that say "called this function!" can all be removed, as
> we have ftrace in the kernel tree, we can use that instead.  I'll take
> this, but feel free to clean them up as follow-on patches.
> 
> thanks,
> 
> greg k-h

Can they be removed even if they print function arguments or other
variables?

- Simon
