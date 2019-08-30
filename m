Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF192C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19FA2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="ycplImAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3HVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:21:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfH3HVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:21:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so5813330wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twCa64puDiziZK2hsD3AlCru3/vAz8rT+ytz7CCTc+Q=;
        b=ycplImANxSDgLuL4+kM16TKUU18e0wPvvbykU2ZxDAVTh+05eOYSVEqCOzsq38A58g
         JCePWp44lRAbdGu01bLeu0gG7/gNClDgyp4x4fWDvNCSOKyUbkWpiV/bep4ByxIaTAdV
         wVlA3yjw193zSV/zOS6w001K5g3PJWIW5CTxey92/pTG1Dw3TOTBQWjsA2wFW47lsNgp
         7KofvcXQ7OnMQFFEPWlCMSDncDrvtGhPrdm90i3NotON2vSDPFy9qZD5F/2HYuZFFmJS
         FjkL62iVJ2gCXJAMhOjhbvRHAdAT+EfDa3ifGsD5lBILbyndxgKjJJaP7+AvkS+F98jo
         0nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twCa64puDiziZK2hsD3AlCru3/vAz8rT+ytz7CCTc+Q=;
        b=ZjoOuhCdSc+HhLmIvuM7Hs6HjwJKdE3fc5rCRUpcxu/Lmwbg5q4hcKfaCOxyptXJ0j
         +h+mVAE2vLQRZmbIYgdOUn0pXK5GJoV8q8TiD28ev1ceUUKPqRX7XXuuAP9gH8VoQX8u
         v3AX2tjGl2q41SZ6XQ++U3Ridlhb79UXdrOX5BNStb0vrRQSyt5Y7fw2dXcSl+3nv2Su
         7IwDmRYlqLC78T6cgqZyb33N5uDsfhAgPMMK+ELExSVepeI1IB2+QCMlixh3YZTebhCg
         +2Uat66eXmb4yqQvyDMtJlhCENe2J8gskoOlmmxxe1iRaBKIjBaCSUjUafIfu4G28beK
         MAGg==
X-Gm-Message-State: APjAAAX9TbYWglCJNcRnwpnig0NWrsIoFdNPGdhRLtIi4cv+D53ztFWb
        RqcRV/Ci4iRjhxmdMcM7FLzGug==
X-Google-Smtp-Source: APXvYqylUVjX12tmncuYbyqQ8NjY6+N8NDkaFh0aScWK4rhmRgO0ieavEjgBJ2VSZyFOnILgxJODjQ==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr16996265wma.16.1567149694154;
        Fri, 30 Aug 2019 00:21:34 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id u128sm1439715wmg.34.2019.08.30.00.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:21:33 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:21:33 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     idosch@idosch.org, andrew@lunn.ch, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190830072133.GP2312@nanopsycho>
References: <20190830053940.GL2312@nanopsycho>
 <20190829.230233.287975311556641534.davem@davemloft.net>
 <20190830063624.GN2312@nanopsycho>
 <20190830.001223.669650763835949848.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830.001223.669650763835949848.davem@davemloft.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 30, 2019 at 09:12:23AM CEST, davem@davemloft.net wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Fri, 30 Aug 2019 08:36:24 +0200
>
>> The promiscuity is a way to setup the rx filter. So promics == rx filter
>> off. For normal nics, where there is no hw fwd datapath,
>> this coincidentally means all received packets go to cpu.
>
>You cannot convince me that the HW datapath isn't a "rx filter" too, sorry.

If you look at it that way, then we have 2: rx_filter and hw_rx_filter.
The point is, those 2 are not one item, that is the point I'm trying to
make :/
