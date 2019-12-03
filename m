Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4CEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB320661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLCOg1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:36:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:64921 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCOg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:36:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 06:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="213443837"
Received: from pgsmsx105.gar.corp.intel.com ([10.221.44.96])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2019 06:36:24 -0800
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.12]) by
 PGSMSX105.gar.corp.intel.com ([169.254.4.81]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 22:36:24 +0800
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
Thread-Index: AQHVqaw+ii/fH1J6I0CEgpyDBLMztaeno36AgACHg7D//4yFAIAAv3yg
Date:   Tue, 3 Dec 2019 14:36:23 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7403CACC7@PGSMSX108.gar.corp.intel.com>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
 <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CF33C36214C39B4496568E5578BE70C7403CA7B2@PGSMSX108.gar.corp.intel.com>
 <AM5PR1001MB09946C295B8DAD5F9C8D191080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB09946C295B8DAD5F9C8D191080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDE4YzY5NTYtMmU4NC00YTcyLTgyYjktZDhmNTU4YjY4M2NjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQXVlbWR3VnpZXC9BZzQ4Z1FYcVhxc3hYRFY4ekFaVkc0ZVE0M0xnRXMxNzdtN0lMaXIzVUJMSGpuZ0lRczNYZ0kifQ==
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
> But on platforms where they can enable the WCLK early they shouldn't be
> looping around here for anything like 400ms. In an ideal world when that
> widget is run SRM should hopefully be already locked but the code does
> allow for some delay. Actually, having a long delay also helps show the user
> that something isn't right here so I'm somewhat loathed to change this.
> 
> Even if you do reduce the retry timings what you're still not protecting
> against is the possibility of audio artefacts when SRM finally locks. You want
> this to lock before the any of the audio path is up so I think we need to find a
> way to resolve that rather than relying on getting lucky with a smooth power-
> up.
> 
Hi Adam,

Thanks for the explanation. So the purpose of the code is providing some
timing tolerance for SRM to lock? If so, I would suggest adding warning message
for the lock fail so people have a clue if their design fails the CTS test. Hard to say
if Google further reduces the Cold latency again in the future.


Regards,
Brent
