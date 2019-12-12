Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFBBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACBD21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HQ/cNvPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfLLW3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:29:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfLLW3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:29:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so4517830wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BKntyhBGknYqR6iJsvJMS7cHfVX43Sx45Nvch3UNnOA=;
        b=HQ/cNvPGNdhjydk4QSD3Kg+XVEeY+qHnpsawRfISHRhABN0sTcIi5OBVnuBmMjfuU7
         SWhkrHr0zUynJ9Qk+Hc5QwERKI4yEIVscnNfSkeRpCcWVsEtrvY0YLhVXT+BGm2i9/Cn
         Ztxxdr8jyyz6aw7Pfc1d4+844wxLYpsTEa/ZNI64hkpgzQLqaRNB3axcYo6NhzvjO/GT
         Pz7iGMyfqrrkWsfjObVciraChCmAvuOYeGYbxEy5z7z6qYGDrJ+DEfZRXP8JNwSpTwyY
         SzA2o2O/XMqZNsH5Xw2Rzf0+9FVINSDhW7FmPCvJ8sSYbDn13ns7Y9O75WQVlyxI9l3k
         Ab9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BKntyhBGknYqR6iJsvJMS7cHfVX43Sx45Nvch3UNnOA=;
        b=mWvn+e/JECCQC6NKWrX4MTMOHQZ3JuZAHE3FpFxB3TueViiqFvmmRQ+qTuXVaLLZpo
         6geeJHuTBO9dCADq6Fi0LpSkHEG1W814ZCARsF6D4iaEYPdgV1PIqPTf4hQpjNkyyJhk
         c9oWi8S5zZI9djgbIlPtKH2KDWjZEdqFwlh8T6cz/6dC7RyHSLlY0yWWR15tt+wsVVKz
         yBF0kpH7scdCMbkPjHw3ZYQBs7Knn0Md1inSHJCL7mgHFrDKblCur//pth3BLxrOXpZB
         TREXMEy2UmdL9sQ3QGgFPti3Qd4t6EmPOVBplb6wdvjrCumyPAMBqP2osliOXjXS52VC
         2h7w==
X-Gm-Message-State: APjAAAXccKosdyYkmZfxdLOVTu58+Aye7PX70zxkuZiFzf5OtlS5TslL
        sVif7fozmJzz0LbmIiR11H332EonML6p3A==
X-Google-Smtp-Source: APXvYqzwAGMP57lljUqh+++k6Xlu0zKN7SnAA93D1C2HJd35TxYZoQy7MfzBXqm7zzxXt9j0OBltfQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr8564947wrx.14.1576189775899;
        Thu, 12 Dec 2019 14:29:35 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca? ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id q3sm7650543wmj.38.2019.12.12.14.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:29:35 -0800 (PST)
Subject: Re: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
To:     Marcel Holtmann <marcel@holtmann.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, khilman@baylibre.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
References: <20191211094923.20220-1-glaroque@baylibre.com>
 <cf77eec5df92b1845f0bf7cc8eb53edd4af9e1bf.camel@suse.de>
 <0CF02341-CF69-4680-B61F-DC5C0702F1A2@holtmann.org>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <3f4aaa42-59fb-b7d2-0e5d-d799d90cab0a@baylibre.com>
Date:   Thu, 12 Dec 2019 23:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0CF02341-CF69-4680-B61F-DC5C0702F1A2@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas and Marcel,

