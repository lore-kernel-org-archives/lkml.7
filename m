Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8719CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ED0208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kdd3qnK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfDBLDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:03:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37539 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfDBLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:03:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190402110347euoutp028a53314c7984d3e3e8e01c6c67688657~Ro2tEqTE_2147421474euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2019 11:03:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190402110347euoutp028a53314c7984d3e3e8e01c6c67688657~Ro2tEqTE_2147421474euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554203027;
        bh=cLKbIBJYSVDMLz3XdUSbuCjGr7hqAE0UOTCNqShOaeE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kdd3qnK7ebRda0ula1h/EfTGgExPD1sq1Kcg3rhla/HbRmz0C9YmBHu12nIYY7qTu
         r0mYQB0aYbgquiACKHkcPE3CnHWMmROIiXprC6no2NhWhT9idZ43svVz+SYuuLkmul
         I85ws1+VJjJPDSAJVLOdKzdlGpdPJh7P3XaNGU+4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190402110347eucas1p26900d62087a91eaf07039e838ce80ea6~Ro2swdo4K1139811398eucas1p2K;
        Tue,  2 Apr 2019 11:03:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.03.04298.29143AC5; Tue,  2
        Apr 2019 12:03:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190402110346eucas1p24786e298e0448e698783edcc081a1016~Ro2sBtxXu1708017080eucas1p2y;
        Tue,  2 Apr 2019 11:03:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190402110346eusmtrp2c04197172ba868b29d67f8dbca2afddc~Ro2ryT0B-0379303793eusmtrp2W;
        Tue,  2 Apr 2019 11:03:46 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-fa-5ca34192ee0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.E4.04140.29143AC5; Tue,  2
        Apr 2019 12:03:46 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190402110345eusmtip1a912a2a5f13be9385567389e3ee70f11~Ro2rfwMgr3251932519eusmtip12;
        Tue,  2 Apr 2019 11:03:45 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: sis: fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, thomas@winischhofer.net,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <08701e39-95a6-bb8e-9371-222ada5f85b2@samsung.com>
Date:   Tue, 2 Apr 2019 13:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7qTHBfHGEzsNrO48vU9m8WJeWfZ
        LU70fWC1uLxrDpvF6pWP2S1OnbrH6sDmcb/7OJPH1YVN7B6fN8l5LJjxnyWAJYrLJiU1J7Ms
        tUjfLoErY+ard8wFl4wqDvz3aGB8r9jFyMkhIWAi0fTmGEsXIxeHkMAKRolrW54zQThfGCU+
        fD/PCuF8ZpR4tG8BI0zLn3N/oFqWM0qsf/ISquUto0TbxBcsIFXCAvYSS86dZAexRQSUJNqu
        dYCNYhZYxChx5/s0VpAEm4CVxMT2VWBjeQXsJN5sXAHWzCKgIvH63HGgqRwcogIREv1n1CFK
        BCVOznwCVsIpECix/fkasFZmAXmJ7W/nMIPMlxCYzi6xevdRZohTXSTWvJkLdbawxKvjW9gh
        bBmJ/zvnM0E0rGOU+NvxAqp7O6PE8sn/2CCqrCUOH7/ICnIFs4CmxPpd+hBhR4mLvSsZQcIS
        AnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ27VwJdZqHxPcd31gnMCrOQvLaLCTv
        zELYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgYjn97/inHYxfLyUdYhTgYFTi
        4U2QXBQjxJpYVlyZe4hRgoNZSYT3TP+CGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE
        0hNLUrNTUwtSi2CyTBycUg2MfN0+3kn5bje9Oh3T9Bf8sv17aOYr9hcXQv2l20o4Pu1Qtzwx
        +xBXzekUoelrzEVUDLv/rtp6XuW6JLN4w8T7l6zb9KW5y/ecL/icfvVYn8GDOWyPVyak3OPS
        1T4kuWd+1yRtx32xgY4mpY/5jjHPc5r9oOwsg8Lqtzt3KV0oZ7CXY+1+sGiuEktxRqKhFnNR
        cSIAu4dUyCgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qTHBfHGJz8y25x5et7NosT886y
        W5zo+8BqcXnXHDaL1Ssfs1ucOnWP1YHN4373cSaPqwub2D0+b5LzWDDjP0sAS5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsxX75gLLhlVHPjv
        0cD4XrGLkZNDQsBE4s+5PyxdjFwcQgJLGSVmvdjA3MXIAZSQkTi+vgyiRljiz7UuNoia14wS
        DZ+ms4IkhAXsJZacO8kOYosIKEm0XetghSi6zSjx99ZLJhCHWWARo8TlzbNYQKrYBKwkJrav
        YgSxeQXsJN5sXAEWZxFQkXh97jgTiC0qECFx62EHC0SNoMTJmU/AbE6BQIntz9eA9TILqEv8
        mXeJGcKWl9j+dg7zBEbBWUhaZiEpm4WkbAEj8ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA
        iNl27OeWHYxd74IPMQpwMCrx8EYILYoRYk0sK67MPcQowcGsJMJ7pn9BjBBvSmJlVWpRfnxR
        aU5q8SFGU6AnJjJLiSbnA6M5ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFM
        HxMHp1QDY9xs1Z37tz+4eO9n8xEnrkc75AVzgm68UPh28N6ROGbejsyjCdJ89dwyvEsuzw9b
        +WGNnsL8qdwtK3h2ZBpx/vmkk/z/4oliBheJm99KaheUrJtSq9h0vDBwEkfArWdLlnsdEvpg
        laqdUnRJ+n3ekUcxiSklX4WfXX1ulSkuzpw0r3nfJ27x40osxRmJhlrMRcWJAM98k2KuAgAA
