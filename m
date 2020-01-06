Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D637C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C667E207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578335693;
	bh=JntLi/yJ4cS9Fj9APMSIeBKJes+q3Xm+EQZItJCaOHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RDBsbnvCfD4Zpqy+86YJGX+sA9bD4herp9lNEm+LHOsSq6DI5lFWf+os9x20IuZu2
	 LRVH00vuAPbsVtTpWqxZ0LhNPgaG0vcWyR7yEI6mwB1aZWGtGp2F7h85Y6gxeagRrV
	 ig0sBV+HZADZ3jqLHaK8c+vwQ2KOARHyNqv4yiSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAFSex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:34:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFSew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:34:52 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7112072E;
        Mon,  6 Jan 2020 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578335691;
        bh=JntLi/yJ4cS9Fj9APMSIeBKJes+q3Xm+EQZItJCaOHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M76DJxGL5Awgyq2fvLv9+VPDjy3kmhrnKoXgIa9knVhOjKWnr4iqsgJwK48shJvJ0
         KMavplXlMD0T899wAH2nlhEYqqtwalODpjq7Q5Y9ypTEFaGQyp8cW87Z0/WqxHxzMd
         Wo/XR6RGKdOI1Pfw44H/1p5Qpgt8l1cBasPJ+B/4=
Date:   Mon, 6 Jan 2020 10:34:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: Multidevice f2fs mount after disk rearrangement
Message-ID: <20200106183450.GC50058@jaegeuk-macbookpro.roam.corp.google.com>
References: <4c6cf8418236145f7124ac61eb2908ad@natalenko.name>
 <2c4cafd35d1595a62134203669d7c244@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4cafd35d1595a62134203669d7c244@natalenko.name>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Oleksandr Natalenko wrote:
> Hi.
> 
> On 04.01.2020 17:29, Oleksandr Natalenko wrote:
> > I was brave enough to create f2fs filesystem spanning through 2
> > physical device using this command:
> > 
> > # mkfs.f2fs -t 0 /dev/sdc -c /dev/sdd
> > 
> > It worked fine until I removed /dev/sdb from my system, so f2fs devices
> > became:
> > 
> > /dev/sdc -> /dev/sdb
> > /dev/sdd -> /dev/sdc
> > 
> > Now, when I try to mount it, I get the following:
> > 
> > # mount -t f2fs /dev/sdb /mnt/fs
> > mount: /mnt/fs: mount(2) system call failed: No such file or directory.
> > 
> > In dmesg:
> > 
> > [Jan 4 17:25] F2FS-fs (sdb): Mount Device [ 0]:             /dev/sdc,
> >   59063,        0 -  1cd6fff
> > [  +0,000024] F2FS-fs (sdb): Failed to find devices
> > 
> > fsck also fails with the following assertion:
> > 
> > [ASSERT] (init_sb_info: 908) !strcmp((char *)sb->devs[i].path, (char
> > *)c.devices[i].path)
> > 
> > Am I doing something obviously stupid, and the device path can be
> > (somehow) changed so that the mount succeeds, or this is unfixable,
> > and f2fs relies on persistent device naming?
> > 
> > Please suggest.
> > 
> > Thank you.
> 
> Erm, fine. I studied f2fs-tools code a little bit and discovered that
> superblock indeed had /dev/sdX paths saved as strings. So I fired up hexedit
> and just changed the superblock directly on the first device, substituting
> sdc with sdb and sdd with sdc (I did it twice; I guess there are 2 copies of
> superblock), and after this the mount worked.
> 
> Am I really supposed to do this manually ;)?

Thank you for investigating this ahead of me. :) Yes, the device list is stored
in superblock, so hacking it manually should work.

Let me think about a tool to tune that.

Thanks,

> 
> -- 
>   Oleksandr Natalenko (post-factum)
