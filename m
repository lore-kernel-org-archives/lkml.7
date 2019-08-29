Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C18C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BFB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567119442;
	bh=9BWAFJVsb4ZftQv8sobpEtSaQjaXCBSGfqFPPkrbxLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=POtHSRbzuQ/RxwCIdD6EemMN6203udnhT1wfXMUkmxo7XocZoA+cIF2GMs5Q9UdJt
	 D9YKdTQGiSJbE9iC/sRVLDguhgK6T7fZzdCobHRLgLeWYhi0sK8zp9B2dfvQbIKonQ
	 Q2UmkUZ8LDBaFV62ahQ0gopZ6L5irOHxuSFGcsPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfH2W5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:57:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41850 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfH2W5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:57:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id h4so490363oih.8;
        Thu, 29 Aug 2019 15:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tt59Vai4nKcFOlf3kuJu+36rcTwUnw+ESfP2cPA8a9w=;
        b=oKu7R06QbsBdaT25B01CUIevRx3l72ZwMHS/TKYjkZJT3WSpPbOMimRBypIvIE/47B
         pBWJk+Q5/+QEW5Wu89HzM9+AqLTwULx149VXKevVqlH4PsZygKEzWeicbAVChuTIc6K3
         9R2IPuowovw26jmT6dTDph9MJeg9lGyiIC9SIVou0m3xoAHmlEln7pI8orOFcerKpdPi
         SlxtwySB2ZZ8CxAxPGWoi5TmEFtE/GQ6tiks6/0CQKTtKJ0kO4NzBSvG5pz9qnzvHYPB
         2FX0Y68noAKEpoGLOPxYmcMNuuizhcfXcwTWjBzQ2Ys17686ACJVUUeKarC4H/1sBMy5
         zjiQ==
X-Gm-Message-State: APjAAAVc8AFevI3Uo9Ri0hZ8Upd1cxHJjoS+JNV0kY7mSYJoCGYWTIwP
        /H7hKGrT8gGbtcPL6RKVgQ==
X-Google-Smtp-Source: APXvYqzNLJ5SnSm+nMCobpcQcc3WHBIxdaTxiYCSwEw6M9n03lmG7rmmrOA9SRGSrxwhdyGE3uk1qQ==
X-Received: by 2002:aca:3909:: with SMTP id g9mr192281oia.158.1567119440204;
        Thu, 29 Aug 2019 15:57:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm1026334oic.6.2019.08.29.15.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:57:19 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:57:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: stm32: add wakeup-source
Message-ID: <20190829225719.GA21954@bogus>
References: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
 <1566833923-16718-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566833923-16718-2-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 17:38:42 +0200, Fabien Dessenne wrote:
> Add the "wakeup-source" property: if the optional wdg interrupt is
> defined, then this property may be defined too.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