X-CMS-MailID: 20190402110346eucas1p24786e298e0448e698783edcc081a1016
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181029190936epcas4p1b20ed796247238cfed3264b601807ba3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181029190936epcas4p1b20ed796247238cfed3264b601807ba3
References: <1539981557-13590-1-git-send-email-wang6495@umn.edu>
        <CGME20181029190936epcas4p1b20ed796247238cfed3264b601807ba3@epcas4p1.samsung.com>
        <CAAa=b7ffkENv=OYDToZgr9fK5qnKs8orMXioQ8ABkFHJ+qTpsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sorry for the late reply.

On 10/29/2018 08:08 PM, Wenwen Wang wrote:
> Hello,
> 
> Can anyone please confirm this bug? Thanks!
> 
> Wenwen
> 
> On Fri, Oct 19, 2018 at 3:39 PM Wenwen Wang <wang6495@umn.edu> wrote:
>>
>> In sisfb_find_rom(), the official pci ROM is checked to see whether it
>> contains the expected value at specific locations. This is done by firstly
>> mapping the rom into the IO memory region 'rom_base' and then invoking
>> sisfb_check_rom() to perform the checks. If the checks succeed, i.e.,
>> sisfb_check_rom() returns 1, the whole content of the rom is then copied to
>> 'myrombase' through memcpy_fromio(). The problem here is that the checks
>> are conducted on the IO region 'rom_base' directly. Given that the device
>> also has the permission to access the IO region, it is possible that a
>> malicious device controlled by an attacker can race to modify the values in
>> the region after the checks but before memcpy_fromio(). By doing so, the
>> attacker can supply unexpected roms, which can cause undefined behavior of
>> the kernel and introduce potential security risk. The following for loop
>> also has a similar issue.

The checks in sisfb_check_rom() seem to verify only that the ROM
content is valid (== it seems to be a valid code not some random
data) by checking few "magic" numbers. There is no checking for
the ROM content being safe from security POV of any kind so I fail
to see how this patch would help against the malicious device
providing insecure ROM content (as it can pass sisfb_check_rom()
checks without a problem)..

