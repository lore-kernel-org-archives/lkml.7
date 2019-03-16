Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81526C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48126218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xgwTkrjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCPTb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:31:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCPTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:31:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id b2so8650997pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pH13QGMiwC7caCYd6kzrRRa3696y6Muo7dRzjjpeRoY=;
        b=xgwTkrjoID3ivuyavFQG3aGXHxzMGb/LTpI5xxaHa+nmNsVmFnO8jSv0c5u1a4dTR6
         4UziJZHAwUHBuPceNKVWpkHwZr0O2UwBvN1un9DvrErvEbbUeBz/7zMbsrtCSt5lU+hf
         K4yYrv5dRlQ3/DKt5SP9gb0f4uYWfNG2e/vAiVpdFisUHFddx58AIW6rf0YPqUAxjkEP
         L8x006/V91cFz4+Y2ps64Udq4PsxLOODVwa7/tQqXnwF+AGrI819Q/7tjTD3z/+ys26j
         2joKSdBBPUnrAkRG50a0dGf1SoG0t+3+BWwAaZ9oeeYwqXw8WuHroeHF2af9z+XAvj4H
         r7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pH13QGMiwC7caCYd6kzrRRa3696y6Muo7dRzjjpeRoY=;
        b=pmNSViONFsoCSz8Ok0ToJ9NHjTlZN/bVP/shGb39RrV8AWL/5NpIIpWnoZlCB0fzIZ
         8eosKiUxdVlvx5GqstQfNwV6F5yY7VZKA3jLhMfUrUIp43Y/X6tnfASVxOmKNkCzSNhq
         2cNyWchXo/P+ucfOD48uIyC9KPnbN5zI5aI7iczRLauC0JmwjSbLDWIsqWZHYLhwg7Eu
         PzRHo7k/vjXRqRbIzECgq/aeJy7QnBgc2gBis1F+QSd6j2oDRS0yoqqHQjxG+N8rV2nu
         cnchX71bmnPiRR50Yj4jcpvS8bRzFuI7BlpxP9W0f4qoIdu+C2dI/guqq60giCPzT1hK
         Cd4A==
X-Gm-Message-State: APjAAAU15J70rikctQHLPFIqA2i34zCfMH042aIwmG0sDH5LthtDl6Cr
        Ojd4XPrX2ox697T2lJUbYgpi6g==
X-Google-Smtp-Source: APXvYqzMLxwt+aULLijMsiC36tFGqG+bJiNqHIv8HaZ5Opf0wIbcYloMoQ0lfcz6Yw9KUUDiHxp3Bw==
X-Received: by 2002:a65:47cb:: with SMTP id f11mr9876515pgs.18.1552764717586;
        Sat, 16 Mar 2019 12:31:57 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e2sm6159325pfa.64.2019.03.16.12.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 12:31:56 -0700 (PDT)
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
 <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
 <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
 <d22bf156-06df-ec67-121d-7dce65088b1a@kernel.dk>
 <55743981-da8f-3211-0650-b143c8fec084@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23f48266-0d12-1891-1373-711b63f4f589@kernel.dk>
Date:   Sat, 16 Mar 2019 13:31:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <55743981-da8f-3211-0650-b143c8fec084@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 6:32 PM, Randy Dunlap wrote:
> On 3/15/19 9:33 AM, Jens Axboe wrote:
>> On 3/14/19 5:49 PM, Randy Dunlap wrote:
>>> On 3/14/19 4:43 PM, Jens Axboe wrote:
>>>> On 3/13/19 5:09 PM, Randy Dunlap wrote:
>>>>> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>>>>>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>>>>>> [Has this already been addressed/fixed?]>>
>>>>>>
>>>>>> Same bug occurs with paride/pcd.c driver.
>>>>>
>>>>> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
>>>>> around 4pm PT.  [caused by paride: pf.c and pcd.c)
>>>>
>>>> I'll take a look at this, been busy with other stuff. How are you
>>>> reproducing this? I'm assuming you don't actually have any hardware :-)
>>>
>>> Right.  I just load the module (pf or pcd), unload it, and
>>> then load it again.
>>
>> Does this work?
>>
> 
> No.  Just loading the pf module gives this:

Missing clear of the queue. This one should be more complete.

To be fair, this was utterly broken since forever. It's just now apparent
since we complain about it. But pf/pcd was one big leak fest.


diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670eefaeb2..377a694dc228 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -749,8 +749,12 @@ static int pcd_detect(void)
 		return 0;
 
 	printk("%s: No CD-ROM drive found\n", name);
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
+	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
+		blk_cleanup_queue(cd->disk->queue);
+		cd->disk->queue = NULL;
+		blk_mq_free_tag_set(&cd->tag_set);
 		put_disk(cd->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8eeeb2..103b617cdc31 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -761,8 +761,12 @@ static int pf_detect(void)
 		return 0;
 
 	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
+	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
+		blk_cleanup_queue(pf->disk->queue);
+		pf->disk->queue = NULL;
+		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
@@ -1047,13 +1051,15 @@ static void __exit pf_exit(void)
 	int unit;
 	unregister_blkdev(major, name);
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->present)
-			continue;
-		del_gendisk(pf->disk);
+		if (pf->present)
+			del_gendisk(pf->disk);
+
 		blk_cleanup_queue(pf->disk->queue);
 		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
-		pi_release(pf->pi);
+
+		if (pf->present)
+			pi_release(pf->pi);
 	}
 }
 

-- 
Jens Axboe

