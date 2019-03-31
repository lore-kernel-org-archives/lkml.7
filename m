Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D43C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E494C2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkWNWXLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfCaSuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:50:40 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46575 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:50:39 -0400
Received: by mail-lf1-f51.google.com with SMTP id r25so4644258lfn.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=S9Q6FFtCbcVYja7dlBlvd2illHdstNzgtUZvuBdLimA=;
        b=rkWNWXLn2dYjhdAXnh3SCriJpT+mWwkp4df6Gr4pX+jf0R36Bs9rHWMGi/Gd8H87Ax
         hPRr7GKqg141aA4UZR50bGkhi8khtuI1UmejAkZPfm5t25EHBjum5ZSWKu/NUzaJw6mT
         IlQgJwJlXSojRWtC4y6mhPPC/NNnXmJBXre5e3qkD9X41v7R+zbb70wZcqOKzAxeeGZa
         xm0LCe0CkXAt9MAih8Y3hjWctTY0nKaLOl4n78hCdE4iilivTVP/MKaL2uxYv1fc1dL+
         pJq1fmpaQ8d/RWCAhbVyssMsydcjTMLtJMROvlf/2VJqGAv09p+3TR0pgSl4wUnFKYFw
         5gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=S9Q6FFtCbcVYja7dlBlvd2illHdstNzgtUZvuBdLimA=;
        b=P8G+r6FyjeWtIQkxodpKoXy5k8ng3jrW+TpsB2TKvboKCXF5lLjPdMnfuvenCuNN9K
         7+trhHtA2Mg8K3DlLxh+jA9rOpOU+ZxDJiG3JT1YTxsG0niLe9gUN3x8Sdbhl1VWYYr9
         dpGf1sDr55PXG83q8YYnC2APF/jf8uBXuViYesSHle0xSkiJ2apsYLQXvRkpwgQCZ69L
         xm5qhA+vgzKZbo0kila2rBEjHqp474ZJzrm1touKWQDi7AXWO5zSf7vjuA4Z41S2OIf1
         VohWgw7IJIIV9AeY5cuOxGBF0GeDJzYA2VravUVhV40ngYCT10MQH9xzUGaa5oSAfYeX
         tLBA==
X-Gm-Message-State: APjAAAXsIPlFsKIpBiyp6WC+ww9xM+/Pz6HAKD5gpkkDnLLaU819phpq
        S3WyWJ/F+n98ySUzBKU4rbFC2Am0
X-Google-Smtp-Source: APXvYqxuXtrCTM5F9kJpaJAJrTkBW4BFikaTmr+j5XR1pAkfKlKIPYsI9I5gePIVi1tuyTx2fVSCyw==
X-Received: by 2002:ac2:4424:: with SMTP id w4mr30219558lfl.148.1554058237773;
        Sun, 31 Mar 2019 11:50:37 -0700 (PDT)
Received: from PF16W6Y2 ([94.25.169.111])
        by smtp.gmail.com with ESMTPSA id e18sm1617579ljb.12.2019.03.31.11.50.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 11:50:36 -0700 (PDT)
Message-ID: <f5fa2112758b4ac95aae12e7b1ab4d4d5a898b49.camel@gmail.com>
Subject: 24 channels for RME UFX II in CC mode
From:   Anton Gubar'kov <anton.gubarkov@gmail.com>
To:     linux-kernel@vger.kernel.org
Date:   Sun, 31 Mar 2019 21:50:33 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm not sure if this is the right place to ask... 

USB audio driver works with RME Fireface UFX II (2a39:3fd1) and
delivers 22 channels in and out. The RME official doc 
http://www.rme-audio.de/download/fface_ufx2_e.pdf states on p. 94 that
the device can do 24 channels in and out in USB CC mode.  Is it
feasible to support 24 channels for this device in linux? 
 
The rationale behind this plead - I need to get SPDIF signal out. I can
configure only 1 ADAT port to be SPDIF - ADAT2. It is mapped to
channels 23 and 24 in both in and out.



Thanks,
Anton Gubarkov.

PS: I'm not subscribed to the list and would appreciate being cc:'ed to
in all replies.

