Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB9C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB342147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM+69fUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfGVH0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:26:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41039 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGVH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:26:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so35009955wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rAskiiV+ri3R+6jTvo9qmXw+6D2IsSlG063mjglSm6c=;
        b=UM+69fUzu4mQL2DoaNInooH1u6TKgukxwWNNSoYIzadZMVZArrL09zFbPmKsGLgXPJ
         KOf9R4l5RYO0INWCIuCzXwE17vUagWAfXfXYZx5IasVCgBnTtCPrSCB1nID4W0XyfBeT
         gplJQyWfFY53NqJwr+1QcEITQaHcOTv6VytdLf1pg4ClfYS86wSG7N1C91GLX1mWS4K2
         eNBPGI6PWC6V+3as4NOaycmXqT93MgDSNg7RoR6D2TU9jUhhk/wdEE7+7CFuEwQUuZbO
         Kwed3bDAyDzSQ87QEjp5Qj6h/ZmqLi4miemykGZeWKKLmYktGad5vmdGbjRkGG1F/JKf
         O2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rAskiiV+ri3R+6jTvo9qmXw+6D2IsSlG063mjglSm6c=;
        b=qNJcoki+I58cV5Nqm8mEhtvCuiJHuX83uz3rvEHbOYvTYTr4Q43Ym9py1+VKIQpcDe
         jwUPYGlbs+sN8C7L/GejNqviTikmVBHNaSWNzk+wipQcAW9KXNf3gXNQFVdlmImaaY8I
         kgwmxcbFKTTC5/vZ1YoHhXwE4ZjNGWH+dtaAA9pF+rjxgCaTC406DbLbj5T7rRDbaapp
         aD5yFqy+b800SqW3pnHYWXvIVABX32GTivd29EcO5Uo1Vc20Jy6rbPmc8QWbKHNoUwQS
         f6N4ARxTtmZpr3LQsBKMSoHoM27athy8q4MlAXE3W0owgEhxpBEtlzLi/VhRgGbnzuNg
         ZeEw==
X-Gm-Message-State: APjAAAUE86QG/6TV/0BwqlIMdOmKFWkMv4+wJnIj8ponJDmt0OrUYY2h
        Rq6YECVIRmEh3BpYw9ODcBBluzNCzRNVmw==
X-Google-Smtp-Source: APXvYqws7P9fTQcXbRzTUWKain6FE66muqhDT7m1LtptShqNQJ4LXzX6EWRF6+jEcuXanOvpr+ewew==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr67962768wru.312.1563780382961;
        Mon, 22 Jul 2019 00:26:22 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b203sm46929766wmd.41.2019.07.22.00.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 00:26:22 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:26:21 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.3-rc2
Message-ID: <20190722072621.GA26079@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs fixes pull request for 5.3-rc2. 
It contains two minor fixes, nothing too exciting.

Thanks,
Oded

The following changes since commit c8917b8ff09e8a4d6ef77e32ce0052f7158baa1f:

  firmware: fix build errors in paged buffer handling code (2019-07-22 08:44:40 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-07-22

for you to fetch changes up to 717261e1769d443515517f101b133b28370ffb7e:

  habanalabs: don't reset device when getting VRHOT (2019-06-27 11:10:15 +0300)

----------------------------------------------------------------
This tag contains the following fixes:

- Fix to VRHOT event handling from the ASIC. No need to reset the ASIC,
  just notify it in dmesg.

- Fix printk specifier for printing dma address

----------------------------------------------------------------
Arnd Bergmann (1):
      habanalabs: use %pad for printing a dma_addr_t

Oded Gabbay (1):
      habanalabs: don't reset device when getting VRHOT

 drivers/misc/habanalabs/goya/goya.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
