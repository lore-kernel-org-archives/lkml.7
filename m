Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D44020656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Ax5udvJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfJVAse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:48:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45080 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJVAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:48:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id b4so587175pfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 17:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9ZxBVNQ9Bd3ja+GyYsGolEdFXPVAh5PHrwO5UMmiKd0=;
        b=Ax5udvJ6yIw/qGB4F3BAhXGmaN8F2sVHDpUS8haKtrzzK5yJOgI3GtcC/lbYjuaosH
         /qGDiiiBpxurUX7vnWLZ78Ds48BgOiRgiBQqA2Uri0kx8wTnkQX/Sl6cjpl/i8AXWvJy
         5Do0YGaQUKogPeKHD3mlCqId25gBU7hNyBc+F3mNEGmIpisGA2NbXI41J1kKSSbdyvb5
         xaH/TITDFZlsfvj7pLG9UiE6Z+5POwJojnlxIH038ae/zfGvf/LSb3VFVyTkm8Wc0qo6
         MAc5F1AZrX1JYrjchag9BH+WIeyDUMzZmNHrCt0myZ3XMhGBRZw4/8WMGf1r0GPGCmTk
         5Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9ZxBVNQ9Bd3ja+GyYsGolEdFXPVAh5PHrwO5UMmiKd0=;
        b=bK3dR3EsBMp8dmOOGAtjQ+pc4R+WTVShzJ/tiMDjoYyp3052lZvDF/6uWaI+wZA4NY
         QYTORIcqGCv/KeowhFspQhp9Rn2Pz6OBtINXRtwY/DTIsH0u6GO6jIaLb7W9olFZR4Ur
         Zo9A5ehqjxFEtOj9x0q2QS+WBYAGv88CtRzPVckQsmvvzJ118UPg+1m9yKMhL8Ptrc8+
         +vxUtXw85IrLm4l79C+qZv1aPhtPZjABjkL+dxORFrvxlVWJV2UZRO2OQolgwWwz3KDT
         9isE33ihgoI1NG+4tmNssjgVopk5T/pjYPj7jftJiN35+t2ydWtshB8hjAlB53NYXLmI
         UX+g==
X-Gm-Message-State: APjAAAWxZXjHQJU5HQC4OERQM04+KC8X4lTa9YVNi8bUdeq06wGtEQWH
        /fJuENefhiW+TEC4QskYvEYnVg==
X-Google-Smtp-Source: APXvYqzUKvN4pMr7EjbyQ0XEf5BpiD4cqXqoEGm8lH9gaJyAV8dXnXgnL/6RoC0cgoVivE7zZZY17g==
X-Received: by 2002:a62:5fc3:: with SMTP id t186mr228439pfb.238.1571705313197;
        Mon, 21 Oct 2019 17:48:33 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id f17sm25360301pgd.8.2019.10.21.17.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 17:48:32 -0700 (PDT)
Date:   Mon, 21 Oct 2019 17:48:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>
Cc:     Shannon Nelson <snelson@pensando.io>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic_debug: provide dynamic_hex_dump stub
Message-ID: <20191021174829.065f9b66@cakuba.netronome.com>
In-Reply-To: <20190918195607.2080036-1-arnd@arndb.de>
References: <20190918195607.2080036-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 21:55:11 +0200, Arnd Bergmann wrote:
> The ionic driver started using dymamic_hex_dump(), but
> that is not always defined:
> 
> drivers/net/ethernet/pensando/ionic/ionic_main.c:229:2: error: implicit declaration of function 'dynamic_hex_dump' [-Werror,-Wimplicit-function-declaration]
> 
> Add a dummy implementation to use when CONFIG_DYNAMIC_DEBUG
> is disabled, printing nothing.
> 
> Fixes: 938962d55229 ("ionic: Add adminq action")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks like this still doesn't appear in any tree, after a month
(judging by linux-next).

Can we take this into the networking tree? Please scream at me if I'm
missing something or this would not be appropriate.
