Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DF1C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C4C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw0NhKal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfLKO5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:57:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727477AbfLKO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576076232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOuQ0JNluzXcS3sSfSKCvMxG138FinNcrFQnRo2BFGs=;
        b=Hw0NhKal/1L/8fnBIo6bjTWibE8sBeVdLBf8Tj8pUcdtJiZoHutHDdhRGd/n7VmQ3soAts
        zcJ8T3WWs9cLhHXYtJVKzluont4AIsZnrc1eCYWvUQ9bFQ6DdjjqevxgYS9aXHtUU8w4Fa
        ik+iSnIpm0Vz/56h81m+79GQDAom2cA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-y8PPLhooP5WpchM39Zd85A-1; Wed, 11 Dec 2019 09:57:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id f17so10574972wrt.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x0frXpADWjlwzRg+ikQlPyDtpxf8HnEMDPw/wa/ACXo=;
        b=Yp5uOekW2NoD+JtFwMRw4in+irBA/Go90/a8ZAzmjAIEdO7Vie969iItnQEGEB7RvS
         ML70oJq+6T+PqkNF+fQJA8mx5JaRwTrJMxrNXWd27MECaXaT3Laqq+5iGetLFzpdAr3U
         Y18WmTviNrG65po/Gec1jYmBVwvXwUE+8c1Cjwc0DTivB2Kbq2G5U9Y59qjPlIBwxmx6
         Vx1DSTEMPWW8GFwbRfF+XYwX7Q9MIBS4VMuUpbrMrp8ktTRffHrWfuxnHurpV7SpqFhZ
         IWFTTsGDeL/tkU/QOtFyI57N1aNCN17w1C3dgQkUCd4xyFJyqgkvZkXtgEG2GZGQZ3fX
         snEQ==
X-Gm-Message-State: APjAAAXCJchDocApTDm/YJARDWFyxuLEDe+rJtzX7x3guBHKRdKeKlIm
        MQvdh33ZDrYmnvbkW4jeIyUirLaSdQpaFxGWPzc1eKMklPLdZ4OKBUGnP8H/NbBYdMe35P8gCyu
        7d9DXvXi+KvcwqS6ntagvUUTQ
X-Received: by 2002:a5d:6350:: with SMTP id b16mr246578wrw.132.1576076230260;
        Wed, 11 Dec 2019 06:57:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTsGgDClortHCsKXPy1CcyXDH1Pt0j/UZJSpYY+P8+o9yaMcWE6SEBiAAY4QjC/58yGmQ83A==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr246537wrw.132.1576076229967;
        Wed, 11 Dec 2019 06:57:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c9sm2469117wmc.47.2019.12.11.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:57:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.devolder@oracle.com
Subject: Re: [RFC PATCH 3/4] Hyper-V/Balloon: Call add_memory() with dm_device.ha_lock.
In-Reply-To: <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com> <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
Date:   Wed, 11 Dec 2019 15:57:08 +0100
Message-ID: <87pnguc3ln.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: y8PPLhooP5WpchM39Zd85A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> The ha_lock is to protect hot-add region list ha_region_list.
> When Hyper-V delivers hot-add memory message, handle_pg_range()
> goes through the list to find the hot-add region state
> associated with message and do hot-add memory. The lock
> is released in the loop before calling hv_mem_hot_add()
> and is reacquired in hv_mem_hot_add(). There is a race
> that list entry maybe freed during the slot.

Do I understand correctly that without memory hot remove there's no
race? If yes than we should clarify this in the changelog.

