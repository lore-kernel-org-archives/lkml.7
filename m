Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0622C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9720857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2RIDpFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfDBKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:08:48 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40807 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfDBKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:08:47 -0400
Received: by mail-ed1-f42.google.com with SMTP id h22so11096272edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hM/V1Uq/1yAabAAkSZVY+jlW6yenEpfKWKsRMpyLU0w=;
        b=c2RIDpFXbpk9OZCrGoRUjMxouPD1dFAc+L9gYIVhc4n9JdmSRVCIrjzusaPhmCsEda
         x34yHX0Rgec7iYM3zyQatJ0fYCdRi3GfrMI4VNqJi0bSF6NAqTdh6F37HpmRbMSmdSRw
         KrumdfuTTgtCdPJF3Q5rRTSRpwqK5XUgnieKbNquvdgJ9m7ASZY9kflVlRclrsezsZhZ
         jKlDpJy6p620QS1UtMt/PcnnuA5wEtTVkHiLVG68mS1AEbgXnrSJ/Yiyv4swd+SgHfgJ
         0qxV5XnydanDwt1HKTMThdCMz1pp4eKeg39LMx8Ooz2sL6XRfoVoGE5MNJoad3ZQyjxD
         /IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hM/V1Uq/1yAabAAkSZVY+jlW6yenEpfKWKsRMpyLU0w=;
        b=n75enYCKwa2RIkbCg+Dxg+g/d+rlnW4GNkWSGXNh6ktgficdIbBV7aKxiOeh3a3KfH
         SqUhVXgouyWmlROwyX374ALYgSE137x9LQjPDbNH7QOk8uabhQsGmAgKVtTAgK1+CW50
         gbuQVrfqnDz6GCIbNo//zeM3Y4FrOMTKf8cS4oBGrBqcJFXeokHoHkhBZEG6MsQeKu/r
         2g8cJOExgZqkLX2U2hos2rzyK/gqZSZLR2MxvypwR0tJsZ2gT+dNbYR/4ypzB4xpzAB6
         ylonBhey+ZQo+fX+7dZCa3BOO0/e4wktTzImVau4DnkfINYyiBsyO0FHHRBty8wE0KVa
         DvHg==
X-Gm-Message-State: APjAAAWqBZL3bl9YBB01FvQSKIyMWkVe4F2YlbWErpO7aepXmQVMJRUT
        uT3LyRpr3h+7lzaxZ3+JLwnQE5TA6m7O2mEHyeU=
X-Google-Smtp-Source: APXvYqzpPU6KyXEfrEPh0vh+EYRBs/6Kh0hbUyXi+qeSKgr0DWAYAgmV4U1vhbEGbhCWKZiMF/HrMVs6dNvGpAUguf4=
X-Received: by 2002:a50:a705:: with SMTP id h5mr36665432edc.226.1554199725901;
 Tue, 02 Apr 2019 03:08:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:aedc:0:0:0:0:0 with HTTP; Tue, 2 Apr 2019 03:08:45 -0700 (PDT)
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Tue, 2 Apr 2019 13:08:45 +0300
Message-ID: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
Subject: ext3 file system livelock and file system corruption, 4.9.166 stable kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To trigger this ext4 file system bug, you need a sparse file with
correct sparse pattern on old-school ext3 file system. I tried
more simpler ways to trigger this but those attempts did not
trigger the bug. I have provided compressed sparse file that
reliably triggers the bug. Size of compressed sparse file 1667256
bytes. Size of uncompressed sparse file 7369850880 bytes.
Following commands will demo the problem.

  wget http://www.elisanet.fi/jariruusu/123/sparse-demo.data.xz
  xz -d sparse-demo.data.xz
  mkfs -t ext3 -b 4096 -e remount-ro -O "^dir_index" /dev/sdc1
  mount -t ext3 /dev/sdc1 /mnt
  cp -v --sparse=always sparse-demo.data /mnt/aa
  cp -v --sparse=always sparse-demo.data /mnt/bb
  umount /mnt
  mount -t ext3 /dev/sdc1 /mnt
  cp -v --sparse=always /mnt/bb /mnt/aa

That last cp command reliably triggers the bug that livelocks and
after reset you have file system corruption to deal with. Deeply
unfunny.

The bug is caused by
"ext4: brelse all indirect buffer in ext4_ind_remove_space()"
upstream commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217, from
<yi.zhang@huawei.com>, who provided a follow-up patch
"ext4: cleanup bh release code in ext4_ind_remove_space()"
upstream commit 5e86bdda41534e17621d5a071b294943cae4376e. The
problem with that follow-up patch is that it is almost criminally
mislabeled. It should have said "fixes ext3 livelock and file
system corrupting bug" or something like that, so that Greg KH &
Co would have understood that it must be backported to stable
kernels too. Now the bug appears to be in all/most stable kernels
already.

Below is the buggy patch that causes the problem. Look at those
new while loops. Once the while condition is true once, it is
ALWAYS true, so it livelocks.

> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -1385,10 +1385,14 @@ end_range:
>  					   partial->p + 1,
>  					   partial2->p,
>  					   (chain+n-1) - partial);
> -			BUFFER_TRACE(partial->bh, "call brelse");
> -			brelse(partial->bh);
> -			BUFFER_TRACE(partial2->bh, "call brelse");
> -			brelse(partial2->bh);
> +			while (partial > chain) {
> +				BUFFER_TRACE(partial->bh, "call brelse");
> +				brelse(partial->bh);
> +			}
> +			while (partial2 > chain2) {
> +				BUFFER_TRACE(partial2->bh, "call brelse");
> +				brelse(partial2->bh);
> +			}
>  			return 0;
>  		}
>

Greg & Co,
Please revert that above patch from stable kernels or backport the
follow-up patch that fixes the problem.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
