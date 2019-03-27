Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40746C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BB52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730842;
	bh=9WGIq56LRWUVKdmKbsI1v0V6Ap9e6r9ucva6Kh29U3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u3Jkd8vxQkpcgbiTnBgVhARWDh0AFb3c0KWIdRtFzQ1iTb6PYAKMVuskNPLTZh+N4
	 lLKuTvuCkTZVQsbXPsf1CVBDaIE25ZMDRzrE5cJszH7k+lgSgmCqyvkPMD49TGpyTw
	 lzqRBWaVTxm3aBt+GyZzWS7Pib5HAkVowUJmJyrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbfC0XyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:54:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34978 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfC0XyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:54:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id m10so9033585otp.2;
        Wed, 27 Mar 2019 16:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIgiXWt7uahQWZacFpuqcefGNM7XMjHOKbwLFz1FSx4=;
        b=HFWJGQyjQ6kmgoWDOEBk6Nnem6OT2ZuSEKfplhNzf8Q913m8szNHZqFBlHeWjXCN4E
         RK3wPgWje94zJ3uE1MplHOvAdxwUSQuo+/Me9JK/00n40uPkf8U5+bQ6nlRh4XfgC3ay
         3N835gUfpoheJgwX68ruvVd+y5rWiUBdR/6uDdIN3olBDPz14YyhlFEGhFH2zVTg2koQ
         7+uGR6t66Bi/m/SNiQcpi0cM3vEPacD9EBbAgcKHSrwnzaO0OzVipD+wjMFPExTjb/J9
         W3KifEsi/Gem8Nx5+8cLgCJIQtRqrnP0JMQzhb8IUPpeLEOGeCCvfT4T5vWqYNzXsApW
         PnpA==
X-Gm-Message-State: APjAAAW+cXYwHYwt7i2rLGceYWGdCqGDXxeXtt1Cxus24gkb3uL7flgI
        4EGwMSnsPJA43bAL9jzlJw==
X-Google-Smtp-Source: APXvYqz+PhyxFSwLtj+ZksTbQhVrzgs9Bpjq68xmx2TlCOifcvhUnrX1JVxOgQf98mNTxkc/I7u6EA==
X-Received: by 2002:a9d:7f0b:: with SMTP id j11mr19955473otq.132.1553730839879;
        Wed, 27 Mar 2019 16:53:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c136sm2664544oih.14.2019.03.27.16.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:53:58 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:53:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     sre@kernel.org, mark.rutland@arm.com, fkan@apm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: syscon-reboot: add a mask property
Message-ID: <20190327235358.GA30280@bogus>
References: <20190308074930.15270-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308074930.15270-1-ms@dev.tdt.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 08:49:30AM +0100, Martin Schiller wrote:
> Make the syscon-reboot driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> This patch is based on commit
> f2c199db477e ("power: reset: syscon-poweroff: add a mask property")
> and does the same change for the syscon-reboot driver.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.txt | 11 +++++++++--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/reset/syscon-reboot.c                   | 19 +++++++++++++++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
