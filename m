Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F304FC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF03A21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WSx2lsXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfGEVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:49:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43179 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfGEVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:49:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so9399457qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=h/A4tEl2mtBha7cHiuEYdkY3q6oP12EZ6C0/Om+AD10=;
        b=WSx2lsXJMKNctZUo8/bf87Uvk5Fi7zcXw+qV0e6Q8AQjzRrwOAT528YRawwec7hge7
         mVfSRjx3YMBkeTx24cG51ppvVAONcixhZgueA7zPAJYNLo1l8mtOvZT00ESxovvB9rfU
         a5I50JSemGPaPw5hbCg61YbXa83GNjX8pWkpr8S6bySjaysb++e8WyOfrbAn/43XZwvg
         DRUgbYcSEXRlJWM7/cQiIh6d4/a2IQdwhOMBSi//5JKIPKQpuuTKf8ZAcXr/nvftPYPj
         OdKpHerRNb5SMMggJfG2ZVdyU8MUDdeZws0SbOF7JdZSnBEkJrLTMkbym1Y1uRtsSSgX
         nQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=h/A4tEl2mtBha7cHiuEYdkY3q6oP12EZ6C0/Om+AD10=;
        b=Jgo+9VgVYFVx32Y8rjfrBAOOF8A8zYL6MBa7l4sqx/dRhQ7YI2LrS974mq5xnTKQHy
         793LE430FK4Yr4NxEShF4IxG6DySnS5dG6e4y2no/5PU/nqR5wFSo+QONylrb3GBoEjm
         7JjZ2pmGUEzgo0BBBlgMVy+F/dEBt0IUCopXczQOb+RkhR32F6nAibe9OjB/yoqr1ICq
         mIe1fbAWTTtRDPTXG3nVMwWpUz+v4oMlNJtvdDTAjah71wEDJK0M5ugJyf0IzmdRhjB6
         iuqCTlWazizRwoiT2cI6iM6g0RON8567xIRjUNpAt99uYPuyXrEjPDg/N/DW5MnK6CGz
         89jg==
X-Gm-Message-State: APjAAAVmgsYdXsQlgnTmTl0KxqWARGRUfmz6j6Dd0SQRW10Fh5rAt6dO
        6BqHbxSEIs+NMHAir2xHUxjUgA==
X-Google-Smtp-Source: APXvYqwBlDfCbZo7ZTpdIz2bIqflSAvvdtH0vqRV0LSfiC8SoRw/HCmTSvtjef6ryWsNF3JJv6vNYw==
X-Received: by 2002:ac8:24b8:: with SMTP id s53mr4592196qts.276.1562363394280;
        Fri, 05 Jul 2019 14:49:54 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t29sm4699697qtt.42.2019.07.05.14.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 14:49:54 -0700 (PDT)
Date:   Fri, 5 Jul 2019 14:49:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 0/2] net: mvpp2: Add classification based on
 the ETHER flow
Message-ID: <20190705144949.1799b20a@cakuba.netronome.com>
In-Reply-To: <20190705120913.25013-1-maxime.chevallier@bootlin.com>
References: <20190705120913.25013-1-maxime.chevallier@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Jul 2019 14:09:11 +0200, Maxime Chevallier wrote:
> Hello everyone,
> 
> This series adds support for classification of the ETHER flow in the
> mvpp2 driver.
> 
> The first patch allows detecting when a user specifies a flow_type that
> isn't supported by the driver, while the second adds support for this
> flow_type by adding the mapping between the ETHER_FLOW enum value and
> the relevant classifier flow entries.

LGTM
