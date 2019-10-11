Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31743ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE2214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570807825;
	bh=GAtARJ6t5b2vt4w1GP+j1Pw4Lt353tnhu6r0XWe+9z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/7UFw+qN4FHpdjptsriMTE99AdmHV4iZdQP0S7IhJ6b/+gwhNCFpkamXrmsCRvJO
	 5gSWK3i1x4VbQmQhdee3+gN0lxAjoDzCv8F531FlDJqm63srAZUC/2Rib3SqeHRlbN
	 PdiulOWbfXjMo2Ac8XrGepYilFyckwuW/aDUP4Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfJKPaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:30:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40873 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJKPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:30:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so8331679oib.7;
        Fri, 11 Oct 2019 08:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IlY2+yeW416JGr4DtEVYz+C96Dhs+gm3/zcCLQ8sBOQ=;
        b=N4ghlBebqu13t+4BxB9hZxdakTRywht11hIlFhHQWdE66rUpdZ4jToRicFzCWIJoNu
         0oDyXQqG2m7wDc6JLSo2mlQRrqzQDTgWLD3W3W/ImwjuXUqxctrdG2qEs0RN7I5Nd8zB
         XTZ198RK0+X2mdMd/Qs/WB+Bq9Z4v4eL9R7fJESzblEP0Ha14dAn2LprTPorbWcoh8OO
         wzaVPAzwyJS+YHNRQRY8eUB/tTnWRCRJNcWKnHxCgOSZRXdNBAO4/YU5oX95lS9hWD3Z
         8F8rN5r+RoCzcbpGdoUYxcvnnJGbo0sSogGq3BCiwJyOujTEpBmtOCVQ8Wf3U0OihIHC
         qSlA==
X-Gm-Message-State: APjAAAWKHtVBmRcg37h8sfeOl4uYgdaMFMPmZWUb8WGRP9qaacl/yAdF
        IiNrFLcRanJTbh3JS2Eijw==
X-Google-Smtp-Source: APXvYqwZweugxncUG7CPGNcm/LK2vvZBo2mMRKKh78w/KX0EXUj40FYs6ODtK25SX3OUSCKzB3WjEg==
X-Received: by 2002:aca:f5c1:: with SMTP id t184mr9829490oih.88.1570807822538;
        Fri, 11 Oct 2019 08:30:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z16sm2668403otq.78.2019.10.11.08.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:30:21 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: clps711x-fb: fix
 native-mode setting
Message-ID: <20191011153021.GA10765@bogus>
References: <20190918193853.25689-1-martin@kaiser.cx>
 <20191005130921.12874-1-martin@kaiser.cx>
 <20191005130921.12874-3-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005130921.12874-3-martin@kaiser.cx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Oct 2019 15:09:21 +0200, Martin Kaiser wrote:
> Move the native-mode setting inside the display-timing node. Outside of
> display-timing, it is ignored.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v2
>  fix the example in this binding as well
> 
>  Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
