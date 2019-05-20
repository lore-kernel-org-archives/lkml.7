Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DEBC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FB321479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbfETNua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:50:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:33552 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbfETNu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:50:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 06:50:29 -0700
X-ExtLoop1: 1
Received: from ejleta-mobl.amr.corp.intel.com (HELO [10.254.104.211]) ([10.254.104.211])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2019 06:50:28 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if
 statement and removed buffer
To:     Hans de Goede <hdegoede@redhat.com>,
        nariman <narimantos@gmail.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190519175706.3998-1-narimantos@gmail.com>
 <783c330c-b706-9d19-467d-a19d2f414a05@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b4e2ee77-cab9-5457-9649-2ff0804fc2b9@linux.intel.com>
Date:   Mon, 20 May 2019 08:50:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <783c330c-b706-9d19-467d-a19d2f414a05@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/19 3:37 AM, Hans de Goede wrote:
> Hi all,
> 
> On 19-05-19 19:57, nariman wrote:
>> From: Nariman Etemadi <narimantos@gmail.com>
>>
>> in function snd_byt_rt5640_mc_probe and removed buffer 
>> yt_rt5640_codec_aif_name & byt_rt5640_cpu_dai_name
>>
>> Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
> 
> Series (all 4 patches) look good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks for the update (I believe it's the v2, yes?)

the code is fine but can be polished to fix a couple of
alignment issues

+	bits = 16;
  	} else {

and checkpatch.pl --strict is quite verbose here. Some reports look like 
false-alarms but the commit message should be wrapped and alignement fixed.

---------------------------------------------------------
0001-ASoC-Intel-bytcr_5640.c-refactored-codec_fixup.patch
---------------------------------------------------------
CHECK: Alignment should match open parenthesis
#86: FILE: sound/soc/intel/boards/bytcr_rt5640.c:980:
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+		SND_SOC_DAIFMT_I2S     |

total: 0 errors, 0 warnings, 1 checks, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0001-ASoC-Intel-bytcr_5640.c-refactored-codec_fixup.patch has style 
problems, please review.
---------------------------------------------------------------
0002-ASoC-Intel-bytcr_5640.c-Refactored-if-statement-and-.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)
#7:
in function snd_byt_rt5640_mc_probe and removed buffer 
yt_rt5640_codec_aif_name & byt_rt5640_cpu_dai_name

total: 0 errors, 1 warnings, 0 checks, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0002-ASoC-Intel-bytcr_5640.c-Refactored-if-statement-and-.patch has 
style problems, please review.
---------------------------------------------------------------
0003-ASoC-Intel-bytcr_rt5651.c-remove-string-buffers-byt_.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)
#7:
The snprintf calls filling byt_rt5651_cpu_dai_name / 
byt_rt5651_cpu_dai_name always fill them with the same string 
(ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers 
around and making the cpu_dai_name / codec_dai_name point to this, 
simply update the foo_dai_name pointers to directly point to a string 
constant containing the desired string.

total: 0 errors, 1 warnings, 0 checks, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0003-ASoC-Intel-bytcr_rt5651.c-remove-string-buffers-byt_.patch has 
style problems, please review.
---------------------------------------------------------------
0004-ASoC-Intel-cht_bsw_rt5645.c-Remove-buffer-and-snprin.patch
---------------------------------------------------------------
WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)
#7:
The snprintf calls filling cht_rt5645_cpu_dai_name / 
cht_rt5645_codec_aif_name

WARNING: suspect code indent for conditional statements (8, 24)
#35: FILE: sound/soc/intel/boards/cht_bsw_rt5645.c:642:
  	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
[...]
+			cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";

WARNING: suspect code indent for conditional statements (8, 24)
#49: FILE: sound/soc/intel/boards/cht_bsw_rt5645.c:646:
  	if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
[...]
+			cht_dailink[dai_index].cpu_dai_name = "ssp0-port";

total: 0 errors, 3 warnings, 0 checks, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0004-ASoC-Intel-cht_bsw_rt5645.c-Remove-buffer-and-snprin.patch has 
style problems, please review.



> 
> Regards,
> 
> Hans
> 
> 
>> ---
>>   sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++----------------------
>>   1 file changed, 4 insertions(+), 22 deletions(-)
>>
>> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c 
>> b/sound/soc/intel/boards/bytcr_rt5640.c
>> index 940eb27158da..0d91642ca287 100644
>> --- a/sound/soc/intel/boards/bytcr_rt5640.c
>> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
>> @@ -1075,8 +1075,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] 
>> = {
>>   /* SoC card */
>>   static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
>> -static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
>> -static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
>>   static char byt_rt5640_long_name[40]; /* = 
>> "bytcr-rt5640-*-spk-*-mic" */
>>   static int byt_rt5640_suspend(struct snd_soc_card *card)
>> @@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct 
>> platform_device *pdev)
>>       log_quirks(&pdev->dev);
>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>> -
>> -        /* fixup codec aif name */
>> -        snprintf(byt_rt5640_codec_aif_name,
>> -            sizeof(byt_rt5640_codec_aif_name),
>> -            "%s", "rt5640-aif2");
>> -
>> -        byt_rt5640_dais[dai_index].codec_dai_name =
>> -            byt_rt5640_codec_aif_name;
>> -    }
>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>> +        byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>> -
>> -        /* fixup cpu dai name name */
>> -        snprintf(byt_rt5640_cpu_dai_name,
>> -            sizeof(byt_rt5640_cpu_dai_name),
>> -            "%s", "ssp0-port");
>> -
>> -        byt_rt5640_dais[dai_index].cpu_dai_name =
>> -            byt_rt5640_cpu_dai_name;
>> -    }
>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>> +        byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
>>       if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
>>           priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
