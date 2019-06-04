Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEE924F01
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj5l5UJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFDEWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:22:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40340 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDEWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:22:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so11860047pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SARezuCw43sPvGe7uU5ZrmfuswZgjGHhT8y7gFFhpmQ=;
        b=cj5l5UJWpiTtZKb3Qo/LaKrCTeNmYK2m38KBP/oZiPozaeh/ybWrdxgy9WLEdYHK6g
         fl/zuZiyvXRH20PUmMBvn9OI0zN7zn4LybNUICkiZCbkT02Q1sg7babChqgSPaGnHUYV
         Ng6lQLQT0ezO1SU0CJ6V3gVKOfW8/+usohbwCH2p1kY4472zp+cGnfPuyVGAYYVUWnb6
         caWMZu4pX4ePHjgNwtUidvOfuoiPttaZjUrpJ/9WTm+ZzZoBIh7nMqg7i9BpJeyWigLy
         JCEbZH92FNdXHPfoaDUhdLEiJekDKeO0XJPw+Lif96EqUcQRr+eKkPMKaSstLXaN2oUX
         esjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SARezuCw43sPvGe7uU5ZrmfuswZgjGHhT8y7gFFhpmQ=;
        b=l/iszVbYIgWsE9QKuepP9IxUFyq1akXVGTxNbqku/xEnNVWOAIKrhA1AR37e0jHnGt
         QPHmZDu4Rr9R5ZkNNzb5uyAX8+yXJcYnTO77xpxQdg7A/w0d0H8ILA+EXNdxDoFSRiGI
         6LYEDQaxBB9fw0i4Pa7uzXu9yQnucAF35Of4JktIcWtMZvhkl3ZYSgAJYuvphmDOawwY
         RhlYeQ9xkQ78cZDb3xwKF6i3N7Hcx2QF7MoOCJtIIbVxX4QP9PREnbje2nAGQU/hxE+e
         kpN2LZrIUl7SXc6wCSHCjmZ/BWmnYGtTRdmshDeSanu7yY5cjd0mtWoUNabybCMiMc+U
         zyww==
X-Gm-Message-State: APjAAAWyPfz2lPeHtbDeHTLujEEE+V3cHB4JfUgMk4SLDp2N4S7ofsBp
        DcvoY773ENfx1s8ro/iALrQgAJvk
X-Google-Smtp-Source: APXvYqxjuozW03fMUG4p66VnMwXkuika9fTn7Xf9rJ2ncK0c+AcA+0iKPywzcgitCkF9ovoMwc3fXQ==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr34973904pfh.14.1559622124537;
        Mon, 03 Jun 2019 21:22:04 -0700 (PDT)
Received: from localhost.localdomain ([117.192.17.118])
        by smtp.googlemail.com with ESMTPSA id q3sm14382390pgv.21.2019.06.03.21.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:22:04 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     joe@perches.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com
Subject: [PATCH v3 0/4] staging: rtl8712: cleanup struct _adapter 
Date:   Tue,  4 Jun 2019 09:51:32 +0530
Message-Id: <cover.1559615579.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
tried to remove some unused variables and redundant lines of code
associated with those variables. I have also fixed some CamelCase
reported by checkpatch.pl  

There are some other code like spinning on a random variable which I
am investigating and will clean up in a different patch set.


Deepak Mishra (4):
  staging: rtl8712: Fixed CamelCase for EepromAddressSize and removed
    unused variable
  staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
  staging: rtl8712: removed unused variables from struct _adapter
  staging: rtl8712: Fixed CamelCase wkFilterRxFF0 and lockRxFF0Filter

 drivers/staging/rtl8712/drv_types.h        | 11 +++--------
 drivers/staging/rtl8712/os_intfs.c         |  6 +++---
 drivers/staging/rtl8712/rtl871x_eeprom.c   |  6 +++---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c |  5 -----
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  |  1 -
 drivers/staging/rtl8712/rtl871x_xmit.c     |  2 +-
 drivers/staging/rtl8712/usb_intf.c         |  4 ++--
 drivers/staging/rtl8712/xmit_linux.c       |  6 +++---
 8 files changed, 15 insertions(+), 26 deletions(-)

-- 
2.19.1

