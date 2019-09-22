Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130FC4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E399E20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 01:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zUYdMzna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfIVB3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 21:29:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41977 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfIVB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 21:29:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so6890728pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DMn51Td2POv7lnNtwrlqLDrrj+YMQmgwExP4qEnhkL0=;
        b=zUYdMzna+R2zI2XOIyeaGmiAQEOgz44LaSfLXx6lFbqfgrl593w7NRGN5Tx79Sg0nC
         rqmOSjzYTVpE7gpQKTwJ6aNM8domemfqPq2SsPiNeVcRgZ5jzvLoqJOKZYwRWRruT76g
         NtXXOAGrYH9fCamvfsFyq3Q18r9dMsP4crRMUJNiQwgoSwKACp9OTwyUsTVPpZ6WX+Ju
         oPgrT7UqF3RXupTacwi0wxzsbahoD2mcZwCdwrqbQ+xBkvAbSWAUT0KUXCAgaw8vUeTd
         kTrK6OhtnVYOhjOLHr8TcNb27iuNK4yNosm20xNdu8UIUWi3iI7C0KDduGjz+afJZEJq
         HPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DMn51Td2POv7lnNtwrlqLDrrj+YMQmgwExP4qEnhkL0=;
        b=anTLcdD+fZ9pZmQGLFwr7iFYbIolddaM1QhfXRNSDBPKdL7hy6l9CAerZDANPsb0hE
         nyAdlPgR04/I4ub6Pn1fZJwaTV/XUmLaOkKh5OQq+20Rbky+N9gWBTCC6C6yrbUY30En
         E32yFjyVu1dhefw3GNAlpxgQMPAXRY1itI1wzQ8LDr+XZvzj+0ZXbahEs+SEL6mLRwLI
         2qZWQ7PT9ACx6UPSyAcLezpg5Mvx5Ptn1PbqyTAGsI8aBvPXIPYcX5KYJiYH6JlsGu0M
         wTxRVi974KkhHJljEnuDxFY/V7EgH9A5boqbP76oigs2l+BesB12Ix7EI9N3+VfQdfEu
         9vJA==
X-Gm-Message-State: APjAAAX2UqWge4m8Nlnk2qSX0prlwn8Pdg+B7E2qOZSYYy8x8Q4BgZ9K
        Dc8Ul/lofMew06r9tB92ZIn7Ag==
X-Google-Smtp-Source: APXvYqzz/GhdU9GscNtk7wgkNvw74Uykne3188YvZa4yf9TZxZP7AruZajWUrGbVd5Ja2vbApg/Abw==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr15330509pfh.81.1569115764088;
        Sat, 21 Sep 2019 18:29:24 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id d69sm5638100pfd.175.2019.09.21.18.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 18:29:23 -0700 (PDT)
Date:   Sat, 21 Sep 2019 18:29:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Peter Mamonov <pmamonov@gmail.com>, andrew@lunn.ch
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net/phy: fix DP83865 10 Mbps HDX loopback
 disable function
Message-ID: <20190921182920.172ea69d@cakuba.netronome.com>
In-Reply-To: <20190918162755.24024-1-pmamonov@gmail.com>
References: <20190918162755.24024-1-pmamonov@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 19:27:55 +0300, Peter Mamonov wrote:
> According to the DP83865 datasheet "the 10 Mbps HDX loopback can be
> disabled in the expanded memory register 0x1C0.1". The driver erroneously
> used bit 0 instead of bit 1.
> 
> Fixes: 4621bf129856 ("phy: Add file missed in previous commit.")
> Signed-off-by: Peter Mamonov <pmamonov@gmail.com>

Applied, queued, thank you!
