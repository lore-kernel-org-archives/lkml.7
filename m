Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40489C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF86205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCKc4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:32:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:29341 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:32:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 02:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="412136254"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 02:32:54 -0800
Received: from pgsmsx110.gar.corp.intel.com (10.221.44.111) by
 PGSMSX107.gar.corp.intel.com (10.221.44.105) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 18:32:53 +0800
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.12]) by
 PGSMSX110.gar.corp.intel.com ([10.221.44.111]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 18:32:53 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Topic: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Index: AQHVqaw+ii/fH1J6I0CEgpyDBLMztaeno36AgACHg7A=
Date:   Tue, 3 Dec 2019 10:32:52 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7403CA7B2@PGSMSX108.gar.corp.intel.com>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
 <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWVmODk2NjMtYmIxMi00NmE2LTk1ZTQtMzFhZWZhYjJmMzk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicDgwQ21lR04zek40bDZzcjYrSVZMQSt1M1ptZEt1Q0gyMG0xdzVWY3hnZ3NQYU1tTDRuUTJBakZkNVlydXY0ZCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> We can potentially reduce the timings here for something shorter although
> I'd need to speak with the HW team as to what, if any reduction is feasible.
> However this is not a real fix as there's potential for audible noises when you
> don't enable WCLK first. As far as I can tell the Intel platforms are capable of
> enabling clocks early, as can be seen in this board file with early SCLK enable:
> 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/kbl_rt
> 5663_max98927.c#L99
> 
> I think there's a need to find some method to enable the WCLK signal
> otherwise there's the potential for audible artefacts when SRM finally locks
> which is not going to be pleasant.
> 

Hi Adam,

Thanks for reply. This patch is not fixing any bug. It just shorten the audio latency
on our boards. Basically we are idling there for 400ms then print a warning message
about SRM not being locked. It seems to me that 400ms is too much even for those
platforms which are able to provide WCLK before calling snd_soc_dai_set_pll()
function but it relies on your HW team to provide the number.

On KBL platform we have interface to control MCLK and I2S clocks like the link
you mentioned but WCLK seems not working on my board. I can try to ask if
someone is working on it but since we are moving to SOF. The chance is slim for
legacy firmware.


Regards,
Brent

