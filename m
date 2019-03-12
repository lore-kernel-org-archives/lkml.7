Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B372214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WeI1yK2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCLFBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:01:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42515 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfCLFBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:01:50 -0400
Received: by mail-io1-f65.google.com with SMTP id c4so936850ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8A/b+lgWtNf3Nkqz+fOEISGGB+20et4JBsACewUU8Ds=;
        b=WeI1yK2KE4J2GI64AQH1VgJIMvFvITP+9eezNGYVDypPJW83iZCucqasi8tfn7Qlmn
         wId80A2OMzOacFN6H4W2SL0NFRLJuMwvI7QyGiTU0YLu8393BScQJKMxO40CcxWiTTZ0
         JJLWTKbJh98Ff4AvZNuTfrBt+gbmOn3XNB9UR/+E7X7CrKIpyIKzfQ8IY34K5w/X8A3B
         h4VOciDtB17zNgppuCSaXzv+zIl/MuG5b6nw+C5DfGs8lPiQbZKmybTKJIPwAicSh2yw
         +4KivRB7zzINfJ6KLqlgtJmnmfeA7DYASat+AnbR9MTPmoslWhn6GxrOVTVBbNxUpSl+
         UmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8A/b+lgWtNf3Nkqz+fOEISGGB+20et4JBsACewUU8Ds=;
        b=NoxRfq9imfDGPqS/h0S0nCnjjgFPvd+tBLBhZlVqqBdd7reen4qlCvS2RcdVvZFLhv
         zpVXixZyOrjz1h01xd6u5TdRgLIVj9ZV5hmSYSODTNu9FzTTLvyvWftdRkSxp6JnlnUX
         XFpLzdGjJnfBp+5NmGzRhExNxG+dtd9JMJjUFe5FbNEaO6IF4yvE4i/c9l3vekEldBi5
         M/8cEZd5o/u7zQ7ydPgNimut/BN4uXNMfBNuSmTqYo/I3/2Zo3hfV5sTqTapI9a/tipJ
         tQh1Dqkhq1w3ZJPrZtZJAMnXozfaKpEOSve5EG6nEbXvxQKXmIh3bfGLxqzf9YVeMZLK
         hDKA==
X-Gm-Message-State: APjAAAX3tEEQJEKfiLUyF0ToGP+qe/TCjP64IZPYUU9dNHIE3IrNvMcx
        xBsPBBXla7hMm8eZ1Y4XI77xGa5Np74CWMuL7oZR1Cje9as=
X-Google-Smtp-Source: APXvYqw+o1U8feJZ8m/b3/gxt1wvmH9eSUSQOj0Rn1prjE0c9oRU+KrDE+06+zySWyscFoq/IxHNWL8P2KtDK+ZMTMk=
X-Received: by 2002:a5d:8903:: with SMTP id b3mr18769341ion.162.1552366908728;
 Mon, 11 Mar 2019 22:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190308041210.84518-1-chiu@endlessm.com>
