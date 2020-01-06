Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E46C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355A721744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578336020;
	bh=Lk2b8isd4AKJZh0uG3znLmDlvurajw8PnaAef68wq2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E52chvVanAKJVVmfYVWUgcMQ0j+c6BfbRIu4jyuTPQJ4D3Y2o0CGinN1SlFOtvmwU
	 FdxtNMkuZDMQLJUIb4tC0rbf4JM0/PZK3vRPALrAgWyGmHJCXsHiS++kes+xE31fkc
	 Y0Mlx+h6TnUUdJU2t8l4dJmy5p4YtGxZOz1maTVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFSkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:40:18 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D92208C4;
        Mon,  6 Jan 2020 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578336018;
        bh=Lk2b8isd4AKJZh0uG3znLmDlvurajw8PnaAef68wq2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Bcx7rydQDjiPxZ3nYt4l5Uc9HBnHLOnDifre9sjZr/zLAFc+MgnKi8yeB3k/pEf+
         fLaGhfKkD73da0pEkrP41WLYiRuody5qYkX9xAEynZA5kgo7PQhwzmd36lsdgY8ZuR
         KGEYjUJYwYAU08342QAl3Fl9NqwGd5aiKI9iVcJM=
Date:   Mon, 6 Jan 2020 10:40:17 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] Multidevice f2fs mount after disk rearrangement
Message-ID: <20200106184017.GD50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
 <e773d576-9458-48d7-bad4-dd4f8c61ebd3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e773d576-9458-48d7-bad4-dd4f8c61ebd3@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06, Chao Yu wrote:
> Hello,
> 
> Thanks for the report. :)
> 
> On 2020/1/5 5:52, Oleksandr Natalenko via Linux-f2fs-devel wrote:
> > Hi.
> > 
> > On 04.01.2020 17:29, Oleksandr Natalenko wrote:
> >> I was brave enough to create f2fs filesystem spanning through 2
> >> physical device using this command:
> >>
> >> # mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd
> >>
> >> It worked fine until I removed /dev/sdb from my system, so f2fs devices 
> >> became:
> >>
> >> /dev/sdc -> /dev/sdb
> >> /dev/sdd -> /dev/sdc
> >>
> >> Now, when I try to mount it, I get the following:
> >>
> >> # mount -t f2fs /dev/sdb /mnt/fs
> >> mount: /mnt/fs: mount(2) system call failed: No such file or directory.
> >>
> >> In dmesg:
> >>
> >> [Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,
> >>   59063,        0 -  1cd6fff
> >> [  +0,000024] F2FS-fs (sdb): Failed to find devices
> >>
> >> fsck also fails with the following assertion:
> >>
> >> [ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char
> >> *)c.devices[i].path)
> >>
> >> Am I doing something obviously stupid, and the device path can be
> >> (somehow) changed so that the mount succeeds, or this is unfixable,
> >> and f2fs relies on persistent device naming?
> >>
> >> Please suggest.
> >>
> >> Thank you.
> > 
> > Erm, fine. I studied f2fs-tools code a little bit and discovered that 
> > superblock indeed had /dev/sdX paths saved as strings. So I fired up 
> > hexedit and just changed the superblock directly on the first device, 
> > substituting sdc with sdb and sdd with sdc (I did it twice; I guess 
> > there are 2 copies of superblock), and after this the mount worked.
> 
> Alright, it works if superblock checksum feature is off...
> 
> > 
> > Am I really supposed to do this manually ;)?
> 
> We'd better add that ability in tune.f2fs. And I guess we need to let
> kernel/fsck to notice that case, and give hint to run tune.f2fs to
> reconfigure primary/secondary/... device paths.

I'm thinking to add tunesb.f2fs to edit superblock explicitly, since it has
to edit it without getting superblock/checkpoint and other f2fs metadata.

For example,
# tunesb.f2fs -c /dev/sdb -c /dev/sdc /dev/sda
.. superblock info ..
.. device list ..
.. hot/cold extensions ..

Will modify the device list, if it's different from parameter.

> 
> Thanks,
> 
> > 
