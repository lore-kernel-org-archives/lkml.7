Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65257C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC4216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfGECnL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:43:11 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60043 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGECnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:43:11 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x652fP8U003667, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x652fP8U003667
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 5 Jul 2019 10:41:25 +0800
Received: from RTITMBSVM07.realtek.com.tw ([fe80::a512:a803:bf1e:b23]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Fri, 5 Jul 2019
 10:41:25 +0800
From:   Kailang <kailang@realtek.com>
To:     "He, Bo" <bo.he@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "chiu@endlessm.com" <chiu@endlessm.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>
Subject: RE: audio lost from speaker after reboot from windows on the device ALC295
Thread-Topic: audio lost from speaker after reboot from windows on the
 device ALC295
Thread-Index: AdUyX8fMiuN0r83nQWCeaW0Sd+ObdQAepbxA
Date:   Fri, 5 Jul 2019 02:41:24 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D768822@RTITMBSVM07.realtek.com.tw>
References: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo He,

Could you help to dump info for us?
Please use attach file to get results.

./alsa-info.sh --no-upload

You will find dump file in folder /tmp/alsa-info.txt-????????.

Please run one time in normal state and one time in fail state.
Please send two result files to me.

BR,
Kailang

> -----Original Message-----
> From: He, Bo <bo.he@intel.com>
> Sent: Thursday, July 4, 2019 8:02 PM
> To: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Cc: perex@perex.cz; tiwai@suse.com; jian-hong@endlessm.com;
> drake@endlessm.com; chiu@endlessm.com; hui.wang@canonical.com
> Subject: audio lost from speaker after reboot from windows on the device
> ALC295
> 
> Hi, patch_realtek.c maintainer:
> 	I see one issue that reboot from windows and boot to ubuntu, the audio
> lost from speaker, I suspect there are some bugs in patch_realtek.c drivers,
> the device is ALC295 and the device id is 0x10ec0295.
> 
> I have done the below experiments:
> 1. reboot from windows to windows, the audio is persist .
> 2. reboot from windows to ubuntu, the audio lost from speaker, but can hear if
> I hotplug one earphone.
> 3. if the issue reproduce after reboot from windows, reboot the ubuntu can't
> restore the audio, I suspect it's warm reset.
> 4. if I write the port 0xcf9 with 0xe to do cold reset, the audio can restore.
> 5. if I do suspend/resume, the audio can restore, I suspect do cold boot and
> suspend will trigger the platform reset to reset the ALC295.
> 6. if I do double function reset (write the verb 0x7ff in alc_init), the audio is
> still can't restore.
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /*
> Function reset */ snd_hda_codec_write(codec, 0x01, 0,
> AC_VERB_SET_CODEC_RESET, 0); /* double Function reset */ 7. the issue is
> first found on kernel 4.19.50, I still see the issue with the latest kernel 5.2-rc2,
> is it possible windows change some default registers, but ALC295 don't
> initialize the register?
> 
> ------Please consider the environment before printing this e-mail.
