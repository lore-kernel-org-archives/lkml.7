Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0AE20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553006535;
	bh=Gu743qy4OIV2LMjMYn6MzjH4V5Sfb2TTSRtVTiYWIdE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZTriy4ST4/tr+p76SmvPvBNXfc341aGJtFMJH07TPtzxChrMXWUuXoxCE/8cziQsX
	 FozkQ2n/e2N72m6VS9BX9eBfKg0gmZTefbD5IVg1UTTOn9T0a4uGyNA4KDQQvDX9w8
	 6IMHSSPwvk7RsmJuJNdEqL3E3Q2Iq2GvNJI42cgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCSOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbfCSOmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:42:12 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077FE20850;
        Tue, 19 Mar 2019 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553006532;
        bh=Gu743qy4OIV2LMjMYn6MzjH4V5Sfb2TTSRtVTiYWIdE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bfx7zwFWPTGXiKa+iItOP0r7n81yXWoyEBES09oWMK8d0ngbBrmw2C49byMMHaB8v
         yeAv5NDYSFUOMybw3OZBBHqvdNYPxt6Lsyl7s3h4RI/5/lWIbu4mqxPQAX4U22F9iZ
         qNmeXCFeBn/zHlnU+IJOiRBICUFPrtB7WFoxweKg=
Date:   Tue, 19 Mar 2019 15:42:09 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "He, Bo" <bo.he@intel.com>
cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: Re: must hold the driver_input_lock in hid_debug_rdesc_show
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
Message-ID: <nycvar.YFH.7.76.1903191541410.19912@cbobk.fhfr.pm>
References: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, He, Bo wrote:

> we see the below kernel panic logs when run suspend resume test with
> usb mouse and usb keyboard connected.
> 
> the scenario is the userspace call the hid_debug_rdesc_show to dump
> the input device while the device is removed. the patch
> hold the driver_input_lock to avoid the race.
> 
> [ 5381.757295] selinux: SELinux:  Could not stat
> /sys/devices/pci0000:00/0000:00:15.0/usb1/1-2/1-2:1.0/0003:03F0:0325.0320/input/input960/input960::scrolllock:
> No such file or directory.
> [ 5382.636498] BUG: unable to handle kernel paging request at 0000000783316040
> [ 5382.651950] CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
> [ 5382.663797] RIP: 0010:hid_dump_device+0x9b/0x160
> [ 5382.758853] Call Trace:
> [ 5382.761581]  hid_debug_rdesc_show+0x72/0x1d0
> [ 5382.766343]  seq_read+0xe0/0x410
> [ 5382.769941]  full_proxy_read+0x5f/0x90
> [ 5382.774121]  __vfs_read+0x3a/0x170
> [ 5382.788392]  vfs_read+0xa0/0x150
> [ 5382.791984]  ksys_read+0x58/0xc0
> [ 5382.801404]  __x64_sys_read+0x1a/0x20
> [ 5382.805483]  do_syscall_64+0x55/0x110
> [ 5382.809559]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>

I rewrote the changelog to explain the situation a bit more clearly, and 
applied. Thanks,

-- 
Jiri Kosina
SUSE Labs

