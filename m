Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D3AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259A820838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfL0H3h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:29:37 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42653 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0H3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:29:37 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBR7SWHC007914, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBR7SWHC007914
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Dec 2019 15:28:32 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 27 Dec 2019 15:28:32 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Dec 2019 15:28:32 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0]) by
 RTEXMB01.realtek.com.tw ([fe80::a917:b20f:da75:59e0%6]) with mapi id
 15.01.1779.005; Fri, 27 Dec 2019 15:28:32 +0800
From:   Kailang <kailang@realtek.com>
To:     Chris Chiu <chiu@endlessm.com>, "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "tomas.espeleta@gmail.com" <tomas.espeleta@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: RE: [PATCH] ALSA: hda/realtek - Enable the subwoofer of ASUS UX431FLC
Thread-Topic: [PATCH] ALSA: hda/realtek - Enable the subwoofer of ASUS
 UX431FLC
Thread-Index: AQHVvILsIv0873NG0EWanwSIV4Ilq6fNlBfw
Date:   Fri, 27 Dec 2019 07:28:32 +0000
Message-ID: <9a6937eb53264ef99409ac234fffe8af@realtek.com>
References: <20191227065724.2581-1-chris.chiu@pacidal.com>
In-Reply-To: <20191227065724.2581-1-chris.chiu@pacidal.com>
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

Hi all,

Current kernel had exist function alc285_fixup_speaker2_to_dac1 to fixed dac for 0x17.
Replace as below.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index fada1ff61353..0193a8722be2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5950,7 +5960,8 @@ enum {
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
-	ALC294_FIXUP_ASUS_INTSPK_GPIO,
+	ALC294_FIXUP_ASUS_DUAL_SPEAKERS,
+	ALC294_FIXUP_FIXED_DAC_SUBWOOFER,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -7097,10 +7108,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		}
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
+	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
 			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
@@ -7117,12 +7127,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
+	[ALC294_FIXUP_FIXED_DAC_SUBWOOFER] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
+	[ALC294_FIXUP_ASUS_DUAL_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		/* The GPIO must be pulled to initialize the AMP */
 		.v.func = alc_fixup_gpio4,
 		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
+		.chain_id = ALC294_FIXUP_FIXED_DAC_SUBWOOFER
 	},
 };
 
@@ -7291,7 +7307,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_GPIO),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", 
+ALC294_FIXUP_ASUS_DUAL_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
--

> -----Original Message-----
> From: Chris Chiu <chiu@endlessm.com>
> Sent: Friday, December 27, 2019 2:57 PM
> To: perex@perex.cz; tiwai@suse.com; Kailang <kailang@realtek.com>;
> hui.wang@canonical.com; tomas.espeleta@gmail.com
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> linux@endlessm.com; Chris Chiu <chiu@endlessm.com>; Jian-Hong Pan
> <jian-hong@endlessm.com>
> Subject: [PATCH] ALSA: hda/realtek - Enable the subwoofer of ASUS UX431FLC
> 
> From: Chris Chiu <chiu@endlessm.com>
> 
> ASUS reported that there's an additional speaker which serves as the
> subwoofer and uses DAC 0x02. It does not work with the commit
> 73a723348a43 ("ALSA: hda/realtek - Enable internal speaker of ASUS
> UX431FLC") which enables the amplifier and front speakers. This commit
> enables the subwoofer to improve the acoustic experience.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  sound/pci/hda/patch_realtek.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index fada1ff61353..0193a8722be2 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5576,6 +5576,16 @@ static void alc295_fixup_disable_dac3(struct
> hda_codec *codec,
>  	}
>  }
> 
> +/* Fixed DAC (0x02) on NID 0x17 to enable the mono speaker */ static
> +void alc294_fixup_fixed_dac_subwoofer(struct hda_codec *codec,
> +					const struct hda_fixup *fix, int action) {
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
> +		hda_nid_t conn[1] = { 0x02 };
> +		snd_hda_override_conn_list(codec, 0x17, 1, conn);
> +	}
> +}
> +
>  /* Hook to update amp GPIO4 for automute */  static void
> alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
>  					  struct hda_jack_callback *jack)
> @@ -5950,7 +5960,8 @@ enum {
>  	ALC269VC_FIXUP_ACER_HEADSET_MIC,
>  	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
>  	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
> -	ALC294_FIXUP_ASUS_INTSPK_GPIO,
> +	ALC294_FIXUP_ASUS_DUAL_SPEAKERS,
> +	ALC294_FIXUP_FIXED_DAC_SUBWOOFER,
>  };
> 
>  static const struct hda_fixup alc269_fixups[] = { @@ -7097,10 +7108,9 @@
> static const struct hda_fixup alc269_fixups[] = {
>  			{ }
>  		}
>  	},
> -	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
> +	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
>  		.type = HDA_FIXUP_PINS,
>  		.v.pins = (const struct hda_pintbl[]) {
> -			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
>  			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own
> jack detect */
>  			{ }
>  		},
> @@ -7117,12 +7127,18 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
>  	},
> -	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
> +	[ALC294_FIXUP_FIXED_DAC_SUBWOOFER] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc294_fixup_fixed_dac_subwoofer,
> +		.chained = true,
> +		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
> +	},
> +	[ALC294_FIXUP_ASUS_DUAL_SPEAKERS] = {
>  		.type = HDA_FIXUP_FUNC,
>  		/* The GPIO must be pulled to initialize the AMP */
>  		.v.func = alc_fixup_gpio4,
>  		.chained = true,
> -		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
> +		.chain_id = ALC294_FIXUP_FIXED_DAC_SUBWOOFER
>  	},
>  };
> 
> @@ -7291,7 +7307,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]
> = {
>  	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E",
> ALC269VB_FIXUP_ASUS_ZENBOOK),
>  	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A",
> ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
>  	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50",
> ALC269_FIXUP_STEREO_DMIC),
> -	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL",
> ALC294_FIXUP_ASUS_INTSPK_GPIO),
> +	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL",
> +ALC294_FIXUP_ASUS_DUAL_SPEAKERS),
>  	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA",
> ALC256_FIXUP_ASUS_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw",
> ALC269_FIXUP_ASUS_G73JW),
>  	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD",
> ALC256_FIXUP_ASUS_MIC),
> --
> 2.20.1

