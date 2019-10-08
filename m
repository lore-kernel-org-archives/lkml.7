Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F37C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F95421871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Ahx2xM/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfJHTNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:13:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35937 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfJHTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:13:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so17892272qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=t6oyuMaPUmyNVT7v4DLW2+8p5dzVhG7Z1YsODEnTYJc=;
        b=Ahx2xM/Ka2OvT+Z8TrK2ZtgnFwLp3ML09vr39yCsPXewB9cSBKn8r2C75aPi6CSdgT
         hID2DzhcFNBPTAB1iBCdlYNlRTHMI8M7wA5syNbttRyBzqSNFtGU45Ts1Ugcs39sEsPF
         xjUjS1QCBvajmZQ7S1vTHTHW8vhCM7R8i33/13MD3D5yXy/kfTyMfNVmq88CPZf9qvz/
         x59LYN8gSkqOgtNPRZNlL8w4woGhJufgQvv3icIe5rxzORHPXHtFAPLAiIBMCNnQu4bc
         zzunS0e+Wf5JkmeVa33HDlgw6/QORMS3ARhuwbWgytoODOGAw3z0IIeAynZuGiHWddPB
         EO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=t6oyuMaPUmyNVT7v4DLW2+8p5dzVhG7Z1YsODEnTYJc=;
        b=ivFDedhFFv8EzCH+H4zwRiOd5ntWhu2gqo9U61QKHC3MyC0ULy3Lf6WEDSuy0rDZOB
         suCRIcU6NF5Egd0e/jkP2PlU86hi0ByPmB9B7pI7ISinNOhWdsRAVGq2uf4xs0ZRvSlD
         3W/IB7OhQy1IzlW6evlpAiprEEexFo0uEp6kt4kIP9ZmI9rRKp8smvfstDJ1xLUUmMGR
         lV8s4cMIKOOvuS+kh/BUtxlIzauACGW/pAgYcyKyjbyUVnfkrvcUcJlT0MfbF5fshKyZ
         Fep4MTHiL6dso3p9cWh/hzYk7AR7IncY9ylvLjs7PHPxTlw9nUfawad/lBAzQHCfOUG+
         hdVA==
X-Gm-Message-State: APjAAAWdojIKeanwIs5MBeBg/6HSvu3C75556GRaLYauK3Qv6Cu30KFz
        lqqLI5bb4A1bVznQMlR94CraqIBN/bU=
X-Google-Smtp-Source: APXvYqwIi/hxcdCKBT8nhkcuPpLBibqtX5z6zBX66YeevnNRqdhFxGxwgLWC6u6R7O5Jdy0QVwaWtQ==
X-Received: by 2002:ae9:d803:: with SMTP id u3mr29765098qkf.131.1570562011888;
        Tue, 08 Oct 2019 12:13:31 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m14sm8803325qki.27.2019.10.08.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:13:31 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:13:20 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: mscc: make arrays static, makes object
 smaller
Message-ID: <20191008121320.59959133@cakuba.netronome.com>
In-Reply-To: <20191007120308.2392-1-colin.king@canonical.com>
References: <20191007120308.2392-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Oct 2019 13:03:08 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate const arrays on the stack but instead make them
> static. Makes the object code smaller by 1058 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   29879	   6144	      0	  36023	   8cb7	drivers/net/phy/mscc.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   28437	   6528	      0	  34965	   8895	drivers/net/phy/mscc.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks.
