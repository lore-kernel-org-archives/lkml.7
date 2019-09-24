Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207AFC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504591AbfIXLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:16:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409582AbfIXLQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:16:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C7E84DCE110A7735864;
        Tue, 24 Sep 2019 19:16:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Sep 2019
 19:15:57 +0800
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
To:     <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <david.oberhollenzer@sigma-star.at>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <27af8d4f-8653-469f-73bb-d388180d93c9@huawei.com>
Date:   Tue, 24 Sep 2019 19:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
Content-Type: multipart/mixed;
        boundary="------------ED80660566D73B2ABC02FFCD"
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit

After incorporating patches, use overlay usecases to test character device-based base fs, and all overlay usecases are executed:

FSTYP         -- overlay  # FSTYP has be overridden as 'overlay'
PLATFORM      -- Linux/x86_64 localhost
MKFS_OPTIONS  -- /tmp/scratch
MOUNT_OPTIONS -- /tmp/scratch /tmp/scratch/ovl-mnt

overlay/001	[not run] This test requires at least 8GB free on /tmp/scratch to run
overlay/002	 1s
overlay/003	 0s
overlay/004	 0s
overlay/005	 1s
overlay/006	 0s
overlay/007	 0s
overlay/008	 0s
overlay/009	 0s
overlay/010	 0s
overlay/011	 1s
overlay/012	 0s
overlay/013	 0s
overlay/014	 1s
...

Attachments:
setup.sh: Create character device for base fs (UBIFS)
local.config: Xfstests local configuration

ÔÚ 2019/9/24 17:40, Zhihao Cheng Ð´µÀ:
> When running overlay tests using character devices as base fs partitions,
> all overlay usecase results become 'notrun'. Function
> '_overay_config_override' (common/config) detects that the current base
> fs partition is not a block device and will set FSTYP to base fs. The
> overlay usecase will check the current FSTYP, and if it is not 'overlay'
> or 'generic', it will skip the execution.
> 
> For example, using UBIFS as base fs skips all overlay usecases:
> 
>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
> 
>   overlay/001	[not run] not suitable for this filesystem type: ubifs
>   overlay/002	[not run] not suitable for this filesystem type: ubifs
>   overlay/003	[not run] not suitable for this filesystem type: ubifs
>   ...
> 
> When checking that the base fs partition is a block/character device,
> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> partition to be a character device that can also execute overlay
> usecases (such as ubifs).
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  common/config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 4c86a49..a22acdb 100644
> --- a/common/config
> +++ b/common/config
> @@ -550,7 +550,7 @@ _overlay_config_override()
>  	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>  	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>  	#    overlayfs base and mount dirs inside base fs mount.
> -	[ -b "$TEST_DEV" ] || return 0
> +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>  
>  	# Config file may specify base fs type, but we obay -overlay flag
>  	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> @@ -570,7 +570,7 @@ _overlay_config_override()
>  	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>  	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>  
> -	[ -b "$SCRATCH_DEV" ] || return 0
> +	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>  
>  	# Store original base fs vars
>  	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> 

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="UTF-8"; name="local.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="local.config"

export FSTYP=ubifs
export TEST_DEV=/dev/ubi0_0
export TEST_DIR=/tmp/test
export TEST_FS_MOUNT_OPTS="-t ubifs"
export SCRATCH_DEV=/dev/ubi0_1
export SCRATCH_MNT=/tmp/scratch
export MOUNT_OPTIONS="-t ubifs"

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="UTF-8"; name="setup.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="setup.sh"

#!/bin/bash

set -e

TMP=/tmp/test
SMP=/tmp/scratch
umount $TMP $SMP 2>/dev/null || true
mkdir -p $TMP $SMP

modprobe -r ubifs 2>/dev/null || true
for i in $(seq 0 1)
do
	ubidetach -p /dev/mtd$i 2>/dev/null || true
done
modprobe -r ubi 2>/dev/null || true
modprobe -r nandsim 2>/dev/null || true

mtd=/dev/mtd0
ubi=/dev/ubi0

ARCH=$(uname -m)
if test "$ARCH" == ppc || test "$ARCH" == armv7l
then
	# 512MB, 8-bits, page size 4KB, OOB 128B, block 128KB
	ID="0x20,0xac,0x00,0x16"
	TSIZE=128MiB
	SSIZE=350MiB
else
	# 2GB, 8-bits, page size 4KB, OOB 128B, block 128KB
	ID="0x20,0xa5,0x00,0x16"
	TSIZE=400MiB
	SSIZE=1500MiB
fi
modprobe nandsim id_bytes=$ID
flash_erase -q -j $mtd 0 0
modprobe ubi
modprobe ubifs

ubiattach -p $mtd
ubimkvol $ubi -N test -s $TSIZE
ubimkvol $ubi -N scratch -s $SSIZE

exit 0

--------------ED80660566D73B2ABC02FFCD--
