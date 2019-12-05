Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98595205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575578265;
	bh=MXN1c2Az4QAp/9O4BJ6cV+Ge2HibAOAul6S0yZ8igzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ICq7qrk8mV/6UtZSAu6ToZoJTLZqv50TsXU+8WwrJIiGgICNascIy0P0hFDtV+pXR
	 9Pmx3DiggHsQXfqJYRycI2aIea/Pj/aNrOo4APvJ7quveni7g1CleaR8+tsRqdsJqs
	 1LNKHg1TzsrwMHD2NgN1K4Mm0x9vRqCLCRSaQr9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfLEUho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:37:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36039 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLEUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:37:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so4053147oic.3;
        Thu, 05 Dec 2019 12:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=35ZG4Dt1GHQBpvFgxpqY5q80MN/v65QQgmh3mucKzk4=;
        b=t6PDfe/eeqDuYjbxVWp2ok1d+qRLWnO9/CSZe8KncQ11tOvlEpC3xAak54MK9DDYYw
         Gva0WbJ9nlE81lU2FSQyBNZ07GvEhituNzVzpFWUXAZXc+kBgac+YRgXLnoCjFRW0Ym2
         rUdfwnWPSMxFADbEBSUbCwNMTCIAiteUDjHwJI/XQlCUYTqqxiCXr6vog0VWkwaFKujk
         v6X9wDAgwOLVNRgium1XuDweBoa6LPC9qrETVBBq6qzH9zzLFTe+VVufMR9EmNicgoZT
         tKyQzj6Dk/TZVsIiVOAPeSr2MHEzl2ons7xjuGiNapZ2aLJKNxPiI7DDWdhRg8TG5nwQ
         82GQ==
X-Gm-Message-State: APjAAAUCkg4yedcBeu8GPLvFht+fsxv6/JkvI+pvws0cK9TjwOyZAaDt
        X76UQO+h2FDV9TrwTm1olw==
X-Google-Smtp-Source: APXvYqybjR88Pnl9WvXUnFPPkc+t2nP5/2RlXPj4PgV7YHQb9ufreDGJOhffZWnH5OojadDmkIESvw==
X-Received: by 2002:a54:4f8e:: with SMTP id g14mr8885410oiy.144.1575578263383;
        Thu, 05 Dec 2019 12:37:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm3782147oth.31.2019.12.05.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 12:37:42 -0800 (PST)
Date:   Thu, 5 Dec 2019 14:37:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: Re: [PATCH v2 01/14] dt-binding: gce: add gce header file for mt6779
Message-ID: <20191205203742.GA1676@bogus>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1574819937-6246-3-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574819937-6246-3-git-send-email-dennis-yc.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 09:58:44 +0800, Dennis YC Hsieh wrote:
> Add documentation for the mt6779 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt6779.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   8 +-
>  include/dt-bindings/gce/mt6779-gce.h          | 222 ++++++++++++++++++
>  2 files changed, 227 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt6779-gce.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
