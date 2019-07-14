Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0ECC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A674320820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5z7oN8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfGNPpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:45:46 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:39454 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfGNPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:45:45 -0400
Received: by mail-qt1-f171.google.com with SMTP id l9so13210580qtu.6;
        Sun, 14 Jul 2019 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=E5z7oN8eXDsJazaisWgOSWc761LOcc1vVCseZvXLOYAnkh44h7hMeVg547CwpwFqtu
         kSuAAHJfEEyvvHBYdrHf8eIfG0Nc8eVpUXfK3UMiyFj0+nbVim8TqGKJmHk0U6Df5Twv
         v4KETET19Dw7i1hkghhdlBgKXT1/8y0QPAoGpD+5QmI326KuEx4uE2FTCCb6tQiWK5vM
         6lhsNq/IipQ5Ipf+x+KwKSx96zvF9xV6iTL4K+NhmL4Y6bNdnjxRETUQ3KIMOkL1dUpM
         7K4CYEqdb9aqVqP51d5P2K4HujIZphdMFb0o9WLnF2DctWeyJ9jJeRy/1448qO7tjOKc
         kuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=FtFaX7Mn+dmXbda2lWip6peZeIElnVfhVNif3K2ddnriugE9Xk32wNQRcKf/DxOWon
         kbNZnIHXlUVQo+hLwHt7Mw02+AlRer5vVrQGTFfhU8dVEJY9kCG108o29ZUU1GUpqbDo
         FIt+KFA9cTKqDMTUM1egdvYNM9nX36ZyX8+Tnq7+tMdIs86FQy4Q4NXKdr6/JXgtBG6h
         +xiionYP7VCHThjaOM07qLlydKs1NEgLdYeSEZdWTX6O/0PJ7A88QHSGKODHXeE3oLSK
         PBN4fKBrzxmW1YQWP7ohYAbdHthbHcpMjqWVO5jq2cM8Ck6hlMmRlQI9in5VlwwkJ0+4
         ZvAA==
X-Gm-Message-State: APjAAAWkD9oKJt2NRoGbFJIFIDsNcm7HbfBcoRsgLeZHxVMYFMG6vzKF
        exGYppKgboDZsW//px8COQ==
X-Google-Smtp-Source: APXvYqzVUPL7VLBkz9cKAYiAlrBnLY/LGPJtrGG6gLQQ7avpVDwEtWG0VddyEZSMzmAXO/NhhUV4+A==
X-Received: by 2002:ac8:1c4:: with SMTP id b4mr14249229qtg.42.1563119144780;
        Sun, 14 Jul 2019 08:45:44 -0700 (PDT)
Received: from keyur-pc (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id d123sm7127907qkb.94.2019.07.14.08.45.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 08:45:44 -0700 (PDT)
Date:   Sun, 14 Jul 2019 11:45:41 -0400
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>,
        Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] staging: most: remove redundant print statement when
 kfifo_alloc fails
Message-ID: <20190714154541.GA32464@keyur-pc>
References: <20190714150546.31836-1-iamkeyur96@gmail.com>
 <06fc2495-dda5-61d2-17e8-0c385e02da1e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fc2495-dda5-61d2-17e8-0c385e02da1e@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

