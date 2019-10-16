Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE01FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FC320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ndf5ytWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406851AbfJPWEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:04:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387945AbfJPWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571263459;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ht56pow+7hHw9PkEuutZWXs4JG9Pm3nm9+CAX9wBhmU=;
        b=Ndf5ytWyhwvqCZtL1eRAHbW3m4kdZa00nmJ4BjyWsPwD38bbL9zezaMiz3XhCC5mO4grIG
        arReqPhusfiYDIR7MNYv9CCv85t54VokXXBLsRBhNGSNdUjzup+ASeSexmYxVxc0gtGe11
        dKgc44q0WoUr7/rO3P2xTiA9NO5F5Dw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-jWWDyWrPO9aBReDhXPIEQA-1; Wed, 16 Oct 2019 18:04:18 -0400
Received: by mail-io1-f70.google.com with SMTP id q11so33181ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 15:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kj70mauJvZOpd/TGWZLioMkjLh4i7juGQ9MH3JKRYp8=;
        b=Ga83vBRbVWixWFpr+iL8C9eEK5W2UJQMQRqtRlLqkJwDlLt7V+9DhibxCC2bXo99OO
         4A0WRF/RcyUcwp6U9TSWHtvObky6ZZ/6kqD/GiChE3RtD5vfJTQHGmn37zLQabrbh3pd
         kX5eFvNCQZ5YE+MtNZ1NQggzKQgMuLM4ViMqOpI2NZMCbb8CyATVfOonbknFdHvKfSqU
         B9WnoTZXM1EqqGurTVafFVeRdyQU27lhMCSvGBN98nQ14W/WNkT3gzfnTnjVRBYEiZVE
         Qctq199LAIA59ZyqX8tHuD7ulM7inojuPh0hJze1DBbF0xGzg19MVLj4HHNyLOISpThu
         k1rg==
X-Gm-Message-State: APjAAAXkTHMMM1Pxahwzj6miGE6+JllOReW2JITU3AWWvSN/rWut1LYW
        7mXxAd6VCANwg44c5op+SunVcj/3yOz2q9spgdzzWF+Oy+6VtU+AY05BtYBw2FhPH0QzktXtFv4
        wSL/PY6lDwG8889dgFtzmhoy8
X-Received: by 2002:a92:d68c:: with SMTP id p12mr105833iln.89.1571263457428;
        Wed, 16 Oct 2019 15:04:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2n9fNqx+DgjljfcPTCFSsOSULZy7Jj1xvkVK0JMwFYEs+vGr6R1mtvp72rlXSkFkxpGvpaQ==
X-Received: by 2002:a92:d68c:: with SMTP id p12mr105802iln.89.1571263457096;
        Wed, 16 Oct 2019 15:04:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r138sm7729iod.59.2019.10.16.15.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 15:04:16 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:04:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     jroedel@suse.de, don.brace@microsemi.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Message-ID: <20191016220415.cbam7qk3pxjmw4gi@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Qian Cai <cai@lca.pw>, jroedel@suse.de,
        don.brace@microsemi.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1571254542-13998-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
