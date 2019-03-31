Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C230C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622B2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 02:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck53Mqst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfCaCIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 22:08:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46569 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfCaCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 22:08:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so2772897pll.13;
        Sat, 30 Mar 2019 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eBg7yjpPulHi/p5KAdz0Pv/mUoivmVreFy+xMokiC04=;
        b=ck53MqstrDUTmLmBxOpa32PKbRBt0UFxlI3AfZ87S6G1PmUJG+ny4tWRee8Ely3wJ/
         ov268GZQGKxXXXYa3v+VK4DTACsF1eH1J+iiNhhed//L0QS0tHNKNtRuuvrL0Nv/FZw2
         eyvNZ/v1TfUmLMJkjo1HM40YeeOw6mHj5/chvydPp/KrmT8BBxMnC9dSSHnPHnQ3FF67
         /QewidiRiIesC4hO5YJenSr9x75uqBTOEcWgJiXdg/uqHL5AliuKPzkjqXUL5IdIY4dt
         K63n0mARNkJpfnQx1+y50hA8J7zfP4EdhXx1XnDOZKdNTIkY4kmH3as7NmviYA8M6xZH
         8H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eBg7yjpPulHi/p5KAdz0Pv/mUoivmVreFy+xMokiC04=;
        b=nmN0zmzmlWjxAnXNVvYdu8qe4LyFHZtY0okniJMrLoX2Nw8kSvuqt5JEbmSextrE0w
         nsnmrg/cwt51AhBqBAaCoSTWC9hEhWrGHBpXGOt3LYPSWF2PEO5oNxXO1D9hWrpTAvu4
         6YLx6ktxC8PGIVk5RHlNI+AHGE0Gk3h4zkkkVBD+3PEP2tTpqcJ67y+ed2xQz2sRW00w
         NtkUs7R97an8/I53oL+SElMM6DDV1LDYm57e8nndu/GXTOLAnf8BdHVWToOlTvCsJdto
         YsTTwVG+NL2m5E17CYiZgrM5bwhuD/i70hTHzqYNPcQJNjOCHYAfP/KgNyk4Ix3rGGYX
         iynA==
X-Gm-Message-State: APjAAAX03CCP+zhFHd6xx9iSgrf6bcUsa/7vzLpe12sItQt0TpE9M8jt
        +hxyzBUWiv502V22nPyjdtU=
X-Google-Smtp-Source: APXvYqxUL26r00oo7Vxc/vOv+0an/xCkMYkaZ852jsCUxT1QBxg15Snoks3Tyzf85jzSM08WgFEw7w==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr57217743plb.186.1553998126062;
        Sat, 30 Mar 2019 19:08:46 -0700 (PDT)
Received: from icarus ([2001:268:c0a5:7955:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id g2sm8238003pfd.134.2019.03.30.19.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 19:08:45 -0700 (PDT)
Date:   Sun, 31 Mar 2019 11:09:32 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 0/2] Add Updown Counter support for Milbeaut M10V SoC
Message-ID: <20190331020932.GA4108@icarus>
References: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
 <20190330183603.55886d4f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190330183603.55886d4f@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 06:36:03PM +0000, Jonathan Cameron wrote:
> On Tue, 26 Mar 2019 15:32:34 +0900
> Shinji Kanematsu <kanematsu.shinji@socionext.com> wrote:
> 
> > This is a series of patch which adds Updown Counter support on
> > Milbeaut M10V SoC.
> > 
> > The Updown Counter counts input pulse signal from external quadrature encoder.
> > It also has input pulse signal counter function.
> Hi Shinji,
> 
> Are you aware of the counter subsystem that has been proposed (and
> as far as I am concerned is ready to be merged)?
> 
> https://patchwork.kernel.org/project/linux-iio/list/?series=147
> (I think that's the latest version posted)..
> William, perhaps you could give an update?
> 
> (bad luck, you are getting popular ;)
> 
> I'll take a quick review as it stands, as some issues may carry over.
> I appreciate that it's always unfortunate to try to upstream stuff at the
> same time as a new framework is being developed / upstreamed, but I don't
> intend to take any additional counter drivers into IIO.  We just
> end up having to maintain old interfaces in more and more drivers.
> 
> Thanks,
> 
> Jonathan

Shinji,

If you reimplement this driver to use the new Generic Counter API, I can
pick it up and include it with my next patchset submission. Please base
your patches ontop of the "generic_counter_v10" branch from my personal
repository:

https://gitlab.com/vilhelmgray/iio/commits/generic_counter_v10

Documentation can be found at:

	Documentation/driver-api/generic-counter.rst
	Documentation/ABI/testing/sysfs-bus-counter

Look at the existing drivers inside the drivers/counter directory to
serve as references:

	drivers/counter/ftm-quaddec.c
	drivers/counter/stm32-timer-cnt.c

If you have any troubles or difficulties with the API, send me a message
and I will be happy to help. :-)

Thank you,

William Breathitt Gray

> 
> > 
> > Shinji Kanematsu (2):
> >   dt-bindings: iio: counter: Add Milbeaut Updown Counter
> >   iio: counter: Add support for Milbeaut Updown Counter
> > 
> >  .../bindings/iio/counter/milbeaut-updown_cnt.txt   |  22 ++
> >  drivers/iio/counter/Kconfig                        |  12 +
> >  drivers/iio/counter/Makefile                       |   1 +
> >  drivers/iio/counter/milbeaut-updown.h              |  38 ++
> >  drivers/iio/counter/milbeaut-updown_cnt.c          | 385 +++++++++++++++++++++
> >  5 files changed, 458 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
> >  create mode 100644 drivers/iio/counter/milbeaut-updown.h
> >  create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c
> > 
> 
