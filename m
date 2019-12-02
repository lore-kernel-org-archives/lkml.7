Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C30C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAFB215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7060+pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLBLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:55:13 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45645 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfLBLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:55:13 -0500
Received: by mail-pf1-f172.google.com with SMTP id 2so183253pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+JlNxZ7OyFpjeQdtLba6JDOrrg1sd3sb+Hultp3gwqE=;
        b=u7060+pHPw+GYyU5wpIFuxR6Hz0lW8bdJCJ6NHMS842+ljhabIBvIcqtux1ayXZ2eZ
         soUSJdKzKXMZFBLfpAcEUzXL1E+drcl49ygA2p/kyqzqLmR/DmYb6lH9XF0JMt+ErTuK
         Ev70V158Ku+LOkYWA8yBZ4rp0qQAL2+S0V4lDGhtJLjAg1M7vSW5wKx/E0lycWGeo9rA
         yF4KU23SxMKn+lD0nRcAkSUC/fcMO0tKblb/6e4EjZkdIbDOEmi37WB3++Q04PLUl8dw
         nNSzIC4SdPYnkHLpquO7L7NtdFCQHlwrxrx/hm5l1psMN2Wo72UvvAMJZWYQReBct90X
         y6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+JlNxZ7OyFpjeQdtLba6JDOrrg1sd3sb+Hultp3gwqE=;
        b=NBTGYRcNnE1Onr5qCjk15ebWgzHRLbXwNiccg4gIyFcj5ajkGb/21E10Bc0OdFjpRO
         ug6QFs/88A73d7OWTdO5F+Kj9eNX0Pf5gDFu8Ot5/RMFfNp3GXwYyvm07KlNJTNF/5XY
         BuzGaUyAyb4k2PaVOF6OY8brCdfR95C45ZFYDBnluoA1PcK330uu8h/BSC/T2zkEp+/B
         yp8ElA4t/wgLHt0AVHDtcErjWKYk3brQtWyNhrLF4R0JkJlQrP4cNOR/T5v0qEaPJTCQ
         0s0oM+NSHrUZdnDyYNEWrue76DEcyKEz/jAqsOox17xsMAvxq19JMhOOCjZZJvMqNGvL
         OWjg==
X-Gm-Message-State: APjAAAVKCz5GMRMlQPRzop2L8lo8kyrR5FFiw2IPpqe4FJJhsP/558zy
        Z/doc7ycgDMhNbRiFQ5WEb9CmA8S
X-Google-Smtp-Source: APXvYqzm8WdJ+jLiaMDKWtpCB/2lpXzkb0xWxhLf4IFgsv7uBj/rXnsKIgsj0RxIetWZTSOAvbMDAg==
X-Received: by 2002:a63:5b59:: with SMTP id l25mr14997655pgm.382.1575287712549;
        Mon, 02 Dec 2019 03:55:12 -0800 (PST)
Received: from localhost (g143.222-224-150.ppp.wakwak.ne.jp. [222.224.150.143])
        by smtp.gmail.com with ESMTPSA id w6sm33899107pge.92.2019.12.02.03.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 03:55:12 -0800 (PST)
Date:   Mon, 2 Dec 2019 20:55:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for v5.5
Message-ID: <20191202115510.GO24874@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pulling.

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 0ecdcaa6d5e78649578ff32c37556a4140b64edf:

  openrisc: Fix Kconfig indentation (2019-11-23 06:49:21 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.5

One thing for 5.5:
 - White space fixups in Kconfig files from Krzysztof Kozlowski

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      openrisc: Fix Kconfig indentation

 arch/openrisc/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)
