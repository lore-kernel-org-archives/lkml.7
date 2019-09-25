Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA932064A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411484AbfIYDP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:15:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58209 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405270AbfIYDP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:15:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TdMZLYy_1569381354;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TdMZLYy_1569381354)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Sep 2019 11:15:54 +0800
Date:   Wed, 25 Sep 2019 11:15:54 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Eric Biggers <ebiggers@google.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
Message-ID: <20190925031554.GA67926@e18g06458.et15sqa>
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
 <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
 <b215554a-092b-fcf3-e0a3-36fab291b4ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b215554a-092b-fcf3-e0a3-36fab291b4ff@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:19:38PM +0800, Zhihao Cheng wrote:
> As far as I know, _require_scratch_shutdown() is called after _overay_config_override(), at this moment, FSTYP equals to base fs. According the implementation of _require_scratch_shutdown:
> 3090 _require_scratch_shutdown()
> 3091 {
> 3092     [ -x src/godown ] || _notrun "src/godown executable not found"
> 3093
> 3094     _scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
> 3095     _scratch_mount
> 3096
> 3097     if [ $FSTYP = "overlay" ]; then                                            # FSTYP = base fs
> 3098         if [ -z $OVL_BASE_SCRATCH_DEV ]; then
> 3099             # In lagacy overlay usage, it may specify directory as
> 3100             # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
> 3101             # will be null, so check OVL_BASE_SCRATCH_DEV before
> 3102             # running shutdown to avoid shutting down base fs accidently.
> 3103             _notrun "$SCRATCH_DEV is not a block device"
> 3104         else
> 3105             src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
> 3106             || _notrun "Underlying filesystem does not support shutdown"
> 3107         fi
> 3108     else
> 3109         src/godown -f $SCRATCH_MNT 2>&1 \
> 3110             || _notrun "$FSTYP does not support shutdown"                      # Executes this path
> 3111     fi
> 3112
> 3113     _scratch_unmount
> 3114 }
> So, we can't get output: _notrun "$SCRATCH_DEV is not a block device". Instead, the verbose should like:
>   after _overlay_config_override FSTYP=ubifs    # Additional print message
>   FSTYP         -- ubifs
>   PLATFORM      -- Linux/x86_64
>   MKFS_OPTIONS  -- /dev/ubi0_1
>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
> 
>   generic/042	[not run] ubifs does not support shutdown
> 
> But I'll consider describing error more concisely in v2.
> 
> 在 2019/9/24 20:33, Amir Goldstein 写道:
> > On Tue, Sep 24, 2019 at 12:34 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> >>
> >> When running overlay tests using character devices as base fs partitions,
> >> all overlay usecase results become 'notrun'. Function
> >> '_overay_config_override' (common/config) detects that the current base
> >> fs partition is not a block device and will set FSTYP to base fs. The
> >> overlay usecase will check the current FSTYP, and if it is not 'overlay'
> >> or 'generic', it will skip the execution.
> >>
> >> For example, using UBIFS as base fs skips all overlay usecases:
> >>
> >>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
> >>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
> >>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
> >>
> >>   overlay/001   [not run] not suitable for this filesystem type: ubifs
> >>   overlay/002   [not run] not suitable for this filesystem type: ubifs
> >>   overlay/003   [not run] not suitable for this filesystem type: ubifs
> >>   ...
> >>
> >> When checking that the base fs partition is a block/character device,
> >> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> >> partition to be a character device that can also execute overlay
> >> usecases (such as ubifs).
> >>
> >> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> >> ---
> >>  common/config | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/common/config b/common/config
> >> index 4c86a49..a22acdb 100644
> >> --- a/common/config
> >> +++ b/common/config
> >> @@ -550,7 +550,7 @@ _overlay_config_override()
> >>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
> >>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
> >>         #    overlayfs base and mount dirs inside base fs mount.
> >> -       [ -b "$TEST_DEV" ] || return 0
> >> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> >>
> >>         # Config file may specify base fs type, but we obay -overlay flag
> >>         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> >> @@ -570,7 +570,7 @@ _overlay_config_override()
> >>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
> >>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
> >>
> >> -       [ -b "$SCRATCH_DEV" ] || return 0
> >> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> >>
> >>         # Store original base fs vars
> >>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> >> --
> >> 2.7.4
> >>
> > 
> > Looks fine.
> > 
> > One nit: there is a message in _require_scratch_shutdown():
> > _notrun "$SCRATCH_DEV is not a block device"
> > for when $OVL_BASE_SCRATCH_DEV is not defined.
> > 
> > Could probably use a better describing error anyway.

I think what Amir suggested is that, as you add char device support to
overlay base device, the message in _require_scratch_shutdown() should
be updated accordingly, not the commit log.

Thanks,
Eryu
