Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F2ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAB2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436547AbfJQNhz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:37:55 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:50678 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfJQNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:37:55 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 09:37:54 EDT
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id DB8BD6000055
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:31:42 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id B01026000053
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:31:42 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Thu, 17 Oct 2019 15:31:42 +0200
Message-Id: <5DA86D3D020000A10003462F@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Thu, 17 Oct 2019 15:31:41 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-kernel@vger.kernel.org>
Subject: Issue with reading sysfs files
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wrote a simple tool to browse sysfs.

However I noticed that there are some files having "r" (read) permission, but when you actually try to read from those, I get an I/O error.
So I wonder whether the actual read was forgotten to implement, or the read permission should be gone actually.

It seems to be implemented correctly in uevent, like
# ll /sys/module/drm/uevent
--w------- 1 root root 4096 Sep 24 12:24 /sys/module/drm/uevent

but it is not (e.g.) for
# ll /sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1/event1/power/autosuspend_delay_ms
-rw-r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1/event1/power/autosuspend_delay_ms
# cat /sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1/event1/power/autosuspend_delay_ms
cat: '/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1/event1/power/autosuspend_delay_ms': Input/output error

Here's a summary of such candidates:
.../power/autosuspend_delay_ms
# ll /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/host2/rport-2:0-0/target2:0:0/2:0:0:1/block/sdb/queue/wbt_lat_usec
-rw-r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/host2/rport-2:0-0/target2:0:0/2:0:0:1/block/sdb/queue/wbt_lat_usec
# cat /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/host2/rport-2:0-0/target2:0:0/2:0:0:1/block/sdb/queue/wbt_lat_usec
cat: '/sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/host2/rport-2:0-0/target2:0:0/2:0:0:1/block/sdb/queue/wbt_lat_usec': Invalid argument

# ll /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/resource0
-rw------- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/resource0
# cat /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/resource0
cat: '/sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/resource0': Input/output error

/sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/resource2_wc

# ll /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/rom
-rw------- 1 root root 262144 Sep 26 14:03 /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/rom
# cat /sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/rom
cat: '/sys/devices/pci0000:00/0000:00:03.1/0000:01:00.0/rom': Invalid argument

# ll /sys/devices/pci0000:80/0000:80:01.1/0000:81:00.0/net/em1/phys_port_id
-r--r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:80/0000:80:01.1/0000:81:00.0/net/em1/phys_port_id
# cat /sys/devices/pci0000:80/0000:80:01.1/0000:81:00.0/net/em1/phys_port_id
cat: '/sys/devices/pci0000:80/0000:80:01.1/0000:81:00.0/net/em1/phys_port_id': Operation not supported

.../net/em1/phys_port_name
.../net/em1/phys_switch_id

# ll /sys/devices/pci0000:80/0000:80:01.2/0000:82:00.0/0000:83:00.0/graphics/fb0/bl_curve
-rw-r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:80/0000:80:01.2/0000:82:00.0/0000:83:00.0/graphics/fb0/bl_curve
# cat /sys/devices/pci0000:80/0000:80:01.2/0000:82:00.0/0000:83:00.0/graphics/fb0/bl_curve
cat: '/sys/devices/pci0000:80/0000:80:01.2/0000:82:00.0/0000:83:00.0/graphics/fb0/bl_curve': No such device

# ll /sys/devices/pci0000:80/0000:80:08.1/0000:86:00.2/ata1/host1/scsi_host/host1/em_buffer
-rw-r--r-- 1 root root 4096 Oct 17 15:25 /sys/devices/pci0000:80/0000:80:08.1/0000:86:00.2/ata1/host1/scsi_host/host1/em_buffer
# cat /sys/devices/pci0000:80/0000:80:08.1/0000:86:00.2/ata1/host1/scsi_host/host1/em_buffer
cat: '/sys/devices/pci0000:80/0000:80:08.1/0000:86:00.2/ata1/host1/scsi_host/host1/em_buffer': Invalid argument

.../em_message

# ll /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/scsi_host/host0/fw_crash_buffer
-rw-r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/scsi_host/host0/fw_crash_buffer
# cat /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/scsi_host/host0/fw_crash_buffer
cat: '/sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/scsi_host/host0/fw_crash_buffer': Invalid argument

# ll /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/target0:2:0/0:2:0:0/block/sda/sda1/trace/act_mask
-rw-r--r-- 1 root root 4096 Sep 26 14:03 /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/target0:2:0/0:2:0:0/block/sda/sda1/trace/act_mask
# cat /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/target0:2:0/0:2:0:0/block/sda/sda1/trace/act_mask
cat: '/sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/host0/target0:2:0/0:2:0:0/block/sda/sda1/trace/act_mask': No such device or address

.../block/sda/sda1/trace/enable
.../block/sda/sda1/trace/end_lba
.../block/sda/sda1/trace/pid
.../block/sda/sda1/trace/start_lba

# ll /sys/devices/virtual/net/lo/duplex
-r--r--r-- 1 root root 4096 Sep 24 12:30 /sys/devices/virtual/net/lo/duplex
# cat /sys/devices/virtual/net/lo/duplex
cat: /sys/devices/virtual/net/lo/duplex: Invalid argument

# ll /sys/devices/virtual/net/lo/name_assign_type
-r--r--r-- 1 root root 4096 Sep 24 12:24 /sys/devices/virtual/net/lo/name_assign_type
# cat /sys/devices/virtual/net/lo/name_assign_type
cat: /sys/devices/virtual/net/lo/name_assign_type: Invalid argument

/sys/devices/virtual/net/lo/speed

Found in 4.12.14-95.6-default of SLES SP4 (x86_64)

Regards,
Ulrich


