Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB94BC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FDC20663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rSuoQkCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfLOEdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:33:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44000 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfLOEdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:33:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id g4so1494112pjs.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 20:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=K51j8K8EN2XPuqttk34dMlLQCvUL9tG6S45o7V+5+MU=;
        b=rSuoQkCYH6bzYBVjPU8FbqRNmY0YmiIcGj83O2cSsmxSzv22e16yc20L3uKiVbr3nK
         B52slI9FmgYjesrnwzmnCMtqozUyb7F7j9eyORMMTiB+BIt1vHimX+L+2eQO5LekkMnr
         koQfyq+dRdKzG/meZ+yw6bU2vO/Q+snYpLPwKD7cfrKBm/ohGaT6sGqDul/3zJQ1mkRn
         4oaveKo+jwkQaRKBl9hp/LLa4TrEPwAShyzFk5wahuGDyB2x4I9JBjh/KcK1ugyMVQiz
         8xF3W/J05lu9lQEcUzSpF91II4YLNi3EDZIQ6f99Ngi7L6E9hWPZMoSkhJiftWXuFHY/
         X8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=K51j8K8EN2XPuqttk34dMlLQCvUL9tG6S45o7V+5+MU=;
        b=K5qBQG5M3kdf5ZPGplt+LumundxOPgnrhn6ELdHR0NvLEdEXFNiJzYN8Jqh8nCqPlG
         DPDDEh5cD5NNUcndMnWbKM3VDue4lIyGQndXvi2yAtgWQaeaHsVFfGlrQkKAG/SXN1D+
         ev9gNUbQ936AqRQ1W9HV/nQg0LeS7RNYrYtYw840xZQOl1M5CL0M3gH2KQ2l95Mib9Aj
         bhUyKsBYGLKc/mE/8C68Q9b630gL8vCNPcqrJGhqHdsa3zOjjxCoT0xzEjOAn3oGPrYv
         DZbsNrgSiswXW6UPxE1rtPRM0tWneQ+f6TxHakfCzbj7/uKHG9Z4Q0V2KC/EEdarV2uf
         Ulcg==
X-Gm-Message-State: APjAAAV0kK4SGZhqnDcamE2inZLm7Fu6Ib7mZIxKDJPnVfc+k9I9THQr
        dBoDA/lu5DwBBvlSg+RDLseEygNY3VI=
X-Google-Smtp-Source: APXvYqxDxnE+42cDuVy+5iQUU/Tx31SkRqB05+m6gIJ/7lrWfSSLYL1x8M/df2LadQS8e5Ghu7t/Lg==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr9254119plc.58.1576384420590;
        Sat, 14 Dec 2019 20:33:40 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id r20sm17218140pgu.89.2019.12.14.20.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 20:33:40 -0800 (PST)
Date:   Sat, 14 Dec 2019 20:33:37 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Milind Parab <mparab@cadence.com>
Cc:     <nicolas.nerre@microchip.com>, <andrew@lunn.ch>,
        <antoine.tenart@bootlin.com>, <f.fainelli@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <hkallweit1@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dkangude@cadence.com>,
        <a.fatoum@pengutronix.de>, <brad.mouring@ni.com>,
        <pthombar@cadence.com>
Subject: Re: [PATCH v2 1/3] net: macb: fix for fixed-link mode
Message-ID: <20191214203337.687ebd6b@cakuba.netronome.com>
In-Reply-To: <1576230061-11239-1-git-send-email-mparab@cadence.com>
References: <1576230007-11181-1-git-send-email-mparab@cadence.com>
        <1576230061-11239-1-git-send-email-mparab@cadence.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 09:41:01 +0000, Milind Parab wrote:
> This patch fix the issue with fixed link. With fixed-link
> device opening fails due to macb_phylink_connect not
> handling fixed-link mode, in which case no MAC-PHY connection
> is needed and phylink_connect return success (0), however
> in current driver attempt is made to search and connect to
> PHY even for fixed-link.
> 
> Signed-off-by: Milind Parab <mparab@cadence.com>

We'll wait to give a chance for Russell, Andrew and others to review,
but this patch looks like a fix and the other ones look like features.
You should post the fix separately so it's included in Linus'es tree
ASAP (mark the patch with [PATCH net]), and the rest of the patches can
wait for the next merge window (mark [PATCH net-next]). Fixes should
also have an appropriate Fixes tag pointing at the first commit where
the bug was present.
