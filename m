Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86829C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8E820449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG8USjoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbfFMQf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:35:27 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:40119 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbfFMHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:43:33 -0400
Received: by mail-vs1-f50.google.com with SMTP id a186so10111044vsd.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hotLWlJT65xEbJ61TV1i6ABCww+sxM3+UkKCRR2VvlQ=;
        b=YG8USjoNprxHuqspzE0bCI9G/czG9Bpmq8c13aybYyA2uPv6mGc4K/kxV4MKObBCXn
         VO+3wB0nSK56AukwJpc9eObDRy0A2QoLuOenXR7F19rKMHv1oprv0EJSU9/OSLYK+/Wi
         DtINoXmlSVoJSm0MdJn4WoLyREIFnkbXu66DmCl8r0+1jAaPvFRirQE3JcpguwggQTO3
         rOUB3bIcW07qNreqZOk/9lUnR2zylA5EjK/TyuvsxZTOODEcKwebcMHh4Q0GnNy53JvS
         aCd51/jxleDuBriRwzn/g3axx6jkj6M8y3RW4XGcXLvGCkcO8MaoUzyBf+IanrvLpBZG
         ct4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hotLWlJT65xEbJ61TV1i6ABCww+sxM3+UkKCRR2VvlQ=;
        b=NjJFCdWfYAi7YDCA5h2S5daQYJPA2iDVHkKPIbkncAKuKtLc0ZEiv44+PG3UEY/p2p
         mb5A/R6Rp7hgkWyGjt748I32TnBS3Wmu+CbMcC2MZDtZryjvTDRQNEYZxcjsR47uxU16
         SzWhqnm3e3vt4zcsSlkdJWQxtxPlRmJ4TqhsEOdtOh1DaVPAmE9TRQUdfbUKjzy4nFoE
         ObxtcLGMPIiYjp/mdwOgFa1ua9MYfY9+eaNBVG00cbyoguXYcwDCGEP6Jn+0zC/+P/Cs
         u0YCN5Ao4N4CFU9HuxkRXvADD57bmqUGxSfV3GT1oJBzfFo1r9teAba1snHW32rAdhOm
         gTkw==
X-Gm-Message-State: APjAAAV83yJjg8wzdZ5KlGOKLtntEY04jHg9R9/I8QjbVDr+mCUtPtLT
        PsizCFJdBOlmvlRvjMPUec1cdFZ+KLD9bzGVz3n1zAskX0M=
X-Google-Smtp-Source: APXvYqwrVqv21Jxe7l7wvY0AC21Hp5Db9lwc3hNEGCAT2hhOG+q80MLPYviUu6jdSvuDaiyfqXClOX/k5IbPqJjTvgI=
X-Received: by 2002:a67:ec5a:: with SMTP id z26mr43636516vso.144.1560411812380;
 Thu, 13 Jun 2019 00:43:32 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 13 Jun 2019 13:13:21 +0530
Message-ID: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
Subject: Pause a process execution from external program
To:     kernelnewbies@kernelnewbies.org,
        open list <linux-kernel@vger.kernel.org>, pedro@palves.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I was just wondering if this is possible in the Linux world.
My requirement is:
For some reason, I want to halt/pause the execution (for some
specified time) of a running process/thread (at some location),
without modified the source, may be by firing some events/signals from
an another external program, by specifying the address location or a
line number.

Is this possible ?
May be by using some system call, or other mechanism using the process PID.
Assume that its a debugging system with all root privileges.

Basically, its just like how "gdb" is able to set the break-point in a
program, and able to stop its execution exactly at that location.
I am wondering what mechanism "gdb" uses to do this?
I tried to check here, but could find the exact place, where this is handled:
https://github.com/bminor/binutils-gdb/blob/master/gdb/breakpoint.c

Unfortunately, I cannot use "gdb", but I wanted to borrow this
mechanism only to serve my purpose.

If anyone is aware, please let me know.
I will share my findings here, after I get some useful results of my
experimentation.

Thank you for your help!


Regards,
Pintu
