Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7ACCA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103021928
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfJUCri convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:47:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:32375 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfJUCri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:47:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 19:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,321,1566889200"; 
   d="scan'208";a="203221302"
Received: from pgsmsx105.gar.corp.intel.com ([10.221.44.96])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2019 19:47:35 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 PGSMSX105.gar.corp.intel.com ([169.254.4.226]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 10:47:34 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: bdw-rt5677: enable runtime channel merge
Thread-Topic: [PATCH] ASoC: bdw-rt5677: enable runtime channel merge
Thread-Index: AQHVeQDQJxSKmeHo60W0FoozADL3CqdkfMRQ
Date:   Mon, 21 Oct 2019 02:47:34 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C74031B9FD@PGSMSX108.gar.corp.intel.com>
References: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
In-Reply-To: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGUyMDI2MTItNzU0Zi00ZjMzLWE0NWUtZjVjZjhmNDU2MGQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT1VkQ1ByNGlteHBlOXBhU2l6SU13dnVLSzlFMTNJTGZ6R1ExNWlVbWhXT3ZCUXNoSEFrVHpqQVU5UUE0WUpYZiJ9
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

> Subject: [PATCH] ASoC: bdw-rt5677: enable runtime channel merge
> 
> In the DAI link "Capture PCM", the FE DAI "Capture Pin" supports 4-channel
> capture but the BE DAI supports only 2-channel capture. To fix the channel
> mismatch, we need to enable the runtime channel merge for this DAI link.
> 

Hi Pierre,

This patch is for the same issue discussed in the following thread:
https://patchwork.kernel.org/patch/11134167/

We enable the runtime channel merge for the DMIC DAI instead of adding a
machine driver constraint. It's working good on chrome's 3.14 branch (which
requires some backport for the runtime channel merge feature). Please let
me know if this implementation is correct for the FE/BE mismatch problem.
Thanks.


Regards,
Brent
