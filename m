Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C6D214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576280446;
	bh=veqap3Y65muXVd9Lr2xstRgjDjimmC+WQHZ+YgwwLks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MF+UxjZrW2W0bk2qn10XUuis9yHg7m7bgplE6/pvhYq3kdh40iz1kSP9C1gbU4xXi
	 vAwHuicNGs+rQhe7urk183dulPHB7Rj0QHNSn2XIMByxC9CJrm2lZVuilBboREODJX
	 KdrDwWf4JhWADnqNFQLHpAEqinNx4TvRgBKnD6qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLMXkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:40:45 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37683 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMXkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:40:45 -0500
Received: by mail-oi1-f169.google.com with SMTP id x195so2093506oix.4;
        Fri, 13 Dec 2019 15:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V1Ed3iKuAEKRicl1Uhv8QMMK9/aCmbB5pf5+U5ktoAA=;
        b=OcPgPejhHY/17XerQ7eiJue/Dsqd3KbXDEoDmCBK+XW23aMkEQkseXd17exf3J5rCO
         OLfGTh53WdGxjWzGNsn7k8xrnHm123/bCKWWHZsHh/hRM5KF4nH+WDt+62G5uB4Nzzyr
         2NkBuuWIwtrZWoKcEk+koN01WCOlXlbpJ+EF4ZxvGv0mj15D/cLyWqJIJmN2wae9RMpz
         4+ue+Y2kxNwkFvt+53pe3zzRROcJw9/xU/AibLDC0kIkZgZM6+c4Om83Pc0vD/XKIsC/
         GeUF3Ltr5bjPBmj4X8n4GwBsZDZw0N1IIFBBpcVwb6o1Xbz/OeLIrdebYMmgadQUMBdv
         QTAA==
X-Gm-Message-State: APjAAAUVPtrZCDzpazL2DoJ/KjdJ/VQlykuviTnKVPFZUdM6iQbJpWDd
        XZFfEpdySw0IejibAZgr8g==
X-Google-Smtp-Source: APXvYqz+NOAXhdTyQjzYrG1tX1ZLVPt0E11C9lVHD0ublsOoZdAE1KxyBBW1Tj/oYQr9n/u9irlxwA==
X-Received: by 2002:a05:6808:4cc:: with SMTP id a12mr8415822oie.115.1576280444026;
        Fri, 13 Dec 2019 15:40:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm3825068oib.42.2019.12.13.15.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:40:43 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:40:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        Cheng-Yu Lee <cylee12@realtek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC 1/5] dt-bindings: hwlock: Add Realtek RTD1195 SB2
Message-ID: <20191213234042.GA9835@bogus>
References: <20191202220535.6208-1-afaerber@suse.de>
 <20191202220535.6208-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202220535.6208-2-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 23:05:31 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define a binding for Realtek RTD1195 SoC's SB2 hardware semaphore.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../bindings/hwlock/realtek,rtd1195-sb2-sem.yaml   | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
