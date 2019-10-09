Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E2FECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6493A2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="elH8HvTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfJIEBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 00:01:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47016 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfJIEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 00:01:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id b8so501279pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 21:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=LQnEVRtaUqRdx8oq4nHL7TuP7CnswhfMj0UbudJCkNo=;
        b=elH8HvTNX73YFmnB2dy01hY2j2bmSz5xAhWehg02ST0i0DmEY52fPhAOVzsGHakA94
         b1FhyrN440t4SYfzDRf1FG24HhmGXBFl43fxRtB+oh8NYyP/nQrvm2NzmBpRAVEtUXbP
         hmA4ib31/2K8MCcdlZ4iFILk23DO1jyJcz4XziEq2lmyjwBV8vD9KUcTmS7wybgRvaH2
         8kWYM+qq3hpsqV7w9qfRn1k9FrsghbSwcRLJCprjs+OKRJpIZfVeZMOccRsiFPgJoKjH
         GxeXKz0p006gobdoqKwWIdrMGyv6UdONE4Jt7PTkd9l8UYiEXroANR8cl/2PpcUr6QZM
         h7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LQnEVRtaUqRdx8oq4nHL7TuP7CnswhfMj0UbudJCkNo=;
        b=CjN2B7e1kiYidDCFPUI4G7y0PKLl0DE+2/CpRtapVx5ogqehig2iao2UXwkIP0Yl7c
         yq+JOsPmMR722goEcop2mks7LqotjBduVHV5u0BAaG9QYbDVao2zh/+LhTJS3CRtkLpg
         G2OXqx8M3j0q1zhyDbPeSJvGPb8YtGFttxcvmfIHogrgh8jN7RrReAudIO4JimnGAZry
         OHNVlV9HolEEZ8CfmuUxLldXehVn66OfHa8/Y6CdDUFXH+dKlauKFFo4K6M6AJizsFU8
         IcQzsVkTxLC0Boid5uDQmi+are9gn+mEMsJinnsB6Uwnx2a/Sw3Usq7aZwwWClGrGMin
         lrSQ==
X-Gm-Message-State: APjAAAU7E31djt5I8h9fphxkQSfc6poJ2xNhcsfqxTn08I1DvKm8zXCw
        Apa5saTG54hKwXAIkifiLxhG5Q==
X-Google-Smtp-Source: APXvYqwuZLt3V1q9u6j2hKZR6SsGo068c0h+BS63ge6a8qYenR1qWOrmO6OPDIlDK5m5u0HufiABbQ==
X-Received: by 2002:a17:90a:ff0f:: with SMTP id ce15mr1710745pjb.14.1570593703973;
        Tue, 08 Oct 2019 21:01:43 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id w2sm611444pfn.57.2019.10.08.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 21:01:43 -0700 (PDT)
Date:   Tue, 8 Oct 2019 21:01:30 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, roy.pledge@nxp.com,
        laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] DPAA fixes
Message-ID: <20191008210130.23f8a123@cakuba.netronome.com>
In-Reply-To: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
References: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Oct 2019 15:10:21 +0300, Madalin Bucur wrote:
> Here's a series of fixes and changes for the DPAA 1.x drivers.
> Fixing some boot time dependency issues, removing some dead code,
> changing the buffers used for reception, fixing the DMA devices,
> some cleanups.

Hi Madalin!

The title of this series says "DPAA fixes", are these bug fixes?
If so they should target the net tree ([PATCH net]) and contain
appropriate Fixes tags.

Cleanups should go into the net-next tree ([PATCH net-next]).

Please try to not post more than 15 patches in one series, it clogs 
up the review flow.

For some of those and other best practices please see:

https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

:)

IMHO there is also no need at all to CC linux-kernel on networking patches..
