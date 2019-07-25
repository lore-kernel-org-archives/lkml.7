Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE213C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E23B21850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvdIQeU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGYTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:18:31 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38553 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfGYTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:18:30 -0400
Received: by mail-pg1-f180.google.com with SMTP id f5so14687676pgu.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aDAwL5Cdh2i3pmbUFIvBo+BF+mpIwQmrHQFud17yoiU=;
        b=KvdIQeU2WyS6Rj3t/8oofxoNMqb33x+F//0Oquki/4v1RGRk66CPLW2JcPQSNb3LoB
         j39AP945iuSEjh/0KnJc7ItgLIB4NYrQQkf+mm9V9hoGN0RJI0vQeKWGg+lsxmN810TR
         X/KUiY77g1CY+6JhePmWhdmXMEdRoHCz8yciY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aDAwL5Cdh2i3pmbUFIvBo+BF+mpIwQmrHQFud17yoiU=;
        b=owO9O9+T+QGZJNoYkX8hTqppVJihK2+TDkdH24jPjEPWmKi3RlbjCxAHcCnova312K
         dC5BpULOJpRYDwotQgFiLNq8umktJ9xIFRHg/TPo0QSmPdd669PUI9jbbn8ik1ytJeA1
         Q7hf+RgJIq+3FGx4h0fLyaj1bNhedM0COzxgnNefISzEYLB/Jtfq0gOCeCSQBsutyJje
         nMvr+JmPMC42yYGir4iuT+aICUuFg49zLLE3Npm3/x3fNHMg6nVoNBvWiQea4rbRS8Eh
         jdJ27oROiUeoVZ5uP6GIRL35FFhBXSOhF+m1IC4aijobKo8ihO1g48WTCk63ljKczmQX
         uJUA==
X-Gm-Message-State: APjAAAW32UxZVwum+9IcuHk2n+aBucL3TG2dlBJXTfpTW66o35ZrEPEE
        epgd1c7BCjWd/nPpSWL0YYCOtg==
X-Google-Smtp-Source: APXvYqyCcBWmg6tvDPsrLgmH0sYeAY28oba+EPqncQmOdGW/32zXvf1WUPg3MaIyYU4E6Pss9CvKVw==
X-Received: by 2002:a63:30c6:: with SMTP id w189mr84852127pgw.398.1564082309986;
        Thu, 25 Jul 2019 12:18:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a5sm43642552pjv.21.2019.07.25.12.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:18:28 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:18:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [RFC] dt-bindings: net: phy: Add subnode for LED configuration
Message-ID: <20190725191825.GF250418@google.com>
References: <20190722223741.113347-1-mka@chromium.org>
 <20190724180430.GB28488@lunn.ch>
 <20190725175258.GE250418@google.com>
 <20190725183441.GL21952@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725183441.GL21952@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 08:34:41PM +0200, Andrew Lunn wrote:
> > As of now I don't plan to expose the label to userspace by the PHY
> > driver/framework itself.
> 
> Great.
> 
> With that change, i think this proposed binding is O.K.

Great, thanks for your feedback!

I'll probably post a new version with actual code next week, unless
there is more discussion before I get to it.
