Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20B32070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZfEnKerJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439247AbfJYLQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:16:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35956 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfJYLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:16:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so1894113wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aggsABIYRRLswIwxQlk1bc5yL6gnA80dLaHTc+5bzIY=;
        b=ZfEnKerJnYGRWOAiA9ZGyMPPaOei4svG9M9ngzt/VRWxfhX1aGYgh7sICeNUFn1fR7
         t7icu56KqU/9tCId7Kbi7XkVfxv6YB4BLQPMyse3pLgbKdOBq2RnyADMVQmd7OK9ZdfE
         snsj1mRqO6GJrZCrrYszrJDK3DbAA75l/ppva5wwEcTvIw7vEnNc/cev+coPLU2L0ekv
         3wsk9Ftia043GAUvXZsDZix9D2JBQbktFGsKUG9Q4cii8tapwG9WaH+FCQQldf7eurht
         ucacZH6tfAmoBM06Wt/OCCtxtKp6bw0SPtuv54rM6jCPZXz5rxqyFhaMA2mYwITH16OH
         8b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aggsABIYRRLswIwxQlk1bc5yL6gnA80dLaHTc+5bzIY=;
        b=JbOUSY0OvUDlBVEGl1eJbfw6CU3wXAWZwja7yVOTvTAHvl9q7JscXr4oZlUSesPc3+
         5/PEuwZz0FZs+upc0ZRmfIX5qLI/zslrqgs6C/eHeQWXMfuoFW0S2pRHG5NuYTXKseds
         MACY46J88s3m2Cl7FuRxJeCpbB6wo16d2NFDKDbp42ttMzWJQEVq1gTOA/x8S4DiguVW
         3T830qjRbJ+tfk9nu7I+rebtn+U6WNsry0UDAU9s3PuEqYR62ZgCPVD1DTSu4gVnKVeJ
         j5vo8G696VHaA6mufTB5e2MqCTvZ0BoU60arOrC093WDgiwsDAx9qWT/tc66cBuFRwbB
         KZ1w==
X-Gm-Message-State: APjAAAXSw3e7KSFn6s6UesYFPPUaQLKwAdzlewcPSPgTh9Rz6xOjsXdj
        HBafCCyPG53XrE5CI6hQibT1Kw==
X-Google-Smtp-Source: APXvYqye0bMzabbhMdyIpkhP6DJpiYxdibp9PiqfCR0Gpk686vQs9d9QZOMBWqPETxqNqJFJXkTTxw==
X-Received: by 2002:a5d:544d:: with SMTP id w13mr2562396wrv.19.1572002189723;
        Fri, 25 Oct 2019 04:16:29 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id v20sm1571589wml.26.2019.10.25.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:16:29 -0700 (PDT)
Date:   Fri, 25 Oct 2019 13:16:27 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Pankaj Sharma <pankj.sharma@samsung.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net,
        eugen.hristev@microchip.com, ludovic.desroches@microchip.com,
        pankaj.dubey@samsung.com, rcsekar@samsung.com,
        jhofstee@victronenergy.com, Sriram Dash <sriram.dash@samsung.com>
Subject: Re: [PATCH v2] can: m_can: add support for handling arbitration error
Message-ID: <20191025111626.GA31153@netronome.com>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
 <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:43:36PM +0530, Pankaj Sharma wrote:
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> detect Protocol error in arbitration phase.
> 
> Transmit error statistics is currently not updated from the MCAN driver.
> Protocol error in arbitration phase is a TX error and the network
> statistics should be updated accordingly.
> 
> The member "tx_error" of "struct net_device_stats" should be incremented
> as arbitration is a transmit protocol error. Also "arbitration_lost" of
> "struct can_device_stats" should be incremented to report arbitration
> lost.
> 
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
> 
> changes in v2:
> - common m_can_ prefix for is_protocol_err function
> - handling stats even if the allocation of the skb fails
> - resolving build errors on net-next branch

No objections from my side.
