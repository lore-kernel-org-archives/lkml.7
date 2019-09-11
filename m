Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D30C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD320838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYKgGPQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfIKQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:46:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35370 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfIKQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:46:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id f24so3645552edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BiDWJImWyVP8vG34YqIt59zURuO0g+ji0CE0EIqAtls=;
        b=GYKgGPQtL0a6a2CGpkFqaJ55ITXdlMk4qlyyHfc4GmfMI9qIW8U5CIy4G5vXCheGFb
         nFtgowVqtwASwJRk0gvEgXWYc9GUEowWRXWWCPkdq1N8ysEtO95om2+FY2/xAsmjgRYf
         0SQKKKnam3glK5IhFkFxpPT8Ur5LYDnod8nnxRVqJsx9Eq2irHNRIznyut0AuJMi/+YG
         3rnqdE+vJWCeWDiWspLOg6cXKq4MUMmOIO/0kIfez47XnJNVBrDyST35ohnAUtkQqOry
         crHr9Lhc9e2Av23E82+K6/TMZhHmggoYSzgD5UDZux+o++N1uikEKSHQdzuvqKrMYg+D
         9D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BiDWJImWyVP8vG34YqIt59zURuO0g+ji0CE0EIqAtls=;
        b=A1FGHH/K9NooN/k5HjbMsiAMUkSzIcTa0ShZg0+hoxL7ti1zFeM68diSRZt1hOdF2l
         VSHMd6IWkH4bshyzQ7yAKzWvUp7J/+ktOp5fAOPQjSewXYMt8ktl9vCcnJzO86ISvXgR
         pjgBfK8JhuSUm+9H4CVLgWCDsOgP2FrnWBppTLANoRvHMKEKKDJFxokUrVLYNtDXLvFx
         Vp/gD19vOTvCsqD7L0/pdJhSJRIvtRCcfnFd4keKcsWg/coWWvzjaW8ezS1Rdmo8M1ER
         T1WdEuopoRaZ3Iuk1wlar+rRXRyvgoH5Ipfknp8jg/GuxEJUzbKHv+k2dV9t72hGqWWE
         luPA==
X-Gm-Message-State: APjAAAVC8BCHxukyMSNywbe84vSJrpAXUjkiZYCdThAb8UwXZ3LuAwMD
        cAe/kEuZlY/YK0Q5mBG6LXVqO8kc+QIptyd9ZferA1vlW04=
X-Google-Smtp-Source: APXvYqwyUo5XkIVub3unDD7ZyEU/Fto6IGNihwXNULU+3TX9sN6+XepBV3+gxQ3KRC7uwZvFnK83kxjF9QEi8MEUOjc=
X-Received: by 2002:a17:906:804d:: with SMTP id x13mr30272703ejw.134.1568220416979;
 Wed, 11 Sep 2019 09:46:56 -0700 (PDT)
MIME-Version: 1.0
From:   yoav rubin <yoavrubin18@gmail.com>
Date:   Wed, 11 Sep 2019 19:46:46 +0300
Message-ID: <CAHcr5QqDCjWZz9ADvsE-3tt8qu4K+1NCn-gJuSsm2KBjUcaYVg@mail.gmail.com>
Subject: linux 32bit kernel virtual space , lowmem , highmem , RAM size
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologize in advance if I'm sending this to the wrong place. (It's my
first time using mailing list...)


I need some help understanding the exact relations between the linux
kernel virtual space , specifically LOWMEM area , and the available
RAM size as seen by the kernel.

after reading this article: https://lwn.net/Articles/75174/ and some
other users threads' i have come to the following connections:

As we all know , the 32bit virtual address space (4GB) is divided into
user space address and kernel space address usually by ratio of
3GB/1GB or 2GB/2GB.

Inside the kernel space address we can find the kernel image itself ,
vmalloc area and some other staff.. the one that interesting me is the
LOWMEM area.

3.LOWMEM is an area of kernel's virtual addresses which mapped
directly into physical RAM for efficiency without using "mid level"
translations.

For this question I'm ignoring the HIGHMEM area since its not exists
in my system (turned it off by menuconfig).

The system have 1.5GB RAM. When the virtual address space got split
between the user and the kernel by ratio of 3/1 , the kernel
recognized only 768MB (or something close to that) of TotalMem.

Allegedly the explanation for that is the kernel had 1 GB of virtual
address space , from that we need to subtract the kernel image itself,
vmalloc area and some other components and than we left with 768 MB of
LOWMEM which apparently for some reason is also the amount of total
memory that I have in my system.

when I changed the ratio to 2GB/2GB , the LOWMEM area increased and
then I saw a TotalMem of 1.5GB (again , almost 1.5GB for the same
reasons)

so the mid conclusion is that the size of kernel's LOWMEM area is the
size of the TotalMem I have in the system.

I know that I'm missing something here because there is no way its true.

Why do I need to increase the LOWMEM area to get more visible RAM
size? the data structures for managing the memory are not that big..

How this affects the applications in user space? why increasing the
LOWMEM area have any impact at all on the other 3GB/2GB of user space
addresses?

thanks!
