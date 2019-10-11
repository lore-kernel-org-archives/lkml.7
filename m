Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB183ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EBB21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJKGQN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:16:13 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45607 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfJKGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:16:13 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9B6Fxdq020822
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Oct 2019 15:15:59 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B6Fxsl019667;
        Fri, 11 Oct 2019 15:15:59 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B66vEJ010178;
        Fri, 11 Oct 2019 15:15:59 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9395631; Fri, 11 Oct 2019 15:13:36 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Fri,
 11 Oct 2019 15:13:36 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
Thread-Topic: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
Thread-Index: AQHVf/sD8rv7sHippUGh2lMUk+4FjA==
Date:   Fri, 11 Oct 2019 06:13:35 +0000
Message-ID: <20191011061335.GA30803@hori.linux.bs1.fc.nec.co.jp>
References: <20191010141200.8985-1-david@redhat.com>
In-Reply-To: <20191010141200.8985-1-david@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <F1F318FC11A60240A9E2F1EBBFD1D79B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:12:00PM +0200, David Hildenbrand wrote:
> Uninitialized memmaps contain garbage and in the worst case trigger kernel
> BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> Right now, when trying to soft-offline a PFN that resides on a memory
> block that was never onlined, one gets a misleading error with
> CONFIG_PAGE_POISONING:
>   :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
>   [   23.097167] soft offline: 0x150000 page already poisoned
> 
> But the actual result depends on the garbage in the memmap.
> 
> soft_offline_page() can only work with online pages, it returns -EIO in
> case of ZONE_DEVICE. Make sure to only forward pages that are online
> (iow, managed by the buddy) and, therefore, have an initialized memmap.
> 
> Add a check against pfn_to_online_page() and similarly return -EIO.
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6bea4f3f8040..55907c27075b 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -540,6 +540,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
>  	pfn >>= PAGE_SHIFT;
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
> +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> +	if (!pfn_to_online_page(pfn))
> +		return -EIO;

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

I think this check could be placed in soft_offline_page(), but that requires
a few more unrelated lines of changes due to the mismatch on type of parameter
between memory_failure() and soft_offline_page(),  This is not your problem,
and I plan to do some cleanup on related interfaces, so this patch is fine.

- Naoya Horiguchi
