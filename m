Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD8C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EEC2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKmOMyi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfG1L2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1L2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so58835983wrm.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Rw98zLA5WI0SsNjkcVzuBXmqholrN3Tz8/1ws8gGo3A=;
        b=EKmOMyi1GnyJ0v0v6hZkyWrhORPZeNXtzcD1UWRKayC+tRueXQbcN7gkd6cS36dHeX
         zvRYXQ1T29zrDJ4vI3dih6uHe5M9tPVOuKD09RdT9BVTS3Q9efADb3bxuz9jmcocRRxg
         PwqNPH+o911yXVWmUOsKPb2Vvgvds0LgoMDePWJjNeGbM6kdHkgSB/byDOsU3MNd1d2G
         5oalhYzK8dexUFOKvxfncvTIhBTfC0K9TEaZpWNeKgZrz49xONGOxt64wuCS/KcB3Ciw
         eE2HHAFOXuPKzlZjSSIFyBZN3M9s+zlnf5g3tjgIr56E7oIVwV/pUiNXj31Nnv3qkmfh
         qeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Rw98zLA5WI0SsNjkcVzuBXmqholrN3Tz8/1ws8gGo3A=;
        b=QVDIg+5bYs0ylEwXvccGxRPcg/bKVo3Zsd/ClRoyVxzRo9FWqWBoFScUznCcygWvpO
         FPDyOEoUFOTufgj5831gw5r0RGvEeTytyDUxFsDn0vJZSmjw9htXlmrEEaTpwrELEHfL
         82FQZkXx3+UA7d4I4Po+ATCndYP2feJGSm3yudKZ+7mrwgINN852RGiJ5z0r/u4XlvKN
         D4sp15O1c8sq9H/9POrjbh20jyUiY7KERiUbVeyZT6JUqW03/MoRd9xpsWQlptdP/hpM
         rqi0XTehOK21MtFImccJKR0KlXoRiSZDXr2/vsHeFN0xxOGQQm5riUKGpgzfvZO8Hb/Q
         4sZw==
X-Gm-Message-State: APjAAAVEEiTkwxWvQgF0CDnsyULs51nLalvRLikA1azt3OjpvsyXU19n
        DrbwUr1YvyPQHplpJnrlkwlIjZZqiog=
X-Google-Smtp-Source: APXvYqz7y34SHBVLYFrCnc0V9bg/QxIvFSgYnnqL495IcEqr9S7VpMfuJInxKx0xBtatB2sb5T6owg==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr5009423wrv.346.1564313301333;
        Sun, 28 Jul 2019 04:28:21 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:20 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 0/9] habanalabs: support open device by multiple processes
Date:   Sun, 28 Jul 2019 14:28:09 +0300
Message-Id: <20190728112818.30397-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set removes the limitation in the driver's code that only a
single process will have a file-descriptor of the device at any point of
time.

This limitation needs to be removed because of two reasons:

1. Blocking multiple processes and trying to account them was stupid and
doomed to fail.

2. The driver needs to support system management applications that just
want to inquire about the device's status while a deep-learning
application is also running and sending work to the device.

With this patch-set, there can be unlimited number of open
file-descriptors of the device by unlimited number of user space
processes.

Having said that, only a single process can submit work to the device, or
do any change in the device itself via IOCTLs. All the processes can
perform inqueries about the device using the INFO IOCTL. This is enforced
by using an object called "context".

The "context" object is created as part of the private data the driver
saves per an open file-descriptor. For backward compatibility with
existing user-space code, the "context" is created in a lazy way (it is
created on the first call to an IOCTL). There can be only a single context
per process, and only a single context on the entire device is considered
"compute context". Only the FD which owns the "compute context" can
call IOCTLs which require this context, such as command submissions,
memory map, etc.

Only when an FD is completely released, its context will be closed. It
doesn't matter if the FD is duplicated or shared in user-space, as the
driver will keep a single private data structure (and single context) per
that FD.

In addition, a context that was open as a "non-compute context" can be
upgraded to a "compute context", if there isn't any other "compute
context". This is because the application usually calls the INOF IOCTL
before it calls other IOCTLs.

Thanks,
Oded

Oded Gabbay (9):
  habanalabs: add handle field to context structure
  habanalabs: verify context is valid in IOCTLs
  habanalabs: create context in lazy mode
  habanalabs: don't change frequency if user context is valid
  habanalabs: maintain a list of file private data objects
  habanalabs: define user context as compute context
  habanalabs: protect only pointer dereference in hard-reset
  habanalabs: kill user process after CS rollback
  habanalabs: allow multiple processes to open FD

 drivers/misc/habanalabs/command_buffer.c     |   6 +
 drivers/misc/habanalabs/command_submission.c |  12 ++
 drivers/misc/habanalabs/context.c            | 145 ++++++++++++++++---
 drivers/misc/habanalabs/debugfs.c            |   4 +-
 drivers/misc/habanalabs/device.c             | 144 +++++++++---------
 drivers/misc/habanalabs/goya/goya_hwmgr.c    |  11 +-
 drivers/misc/habanalabs/habanalabs.h         |  39 ++---
 drivers/misc/habanalabs/habanalabs_drv.c     |  54 ++-----
 drivers/misc/habanalabs/habanalabs_ioctl.c   |  20 ++-
 drivers/misc/habanalabs/memory.c             |   6 +
 10 files changed, 285 insertions(+), 156 deletions(-)

-- 
2.17.1

