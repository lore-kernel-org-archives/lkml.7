Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ED0C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E712084E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/D+kKMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFVPXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:23:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:23:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so5055416pfy.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=64rfDwm6z7J4Eoudftbx7Yfz/GS48slNahoFEbbSYSE=;
        b=Z/D+kKMAPiM4pEcdUvCNl5F7O3CiZW2+XmJ2as8DlefeTMFa0yFNJhqUTQn/PtIevr
         2ZZ7i7nZIc9OIdLxISeALY4bNAiRDPxlVusMksKmeIZGaomsmGDBurrc0x6gpktsiOQD
         O8GBmFIZXbtpABoX0q0gpe5bQ8rcJz5oUlcHijBKF8Hd1gcSXizUQbTIOz/2J/EuP2yi
         tQ1FtX4sDXevE8ByGVS5grPjTmEZ+R15l4XmoHe81bXSiOu0/PqqU4H5/uFo+P9oh8t7
         e82YskjeLArnAAc9Iu+Lwek2fyCh4BJKtTiZAKaEDao6JwyDoPu907wLn+r7vu06FYs+
         kHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=64rfDwm6z7J4Eoudftbx7Yfz/GS48slNahoFEbbSYSE=;
        b=eX/lpbFHQLYKPUJUzZ7dqIQP0NzDeUw3kavV1NR2vBBRqFVBsmfDSEwpiaWXiy5A5T
         aiQ8XrcgNhKxf+QERRQbqmTiM/7FLx14boPcTe8hHjDKk/2uCyufS0xA4o73mRjnCAcM
         Zit0EkYsbiRmPH5efeLjrydKtUfBxRaKqzeQ2Fn7OeGZsH7qOt2GPhBdEgSbUV4oTLH/
         AdzRbsVaiKVDuvbuHPLGd8NofIALGFv7N6yyxAjf1UEzMJayCbddGhX531UR2tHoIvnO
         3zdFiKchTj3ge5DWu2fCaoMWJd75Uvb1WUzulQ4h6w7t/3MsDgASlMFAuR6Klmlt+Dro
         9CGA==
X-Gm-Message-State: APjAAAWoFO6GhOop55xl4zEa/bAaMVhstbO0yL4tFtVC2vz0Cg+OAR4X
        3/hg6ngBIs5nOYzMIoWO/H0=
X-Google-Smtp-Source: APXvYqytvQnckoLSzsyVUDjnEMPO07TkPNcRcqkfFHTQs/ML7iouJlHa6Nwq3nmlLLp9664WpvLU4A==
X-Received: by 2002:a63:63c1:: with SMTP id x184mr17894625pgb.213.1561217021616;
        Sat, 22 Jun 2019 08:23:41 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id l44sm12496777pje.29.2019.06.22.08.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 08:23:40 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 0/2] Modify functions return type to void
Date:   Sat, 22 Jun 2019 08:23:06 -0700
Message-Id: <cover.1561215416.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies two function return types to void.
The return values of the function are never checked and they always return success.
This resolves coccicheck Unneeded variable warnings

PATCH[1/2] : This patch modifies return type of function loadparam() to void. 

PATCH[2/2] : This patch modifies return type of rtw_reset_drv_sw() to void.

Shobhit Kukreti (2):
  staging: rtl8723bs: os_dep: Modify return type of function
    loadparam(..)     to void
  staging: rtl8723bs: os_dep: Modify return type of function    
    rtw_reset_drv_sw() to void.

 drivers/staging/rtl8723bs/include/osdep_intf.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c    | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.7.4

