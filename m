Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479B7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194C020748
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 01:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQcNvJfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLBBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 20:42:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfLBBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 20:42:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so17094625pgl.5;
        Sun, 01 Dec 2019 17:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uhfo+Tsmbw3kX/yCMxwrxLrXfDbUCCVYUmIkTB7sVPY=;
        b=VQcNvJfF7M39+QSaXYKr8Rgd1oArBi1F0NTI/m+Y9OkyarJzFqLfTjCQq6TX+FUyOR
         wK9lkIbY+hVk7gVKH4ZWt2XtCKHW0VIo7KO/ekhnXmC8DpcHf7URaxZpQ1H4Cv50vI3S
         YMuSwknEpN5LCkxEauwax+kk0DNJLyaP+Y2DuP3JuZK8UMq2kJiu4UiOgN3on6UwZiiY
         oujDuPcNq67+eV/wm1lCcFHl7TN+TVpxx8zLBJddWekfBPPBFAMkKUtjfIOm2nMMtho2
         YlN3A/JoPlC/u11MSPw87N4G4ORBwYsvJ8R3DY4ys3QpErLSQ9WsX80gllECMKKJibLF
         cHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uhfo+Tsmbw3kX/yCMxwrxLrXfDbUCCVYUmIkTB7sVPY=;
        b=jTIOA9WqBx+SWCS0S60Ap9pD0HYg5zLXNFcTgQQ7d7YIbl5xI9v+w1IIwqsUkvuC9t
         Oh+NBdAIL29ZgK5whu8/5cdhzL09QyxORkFdGJa4da0E5YgcClIjCPlIA0iQB85b2yCQ
         DNgLAnv1lT+5Ohcsmvb2y94uhkIuz6KuPcrIWCOBwvhj3sLWiqvnTtacC8HUkR3Eax+d
         nzWm3FN8pG5VmcvYrtjmUTZkM1qmPsnC8E6z1pws35pRU6ADB/DaySWds0mALbs7q6AW
         V0x/aqnd2bi22q6v1WRLCRUDynP7ODoB/eVFiQJ+jaO61WtMBUlo/ImmVLoUXoxqEMOk
         wpbg==
X-Gm-Message-State: APjAAAVnVv6rjAeMCtE49r6cwz3K40QandPC4/vY6v0Wbv+Kj4Oj4GRU
        E5x/4V2Khr/RXrD5A6hKToE=
X-Google-Smtp-Source: APXvYqy3NxrHy9dDtOm4rbfhAZ5ovvcHxW7AxzSB9D2aLC4FbRyOoWq7jNqTfeCQ6zh8E7SCWi0Qfg==
X-Received: by 2002:a63:105b:: with SMTP id 27mr17554482pgq.268.1575250961136;
        Sun, 01 Dec 2019 17:42:41 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m71sm13516731pje.0.2019.12.01.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 17:42:40 -0800 (PST)
Date:   Sun, 1 Dec 2019 17:42:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191202014237.GR248138@dtor-ws>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128185630.GK82109@yoga>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:56:30AM -0800, Bjorn Andersson wrote:
> On Tue 26 Nov 08:13 PST 2019, Marc Gonzalez wrote:
> 
> > Date: Tue, 26 Nov 2019 13:56:53 +0100
> > 
> > Using devm_add_action_or_reset() produces simpler code and smaller
> > object size:
> > 
> > 1 file changed, 16 insertions(+), 46 deletions(-)
> > 
> >     text	   data	    bss	    dec	    hex	filename
> > -   1797	     80	      0	   1877	    755	drivers/clk/clk-devres.o
> > +   1499	     56	      0	   1555	    613	drivers/clk/clk-devres.o
> > 
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Looks neat
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This however increases the runtime costs as each custom action cost us
an extra pointer. Given that in a system we likely have many clocks
managed by devres, I am not sure that this code savings is actually
gives us overall win. It might still, I just want to understand how we
are allocating/packing devres structures.

Thanks.

-- 
Dmitry
