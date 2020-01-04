Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00EFC33C8C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E2D21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173137;
	bh=cEoTCCKJOA9+A27WKM3FZjnMbVBS1L3hY5cezH3Ax3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Glxf8Ii7NAZglqaWEqncY4vYhXvj3L+ntMxzW3W+8ZuX3RPZPAmCIUQDgbGg+X0r/
	 XMlSjOKKz5ekNFhnNVeQYrI3vzS473zcLok3iJsR08VDNMq6rRl+ZfUTSuRedDoKyt
	 S/4UBQg0gtYhyN/4usXy8btuBLu9s0v0tDEhWGVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgADVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:25:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37911 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgADVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:25:36 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so44780982ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lBc75v5k8yr7YkZSPENL1U+v5GuB9Phe9x6JuGau+/Y=;
        b=psbvOrWQ52G3UYcjy98OrEEpiyhmi+cEhr1SLykXmhX3h6D4Bz4rajLpqiLOR8F0nC
         mAwanCgVOb2j/U0rpwxvjMh7FNUWDLl5wDlNBZ/FJnXleb2UX06ZHUikntHAPvYAN+tx
         nmVM5jq41H2rtdvSC4c72/PzriOaFZ44Ws5dnS4KFv3VRGKrTsRHpzhVXkMdwSbgbdPb
         bezslIgQ2zk67FrTcGRDucEzL11udUUxcnhi1rX5JMFCj/8pfcPW+IG1jhR8Z6UL1eR/
         JcqvH11hNKP315B4J2MhQYFhewpE5qoRiXZMddgbDdwVnBT2tm6n/PNOr6hTp94OFomj
         9LPw==
X-Gm-Message-State: APjAAAUhETGBBrRagKCEgD1O2dRkB0ir22h3JN523tJ9Tym/iTY7KbBv
        /sIZ2hJ8uTLbua/Xe4p3/fEo+8o=
X-Google-Smtp-Source: APXvYqyUor4bBhdGhZSpcd4sEzl9rb6ftkFAGK3Nnm/VwdU8k+NbDxHRPjLoIwupjQ5PsOvOuq/c7A==
X-Received: by 2002:a02:b80b:: with SMTP id o11mr75607810jam.105.1578173135271;
        Sat, 04 Jan 2020 13:25:35 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o83sm22375376ild.13.2020.01.04.13.25.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:25:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:25:33 -0700
Date:   Sat, 4 Jan 2020 14:25:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime@cerno.tech, jsarha@ti.com, tomi.valkeinen@ti.com,
        praneeth@ti.com, mparab@cadence.com, sjakhade@cadence.com,
        yamonkar@cadence.com
Subject: Re: [PATCH v2 13/14] dt-bindings: phy: phy-cadence-torrent: Add
 platform dependent compatible string
Message-ID: <20200104212532.GA11969@bogus>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
 <1577114139-14984-14-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577114139-14984-14-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 16:15:38 +0100, Yuti Amonkar wrote:
> Add a new compatible string used for TI SoCs using Torrent PHY.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
