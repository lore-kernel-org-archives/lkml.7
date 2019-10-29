Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83755CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498D820659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572377286;
	bh=apLTNV5FI4HqB73ycnDqLkUuNALccPR33EKsR7jaXZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EPBTz1BuYP5zuY0hDHGj7ETLpffC3vrpb8FBE4ZrMB2Y16RUaRB5Eez6j1ntml1R6
	 1nhl1oMF5VMmEkxZxMxcYaBPvVzRnh9m+fNk8I3xCQi40LYqOut37+THS/yp6n7feL
	 1MT5/aiLLoeJdQ9gw6x6r2S2LVeFI0FKfbXR4FqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfJ2T2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:28:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38979 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2T2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:28:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so4693328otl.6;
        Tue, 29 Oct 2019 12:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0zdnZwmokAR/GsYiaZ2pYAzVNUBZHxjHTMKuDhMdpYM=;
        b=JMLQW7U7MQy3HqMsPX6SQsHE/CpMjgSMAy+OWVztK+RQU8BxXReHEe9aR1/GGxzjhl
         8vOvxN2aIaUUs9cAmTzVYpIdQvBZ1V6gaA2uBMXG2QFsxQH9izYS2W38hv8vkjDqHbFo
         EaPiUsYzzqXWACEjowGFdKwDpLtEZBgQN2mIm+hhhiNmf8fVcG3Q6EsXKf/jU7htJvqr
         8Pu0ai24P4QdMK6leIcPWCiWWppToG3PNfEoEBFBqmeuIhvvEdSf5UiVvPWtwAld65EM
         AsPGea2+PiFBud3uIisXJNdnxtepCapZ7+04qhOSAe7JFSCbbSLBUKf4wL52HPSBpdfb
         cANA==
X-Gm-Message-State: APjAAAWnVI4PkvyInaDVtUeCGGlLICA7p0Cd8zwuX/BXscnK/hMooteV
        iTo2SDjj9/vyP4MKgM0CZw==
X-Google-Smtp-Source: APXvYqzJ2OGkDg7Vi9JH4GFnkn6p59w8xzjoTajxVuI3H1NYV9vMfSDmHlkyOxYkTrLcJ9f/qmqtXw==
X-Received: by 2002:a05:6830:22ef:: with SMTP id t15mr8798502otc.256.1572377283925;
        Tue, 29 Oct 2019 12:28:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm5104885otb.63.2019.10.29.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:28:03 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:28:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ondrej Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: Add bindings for USB3 phy on
 Allwinner H6
Message-ID: <20191029192802.GA1282@bogus>
References: <20191024105500.2252707-1-megous@megous.com>
 <20191024105500.2252707-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024105500.2252707-2-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 12:54:57 +0200, Ondrej Jirman wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
> 
> Add a device tree binding for the PHY.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../phy/allwinner,sun50i-h6-usb3-phy.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
