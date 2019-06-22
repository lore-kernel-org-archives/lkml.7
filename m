Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8533C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9433D20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu6JU6JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFVQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:41:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:41:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so493108pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lJepOsaA8mamkEWBgZFhhdkuq2on+kd/GU1u/vUh49o=;
        b=mu6JU6JFyAZ+TREz1RN+V2t/T29Se0Wd3A1zzBwUuz58G1ldV8WJwhZfVlHdinhcaO
         UDBvQ1ffTp03sRnblV0fkphEGljhoxjU6FZ0FCHAjvDMpEVzgNX+w8fRNU40z9CCScP5
         Iew8fyLOpawIpuYh3MxDJ5Klk++x7BxbTSaTe0zKXtIu9vrPR8yhiU/dmnz5JPIvP3lH
         pou0yILYMCKlaa3ARWYNDTQXmp6zcEi4mR2jAftIG5KR9z0OgARdbBTR/hk8l1Zjd+Nj
         fWYCMRQoiLOSJn0ooyT4h/W+63z2xHsqjSfMvxQocd7QkDuCQJsssmvhVQkntK63iKFX
         qA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lJepOsaA8mamkEWBgZFhhdkuq2on+kd/GU1u/vUh49o=;
        b=bvvBQ+DDzIE4gk5qs68syKdn908w3oYBCRE0CHwn/RMAZvqxl5irM57xYDsuifxaQT
         PrWxFLjGtlMgJLU+Wv2+e7ar6kybX45lVED46nwGSRI6IN5LZZ8Yxu6z7j18Pow4cIGd
         taLWGHYJSuGkbXNNQwHg3/OG4P3YXSPKpTbZLcpusg/3UebTi/vtrNj9hu43H8gnn1LN
         3WkchJRrpQRrz2Obl5MG2fi8G1xzg/gfk7+Pi4Z9TAiPhmP0+0fhRHOKpVtjWfo2ER6Y
         An+6iuL8z2ABam8YP5u4GmJELhedC+dueFQ3Ct8hIE2ImEzMnjEzphp0o5UHWVImhEDY
         ilDw==
X-Gm-Message-State: APjAAAVSF219C9KIpWiQOsp7EYRRTdK5L0ODaHEzO3zhtBuNFcTL6+7n
        Qn3rjTecVlwybPN70xypSEs/qgbmvW4=
X-Google-Smtp-Source: APXvYqxY6WZ9J1wmcavq39bA3G5zySVTK0kZEz5Lo/CRKStdyZfu7ty3tpwEmnhUkzQWpy5LBlFE1g==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr14205717pjc.31.1561221667593;
        Sat, 22 Jun 2019 09:41:07 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u5sm5809161pgp.19.2019.06.22.09.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 09:41:06 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 0/3] Change function return type to void
Date:   Sat, 22 Jun 2019 09:40:39 -0700
Message-Id: <cover.1561220637.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset modifies function return types to void.
The return values of the function are never checked and 
they always return success.
This resolves coccicheck Unneeded variable warnings.

PATCH[1/3]: This patch changes return type of rtw_suspend_normal() to 
void

PATCH[2/3]: This patch changes return type of rtw_suspend_wow() to 
void 

PATCH[3/3]: This patch changes return type of rtw_init_default_value to 
void


Shobhit Kukreti (3):
  staging: rtl8723bs: os_dep: Change return type of function    
    rtw_suspend_normal() to void
  staging: rtl8723bs: os_dep: modified return type of function    
    rtw_suspend_wow() to void
  staging: rtl8723bs: os_dep: Change return type of    
    rtw_init_default_value() to void

 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 14 ++++----------
 2 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.7.4