On 12/12/19 9:46 PM, Marcel Holtmann wrote:
> Hi Nicolas,
>
>>> Actually IRQ can be found from GPIO but all platforms don't support
>>> gpiod_to_irq, it's the case on amlogic chip.
>>> so to have possibility to use interrupt mode we need to add interrupts
>>> field in node and support it in driver.
>>>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> ---
>>> drivers/bluetooth/hci_bcm.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>> This triggers the following panic on Raspberry Pi 4:
>>
>> [    6.634507] Unable to handle kernel NULL pointer dereference at virtual
>> address 0000000000000018
>> [    6.643486] Mem abort info:
>> [    6.646350]   ESR = 0x96000004
>> [    6.649466]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    6.654873]   SET = 0, FnV = 0
>> [    6.657977]   EA = 0, S1PTW = 0
>> [    6.661201] Data abort info:
>> [    6.664135]   ISV = 0, ISS = 0x00000004
>> [    6.668042]   CM = 0, WnR = 0
>> [    6.671061] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000f3c83000
>> [    6.677627] [0000000000000018] pgd=0000000000000000
>> [    6.682595] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [    6.688255] Modules linked in: hci_uart brcmutil btqca btbcm cfg80211
>> bluetooth raspberrypi_cpufreq ecdh_generic ecc rfkill clk_raspberrypi
>> raspberrypi_hwmon pwm_bcm2835 crct10dif_ce bcm2835_dma i2c_bcm2835 pcie_brcmstb
>> ip_tables x_tables ipv6 nf_defrag_ipv6
>> [    6.711519] CPU: 3 PID: 39 Comm: kworker/u8:1 Not tainted 5.5.0-rc1-next-
>> 20191212-00009-geb500fec1e34-dirty #26
>> [    6.721771] Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>> [    6.727709] Workqueue: events_unbound async_run_entry_fn
>> [    6.733105] pstate: a0000005 (NzCv daif -PAN -UAO)
>> [    6.737971] pc : platform_get_irq_optional+0xa4/0x260
>> [    6.743099] lr : platform_get_irq_optional+0x6c/0x260
>> [    6.748226] sp : ffff8000101b3c20
>> [    6.751586] x29: ffff8000101b3c20 x28: ffffd4bd4a957000
>> [    6.756980] x27: ffff0000f6c0c070 x26: ffff0000f6c0c020
>> [    6.762373] x25: 0000000000000000 x24: 0000000000000000
>> [    6.767767] x23: ffff0000f6238c00 x22: ffffd4bd4a241a38
>> [    6.773159] x21: ffffd4bd49e95838 x20: ffff0000f6238bf0
>> [    6.778552] x19: 0000000000000000 x18: 0000000000000010
>> [    6.783944] x17: 0000000000000000 x16: ffffd4bd497117a8
>> [    6.789337] x15: ffff0000f6fc0470 x14: 0720072007200720
>> [    6.794730] x13: 0720072007200720 x12: 0720072007200720
>> [    6.800123] x11: 0720072007200720 x10: 0720072007200720
>> [    6.805516] x9 : 0720072007200720 x8 : 0720072007200720
>> [    6.810913] x7 : ffffd4bd496ad210 x6 : 000000000000017d
>> [    6.810922] x5 : 0000000000000000 x4 : ffff0000fb7fa1b0
>> [    6.821713] x3 : 00000000f6238800 x2 : 0000000000000000
>> [    6.821716] x1 : 0000000000000000 x0 : 0000000000000000
>> [    6.821720] Call trace:
>> [    6.821730]  platform_get_irq_optional+0xa4/0x260
>> [    6.839768]  platform_get_irq+0x1c/0x58
>> [    6.839792]  bcm_serdev_probe+0x40/0x138 [hci_uart]
>> [    6.839805]  serdev_drv_probe+0x34/0x70
>> [    6.852544]  really_probe+0xd8/0x428
>> [    6.852546]  driver_probe_device+0xdc/0x130
>> [    6.852549]  __driver_attach_async_helper+0xa8/0xb0
>> [    6.852558]  async_run_entry_fn+0x40/0x1a0
>> [    6.869534]  process_one_work+0x19c/0x320
>> [    6.869537]  worker_thread+0x48/0x420
>> [    6.877319]  kthread+0xf0/0x120
>> [    6.877324]  ret_from_fork+0x10/0x18
>> [    6.877330] Code: 17ffffef f9419293 937a7c02 8b020273 (f9400e62)
>> [    6.890329] ---[ end trace 3ebb39e57973e0b7 ]---
>>
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index f8f5c593a05c..9f52d57c56de 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device
>>> *serdev)
>>> {
>>> 	struct bcm_device *bcmdev;
>>> 	const struct bcm_device_data *data;
>>> +	struct platform_device *pdev;
>>> 	int err;
>>>
>>> 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
>>> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device
>>> *serdev)
>>> #endif
>>> 	bcmdev->serdev_hu.serdev = serdev;
>>> 	serdev_device_set_drvdata(serdev, bcmdev);
>>> +	pdev = to_platform_device(bcmdev->dev);
>> Ultimately bcmdev->dev here comes from a serdev device not a platform device,
>> right?
> I was afraid of this, but then nobody spoke up. Can we fix this or should I just revert the patch?

sorry about that, i will provide a fix as soon as possible but i have no pi4 to validate on it so i will add no in cc nicolas and if you can give me a feedback i will appreciate .


Marcel, what is better for you a fix on this patch or a new version of this patch ?

> Regards
>
> Marcel
>
Regards

Guillaume

