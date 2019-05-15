Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F89C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6852082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hrYt0/ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEOMvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:51:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41499 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfEOMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:51:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id d12so2534169wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fg6OP2DED752HjsMq0NXZ5WlRg7LvFxNGMaPYkthNUY=;
        b=hrYt0/aoSO+OJYi45mrG6h3xhg24TJsWQOaYbAqf/14KTr9tZzZwjtb37abQRsU4xw
         ScqubFPj8CjpxrQ3JpCeZa8uG5HR64PVoo352fY2k9nUlTYyEjdrACMhHM2lnEalNzIJ
         3hg6JiSgu/Qyko65UeMCT8hx7uwEcudODuWvKf48U5u92mu2n9z1IwftNgrzDoajS/5o
         PINRMFaWApSaldNe55zR/y+g00obzx4T7YzJHeGWF6vvdNUWJa4ptGLLRM2rbCWseLiN
         S1nD+GZGX191eGNHZHVI7RF8WEFgwn9+9s7FRzh/ndxgK1/9wDj+tjQzAcPMa/G1aemW
         64vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fg6OP2DED752HjsMq0NXZ5WlRg7LvFxNGMaPYkthNUY=;
        b=YTB8ArIeJfrSLlc1LrAbX0JLphHT5iSwzoz0AMxzJkJBjn+Bk31NIp2+G4ednemzbW
         XKTyYFVDOrM+qnfPTVk7h2veVJV0Rk+5fpOlQ+ebCWNZCIK1DcBG6y6siNtXC3JEBySX
         qUzOrI+AxG9JKFoHGnKnP/rEoNISGg59IaoFgpI7tfkA8fPJFPGSXX4Ae52hwmNfhvRA
         xZhqEXfVXK/Ar0p+Z+r22yF/FZKHPpNpFEIylmv5i5WHjp1uPuwMlicuiYcIEDeeb5m8
         7azDzvKr5BRh6srRE/x36+gJLTTkNQnOmKJrWbxD2U1M5ugixLsrlddBQoBsxzACz2k0
         beSg==
X-Gm-Message-State: APjAAAUWXvJHDQ095MNgVUcc24Gke5qhw1Nh2pr8f/O9hybBEop/B2rp
        wgPMh3xDVRVPnb/12oSXEkRsN+BhDRsiYA==
X-Google-Smtp-Source: APXvYqzSvi9PSrO6cnVohF4qZIKU4C2SLgIrB7VO/9eocGzKzp5mTF6HbIi9yAkqnpQ8V83jhrYGrQ==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr21281017wrq.115.1557924696502;
        Wed, 15 May 2019 05:51:36 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l16sm3057132wrb.40.2019.05.15.05.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:51:35 -0700 (PDT)
Subject: Re: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        baylibre-upstreaming@groups.io,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
 <20190513091548.16674-3-narmstrong@baylibre.com>
 <CAPDyKFp-mU-pCcwGUkL8B5YfhXamHtTcRHe8eX9SNupMxr-kgg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <610fa8f2-29ec-96c6-b238-a1f444ad1c5b@baylibre.com>
Date:   Wed, 15 May 2019 14:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp-mU-pCcwGUkL8B5YfhXamHtTcRHe8eX9SNupMxr-kgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2019 13:34, Ulf Hansson wrote:
> On Mon, 13 May 2019 at 11:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
>> the data from DDR, leading to a broken controller.
> 
> Could you possibly make it more clear that this is about the internal
> DMA support in the controller that is broken?
> 
> Did you consider to use the controller without using the DMA mode? Is
> that possible?

No we can only use the DMA, in block mode (using our bounce buffer mode)
or in descriptor mode.

> 
>>
>> But each MMC controller has 1,5KiB of SRAM after the registers, that can
>> be used as bounce buffer to avoid direct DDR access from the integrated
>> DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).
> 
> I think "DDR" is a confusing terminology, that goes for the DT binding
> as well. What about using "DRAM" instead?

Seems better, I'll wait on Rob's feedback on this a few more days.

> 
> In any case, using the SRAM seems like it could work. However, just so
> I get this right, it solely dedicated to the SDIO controller or may
> someone else also try to use it?

This SRAM is dedicated to *each* MMC controller. Not sure if other masters
could access it, but it would be unfortunate.

I'll add these details in the commit log.

> 
>>
>> The quirk is to disable the chained descriptor for this controller, and
>> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
>>
>> The performance hit hasn't been evaluated, but the fix has been tested
>> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
>> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
>> at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.
> 
> If possible to not use DMA, it would be interesting to compare numbers. :-)

I could activate this quirk on a MMC or SDcard dedicated controller and
compare, but SDIO and MMC/SDcard transactions are really different.

We compared it on the AXG platform with the same MMC controller revision,
CPU freq, DRAM technology, kernel revision and the peak WiFi "speed" was
equivalent, but with a slighly superior CPU usage.

> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 65 ++++++++++++++++++++++++++-------
>>  1 file changed, 52 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index c5a8af4ca76b..6ef465304052 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -129,6 +129,9 @@
>>  #define SD_EMMC_TXD 0x94
>>  #define SD_EMMC_LAST_REG SD_EMMC_TXD
>>
>> +#define SD_EMMC_SRAM_DATA_BUF_LEN 1536
>> +#define SD_EMMC_SRAM_DATA_BUF_OFF 0x200
>> +
>>  #define SD_EMMC_CFG_BLK_SIZE 512 /* internal buffer max: 512 bytes */
>>  #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
>>  #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
>> @@ -168,6 +171,8 @@ struct meson_host {
>>         unsigned long req_rate;
>>         bool ddr;
>>
>> +       bool ddr_access_quirk;
>> +
>>         struct pinctrl *pinctrl;
>>         struct pinctrl_state *pins_default;
>>         struct pinctrl_state *pins_clk_gate;
>> @@ -232,11 +237,20 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
>>  static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>                                         struct mmc_request *mrq)
>>  {
>> +       struct meson_host *host = mmc_priv(mmc);
>>         struct mmc_data *data = mrq->data;
>>         struct scatterlist *sg;
>>         int i;
>>         bool use_desc_chain_mode = true;
>>
>> +       /*
>> +        * When Controller DMA cannot directly access DDR memory, disable
>> +        * support for Chain Mode to directly use the internal SRAM using
>> +        * the bounce buffer mode.
>> +        */
>> +       if (host->ddr_access_quirk)
>> +               return;
>> +
>>         /*
>>          * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
>>          * reported. For some strange reason this occurs in descriptor
>> @@ -1049,6 +1063,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>         host->dev = &pdev->dev;
>>         dev_set_drvdata(&pdev->dev, host);
>>
>> +       /* The G12A SDIO Controller needs an SRAM bounce buffer */
>> +       host->ddr_access_quirk = device_property_read_bool(&pdev->dev,
>> +                                       "amlogic,ddr-access-quirk");
>> +
>>         /* Get regulators and the supported OCR mask */
>>         host->vqmmc_enabled = false;
>>         ret = mmc_regulator_get_supply(mmc);
>> @@ -1146,9 +1164,16 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>                 goto err_init_clk;
>>
>>         mmc->caps |= MMC_CAP_CMD23;
>> -       mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>> +       if (host->ddr_access_quirk) {
>> +               /* Limit to the available sram memory */
>> +               mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
>> +               mmc->max_blk_count = mmc->max_segs;
>> +       } else {
>> +               mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>> +               mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
>> +                               sizeof(struct sd_emmc_desc);
>> +       }
>>         mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
>> -       mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
>>         mmc->max_seg_size = mmc->max_req_size;
>>
>>         /*
>> @@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>          */
>>         mmc->caps2 &= ~MMC_CAP2_HS400;
>>
>> -       /* data bounce buffer */
>> -       host->bounce_buf_size = mmc->max_req_size;
>> -       host->bounce_buf =
>> -               dma_alloc_coherent(host->dev, host->bounce_buf_size,
>> -                                  &host->bounce_dma_addr, GFP_KERNEL);
>> -       if (host->bounce_buf == NULL) {
>> -               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>> -               ret = -ENOMEM;
>> -               goto err_free_irq;
>> +       if (host->ddr_access_quirk) {
>> +               /*
>> +                * The MMC Controller embeds 1,5KiB of internal SRAM
>> +                * that can be used to be used as bounce buffer.
>> +                * In the case of the G12A SDIO controller, use these
>> +                * instead of the DDR memory
>> +                */
>> +               host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
>> +               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
>> +               host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
>> +       } else {
>> +               /* data bounce buffer */
>> +               host->bounce_buf_size = mmc->max_req_size;
>> +               host->bounce_buf =
>> +                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
>> +                                          &host->bounce_dma_addr, GFP_KERNEL);
>> +               if (host->bounce_buf == NULL) {
>> +                       dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>> +                       ret = -ENOMEM;
>> +                       goto err_free_irq;
>> +               }
>>         }
>>
>>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>> @@ -1208,8 +1245,10 @@ static int meson_mmc_remove(struct platform_device *pdev)
>>
>>         dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>>                           host->descs, host->descs_dma_addr);
>> -       dma_free_coherent(host->dev, host->bounce_buf_size,
>> -                         host->bounce_buf, host->bounce_dma_addr);
>> +
>> +       if (!host->ddr_access_quirk)
>> +               dma_free_coherent(host->dev, host->bounce_buf_size,
>> +                                 host->bounce_buf, host->bounce_dma_addr);
>>
>>         clk_disable_unprepare(host->mmc_clk);
>>         clk_disable_unprepare(host->core_clk);
>> --
>> 2.21.0
>>

Thanks for reviewing,

> 
> Kind regards
> Uffe
> 