>
> To avoid the race and simply the code, make hv_mem_hot_add()
> under protection of ha_region_list lock. There is a dead lock
> case when run add_memory() under ha_lock. add_memory() calls
> hv_online_page() inside and hv_online_page() also acquires
> ha_lock again. Add lock_thread in the struct hv_dynmem_device
> to record hv_mem_hot_add()'s thread and check lock_thread
> in hv_online_page(). hv_mem_hot_add() thread already holds
> lock during traverse hot add list and so not acquire lock
> in hv_online_page().
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 34bd73526afd..4d1a3b1e2490 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -545,6 +545,7 @@ struct hv_dynmem_device {
>  =09 * regions from ha_region_list.
>  =09 */
>  =09spinlock_t ha_lock;
> +=09struct task_struct *lock_thread;
> =20
>  =09/*
>  =09 * A list of hot-add regions.
> @@ -707,12 +708,10 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
>  =09unsigned long start_pfn;
>  =09unsigned long processed_pfn;
>  =09unsigned long total_pfn =3D pfn_count;
> -=09unsigned long flags;
> =20
>  =09for (i =3D 0; i < (size/HA_CHUNK); i++) {
>  =09=09start_pfn =3D start + (i * HA_CHUNK);
> =20
> -=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09=09has->ha_end_pfn +=3D  HA_CHUNK;
> =20
>  =09=09if (total_pfn > HA_CHUNK) {
> @@ -724,7 +723,6 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
>  =09=09}
> =20
>  =09=09has->covered_end_pfn +=3D  processed_pfn;
> -=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> =20
>  =09=09init_completion(&dm_device.ol_waitevent);
>  =09=09dm_device.ha_waiting =3D !memhp_auto_online;
> @@ -745,10 +743,8 @@ static void hv_mem_hot_add(unsigned long start, unsi=
gned long size,
>  =09=09=09=09 */
>  =09=09=09=09do_hot_add =3D false;
>  =09=09=09}
> -=09=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09=09=09has->ha_end_pfn -=3D HA_CHUNK;
>  =09=09=09has->covered_end_pfn -=3D  processed_pfn;
> -=09=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  =09=09=09break;
>  =09=09}
> =20
> @@ -771,8 +767,13 @@ static void hv_online_page(struct page *pg, unsigned=
 int order)
>  =09struct hv_hotadd_state *has;
>  =09unsigned long flags;
>  =09unsigned long pfn =3D page_to_pfn(pg);
> +=09int unlocked;
> +
> +=09if (dm_device.lock_thread !=3D current) {

With lock_thread checking you're trying to protect against taking the
spinlock twice (when this is called from add_memory()) but why not just
check that spin_is_locked() AND we sit on the same CPU as the VMBus
channel attached to the balloon device?=20

> +=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09=09unlocked =3D 1;
> +=09}

We set unlocked to '1' when we're actually locked, aren't we?

> =20
> -=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  =09=09/* The page belongs to a different HAS. */
>  =09=09if ((pfn < has->start_pfn) ||
> @@ -782,7 +783,9 @@ static void hv_online_page(struct page *pg, unsigned =
int order)
>  =09=09hv_bring_pgs_online(has, pfn, 1UL << order);
>  =09=09break;
>  =09}
> -=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
> +=09if (unlocked)
> +=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
> =20
>  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> @@ -860,6 +863,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09pg_start);
> =20
>  =09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09dm_device.lock_thread =3D current;
>  =09list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  =09=09/*
>  =09=09 * If the pfn range we are dealing with is not in the current
> @@ -912,9 +916,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09=09} else {
>  =09=09=09=09pfn_cnt =3D size;
>  =09=09=09}
> -=09=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  =09=09=09hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt, has);
> -=09=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);

Apart from the deadlock you mention in the commit message, add_memory
does lock_device_hotplug()/unlock_device_hotplug() which is a mutex. If
I'm not mistaken you now take the mutext under a spinlock
(&dm_device.ha_lock). Not good.


>  =09=09}
>  =09=09/*
>  =09=09 * If we managed to online any pages that were given to us,
> @@ -923,6 +925,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09res =3D has->covered_end_pfn - old_covered_state;
>  =09=09break;
>  =09}
> +=09dm_device.lock_thread =3D NULL;
>  =09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> =20
>  =09return res;

--=20
Vitaly