In-Reply-To: <20190308041210.84518-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 12 Mar 2019 13:01:37 +0800
Message-ID: <CAB4CAwewnQx9bkY=MpJBx4jV94tnysczS0ygOwa0hSh8FSo1Nw@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix a null pointer dereference for ACPI devices
To:     joro@8bytes.org, iommu@lists.linux-foundation.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:12 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> On ASUS laptop X512DK with the realtek USB card reader, the NULL
> pointer dereference happens while bringing up the rtsx_usb driver.
>
> [    1.782281] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000090
> [    1.782283] PGD 0 P4D 0
> [    1.782285] Oops: 0000 [#1] SMP NOPTI
> [    1.782287] CPU: 6 PID: 290 Comm: systemd-udevd Not tainted 4.20.0-2-g=
eneric #3+dev91.add2285bem1
> [    1.782288] Hardware name: ASUSTeK COMPUTER INC. VivoBook_ASUSLaptop X=
512DK_X512DK/X512DK, BIOS X512DK.200 01/04/2019
> [    1.782292] RIP: 0010:acpi_device_hid+0x6/0x30
> [    1.782293] Code: ff ff 5b 31 c0 41 5c 5d c3 49 8b 84 24 20 02 00 00 4=
8 85 c0 74 e4 48 8b 40 38 48 85 c0 75 d3 eb d9 90 90 90 0f 1f 44 00 00 55 <=
48> 8b 97 90 00 00 00 48 8d 8f 90 00 00 00 48 c7 c0 f7 4a ba b9 48
> [    1.782294] RSP: 0018:ffffb1c40209f7a8 EFLAGS: 00010246
> [    1.782295] RAX: 0000000000000000 RBX: ffff9ed23446b200 RCX: 000000000=
0000000
> [    1.782296] RDX: ffff9ed22ab23010 RSI: 0000000000000001 RDI: 000000000=
0000000
> [    1.782297] RBP: ffffb1c40209f7e0 R08: 0000000000000000 R09: 000000000=
0000228
> [    1.782297] R10: 0000000000000000 R11: ffff9ed2288c5ed8 R12: fffffffff=
ffffff0
> [    1.782298] R13: ffff9ed22ab23010 R14: 0000000000000000 R15: 000000000=
0000000
> [    1.782299] FS:  00007f9aa61988c0(0000) GS:ffff9ed234b80000(0000) knlG=
S:0000000000000000
> [    1.782300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.782300] CR2: 0000000000000090 CR3: 00000002aaafc000 CR4: 000000000=
03406e0
> [    1.782301] Call Trace:
> [    1.782307]  ? check_device.part.19+0x5e/0x140
> [    1.782308]  amd_iommu_add_device+0x2d/0x4a0
> [    1.782310]  ? acpi_match_device+0x30/0x70
> [    1.782312]  iommu_bus_notifier+0xc5/0xe0
> [    1.782315]  notifier_call_chain+0x4c/0x70
> [    1.782316]  blocking_notifier_call_chain+0x43/0x60
> [    1.782319]  device_add+0x392/0x6a0
> [    1.782321]  platform_device_add+0x111/0x260
> [    1.782323]  mfd_add_device+0x445/0x570
> [    1.782326]  ? urb_destroy+0x1b/0x40
> [    1.782329]  ? _cond_resched+0x19/0x30
> [    1.782330]  mfd_add_devices+0xab/0x120
> [    1.782333]  rtsx_usb_probe+0x256/0x300 [rtsx_usb]
> [    1.782336]  usb_probe_interface+0xf1/0x300
> [    1.782338]  really_probe+0xfe/0x3b0
> [    1.782339]  driver_probe_device+0xba/0x100
> [    1.782341]  __driver_attach+0xe4/0x110
> [    1.782343]  ? driver_probe_device+0x100/0x100
> [    1.782345]  bus_for_each_dev+0x79/0xc0
> [    1.782347]  ? kmem_cache_alloc_trace+0x15e/0x1e0
> [    1.782348]  driver_attach+0x1e/0x20
> [    1.782350]  bus_add_driver+0x159/0x230
> [    1.782351]  driver_register+0x70/0xc0
> [    1.782353]  usb_register_driver+0x7f/0x140
> [    1.782356]  rtsx_usb_driver_init+0x23/0x1000 [rtsx_usb]
> [    1.782359]  do_one_initcall+0x4a/0x1c4
> [    1.782377] localhost kernel: RIP: 0033:0x7f9aa6806299
> [    1.782379] localhost kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 0=
0 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8=
b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 6b 0c 00 f7 d8 64=
 89 01 48
> [    1.782379] localhost kernel: RSP: 002b:00007fff6471bd48 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000139
> [    1.782380] localhost kernel: RAX: ffffffffffffffda RBX: 000056264b3ba=
4a0 RCX: 00007f9aa6806299
> [    1.782381] localhost kernel: RDX: 0000000000000000 RSI: 00007f9aa670a=
cad RDI: 000000000000000e
> [    1.782381] localhost kernel: RBP: 00007f9aa670acad R08: 0000000000000=
000 R09: 000056264b3ba4a0
> [    1.782382] localhost kernel: R10: 000000000000000e R11: 0000000000000=
246 R12: 0000000000000000
> [    1.782383] localhost kernel: R13: 000056264b3acc10 R14: 0000000000020=
000 R15: 000056264b3ba4a0
> [    1.782384] localhost kernel: Modules linked in: rtsx_usb(+) uas usb_s=
torage hid_multitouch hid_generic amdgpu(+) chash amd_iommu_v2 gpu_sched i2=
c_algo_bit serio_raw drm_kms_helper syscopyarea ahci sysfillrect sysimgblt =
fb_sys_fops libahci ttm drm wmi video i2c_hid hid
> [    1.782391] localhost kernel: CR2: 0000000000000090
> [    1.782392] localhost kernel: ---[ end trace ba1c82e36e279e13 ]---
>
> The reason is the card reader attached to the USB and doesn't have
> corresponding ACPI device. So the ACPI_COMPANION(dev) passed to
> acpi_device_hid() is NULL which results in null derefernce at the
> consequent device->pnp.ids.
>
> Fix this by validating the ACPI companion of the device first.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/iommu/amd_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1167ff0416cf..7737d184a185 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -168,6 +168,9 @@ static inline int get_acpihid_device_id(struct device=
 *dev,
>  {
>         struct acpihid_map_entry *p;
>
> +       if (!has_acpi_companion(dev))
> +               return -ENODEV;
> +
>         list_for_each_entry(p, &acpihid_map, list) {
>                 if (!match_hid_uid(dev, p)) {
>                         if (entry)
> --
> 2.20.1
>

Gentle ping. Any comments or suggestions? Thanks.

Chris