In-Reply-To: <1571254542-13998-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
X-MC-Unique: jWWDyWrPO9aBReDhXPIEQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 16 19, Qian Cai wrote:
>After the commit 754265bcab78 ("iommu/amd: Fix race in
>increase_address_space()"), it could still possible trigger a race
>condition under some heavy memory pressure below. The race to trigger a
>warning is,
>
>CPU0:=09=09=09=09CPU1:
>in alloc_pte():=09=09in increase_address_space():
>while (address > PM_LEVEL_SIZE(domain->mode)) [1]
>
>=09=09=09=09spin_lock_irqsave(&domain->lock
>=09=09=09=09domain->mode    +=3D 1;
>=09=09=09=09spin_unlock_irqrestore(&domain->lock
>
>in increase_address_space():
>spin_lock_irqsave(&domain->lock
>if (WARN_ON_ONCE(domain->mode =3D=3D PAGE_MODE_6_LEVEL))
>
>[1] domain->mode =3D 5
>
>It is unclear the triggering of the warning is the root cause of the
>smartpqi offline yet, but let's fix it first by lifting the locking.
>
>WARNING: CPU: 57 PID: 124314 at drivers/iommu/amd_iommu.c:1474
>iommu_map_page+0x718/0x7e0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec0000 flags=3D0x0010]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec1000 flags=3D0x0010]
>CPU: 57 PID: 124314 Comm: oom01 Tainted: G           O
>Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
>07/10/2019
>RIP: 0010:iommu_map_page+0x718/0x7e0
>Code: 88 a5 70 ff ff ff e9 5d fa ff ff 48 8b b5 70 ff ff ff 4c 89 ef e8
>08 32 2f 00 41 80 fc 01 0f 87 b7 3d 00 00 41 83 e4 01 eb be <0f> 0b 48
>8b b5 70 ff ff ff 4c 89 ef e8 e7 31 2f 00 eb dd 0f 0b 48
>RSP: 0018:ffff888da4816cb8 EFLAGS: 00010046
>RAX: 0000000000000000 RBX: ffff8885fe689000 RCX: ffffffff96f4a6c4
>RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8885fe689124
>RBP: ffff888da4816da8 R08: ffffed10bfcd120e R09: ffffed10bfcd120e
>R10: ffffed10bfcd120d R11: ffff8885fe68906b R12: 0000000000000000
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec1a00 flags=3D0x0010]
>R13: ffff8885fe689068 R14: ffff8885fe689124 R15: 0000000000000000
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec1e00 flags=3D0x0010]
>FS:  00007f29722ba700(0000) GS:ffff88902f880000(0000)
>knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007f27f82d8000 CR3: 000000102ed9c000 CR4: 00000000003406e0
>Call Trace:
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec2000 flags=3D0x0010]
> map_sg+0x1ce/0x2f0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec2400 flags=3D0x0010]
> scsi_dma_map+0xd7/0x160
> pqi_raid_submit_scsi_cmd_with_io_request+0x1b8/0x420 [smartpqi]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec2800 flags=3D0x0010]
> pqi_scsi_queue_command+0x8ab/0xe00 [smartpqi]
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec2c00 flags=3D0x0010]
> scsi_queue_rq+0xd19/0x1360
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec3000 flags=3D0x0010]
> __blk_mq_try_issue_directly+0x295/0x3f0
>smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0000
>address=3D0xffffffffffec3400 flags=3D0x0010]
>AMD-Vi: Event logged [IO_PAGE_FAULT device=3D23:00.0 domain=3D0x0000
>address=3D0xffffffffffec3800 flags=3D0x0010]
> blk_mq_request_issue_directly+0xb5/0x100
>AMD-Vi: Event logged [IO_PAGE_FAULT device=3D23:00.0 domain=3D0x0000
>address=3D0xffffffffffec3c00 flags=3D0x0010]
> blk_mq_try_issue_list_directly+0xa9/0x160
> blk_mq_sched_insert_requests+0x228/0x380
> blk_mq_flush_plug_list+0x448/0x7e0
> blk_flush_plug_list+0x1eb/0x230
> blk_finish_plug+0x43/0x5d
> shrink_node_memcg+0x9c5/0x1550
>smartpqi 0000:23:00.0: controller is offline: status code 0x14803
>smartpqi 0000:23:00.0: controller offline
>
>Fixes: 754265bcab78 ("iommu/amd: Fix race in increase_address_space()")
>Signed-off-by: Qian Cai <cai@lca.pw>
>---
>
>BTW, Joerg, this line from the commit "iommu/amd: Remove domain->updated" =
looks
>suspicious. Not sure what the purpose of it.
>
>*updated =3D increase_address_space(domain, gfp) || *updated;
>

Looking at it again I think that isn't an issue really, it would just
not lose updated being set in a previous loop iteration, but now
I'm wondering about the loop itself. In the cases where it would return
false, how does the evaluation of the condition for the while loop
change?

> drivers/iommu/amd_iommu.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..a5754068aa29 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1465,12 +1465,9 @@ static void free_pagetable(struct protection_domain=
 *domain)
> static bool increase_address_space(struct protection_domain *domain,
> =09=09=09=09   gfp_t gfp)
> {
>-=09unsigned long flags;
> =09bool ret =3D false;
> =09u64 *pte;
>
>-=09spin_lock_irqsave(&domain->lock, flags);
>-
> =09if (WARN_ON_ONCE(domain->mode =3D=3D PAGE_MODE_6_LEVEL))
> =09=09/* address space already 64 bit large */
> =09=09goto out;
>@@ -1487,8 +1484,6 @@ static bool increase_address_space(struct protection=
_domain *domain,
> =09ret =3D true;
>
> out:
>-=09spin_unlock_irqrestore(&domain->lock, flags);
>-
> =09return ret;
> }
>
>@@ -1499,14 +1494,19 @@ static u64 *alloc_pte(struct protection_domain *do=
main,
> =09=09      gfp_t gfp,
> =09=09      bool *updated)
> {
>+=09unsigned long flags;
> =09int level, end_lvl;
> =09u64 *pte, *page;
>
> =09BUG_ON(!is_power_of_2(page_size));
>
>+=09spin_lock_irqsave(&domain->lock, flags);
>+
> =09while (address > PM_LEVEL_SIZE(domain->mode))
> =09=09*updated =3D increase_address_space(domain, gfp) || *updated;
>
>+=09spin_unlock_irqrestore(&domain->lock, flags);
>+
> =09level   =3D domain->mode - 1;
> =09pte     =3D &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> =09address =3D PAGE_SIZE_ALIGN(address, page_size);
>--=20
>1.8.3.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

