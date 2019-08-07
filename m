Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212042199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfHGPWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:22:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:54844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388257AbfHGPWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:22:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 08:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="373804945"
Received: from knguye7-mobl.amr.corp.intel.com (HELO [10.255.81.127]) ([10.255.81.127])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2019 08:22:12 -0700
Subject: Re: [Sound-open-firmware] [PATCH v2 3/5] ASoC: SOF: Add DT DSP device
 support
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
References: <20190723084104.12639-1-daniel.baluta@nxp.com>
 <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
 <CAEnQRZDr+gj_eiESLNbVUVy1rreRE1nnDgtb3g=CjaRF5Aq9Vw@mail.gmail.com>
 <CAEnQRZDctjdzQ2RjJXhQh+s=d0y_j3Taa51hDaR4bqJ62C=7iQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <85b4a2c4-761e-bdcf-f05e-2fb16c06f11e@linux.intel.com>
Date:   Wed, 7 Aug 2019 10:22:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDctjdzQ2RjJXhQh+s=d0y_j3Taa51hDaR4bqJ62C=7iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +static int sof_dt_probe(struct platform_device *pdev)
>>>> +{
>>>> +     struct device *dev = &pdev->dev;
>>>> +     const struct sof_dev_desc *desc;
>>>> +     /*TODO: create a generic snd_soc_xxx_mach */
>>>> +     struct snd_soc_acpi_mach *mach;
>>>
>>> I wonder if you really need to use the same structures. For Intel we get
>>> absolutely zero info from the firmware so rely on an ACPI codec ID as a
>>> key to find information on which firmware and topology to use, and which
>>> machine driver to load. You could have all this information in a DT blob?
>>
>> Yes. I see your point. I will still need to make a generic structure for
>> snd_soc_acpi_mach so that everyone can use sof_nocodec_setup function.
>>
>> Maybe something like this:
>>
>> struct snd_soc_mach {
>>    union {
>>    struct snd_soc_acpi_mach acpi_mach;
>>    struct snd_soc_of_mach of_mach;
>>    }
>> };
>>
>> and then change the prototype of sof_nocodec_setup.
> 
> Hi Pierre,
> 
> I fixed all the comments except the one above. Replacing snd_soc_acpi_mach
> with a generic snd_soc_mach is not trivial task.
> 
> I wonder if it is acceptable to get the initial patches as they are
> now and later switch to
> generic ACPI/OF abstraction.
> 
> Asking this because for the moment on the i.MX side I have only
> implemented no codec
> version and we don't probe any of the machine drivers we have.
> 
> So, there is this only one member of snd_soc_acpi_mach that imx
> version is making use of:
> 
>    mach->drv_name = "sof-nocodec";
> 
> That's all.
> 
> I think the change as it is now is very clean and non-intrusive. Later
> we will get options to
> read firmware name and stuff from DT.
> 
> Anyhow, I don't think we can get rid of snd_dev_desc structure on
> i.MX. This will be used
> to store the information read from DT:
> 
> static struct sof_dev_desc sof_of_imx8qxp_desc = {
> »       .default_fw_path = "imx/sof",
> »       .default_tplg_path = "imx/sof-tplg",
> »       .nocodec_fw_filename = "sof-imx8.ri",
> »       .nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
> »       .ops = &sof_imx8_ops,
> };
> 
> For the moment we will only use the default values.

Yes, that's fine for now. If you don't have a real machine driver then 
there's nothing urgent to change.

Is the new version on GitHub?

Thanks
-Pierre
