Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E72C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F3A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7X/C3q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfDOPDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:03:23 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44998 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:03:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id u187so6490081ybg.11;
        Mon, 15 Apr 2019 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RY0p0Zcv3snDWs0H1r/vdemz2kzLyanKjr53qbrZVm4=;
        b=G7X/C3q7Y2Ju2TWRFMa8lgJ/y59jZzIPvS3PFcj/Xted9evMhIUhKjv8Vp9mM8j1CC
         3n+Tjl7X4/TqLFqG3uAKq30K2eHBrI/KimeQBSBX9yt7uekg6G2llh4IZy3xea/hnWLw
         zAJ/Vu5q2GD6Wcl745smvWc1YNhqau27iVu9NRqqEhZRlAww+dU/JXyXfAxecZArQOWX
         tHSkZdJRdo9M11dsl7aY7w6mrQttekQg3Q0D3ofhEJ6s2tUzA/k2YR/NjA8LQaKd6SM6
         qzpd7CWfLuVnBLZ8j6pXD+SXuAizaeETjk1Boqdw8ntYZDybDIvIMz68Kpb320PZwwlf
         hMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RY0p0Zcv3snDWs0H1r/vdemz2kzLyanKjr53qbrZVm4=;
        b=dL6cfzTRfNjB2o+jUQcFrnFsWFbFiNRFLc+9kUYrUeJIcBTbgYWKct8a4K4Xi2eLCY
         XQdIXEK5ebSH+4pe7Mw6gGEI6S9JQWLDuyLlRgxomkTnmXNMZ3BZIw5JsmE9Gx2vfA/D
         HKv6918rV/KJqruGZfwR1E8m/fWrL6oKZLE64x2w+LsbYEkRbQfzD2Mbdi2uqrf+I9CO
         HNx0gE1nvaWsqX2wUlbKjcXAEE5V7Cp6vvwlE3xXf1VO9c4dPPi42aErqgNWMc3qFD2p
         geMSM+8L7OnvpzWS+AOwMm915tvXr/6qSoA4XQxvci63ydOUDlmow+SGbK7hvvE8x9MV
         BQGw==
X-Gm-Message-State: APjAAAUktPRKJnmvmICc3kcV64C48yDlP1f7VYERRm1tJgvlNgvGUoGI
        wMcy7FqWXk1TGZpK1LeEfALknz6PKbybCquhs5w=
X-Google-Smtp-Source: APXvYqy7nIOd1XbQhyFh7GYDwDTtu28lS0yxFBO9Gd4jp+COsrICYKp3tEK8VYBXiQpOkhu2UHBGEHVDvO6Tppw4nkQ=
X-Received: by 2002:a25:8408:: with SMTP id u8mr26778233ybk.332.1555340601692;
 Mon, 15 Apr 2019 08:03:21 -0700 (PDT)
MIME-Version: 1.0
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Mon, 15 Apr 2019 23:04:11 +0800
Message-ID: <CABXRUiSdJD477FVdTEN8VVm5yqsJ3u-=FsX2fBN2+KWK3HrVPw@mail.gmail.com>
Subject: Potential kernel address leakage in driver/atm.
To:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, recently I found that there is a kernel address leakage to user
space via copy_to_user in
drivers/atm/iphase.c:2772 (linux-5.0.7)
In ia_ioctl, when cmd is MEMDUMP_DEV, copy_to_user will copy struct
IADEV from ia_dev[board] to user space.
The struct is initialized in ia_init_one(line 3185/3211) and the pci
and next_board field are kernel pointers assigned in line 3191 and
3224.

Related code:
static int ia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
{
    ...
    iadev = kzalloc(...);
    ...
    iadev->pci =  pdev;
    ...
    iadev->next_board = ia_boards;
    ...
}

static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
{
    ...
    IADEV *iadev;
    ...
    iadev = ia_dev[board];
    ...
    switch (ia_cmds.cmd) {
        ...
        case MEMDUMP_DEV:
        ...
        if (copy_to_user(ia_cmds.buf, iadev, sizeof(IADEV)))
        ...
    }
}
