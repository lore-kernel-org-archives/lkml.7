Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF4C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D430D20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwbtJfTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfLQSEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:04:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727795AbfLQSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576605847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yL6Wx8FJbF1cfEPKDHMY+SffPQ768eqZ6To0Cyt4DDY=;
        b=MwbtJfTVGCNLUYdTzj+kxVyf9ohHxhxL+DA2susDCXJcFYvka7LNG8drRnNqTWWDPdoPO6
        BeSZFxtuzIKk7b55bA8KkkshBj7qR8ruMrF3L+/wEN7aQn7shgQHr2Dg6OfxMkTUnFXrq5
        Vr9amDaMvp4rNBPmY6FpN/145KW/b6Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-ds02HPUDMkmX-AycmepGeQ-1; Tue, 17 Dec 2019 13:04:04 -0500
X-MC-Unique: ds02HPUDMkmX-AycmepGeQ-1
Received: by mail-lj1-f198.google.com with SMTP id k25so3520033lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yL6Wx8FJbF1cfEPKDHMY+SffPQ768eqZ6To0Cyt4DDY=;
        b=EJQ2rSogUP+QQVnPhjsPQz5U4gF4QtVC7Fwk38ThJ3+oHI12EuaK4Gx+KSD64gtDQG
         A0DgzalTifXN6ASMsNJmY0apy9YnsYfxHoTYOBgLO5Dgyzcl6ZEGX1IuM8UzF0TCH4WY
         1vStXEDm6Kd9k2LpsuPqIgN1FJpkLP5XQHW1aZgA2Rw/jNBKL9+4M7LZjxKHpOz3dbZs
         Wv0wOIbz5sKxBar8SMwRbWAmtWT5BWGe6PqNcVL2Aks/Cntm2jYgb7mpnPDz/aEPMsEd
         1oT/VKNIR3ALu+qktWNvnCMyd4GTYu9UUp226Ym3lA14A4SBFfUgAZtaPI+E1s84Db8F
         8CNg==
X-Gm-Message-State: APjAAAX+6VyImpRz1d+o9WDx8ibbdpHKUIk4dG29NlCmo7oO8FJJk9CS
        Kz+G5biYnZVC4flVVd9EFs8HfhOdJQ5sQsK/Lc1NoVW4rtH4ZxlzRKA1XlPe8gHNqCuHHy96sjZ
        i6OlPUsE174QBKOPwhx5Q4iZu3j/hKrYkPPAK5X5Y
X-Received: by 2002:a2e:7816:: with SMTP id t22mr4258296ljc.161.1576605842620;
        Tue, 17 Dec 2019 10:04:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyswWy+yH0PjzzvoBt11sI4/79C9b2ATVCClJQNBw86mNMm+HVqSDbs50hEbZEkfwQtHvPXmfdhrTndG0GJKtg=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr4258268ljc.161.1576605842388;
 Tue, 17 Dec 2019 10:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20191217175542.22187-1-jsnitsel@redhat.com>
In-Reply-To: <20191217175542.22187-1-jsnitsel@redhat.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 17 Dec 2019 11:03:36 -0700
Message-ID: <CALzcddvM23DAFX9JbW-GOHjZBsKprmbG=QsT94uMnST3asFDMA@mail.gmail.com>
Subject: Re: [RFC PATCH] iommu/vt-d: avoid panic in __dmar_remove_one_dev_info
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:56 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> In addition to checking for a null pointer, verify that
> info does not have the value DEFER_DEVICE_DOMAIN_INFO or
> DUMMY_DEVICE_DOMAIN_INFO. If info has one of those values
> __dmar_remove_one_dev_info will panic when trying to access
> a member of the device_domain_info struct.
>
>     [    1.464241] BUG: unable to handle kernel NULL pointer dereference at 000000000000004e
>     [    1.464241] PGD 0 P4D 0
>     [    1.464241] Oops: 0000 [#1] SMP PTI
>     [    1.464241] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        --------- -  - 4.18.0-160.el8.x86_64 #1
>     [    1.464241] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
>     [    1.464241] RIP: 0010:__dmar_remove_one_dev_info+0x27/0x250
>     [    1.464241] Code: 00 00 00 0f 1f 44 00 00 8b 05 35 ec 75 01 41 56 41 55 41 54 55 53 85 c0 0f 84 99 01 00 00 48 85 ff 0f 84 92 01 00 00 48 89 fb <4c> 8b 67 50 48 8b 6f 58 $
>     [    1.464241] RSP: 0000:ffffc900000dfd10 EFLAGS: 00010082
>     [    1.464241] RAX: 0000000000000001 RBX: fffffffffffffffe RCX: 0000000000000000
>     [    1.464241] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffffffffffffe
>     [    1.464241] RBP: ffff88ec7a72f368 R08: 0000000000000457 R09: 0000000000000039
>     [    1.464241] R10: 0000000000000000 R11: ffffc900000dfa58 R12: ffff88ec7a0eec20
>     [    1.464241] R13: ffff88ec6fd0eab0 R14: ffffffff81eae980 R15: 0000000000000000
>     [    1.464241] FS:  0000000000000000(0000) GS:ffff88ec7a600000(0000) knlGS:0000000000000000
>     [    1.464241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [    1.464241] CR2: 000000000000004e CR3: 0000006c7900a001 C 00000000001606b0
>     [    1.464241] Call Trace:
>     [    1.464241]  dmar_remove_one_dev_info.isra.68+0x27/0x40
>     [    1.464241]  intel_iommu_add_device+0x124/0x180
>     [    1.464241]  ? iommu_probe_device+0x40/0x40
>     [    1.464241]  add_iommu_group+0xa/0x20
>     [    1.464241]  bus_for_each_dev+0x77/0xc0
>     [    1.464241]  ? down_write+0xe/0x40
>     [    1.464241]  bus_set_iommu+0x85/0xc0
>     [    1.464241]  intel_iommu_init+0x4b4/0x777
>     [    1.464241]  ? e820__memblock_setup+0x63/0x63
>     [    1.464241]  ? do_early_param+0x91/0x91
>     [    1.464241]  pci_iommu_init+0x19/0x45
>     [    1.464241]  do_one_initcall+0x46/0x1c3
>     [    1.464241]  ? do_early_param+0x91/0x91
>     [    1.464241]  kernel_init_freeable+0x1af/0x258
>     [    1.464241]  ? rest_init+0xaa/0xaa
>     [    1.464241]  kernel_init+0xa/0x107
>     [    1.464241]  ret_from_fork+0x35/0x40
>     [    1.464241] Modules linked in:
>     [    1.464241] CR2: 000000000000004e
>     [    1.464241] ---[ end trace 0927d2ba8b8032b5 ]---
>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: stable@vger.kernel.org # v5.3+
> Cc: iommu@lists.linux-foundation.org
> Fixes: ae23bfb68f28 ("iommu/vt-d: Detach domain before using a private one")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..e42a09794fa2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
>
>         spin_lock_irqsave(&device_domain_lock, flags);
>         info = dev->archdata.iommu;
> -       if (info)
> +       if (info && info != DEFER_DEVICE_DOMAIN_INFO
> +           && info != DUMMY_DEVICE_DOMAIN_INFO)
>                 __dmar_remove_one_dev_info(info);
>         spin_unlock_irqrestore(&device_domain_lock, flags);
>  }
> --
> 2.24.0
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

I'm not positive that the DUMMY_DEVICE_DOMAIN_INFO check is needed.
It seemed like there were checks for that most places before
dmar_remove_one_dev_info
would be called, but I wasn't certain.

