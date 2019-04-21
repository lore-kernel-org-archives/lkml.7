Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D679C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD7C2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcElJI4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfDUI0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:26:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33160 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:26:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so4503400pgh.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xtJDXk9MnspBzmfRWUTSL1NCl1WF1RAaR95qRXy3Kc=;
        b=rcElJI4x2bboUOsG7PlhBFgwQYf9j3PbmcXFLwrWJvLv4a0m1ETcoy/J98zxiS7bQU
         ajKt9JC3AFo3qjqLc1OOua98R1f0C49PFeJO7OJmslGKV4XPZ0ccwW3bLKjGO3SvV2Rt
         P+rG/hHOyi8W/GIXV3Lq0hI7Df0z4353ZNW1D78Z+T5GJgzd3JbF1Sr7BCwCq8HJvUc/
         YTKXne5uT3yPM9QmOWmfYVEsAHt9us9HPtKhPnx8Ab7FpJQK6eKf0efM5vA1iChvgIAG
         kP8gSWzyqO1Gz2gejImhUQt4QhC/Mv3ggv+BxIiD8dROZ0iHGSYOl78q/XPGtu48+eZD
         EfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xtJDXk9MnspBzmfRWUTSL1NCl1WF1RAaR95qRXy3Kc=;
        b=E3rhK0jkHWd1519Djgjn3MrAJ8XdGLQk71Klrjq/gF2L9hCZ09Q1VmUNs/yd8OoyxC
         KpTd2WHhwwxgRgdr4MEcoPwQKQYkpYAPMWu82oxuiDqpgYeuV5pB5VGm4TapJV+UPun2
         MVvUTVFQT5+jZ29ZCOsuLh2BO9IFpVisuM5481n1xskCbSLYQVlMrrOY7+rFYvAQsy+u
         b2xEEFcT0lfbwgeyM25utWZeIoK4D2+uf7K8mJ1tE8G5ZtccLZgdIdERwNPW6Gj1GEpi
         2MYzYavSAXVOtzHpiBSOa83vpzuaL61zNxOIast1Gu2sAs5xtAq7ps12ae7/weaU5tDu
         oq2g==
X-Gm-Message-State: APjAAAXb51b9MAijNIu05HerLBxOymLrxfadbxaeLlgD9cRq2S7i8SkG
        RvfEjuMTPO+GxMBuBdfqK4U=
X-Google-Smtp-Source: APXvYqwVKgwHheUglkAjUvWdJTWy7ZvTdu5JlRuq+OCTYY6yw1QnhYg6gRfWDDOsCVABrSd9gNUWbg==
X-Received: by 2002:a62:aa06:: with SMTP id e6mr14056562pff.254.1555835192758;
        Sun, 21 Apr 2019 01:26:32 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id d3sm13373174pfn.113.2019.04.21.01.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 01:26:32 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:26:28 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421082627.GB8304@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421080439.GA8784@Asurada>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > Firstly, according to your commit message, neither imx8qm nor
> > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > starts with "mclk1". So, before you change the driver, I don't
> > > think it's even a right thing to define an "mclk0" in the DT.
> > 
> > From what I understand mclk0 means option 00b of MSEL bits which is:
> > * busclk for i.MX8
> > * mclk1 for i.MX6/7.
> 
> MSEL bit is used for an internal clock MUX to select four clock
> inputs. However,  these four clock inputs aren't exactly 1:1 of
> SAI's inputs. As fas as I can tell, SAI only has one bus clock
> and three MCLK[1-3]; the internal clock MUX maps the bus clock
> or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> inputs[1-3]. So it doesn't sound right to me that you define an
> "MCLK0" in the DT, as it's supposed to describe input clocks of
> SAI block, other than its internal clock MUX's.

Daniel, I think I's saying this too confident, though I do feel
so :) But if you can prove me wrong and justify that there is an
"MCLK0" as an external input of the SAI block, I will agree with
this change.

Thanks
