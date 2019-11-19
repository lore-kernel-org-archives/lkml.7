Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B2C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BBB2245B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Vjz8znJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKSXMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:12:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45108 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:12:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so2652858lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=J6djBZAZ4NKmoE5rDlXQqbYC4TEITCNxIlH5HQol9VI=;
        b=Vjz8znJ6cb48JQjUqD6uTuZV0ePVCQHg2q8rjcLMUst/MwnYK5I8QKVAODVhtFGomV
         Nc2qf1AXDeKZGyVudF42PKOCi42xtrwsdb9l6Gt2B2JBAxUt8ZQZCbPB7XPRyBZ8XRos
         Cmu34UdrptldO+ncwB3Txz9DFyC4ZNmpBXK+iRmZ3V+R/wTj4aZ6NiRUgHwiepjkouFJ
         iE3cC7RZudMqPTkXB/GWq6Ba6+EAC2vMqxvluLSRQZ93TZt39k8kq4/P2oMS8lc5pFG/
         qylQEC6Vrz/MNPE/ic5RLYJldRFhSeDSkbb0wjV77HbUgUZwA7iUaVbV/1DgZRNMfje2
         ebyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=J6djBZAZ4NKmoE5rDlXQqbYC4TEITCNxIlH5HQol9VI=;
        b=VjBhD2h1cpnjltDs36A77153CSVolB5tBNYoiYsQ//YX29FE5lAh8ALhAdfVt4T/8r
         5V8ydpBVhBmsgLRBtygdfqHYeecF3H2NclHmC8HncN1UgWbtLdqjYK/NSVgdyiR7mCmC
         P8AeR3GOWYHgCbnF0a896PizprlsEuM/u2YoHrJWbckwHheNRyIKGZmyIR75uka/sp0z
         fhAuaabhOfrxszO2Pjs61tesk4IsZQAmsj0CAgcmZDSYqkITHMA2iXysctKhN7exXJ8S
         iFCI4Vj2zuF3fUCxUfR0bQZeaeG7uEr3L+dYMDCoQGL/MxTdfegkNd02NgVWzUE0E0cp
         D9Xg==
X-Gm-Message-State: APjAAAWXT3xrfptwKfE7+41Al6YqUoDKHECrX/mVXQdN0hPnDJnURK4s
        9k/mNNZ4oKIDHuEjgxbxp4CC3GaGgrs=
X-Google-Smtp-Source: APXvYqzEPJDu2v7/BPSwTZzTsuB/P5qIDv0tkxu6tWkp9wShP1RJG9l88xRd/STrMH9vn7E9/djg9Q==
X-Received: by 2002:ac2:53ba:: with SMTP id j26mr147420lfh.92.1574205160201;
        Tue, 19 Nov 2019 15:12:40 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p88sm11086298ljp.13.2019.11.19.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:12:39 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:12:21 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 net-next 07/13] net: ethernet: ti: introduce cpsw 
 switchdev based driver part 1 - dual-emac
Message-ID: <20191119151221.14ff2d28@cakuba.netronome.com>
In-Reply-To: <20191119221925.28426-8-grygorii.strashko@ti.com>
References: <20191119221925.28426-1-grygorii.strashko@ti.com>
        <20191119221925.28426-8-grygorii.strashko@ti.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 00:19:19 +0200, Grygorii Strashko wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Part 1:
>  Introduce basic CPSW dual_mac driver (cpsw_new.c) which is operating in
> dual-emac mode by default, thus working as 2 individual network interfaces.
> Main differences from legacy CPSW driver are:
> 
>  - optimized promiscuous mode: The P0_UNI_FLOOD (both ports) is enabled in
> addition to ALLMULTI (current port) instead of ALE_BYPASS. So, Ports in
> promiscuous mode will keep possibility of mcast and vlan filtering, which
> is provides significant benefits when ports are joined to the same bridge,
> but without enabling "switch" mode, or to different bridges.
>  - learning disabled on ports as it make not too much sense for
>    segregated ports - no forwarding in HW.
>  - enabled basic support for devlink.
> 
> 	devlink dev show
> 		platform/48484000.switch
> 
> 	devlink dev param show
> 	 platform/48484000.switch:
> 	name ale_bypass type driver-specific
> 	 values:
> 		cmode runtime value false
> 
>  - "ale_bypass" devlink driver parameter allows to enable
> ALE_CONTROL(4).BYPASS mode for debug purposes.
>  - updated DT bindings.

Could you please add documentation for the devlink parameter under
Documentation/networking/devlink-params-* ?
