Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DAAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04C120748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj/RASmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKRNbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:31:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39708 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKRNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:31:47 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so18741307ioj.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=63iy4bM1DyfcTYSYJP2g8q0wwRewQXs5L/sp5PcQ2ss=;
        b=gj/RASmOyEqxCI41ANRk/aEJBdmHqtNojat9rU0G+A4F4TfVM++nYuROKVg4Sub9vg
         0Rv9eUkWq2miLtzLKpj+sMDBgQgPl1hwgzN0Qw3FCY4uUFr16wg1UJNTNzS9o4XtRDeK
         HHx/xk6MClm6XKUADv/eiFBceHAvJKy9AH1FqB1NqdXi178rMc2WQc8j65QXQdYvzGRQ
         2xc8F5/A1iuvBNLEbdDtce/HyuyxnAzy4jLP0EQur/fXjePFivdql8XyKmj4ccoY0dBP
         Z11xO00CgcqRNx3ruwp+ah3DDEvCtA3HwJUCj34039/TlYyC6N+msl1w0es5no0Ocruk
         84jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=63iy4bM1DyfcTYSYJP2g8q0wwRewQXs5L/sp5PcQ2ss=;
        b=ECJe6apkY721gCrQiDx7OVHr3WDUtNNhDpgqX53CTUDXi1KQySG4Olj/x9AhYRxOEC
         irnEW5eHcIQe1rRxhpaEXif6DIrKC/VPm9m1tHa+4EGDtjj65CFx0KO/E1a8EVgtV/Xh
         7J80O2kfW24f8WHCgBlKDFYLk/ydW8DBGjK7PdDwxWc+ykheTNAcsosRG0ei7BGH3/z1
         FjhL5hnoo/wCx4I6ZsTfUf/8eyozbec8VJmyGzvsAZr/1Bb560+9gKLTcByGJVxQ6gOe
         f99BudqJfBZfABsi1W2dBtKfgro1TVNoBhG5c1p3XMXv7rs1TITMY383xGWSbJ7vVBAa
         V27w==
X-Gm-Message-State: APjAAAX49903D9HFTv8YALSgEN9A6UCOAQHDhcX2ygNTp+1VbRvfm2aj
        VtIU2lpR6Q+udCZ1fmeGLMCiDry6jG24rN9r06MZ3b9H
X-Google-Smtp-Source: APXvYqw+SP9qGLQPAFPXUCCopyMT5M7wKYEkGPg3ytjJaeOQCLbbxVu3xKYNBjphdETxI4Zvb1+q0M2Zt8ap4EQq1hA=
X-Received: by 2002:a6b:c98e:: with SMTP id z136mr1018199iof.15.1574083903945;
 Mon, 18 Nov 2019 05:31:43 -0800 (PST)
MIME-Version: 1.0
From:   Siavash Arya <siavash.arya89@gmail.com>
Date:   Mon, 18 Nov 2019 14:31:08 +0100
Message-ID: <CADuSoB88Tk0sKVDUdnXowL0b9B=GC0UAsi-NN=x1-2jN3+pbPg@mail.gmail.com>
Subject: Hard crash bug with v5 kernel
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm rewriting this message since I forgot to put a subject on my last attempt.

"Hi,

When I use any ubuntu (probably any Linux) version that is running on
a kernel that is of version 5 or higher, I have an issue where my
computer hangs completely when reading from any of my hard drives.
When this happens not even the caps lock button on my keyboard is
working anymore. I know that it happens on reading because I got help
at the freenode channels and tried a dd command that would read from
any of my 3 hard drives. I first detected the problem when I tried to
copy files. Anytime I got to copying between 2,5 GB -> 3 GB this
happened and I had to long press my hardware button to shutdown the
computer.
Today I'm not even able to run the ubuntu 18.04 installer because this
happens at "copying files" during installation. If I run the installer
live, this problem exists.
When I had ubuntu installed some days ago, I had to use grub to boot
with an older kernel version in order to copy my files to my backup
drive so that I could try to reinstall ubuntu. But I'm not able to
install ubuntu anymore so I'm using Linux Mint and I don't like it at
all compared to ubuntu so please please solve this fatal bug soon ! :)
Please let me know what you need ot know and how I can help you solve this.

Best,
Siavash"
