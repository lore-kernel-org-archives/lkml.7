Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E13C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277002084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDIPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:16:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDIPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:16:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so9592313ply.4;
        Tue, 09 Apr 2019 08:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyDoJ4EF4tKFatRTJIVOBt2T69QEP0WdD+xc0GB6Pf8=;
        b=sEb6V+GjGpX/adAxqjtR3ah3mJ5NNIR/J7jAVigYyPqa+Lb9uCNMWya45zHB9YPGWL
         kbpVGsu3nwzmgI/bNglWgr7PTpsXmMbdu/rl20ZsFyxHzleDptVgePn0Gz8Yc2SSn0Dl
         oLawAkzn9RAN108UPSblsxYAIgrQK2BIrG03OGvtl4rtQ0HZQNe5kPgk0IcPUdPwHaVI
         SuAN4IgkhZwWVl5D4yC6Tk7Dy/ZFsX0mPEDxh5SZu/luY+3Z6ZBI0l6Iyw9LArKxsAjg
         WxJ6cn0WS0S4VrNGgZRsM73qyh35EytCFGKB6U7elXMxrmDm630UZseS6QtkoAjJ8kCC
         UobQ==
X-Gm-Message-State: APjAAAV/eJlVLKrwc7OVhqbSpOM/o3BNnCB3uD8QpKZ6HEs2oKTkpSTV
        qZ80rvFLQVXnlTdyRXI7+9s=
X-Google-Smtp-Source: APXvYqzlwcZxQo5mq4WPr+YtES0+PQj+Skp4JMJiQoex8JslatADRapIFoX2ocQZY6cYV46JjVZt5g==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr38121413plb.112.1554823010201;
        Tue, 09 Apr 2019 08:16:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g73sm60597977pfd.185.2019.04.09.08.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:16:49 -0700 (PDT)
Message-ID: <1554823007.161891.6.camel@acm.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kento.A.Kobayashi@sony.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Jacky.Cao@sony.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 09 Apr 2019 08:16:47 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904091014570.1599-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1904091014570.1599-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-09 at 10:44 -0400, Alan Stern wrote:
+AD4 On Mon, 8 Apr 2019, Martin K. Petersen wrote:
+AD4 
+AD4 +AD4 
+AD4 +AD4 Alan,
+AD4 +AD4 
+AD4 +AD4 +AD4 So it looks as though the SCSI subsystem doesn't like to have a reset 
+AD4 +AD4 +AD4 handler call scsi+AF8-remove+AF8-host.
+AD4 +AD4 
+AD4 +AD4 Are you talking about a PCI device removal handler or a SCSI error
+AD4 +AD4 handler?
+AD4 
+AD4 The context of this discussion is a USB mass-storage device where the
+AD4 device's port on its upstream hub has been powered off.  The
+AD4 powered-off port causes an executing command to time out.  As a result
+AD4 the SCSI error handler runs and calls the USB reset routine, but the
+AD4 reset fails because the kernel is unable to communicate with the device
+AD4 through the powered-off port.  This causes the USB reset routine to
+AD4 unbind the device from its USB driver, which in turn calls
+AD4 scsi+AF8-remove+AF8-host -- while the error handler is still running.

From which context does that unbind happen? From inside a SCSI EH callback
or from the context of a workqueue? I think the former is not allowed but
that the latter is allowed. The SRP initiator driver (ib+AF8-srp.c) follows the
latter approach. See also srp+AF8-queue+AF8-remove+AF8-work().

Bart.
