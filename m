Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6D22CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566924790;
	bh=c1ZinrHJ7RUGlyP5ZLkDoPTj2Y8bimWAnUj+LND0tE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ebn4NUT//kBHT/EoAVBGhM7mx+qZOYgRPdCyIJRO+vKNiTlKGh1NQpknL5tgDrKqj
	 +90e2etiMGjDT4HjckU+DVLwUxkh+Jg55cTsJ+4zt0T1oZ136VbwLABaya9QksQ+wX
	 PT4vCySMJWmheMyDeeOYGfaIUhGhF8wcx0EvK074=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfH0QxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:53:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45192 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0QxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:53:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so19315395otp.12;
        Tue, 27 Aug 2019 09:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXZ+L1izx3v6iUiXs7Bmef3akgnqSl4UHvWXUS90ess=;
        b=Gpen/bScC7QWsCaxSYyPFbWXLr/Fah/GigR6RuDqd26V2iJSf0civGNqg4KnNjWFsm
         i2vSXXf8PImIcL73g6gZNtEBvAZ8hv/OaBPOnfTTn3fQnulAt90IlIPz1aN3UVwc7g/G
         jC5Y4oW2j+zvM7cbTdYWzPQQ6lB0OFlOsTHp1vOnQKozr8leiRC+zNR1qK7cLp00fBEJ
         fFx6+4akBWxGYfrq8KwrsLsFRI2U6q55J17EUOniSg3aLv7znIPB78y/OiMnCSZF7QeN
         gVKvZuFKpqiwbktrnI/n1OheIvLI+R6pvvxX0mZpU2CFVLRiL3pVAkY1x7ecZvq2Xfrm
         uGzg==
X-Gm-Message-State: APjAAAXedfoMplXwMQ5qK3j479s/rFfROzGt5VxG10D3cUpmHOf3qFAy
        ibFczigzGYFxLlRP7EelTQ==
X-Google-Smtp-Source: APXvYqwqaZqJc0EiQWQhXT7audNujzC7IOtWcqZLwMXAJYa90ehz6JXD56+/jyz25pglcwAaTH3NUg==
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr4181259otd.295.1566924788324;
        Tue, 27 Aug 2019 09:53:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm4318199oid.26.2019.08.27.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:53:07 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:53:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 09/11] clk: mediatek: Add dt-bindings for MT6779 clocks
Message-ID: <20190827165307.GA29782@bogus>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
 <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 17:21:40 +0800, Mars Cheng wrote:
> From: mtk01761 <wendell.lin@mediatek.com>
> 
> Add MT6779 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and subsystem clocks.
> 
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---
>  include/dt-bindings/clock/mt6779-clk.h |  436 ++++++++++++++++++++++++++++++++
>  1 file changed, 436 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6779-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
