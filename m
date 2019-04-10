Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D01C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9309120854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXyxBPU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfDJEab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:30:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44774 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfDJEaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:30:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so560330pll.11;
        Tue, 09 Apr 2019 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1qlgnPrUH7CcuLuQLu7vBTzEUvbkD9aeMWyD3vveT+4=;
        b=qXyxBPU7BHhilFmVEbZfMkvsD6Xk0iNcscnlDbOunNg6fvIdP+x8DKtkP/950QXqJ1
         b7Q0iRPWfbajK3XwuaPBCFzWHBFD3+rZ5pgUl2dEEUtOlhImeFqQkQ0PvYMegyPYLeFD
         RP3NVqLrtLxQlKDoWxC5JaAKncIAxyRiuTyhwHIqYchF5Wts8nPw1eY6m4WviT4P1AVw
         cF3cZfKffe+KHonaySuCHZkSEV4f5LuW8GnCRkWjC2UQN5JvRIj9c/HybgoQbYqpCB/d
         NdO65vqlCs9hqqDYdcO97q9bK0IcRT/PJ3E5CIPnFRY8W+DnBQPnhV4/hnOFOFplBgNk
         M2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qlgnPrUH7CcuLuQLu7vBTzEUvbkD9aeMWyD3vveT+4=;
        b=HoUnab4hv7ZfC7aSlLNBbkgCMA6OeaHIf+dTgaXziw/utEzk0EatRZXMuU2EHQuuTS
         6O4+i/l41M6Rj1J44Oz0+8MfQkJScqVeiKetJmi4ZvYDCNzWg38N8wMgYLDVCYlRGDfH
         Q7PTl6p+lzHZtZ5o9d20wMj+LOLVnRsETvLc6jiERBjCJcpQs9NeU6Y7r3o5c2rXhOtt
         1oZIRBDc57LWBlY9rOsCMTQMDpbgdrOI7OvlXBy+6QQipkPWsBA1tBlHBVk/skamEpHJ
         BMGOnfYaqVUD/qjjuZhnXGNFrg3a7cf9sdw08xLRY9CC9TR9Uv90XfxmAzsrFusUEiYr
         jD+Q==
X-Gm-Message-State: APjAAAVaw2J5PYYyYEavU8ux/R6rW4eSuPjuIgzzUlSp6SY6sCr4I32p
        Vra7nlPK16jLTapl9z/3BdU=
X-Google-Smtp-Source: APXvYqwH20ZmJQ2gaiJXYjc0Iq3X29OvYiq+lfIZnE1lCDPYOKhCvZBnluXA+60IMJlj9bR6XoDP2A==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr39581544plp.99.1554870630020;
        Tue, 09 Apr 2019 21:30:30 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id g4sm121025pfc.75.2019.04.09.21.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:30:29 -0700 (PDT)
Date:   Tue, 9 Apr 2019 21:30:26 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in
 probe
Message-ID: <20190410043025.GE3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:27:42AM +0000, Viorel Suman wrote:
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
