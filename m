Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A66C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1C20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Z9LQs4cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfDXA13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:27:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38557 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfDXA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:27:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so18346535qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jsDid659kSscC6xtD+dsY8Tahys0s36n+fqqZemfV24=;
        b=Z9LQs4cyedfBuchy1MsfQnUGuXXDT0cq/grgTJJkSHz3I8yg4xJsAP7iklJaDEolSu
         h7eTidGSXEdGevmiQab4zHe6InTaQrXKv8aENG06Pe/fH0DIokKuUOcz8zC/lIZOI4RB
         W9e62ik3kkJMs2vkglIrfqfhrzdxedP2tdO09o9QCxzxN5UhMQt+klEbPyfjfkyxD/Yy
         qGC/R6jD6Y86t6EWZrdL6v+VqopY8nRDLc9dtNevvtQCU4xHnkri5ctCf13qn2DYnkO/
         WZo46ThOmDlk6FgrOa9tQ8XMcrxE25PlWdVBlwY4Dew3Cc3e+ITPlnVPZEJfdSokZ03P
         IxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jsDid659kSscC6xtD+dsY8Tahys0s36n+fqqZemfV24=;
        b=SFIZtA0Db+RbNO7SG8dyp8kwJWhbkPFDuZnZJ2U20UQndnF413+0eniQuyd25/B0U3
         SjmljsRKCnbZgTd6GCVRYRpbRQXJ8PzN52Z4jkp91N5iinRXdCM63HrhLfJF05QWOzn7
         MpxttI//hkor8PEn7aRCHZh4e38SsPg+slDJp0ejz7TwgZRiDHNZF3R5Kiw31g1DWahU
         Bu1gexOYhME5zNA86RrD3WFWu5tGDirz6rjywye3ZF7Jdu7BftjPDy035EwVzpNYmiod
         cx3BgNhO+YH2YlH2BdGJOJwv5F5n8Lx5vF5+n4YsXJgLWItn0bQmwwjmrLefPTqDhgFU
         nBbg==
X-Gm-Message-State: APjAAAXldZNsygXb6FFTA0wFmBbkx89zLd6nuFyUe/FCyzipkAxypM//
        nsNba+WK9+ZSjiYKgcqNPggIxA==
X-Google-Smtp-Source: APXvYqxbJnsmM0nSs9LrkP9jN2rc/vnk9K5fua+jfvJI+ONQPOU/5LD/dVX2ll5sORZfkkQpM35cyQ==
X-Received: by 2002:ad4:5442:: with SMTP id h2mr10800126qvt.198.1556065647951;
        Tue, 23 Apr 2019 17:27:27 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m6sm1280354qkc.56.2019.04.23.17.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 17:27:27 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:27:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
Message-ID: <20190423172709.693f4784@cakuba.netronome.com>
In-Reply-To: <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
        <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 16:08:53 +0300, Grygorii Strashko wrote:
> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
> config option.
> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
> make build work.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Last time I tried including the same object file in two different
modules it backfired pretty badly.  Would you mind sparing some 
details as to why you need to do this?
