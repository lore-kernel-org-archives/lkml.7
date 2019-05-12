Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE7C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AA220873
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJU4NUo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfELUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 16:49:48 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:41841 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfELUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 16:49:47 -0400
Received: by mail-yw1-f54.google.com with SMTP id o65so9346695ywd.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=CQS5rVb5A7Wokw7HTdpc5JzdEFnMZc3iivC7IhZNIic=;
        b=BJU4NUo9A2C30NphLgpiHZCNDLVx3uT5H0nD3FdqJqJmXBVDUpeiMYTbkK8zwiKBou
         yT7mdbVyeyEy5zVbw9k043OUpInGHp/kgZIy9+csYP2SBd8W2z3nhWpWLYDw2My0bdP2
         V0zamYBM+k6CblucA7YWW70cfxJ0JCN10RlvEzTKjDhDSFtKrH2y1D1xg6plmf0+pyVW
         HwdDfQ3EqeZUu7GveNJEws5glsbue3pmKhrKxOaPxRT2ZZYtLGDQzNtLZFX1u0sF24CQ
         7qw1A8PmHMdXxG/mCyDHwyQFPhk34DW4y6Pitqlh905nb1gM4bQq92HRzk2xMZ7YgJWg
         WnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=CQS5rVb5A7Wokw7HTdpc5JzdEFnMZc3iivC7IhZNIic=;
        b=CT7rUS61sQLmBeqMZm/pr+0AnBIsylb85wLEwaOlnhungOYSGnybzy2Ty8U09EKKfG
         ORzGc+G4YCY1r8NgYBTRJ7NH6Eaje5cgySafMJG3zxCf8pOrybIUq7iApLgJh8SflqWr
         4he0ghmbhr/y2EsQvaEdiy5IHHefryvh8CJ9xiIUUB1hDPl8Nzfs4NSdgG49IJ6ChDg4
         46HaMBzOGuTJNXbv2v6+OGNhvQfHiZ8YX5AYPNsJ/zCoB4+2gJRMsMlqExTDeFCCNv/7
         7MSehkgJkAt/7GIt8iQ56GhhrOrfXs1umtFfzNVlVvvhHunxKXZdjilkV3qhwSH9XdiL
         5sDw==
X-Gm-Message-State: APjAAAWR+0+FN0SniK7dnQ9S8T8M+QjdjeO7KhkpUdf4yvx83BXUdC+l
        V4rdWa0QAqs4TyvSHxnE6j0jPHkmzVXARNBe8Hy5Yi8Z
X-Received: by 2002:a81:4985:: with SMTP id w127mt11498835ywa.144.1557694186996;
 Sun, 12 May 2019 13:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074519.61272b42@canb.auug.org.au> <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
In-Reply-To: <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Sun, 12 May 2019 22:49:18 +0200
Message-ID: <CA+QBN9BcrrgT-ThOMwSjugTVRqoU10d8juOibLMMROvWvJqd4g@mail.gmail.com>
Subject: Re: C3600, sata controller
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel's config and dmesg are here

http://www.downthebunker.com/chunk_of/stuff/public/projects/workstations/hppa/c3600/kernel/5.1-git-v5.2-64bit/

http://www.downthebunker.com/chunk_of/stuff/public/projects/workstations/hppa/c3600/kernel/4.16.2-64bit/

Il giorno dom 12 mag 2019 alle ore 22:44 Carlo Pisani
<carlojpisani@gmail.com> ha scritto:
>
> guys,
> I asked a friend to lend us his card, which is the card2 listed below
> and not things are becoming really weird
>
> card1, Silicon Image, Inc. Adaptec AAR-1210SA
> card2, Silicon Image, Inc. SiI 3124 PCI-X Serial ATA
>
> the card1 is a PCI32 bit card, and uses the "sata_sil" driver
> the card2 is a PCI64 bit card, and uses the "sata_sil24" driver
>
> card1 is installed in a PCI32 slot, and it's moving 32Gbyte in a loop
> without any issue
>
> I have just tested card2 in each of the PCI-X slot (including the 3.3V
> one) and ... it has always triggered the HPMC unit, crashing the
> machine
>
> the hardware is different, and drivers are also different, but  ....
> maybe the problem is related to 32 vs 64bit?
>
> I am going to repeat the test with card2 installed in a PCI32 slot.
> This should force it to 32bit: will it work correctly?
> (hope this makes sense)
>
> ---
>
> we have also checked if the kernel is correctly handling the ram
> we have a C3600 with 8Gbyte of ram
>
> mount -t tmpfs -o size=7G tmpfs /mnt/ramdrive/
> dd if=/dev/zero of=/mnt/ramdrive/test.bin
> badblocks -swv /mnt/ramdrive/test.bin
>
> checking for bad blocks in read-write mode
> From block 0 to 7340031
> Testing with pattern 0xaa: done
> Reading and comparing: done
> Testing with pattern 0x55: done
> Reading and comparing: done
> Testing with pattern 0xff: done
> Reading and comparing: done
> Testing with pattern 0x00: done
> Reading and comparing: done
> Pass completed, 0 bad blocks found.
>
> no problems found
