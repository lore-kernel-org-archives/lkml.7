Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFDCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF2F20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBmEhAP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfHFE5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 00:57:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45389 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFE5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:57:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so61998363qkj.12;
        Mon, 05 Aug 2019 21:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H5PoLaRUzQ7jHFWVXQJdD4uOXG4zKCbWnQmupq/zCJs=;
        b=YBmEhAP9JCHQHshoxwy7MynYbmigYP7ttZ1qmo415zJMDLoedmtyqPCVRFPhZXlf+u
         WcPsKZeLheFJ2MfkmT6+bBkdSD6gL6RxJyvdzCiqVtdyJt41bBeG0RDALTTLvh5DTmeC
         6dyLGBulL/3t4Ycq7G5X/MK2xQz1ry7bsJUS9aX7ifJ5yAnI0Y4WM9YKPFikx+uG2XIs
         1xWc2SOqts7VNTuOidON7WfKH/ol2Kq3mA/AN9DxXRmkOvFR9PFaGr4VYF4OS4d5l0RE
         1i5/XNWLj4TPJrXbfD0cHii2cjD7/0Wlww0PbcvcLCdF8iWux8CGN/hFGoQJwWSpJrWa
         eTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H5PoLaRUzQ7jHFWVXQJdD4uOXG4zKCbWnQmupq/zCJs=;
        b=DnfatXGhUj8rGch78zUIxHo7oRN8f3v6qqZOWhOKb9E4zvAtdGfF3QOw3QtGuZjYAW
         VYzhFBhHxZ9bI5Uy9hRcWq9pF/EJDo8Ui1cxKmUPgdQGcYxt0jJnyp5lvSjYs2vqL+JW
         zJIkMYEmDwD38BlaidYITIHTZ1fqlj7GGoHHqahOQK0Q5fqu45xVYgthfk5dPjcaRrxm
         DeDqvpLtEeY3a4Tofgp6k/9VvsEuOniZuTyHxMgyOg69r8xkLDZT/8hIklBQfGLfzhIC
         qNS3rLXMk6XBV422sdMmxDWc59w1bYTj4MEatMOaYLlZlU56QKfciHJ0UkFoUfQGA7+g
         YcYA==
X-Gm-Message-State: APjAAAVUOyhqnBC/bvz6wJJiDUmrGBclqjC9kG9EY6IxwDHTlkfBB1uF
        BGuc5j6AZ7lhYQPdL63Z8k05KtWIYj4UMg==
X-Google-Smtp-Source: APXvYqxqi/D52g8sg7EAn/oUQfAvhDRugqEh5ndW/Lwq8P4N/Pcmd7LkaRCUnyGgdNxOmqJP7ysx0g==
X-Received: by 2002:ae9:edcf:: with SMTP id c198mr1389828qkg.79.1565067452446;
        Mon, 05 Aug 2019 21:57:32 -0700 (PDT)
Received: from ricksfedoradesktop.metrodesignoffice.com (209-6-49-13.s3339.c3-0.smr-cbr1.sbo-smr.ma.cable.rcncustomer.com. [209.6.49.13])
        by smtp.gmail.com with ESMTPSA id z33sm38836391qtc.56.2019.08.05.21.57.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 21:57:31 -0700 (PDT)
Message-ID: <6a1dcbe6e3ddb03912f8904a368d40c09dd22bd1.camel@gmail.com>
Subject: Re: Bisected: Kernel 4.14 + has 3 times higher write IO latency
 than Kernel 4.4 with raid1
From:   riccardofarabia@gmail.com
To:     NeilBrown <neilb@suse.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-raid <linux-raid@vger.kernel.org>
Cc:     Alexandr Iarygin <alexandr.iarygin@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Aug 2019 00:57:30 -0400
In-Reply-To: <87h86vjhv0.fsf@notabene.neil.brown.name>
References: <CAMGffEkotpvVz8FA78vNFh0qZv3kEMNrXXfVPEUC=MhH0pMCZA@mail.gmail.com>
         <0a83fde3-1a74-684c-0d70-fb44b9021f96@molgen.mpg.de>
         <CAMGffE=_kPoBmSwbxvrqdqbhpR5Cu2Vbe4ArGqm9ns9+iVEH_g@mail.gmail.com>
         <CAMGffEkcXcQC+kjwdH0iVSrFDk-o+dp+b3Q1qz4z=R=6D+QqLQ@mail.gmail.com>
         <87h86vjhv0.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux raid folks?

I've joined this email ring to ask for help (I'd be happy to try to
help in return, but I doubt that I could help anyone with advanced raid
issues.  Maybe I can return any love in other non-raid ways?  Ah well..
I've been using linux raid for a quite a few years, but until now, I
haven't had to rescue data from an array.

I have some data on a 5-disk, raid 10 array that was set-up as the os
for a fedora 28 box that I used as both a hypervisor and workstation /
desktop.  I set that up with anaconda, the fedora installer, and I set
the raid level to 10, used lvm2 and xfs as the file system.  So there
is one lvm volume / group, on the physical raid, that group has several
partitions for /root, /var, /swap and etc.

I would ordinarily have completd back-ups (actualy I usually use NAS
for all data and never keep data locally) and use the disks as door
stops, but I wouldn't mind getting some pictures and videos back that
are on this array.  Also there's a current vm on there that I'd like to
get back if I can.  I had to rebuild this box because the raid array
seemed to have failed and the last box wouldn't boot.

Can I ask for help from this group?

I have attached the drives to another box, this one that I'm using now.
It is running fedora 30 (nice os / distro). I can see the drives, and I
can start the array with 4 of 5 disks, using mdadm -assemble and the
devices or the UUID, but I can't seem to mount the array to see the
data.

I've checked all the disks with the SMART test routine of the gnome
disks gui utility.  A couple have bad sectors but they all are labeled
as OKAY but the SMART Test...

I'm working through the RAID Recovery pages from the wiki that gave me
this email ring.  https://raid.wiki.kernel.org/index.php/RAID_Recovery

Thanks for considering!

Rick Nilsson

On Tue, 2019-08-06 at 09:46 +1000, NeilBrown wrote:
> On Mon, Aug 05 2019, Jinpu Wang wrote:
> 
> > Hi Neil,
> > 
> > For the md higher write IO latency problem, I bisected it to these
> > commits:
> > 
> > 4ad23a97 MD: use per-cpu counter for writes_pending
> > 210f7cd percpu-refcount: support synchronous switch to atomic mode.
> > 
> > Do you maybe have an idea? How can we fix it?
> 
> Hmmm.... not sure.
> 
> My guess is that the set_in_sync() call from md_check_recovery()
> is taking a long time, and is being called too often.
> 
> Could you try two experiments please.
> 
> 1/ set  /sys/block/md0/md/safe_mode_delay 
>    to 20 or more.  It defaults to about 0.2.
> 
> 2/ comment out the call the set_in_sync() in md_check_recovery().
> 
> Then run the least separately after each of these changes.
> 
> I the second one makes a difference, I'd like to know how often it
> gets
> called - and why.  The test
> 	if ( ! (
> 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
> 		test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
> 		test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
> 		(mddev->external == 0 && mddev->safemode == 1) ||
> 		(mddev->safemode == 2
> 		 && !mddev->in_sync && mddev->recovery_cp == MaxSector)
> 		))
> 		return;
> 
> should normally return when doing lots of IO - I'd like to know
> which condition causes it to not return.
> 
> Thanks,
> NeilBrown

