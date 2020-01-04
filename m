Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FFFC33C8C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150E8222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="GFNOZfPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgADVww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:52:52 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:33572 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgADVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:52:51 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B399E67EB38;
        Sat,  4 Jan 2020 22:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1578174768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8kF02N3UgQmy+M1+yfJ0I6y3z6Y1C+QkxFReEl2674=;
        b=GFNOZfPmGwsVS7Lu1EiBphG1JX+AG9AGuAp80b0BOmfehEGCwtDhFkzBKLzoLIuRwYwVUo
        7yk63AU35oNKiI+qp62YNbWfkA0b7hoO7aIGj4PruQAsQ7fpWcM03Khl5Ew2ASAZIl0HoY
        xJszXGq1M10QUMvkakjs14dtGuAWUhI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 04 Jan 2020 22:52:48 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Subject: Re: Multidevice f2fs mount after disk rearrangement
In-Reply-To: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <2c4cafd35d1595a62134203669d7c244@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 04.01.2020 17:29, Oleksandr Natalenko wrote:
> I was brave enough to create f2fs filesystem spanning through 2
> physical device using this command:
> 
> # mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd
> 
> It worked fine until I removed /dev/sdb from my system, so f2fs devices 
> became:
> 
> /dev/sdc -> /dev/sdb
> /dev/sdd -> /dev/sdc
> 
> Now, when I try to mount it, I get the following:
> 
> # mount -t f2fs /dev/sdb /mnt/fs
> mount: /mnt/fs: mount(2) system call failed: No such file or directory.
> 
> In dmesg:
> 
> [Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,
>   59063,        0 -  1cd6fff
> [  +0,000024] F2FS-fs (sdb): Failed to find devices
> 
> fsck also fails with the following assertion:
> 
> [ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char
> *)c.devices[i].path)
> 
> Am I doing something obviously stupid, and the device path can be
> (somehow) changed so that the mount succeeds, or this is unfixable,
> and f2fs relies on persistent device naming?
> 
> Please suggest.
> 
> Thank you.

Erm, fine. I studied f2fs-tools code a little bit and discovered that 
superblock indeed had /dev/sdX paths saved as strings. So I fired up 
hexedit and just changed the superblock directly on the first device, 
substituting sdc with sdb and sdd with sdc (I did it twice; I guess 
there are 2 copies of superblock), and after this the mount worked.

Am I really supposed to do this manually ;)?

-- 
   Oleksandr Natalenko (post-factum)
