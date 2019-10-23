Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FF3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A09205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbfJWIqB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:46:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56174 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJWIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:46:00 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9N8idV2013066, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9N8idV2013066
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 23 Oct 2019 16:44:39 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 23 Oct 2019 16:44:38 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 23 Oct 2019 16:44:37 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::6d88:58e2:6d4b:ff7c]) by
 RTEXMB01.realtek.com.tw ([fe80::6d88:58e2:6d4b:ff7c%13]) with mapi id
 15.01.1779.005; Wed, 23 Oct 2019 16:44:37 +0800
From:   Kailang <kailang@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>, Aaron Ma <aaron.ma@canonical.com>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
Thread-Topic: [PATCH] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
Thread-Index: AQHViO7vxXHEn3Xl7Ee6N1/g4hdxKqdmTdyAgAGbrzA=
Date:   Wed, 23 Oct 2019 08:44:37 +0000
Message-ID: <848ebd7fd86e4c05936e70f500f718e9@realtek.com>
References: <20191022153855.14368-1-aaron.ma@canonical.com>
 <s5hpniodaq4.wl-tiwai@suse.de>
In-Reply-To: <s5hpniodaq4.wl-tiwai@suse.de>
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



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, October 23, 2019 12:08 AM
> To: Aaron Ma <aaron.ma@canonical.com>
> Cc: perex@perex.cz; Kailang <kailang@realtek.com>;
> hui.wang@canonical.com; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda/realtek - Fix 2 front mics of codec 0x623
> 
> On Tue, 22 Oct 2019 17:38:55 +0200,
> Aaron Ma wrote:
> >
> > These 2 ThinkCentres installed a new realtek codec ID 0x623, it has 2
> > front mics with the same location on pin 0x18 and 0x19.
> >
> > Apply fixup ALC283_FIXUP_HEADSET_MIC to change 1 front mic location to
> > right, then pulseaudio can handle them.
> > One "Front Mic" and one "Mic" will be shown, and audio output works
> > fine.
> >
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> 
> I'd like to have Kailang's review about the new codec before applying.
> 
> Kailang, could you take a look?
OK.
I will post you the patch for ALC623 codec tomorrow.
Thanks.

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/patch_realtek.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c
> > b/sound/pci/hda/patch_realtek.c index b000b36ac3c6..c34d8b435f58
> > 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -7186,6 +7186,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
> = {
> >  	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station",
> ALC294_FIXUP_LENOVO_MIC_LOCATION),
> >  	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station",
> ALC294_FIXUP_LENOVO_MIC_LOCATION),
> >  	SND_PCI_QUIRK(0x17aa, 0x3151, "ThinkCentre Station",
> > ALC283_FIXUP_HEADSET_MIC),
> > +	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station",
> ALC283_FIXUP_HEADSET_MIC),
> > +	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station",
> > +ALC283_FIXUP_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80",
> ALC269_FIXUP_DMIC_THINKPAD_ACPI),
> >  	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210",
> ALC283_FIXUP_INT_MIC),
> >  	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70",
> > ALC269_FIXUP_DMIC_THINKPAD_ACPI), @@ -9187,6 +9189,7 @@ static
> const struct hda_device_id snd_hda_id_realtek[] = {
> >  	HDA_CODEC_ENTRY(0x10ec0298, "ALC298", patch_alc269),
> >  	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
> >  	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
> > +	HDA_CODEC_ENTRY(0x10ec0623, "ALC623", patch_alc269),
> >  	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660",
> patch_alc861),
> >  	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
> >  	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),
> > --
> > 2.17.1
> >
> 
> ------Please consider the environment before printing this e-mail.
