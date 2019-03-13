Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F499C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC12147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS+qQib9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCMOyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:54:24 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37206 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:54:23 -0400
Received: by mail-wr1-f47.google.com with SMTP id y15so2355091wro.4;
        Wed, 13 Mar 2019 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FGHlU6RQ5cUiMTkTZ+dDQRlmdCpLDztigm2epTXfLmo=;
        b=HS+qQib99j9EN+RbUbyq/1g6D54HvfHDe58WS16AUlkPTkjO+x0DK9+qkCHyrMX5oj
         bFDgKLuLHhflgT7TrAMZbVYoHGneERvkLtLARTMwtFh4I2X7tgDWnRURgip7/qhppCbx
         L6xtJSWOTyLOajaBzMmwBoQeIP63pn0pcAIhBNbIxg43aLzhWI5f6fkqw+bgh2dTtfEE
         tck+XA0vm3Yn8ndAvFiEGD3pFE5V90JMLyI52a/dhIH7oVRVLK5xlknzHSzhmOMr+DXe
         8lEVt++tCvTDg963fAel0o8aFEHYz2lX4sSp87Vf9oWFw3Mb/S8yg6P22+gPOoGdhPZv
         JRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FGHlU6RQ5cUiMTkTZ+dDQRlmdCpLDztigm2epTXfLmo=;
        b=uBj7XgtI9X/rDo6fU06ZljirN1iAckbm+JjN4D9sSpONFcwzKJWWPuld3Z8oAmi06m
         O9UbMVwUKVlRVsIDzc1+cp12H91rAYaIl0AOlnV0eh8YuflYqDzDKnsVunAb/oYOE6r1
         bALm7ipFOzZZy+hbAO60pTbPZ9POtP5ZYoIFxwLwPuGx22pf3vEtsUZEixG14WCfATWA
         7gZyjG7/mfh3qnyBdyHSnEq8l23FDzLIepPYBqOHJCEXskEt28z5qC6DpzpobpwJTsdA
         lAawxVkXD4gLhpHeUJS+DuJRLPNXjdiNNn/uIWjbwOfY4qVViNTP/0qwbXvCXkImpC04
         XMIg==
X-Gm-Message-State: APjAAAVsqHfpqjYuEtcf+pCvWBRHyxsHp4tqoo+n3GMGB9wDZ/GBIS0g
        JdfNK/gHC5fgWkJtkdcku9c=
X-Google-Smtp-Source: APXvYqyvkalLJao+ZRLHuCxYnO2OjxcJxvgxxfKe3vLwQyofP3ej79glGmtdcHgVREUqUCXbEGqZgQ==
X-Received: by 2002:a5d:6b4c:: with SMTP id x12mr6272759wrw.14.1552488861412;
        Wed, 13 Mar 2019 07:54:21 -0700 (PDT)
Received: from K55DR ([86.57.255.94])
        by smtp.gmail.com with ESMTPSA id a14sm14990377wrx.96.2019.03.13.07.54.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 07:54:20 -0700 (PDT)
Date:   Wed, 13 Mar 2019 17:54:18 +0300
From:   Alexander Pateenok <pateenoc@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Indirect call in vesafb driver
Message-ID: <20190313145418.bwta37cogo7a4qtt@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There're several indirect calls in inline assembly in vesafb driver
(drivers/video/fbdev/vesafb.c), and these calls cannot be automatically
changed to retpolines. It's in vesafb_pan_display():

   73        __asm__ __volatile__(
   74                "call *(%%edi)"

and in vesa_setpalette():

  113        __asm__ __volatile__(
  114         "call *(%%esi)"

Is there need to use CALL_NOSPEC ?

Thanks, Alex
