Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3F9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxfgl/v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504946AbfIXMdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:33:37 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43428 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504934AbfIXMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:33:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id q7so546888ywe.10;
        Tue, 24 Sep 2019 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ppbf0GjjcLCC8+XESr5CsIazd9/C/wSsIdEq9i6snq4=;
        b=Gxfgl/v4Uz0X74siTnjFjyr0iu6alwIFn6sFgnibTtA/y00I09UtrBXQqVuxSPAAor
         6P6/Eyo09MTd/fkNYYHU9ysIwD8de4ApJ+lnI/grQTddv/QdepQlP9hj/4x6uHHKfcO1
         6Uc6q7tQBNvHpLZyawiTfdJmnO+5lcSmM4CImvE9eFhy44FwvAPAAGMfRL6hAPjamELT
         M7Me9a8cPDYieczoUyjHJtNfDCgfcOWfrBHgP2ozqMQUIPFlFsRh1BkmWwhRGscySk+g
         54vuiFbxERIbj5JX+I2X7nshpf9fRthyIYviXDjIBgpBPMBORC3kLL3FumiHzEyGqPji
         WU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ppbf0GjjcLCC8+XESr5CsIazd9/C/wSsIdEq9i6snq4=;
        b=PUXXFcarnb/uc5fUMvZXWMiCO1PVxRM6Lr8zHp1EXIMrSahWFO+JENiLTo3yNy3tGs
         QBJePl0T7DvmVkjD12A8ZbxXyR0gnvwmcXR61EVI2MTlisPZZQRKBx2dYyUfrfBpD+8M
         KAzbx1ejA/D07iYQVdGllSVAGkPXHC8425d5o5/qFDnHARUbZLUcHHbQPSnwN4WfP9oJ
         ImC5PIt01LGR5RwrpXz77f66TRZBMln/6eKGu2o6thpoepZCBpfBmSvKuyXaPJnDfSZZ
         DU86ebFNL8dbSK9y7COsx75O08K5MFdUoB+6gt4usYwbVMGvXS4fY38O1q4c9ntTGPFw
         wbwA==
X-Gm-Message-State: APjAAAX0lOLQRFHaujHKEPI/XQZH8cwWOLmr8XQlcza4gtvTxlL6CQJv
        0CbEJ/od7ohK82gbCkYRXPMkPftoLFCwO9pdBbw=
X-Google-Smtp-Source: APXvYqwjG4q9GRUGk57wxOKNpD3JAGN1fkZ7dn1XUtgSFXZm3+d80AM/mL1e1HBSMlyQytPBPr6yEqklsqU8peyXgOA=
X-Received: by 2002:a81:7743:: with SMTP id s64mr1652106ywc.183.1569328416165;
 Tue, 24 Sep 2019 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Sep 2019 15:33:25 +0300
Message-ID: <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
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

On Tue, Sep 24, 2019 at 12:34 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
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
> --
> 2.7.4
>

Looks fine.

One nit: there is a message in _require_scratch_shutdown():
_notrun "$SCRATCH_DEV is not a block device"
for when $OVL_BASE_SCRATCH_DEV is not defined.

Could probably use a better describing error anyway.

Thanks,
Amir.
