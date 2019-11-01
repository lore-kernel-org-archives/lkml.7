Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55446CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B27B217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="2S1M79vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfKASPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:15:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKASPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:15:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1so10460805wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DaF/fN8ohwgwUWkK8En+70QBPGXgnEWmIV9bvJcYsGw=;
        b=2S1M79vFdbXz9S+tocHSJzFBdka0QHGa+4GkHJg//hWg706Vo5rD9oenQfOtaSmAUr
         Nk+Xd4+m+4czttRqQqXSum8FZZ65QDDeTkUjrFOxlHkLQTzGj+cUrk1h1XuuvMmLFRcc
         lEXLOwGtliJMr9WIAPTkQcoyZ81IW7MhYB0BuJkeOLkw4/BkQfLckT0irJmjcQsomzLU
         +GPO09k2Ymz5woSHeDQczPGhUFi9SEGe9bJ28Tf2qL+m6bC+0xAoBsx312A5mTCrVzIy
         2AWuzg55SbyWLaQYh1BblY4f5/tV6fADaOazrHHe9CLV7L+buzkjGGWoCphBpoUFkJG/
         H3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DaF/fN8ohwgwUWkK8En+70QBPGXgnEWmIV9bvJcYsGw=;
        b=rNShbMai0iyr7ePAnu4MswmxmBs9wJyRpxQV53tuBmMuXaQ46VHUvQ326MtImppw0j
         kAuaq7dP4hk9yOX3eXrs43SIIKXvbY55uYXbEZ5MJEVGQ0OZu55bmh7wrzTrPEgd9Q2y
         2CqGHrngVsuYyOKHOUxAvTbIw/jpbUcaQstj6ctcoohVOQRQ8fL5J7VfEpKwyCHmLV0w
         keqvrXVn+ecaiDrh4dM9deRV+ec2+z/sb5LnlS/Wegk3wyFN6j6ZHZTsQoiYof8CmfA7
         syh1T4NcotDj/nGG5j/L5bWIU83GFZeqWwzRKBXns84elzEwDl6bL7DYZzVCyK/bS7xO
         5MHQ==
X-Gm-Message-State: APjAAAUHzb5YuFU6DHq/X31JBXMJcSkVISgbocxFUt6gBrZA5jyz0uWy
        LksCnGboonzUEA1Luv5VlfsFIg==
X-Google-Smtp-Source: APXvYqynjkno+tQJc/BZhuPrx+2HgsQ9d+fnoevBPdLgerZmbfcvhXVkLbrgtMikjKc41AEYKJVkQg==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr7333981wrp.354.1572632122919;
        Fri, 01 Nov 2019 11:15:22 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id v6sm2006297wrt.13.2019.11.01.11.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 11:15:22 -0700 (PDT)
Date:   Fri, 1 Nov 2019 19:15:21 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: davinci-mdio: convert bindings to
 json-schema
Message-ID: <20191101181520.GC5859@netronome.com>
References: <20191101164502.19089-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101164502.19089-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 06:45:02PM +0200, Grygorii Strashko wrote:
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the TI SoC Davinci/OMAP/Keystone2 MDIO Controllerr over to a
> YAML schemas.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>
