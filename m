Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C8C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F402082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcJfabqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442536AbfIYHSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:18:52 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45633 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437009AbfIYHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:18:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id x65so407036ywf.12;
        Wed, 25 Sep 2019 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZ3VnberXXl+Q/9IPbdaDqe16sWDnoZalHAnBGlNPH8=;
        b=TcJfabqyz1SZlZ3H3wCoCgPLUSGbyvhaiHjoo6CpV54jCbZO/idllgPrhKdSRbkNZQ
         nCyaJFb+xU1mJUgHhp34wLJ2zTlFgpCORbEyWSZf+MHBdzMzJxHhfp2rf6lUehSjEfTN
         CPCgcq2zi+o0n6/e7UZctT4P5jWh1+WVuzpUbqeXwLuBeci35/QU66exY+JBfHKQbnO2
         Do/UEvudqzHgvecE23eglKK1rf17uS1HUVBR/yUfpAHEfuLsquuUKfzhb67iu+3KFgDu
         JfCv+xg+oa9dwI6ZF44nGv/SY8TXJY7sJILedZxWBZDpqcP5kXpaIKxxme87+h1gikqq
         TYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZ3VnberXXl+Q/9IPbdaDqe16sWDnoZalHAnBGlNPH8=;
        b=qQvZrJrDEgvJ5/616VQ7lmJksXeg/uAd3ozu5dPRgESUS6HJKAckh3H4TbDQpDPeLL
         HfzJg3u8teW8EjDa1YqXmz7HRXN4ktGOgi1XzU4krnEROvANE3uMHfpngIMbFmxLI2YV
         J5sSpnb2fJq9ZLAG9rjOuNgyvvaKCgwe1t7+rrJCIBNL8RsZc1CRr9jhiGSzR+CIgPkV
         7FuWFab0hFXiuwsSK5cOjmWnmH4BIccdujAFGD4HdDq/+kmG/zhQn+UwkYevg7VtZ2/L
         pE5RapkcCVtV1yBTVvjRdqhxI0ysNACPRLOC4xKXP+etsbJX1DgQ6rTSk07vDUKrHhlj
         pZqg==
X-Gm-Message-State: APjAAAVqmTIMJt32XS+O53LHxY9MWmy0b7Q3lVQi0Giu98/9yTP9yc0S
        rm7MG150ylR0+WYLYinIaViyDHHjmW9HtYaFBjE=
X-Google-Smtp-Source: APXvYqxvh6SEBI8yGwwivJ3ovHtuG2rDkCstKV7h4t24bTekVPgiGCtdpI6mDgtvpDSPaI3/QV4WttEj14ANH0Ux+dc=
X-Received: by 2002:a81:54:: with SMTP id 81mr4470004ywa.25.1569395930960;
 Wed, 25 Sep 2019 00:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Sep 2019 10:18:39 +0300
Message-ID: <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v3] overlay: Enable character device to be the
 base fs partition
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Eric Biggers <ebiggers@google.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 9:29 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
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
>   overlay/001   [not run] not suitable for this filesystem type: ubifs
>   overlay/002   [not run] not suitable for this filesystem type: ubifs
>   overlay/003   [not run] not suitable for this filesystem type: ubifs
>
> When checking that the base fs partition is a block/character device,
> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> partition to be a character device that can also execute overlay
> usecases (such as ubifs).
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks fine.
Eryu, you may change this to Reviewed-by

> ---
>  common/config | 6 +++---
>  common/rc     | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/common/config b/common/config
> index 4c86a49..4eda36c 100644
> --- a/common/config
> +++ b/common/config
> @@ -532,7 +532,7 @@ _canonicalize_mountpoint()
>  # When SCRATCH/TEST_* vars are defined in evironment and not
>  # in config file, this function is called after vars have already
>  # been overriden in the previous test.
> -# In that case, TEST_DEV is a directory and not a blockdev and
> +# In that case, TEST_DEV is a directory and not a blockdev/chardev and
>  # the function will return without overriding the SCRATCH/TEST_* vars.
>  _overlay_config_override()
>  {
> @@ -550,7 +550,7 @@ _overlay_config_override()
>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>         #    overlayfs base and mount dirs inside base fs mount.
> -       [ -b "$TEST_DEV" ] || return 0
> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>
>         # Config file may specify base fs type, but we obay -overlay flag
>         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> @@ -570,7 +570,7 @@ _overlay_config_override()
>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>
> -       [ -b "$SCRATCH_DEV" ] || return 0
> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>
>         # Store original base fs vars
>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> diff --git a/common/rc b/common/rc
> index 66c7fd4..8d57c37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3100,7 +3100,7 @@ _require_scratch_shutdown()
>                         # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
>                         # will be null, so check OVL_BASE_SCRATCH_DEV before
>                         # running shutdown to avoid shutting down base fs accidently.
> -                       _notrun "$SCRATCH_DEV is not a block device"
> +                       _notrun "This test requires a valid $OVL_BASE_SCRATCH_DEV as ovl base fs"
>                 else
>                         src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
>                         || _notrun "Underlying filesystem does not support shutdown"
> --
> 2.7.4
>