>> To avoid the above issue, this patch firstly copies the content of the rom
>> and then performs the checks on the copied version. If all the checks are
>> satisfied, the copied version will then be returned.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  drivers/video/fbdev/sis/sis_main.c | 52 ++++++++++++++++----------------------
>>  1 file changed, 22 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
>> index 20aff90..a2d8051 100644
>> --- a/drivers/video/fbdev/sis/sis_main.c
>> +++ b/drivers/video/fbdev/sis/sis_main.c
>> @@ -4089,29 +4089,29 @@ static int __init sisfb_setup(char *options)
>>  }
>>  #endif
>>
>> -static int sisfb_check_rom(void __iomem *rom_base,
>> +static int sisfb_check_rom(unsigned char *rom_base,
>>                            struct sis_video_info *ivideo)
>>  {
>> -       void __iomem *rom;
>> +       unsigned char *rom;
>>         int romptr;
>>
>> -       if((readb(rom_base) != 0x55) || (readb(rom_base + 1) != 0xaa))
>> +       if ((*rom_base != 0x55) || (*(rom_base + 1) != 0xaa))
>>                 return 0;
>>
>> -       romptr = (readb(rom_base + 0x18) | (readb(rom_base + 0x19) << 8));
>> +       romptr = (*(rom_base + 0x18) | (*(rom_base + 0x19) << 8));
>>         if(romptr > (0x10000 - 8))
>>                 return 0;
>>
>>         rom = rom_base + romptr;
>>
>> -       if((readb(rom)     != 'P') || (readb(rom + 1) != 'C') ||
>> -          (readb(rom + 2) != 'I') || (readb(rom + 3) != 'R'))
>> +       if ((*(rom)     != 'P') || (*(rom + 1) != 'C') ||
>> +          (*(rom + 2) != 'I') || (*(rom + 3) != 'R'))
>>                 return 0;
>>
>> -       if((readb(rom + 4) | (readb(rom + 5) << 8)) != ivideo->chip_vendor)
>> +       if ((*(rom + 4) | (*(rom + 5) << 8)) != ivideo->chip_vendor)
>>                 return 0;
>>
>> -       if((readb(rom + 6) | (readb(rom + 7) << 8)) != ivideo->chip_id)
>> +       if ((*(rom + 6) | (*(rom + 7) << 8)) != ivideo->chip_id)
>>                 return 0;
>>
>>         return 1;
>> @@ -4124,6 +4124,10 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>         unsigned char *myrombase = NULL;
>>         size_t romsize;
>>
>> +       myrombase = vmalloc(65536);
>> +       if (!myrombase)
>> +               return NULL;
>> +
>>         /* First, try the official pci ROM functions (except
>>          * on integrated chipsets which have no ROM).
>>          */
>> @@ -4131,20 +4135,15 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>         if(!ivideo->nbridge) {
>>
>>                 if((rom_base = pci_map_rom(pdev, &romsize))) {
>> -
>> -                       if(sisfb_check_rom(rom_base, ivideo)) {
>> -
>> -                               if((myrombase = vmalloc(65536))) {
>> -                                       memcpy_fromio(myrombase, rom_base,
>> -                                                       (romsize > 65536) ? 65536 : romsize);
>> -                               }
>> -                       }
>> +                       memcpy_fromio(myrombase, rom_base,
>> +                                       (romsize > 65536) ? 65536 : romsize);
>>                         pci_unmap_rom(pdev, rom_base);
>> +
>> +                       if (sisfb_check_rom(myrombase, ivideo))
>> +                               return myrombase;
>>                 }
>>         }
>>
>> -       if(myrombase) return myrombase;
>> -
>>         /* Otherwise do it the conventional way. */
>>
>>  #if defined(__i386__) || defined(__x86_64__)
>> @@ -4156,24 +4155,17 @@ static unsigned char *sisfb_find_rom(struct pci_dev *pdev)
>>                         rom_base = ioremap(temp, 65536);
>>                         if (!rom_base)
>>                                 continue;
>> -
>> -                       if (!sisfb_check_rom(rom_base, ivideo)) {
>> -                               iounmap(rom_base);
>> -                               continue;
>> -                       }
>> -
>> -                       if ((myrombase = vmalloc(65536)))
>> -                               memcpy_fromio(myrombase, rom_base, 65536);
>> -
>> +                       memcpy_fromio(myrombase, rom_base, 65536);
>>                         iounmap(rom_base);
>> -                       break;
>>
>> +                       if (sisfb_check_rom(myrombase, ivideo))
>> +                               return myrombase;
>>                 }
>>
>>         }
>>  #endif
>> -
>> -       return myrombase;
>> +       vfree(myrombase);
>> +       return NULL;
>>  }
>>
>>  static void sisfb_post_map_vram(struct sis_video_info *ivideo,
>> --
>> 2.7.4

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
