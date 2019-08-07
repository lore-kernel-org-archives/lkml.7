Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2259BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD41521BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfHGPL2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:11:28 -0400
Received: from mail-oln040092070011.outbound.protection.outlook.com ([40.92.70.11]:5250
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfHGPL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:11:28 -0400
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (10.152.20.51) by DB5EUR03HT106.eop-EUR03.prod.protection.outlook.com
 (10.152.21.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Wed, 7 Aug
 2019 15:11:23 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.20.54) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18 via Frontend Transport; Wed, 7 Aug 2019 15:11:23 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::b952:7cd2:4c8d:e460%4]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 15:11:23 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] ASoC: hdmi-codec: reorder channel allocation list
Thread-Topic: [PATCH] ASoC: hdmi-codec: reorder channel allocation list
Thread-Index: AQHVTTJgrNqnXK20ckCpJVfRK56Stg==
Date:   Wed, 7 Aug 2019 15:11:23 +0000
Message-ID: <HE1PR06MB4011885AED9F32B09183B617ACD40@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::39) To HE1PR06MB4011.eurprd06.prod.outlook.com
 (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:B03E61AC6D8F6D4AC2A1E36925A612D1F5029E87CE33F003A498AF30D2E17EA0;UpperCasedChecksum:7B61337F58BD9B4DDCC07FCCE2708FDAD61D4B649E02FD0D6C8029B970A8256F;SizeAsReceived:7542;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [8m8qlruG5jcMejJd/RQ3QDLtvJ2HNRIK]
x-microsoft-original-message-id: <20190807151102.12445-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT106;
x-ms-traffictypediagnostic: DB5EUR03HT106:
x-microsoft-antispam-message-info: 7LQwicdDVW3OnTsCGLzNf4j34xyzSDJje+4oXs83T26dD6JjBy/9MNlHgh5TM84PbQTGqu/9ZN1QhrqLHjMi1Nd8f8hUPyxfZtK0rOUNXR3cctzGI7rlctOHp/5y2I8Qy4lzs9kZV2kT4haEQVsbdZySEpYeeDAc/MUfK+fS6wxgsEuvijrj1OADrXEv8dC3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8936be24-6be4-4911-a5bc-08d71b49825b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 15:11:23.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong channel allocation is selected by hdmi_codec_get_ch_alloc_table_idx().

E.g when ELD reports FL|FR|LFE|FC|RL|RR or FL|FR|LFE|FC|RL|RR|RC|RLC|RRC

ca_id 0x01 with speaker mask FL|FR|LFE gets selected instead of
ca_id 0x03 with speaker mask FL|FR|LFE|FC for 4 channels

and

ca_id 0x04 with speaker mask FL|FR|RC gets selected instead of
ca_id 0x0b with speaker mask FL|FR|LFE|FC|RL|RR for 6 channels

Fix this by reorder the channel allocation list with
most specific speaker mask at the top.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 sound/soc/codecs/hdmi-codec.c | 115 ++++++++++++++++------------------
 1 file changed, 53 insertions(+), 62 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 0bf1c8cad108..9b5a0a419f86 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -188,84 +188,75 @@ static const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
 /*
  * hdmi_codec_channel_alloc: speaker configuration available for CEA
  *
- * This is an ordered list that must match with hdmi_codec_8ch_chmaps struct
+ * This is an ordered list where ca_id must exist in hdmi_codec_8ch_chmaps
  * The preceding ones have better chances to be selected by
  * hdmi_codec_get_ch_alloc_table_idx().
  */
 static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 	{ .ca_id = 0x00, .n_ch = 2,
-	  .mask = FL | FR},
-	/* 2.1 */
-	{ .ca_id = 0x01, .n_ch = 4,
-	  .mask = FL | FR | LFE},
-	/* Dolby Surround */
+	  .mask = FL | FR },
+	{ .ca_id = 0x03, .n_ch = 4,
+	  .mask = FL | FR | LFE | FC },
 	{ .ca_id = 0x02, .n_ch = 4,
 	  .mask = FL | FR | FC },
-	/* surround51 */
+	{ .ca_id = 0x01, .n_ch = 4,
+	  .mask = FL | FR | LFE },
 	{ .ca_id = 0x0b, .n_ch = 6,
-	  .mask = FL | FR | LFE | FC | RL | RR},
-	/* surround40 */
-	{ .ca_id = 0x08, .n_ch = 6,
-	  .mask = FL | FR | RL | RR },
-	/* surround41 */
-	{ .ca_id = 0x09, .n_ch = 6,
-	  .mask = FL | FR | LFE | RL | RR },
-	/* surround50 */
+	  .mask = FL | FR | LFE | FC | RL | RR },
 	{ .ca_id = 0x0a, .n_ch = 6,
 	  .mask = FL | FR | FC | RL | RR },
-	/* 6.1 */
-	{ .ca_id = 0x0f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | RC },
-	/* surround71 */
+	{ .ca_id = 0x09, .n_ch = 6,
+	  .mask = FL | FR | LFE | RL | RR },
+	{ .ca_id = 0x08, .n_ch = 6,
+	  .mask = FL | FR | RL | RR },
+	{ .ca_id = 0x07, .n_ch = 6,
+	  .mask = FL | FR | LFE | FC | RC },
+	{ .ca_id = 0x06, .n_ch = 6,
+	  .mask = FL | FR | FC | RC },
+	{ .ca_id = 0x05, .n_ch = 6,
+	  .mask = FL | FR | LFE | RC },
+	{ .ca_id = 0x04, .n_ch = 6,
+	  .mask = FL | FR | RC },
 	{ .ca_id = 0x13, .n_ch = 8,
 	  .mask = FL | FR | LFE | FC | RL | RR | RLC | RRC },
-	/* others */
-	{ .ca_id = 0x03, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC },
-	{ .ca_id = 0x04, .n_ch = 8,
-	  .mask = FL | FR | RC},
-	{ .ca_id = 0x05, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC },
-	{ .ca_id = 0x06, .n_ch = 8,
-	  .mask = FL | FR | FC | RC },
-	{ .ca_id = 0x07, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RC },
-	{ .ca_id = 0x0c, .n_ch = 8,
-	  .mask = FL | FR | RC | RL | RR },
-	{ .ca_id = 0x0d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RC },
-	{ .ca_id = 0x0e, .n_ch = 8,
-	  .mask = FL | FR | FC | RL | RR | RC },
-	{ .ca_id = 0x10, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | RLC | RRC },
-	{ .ca_id = 0x11, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
 	{ .ca_id = 0x12, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | RLC | RRC },
-	{ .ca_id = 0x14, .n_ch = 8,
-	  .mask = FL | FR | FLC | FRC },
-	{ .ca_id = 0x15, .n_ch = 8,
-	  .mask = FL | FR | LFE | FLC | FRC },
-	{ .ca_id = 0x16, .n_ch = 8,
-	  .mask = FL | FR | FC | FLC | FRC },
-	{ .ca_id = 0x17, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | FLC | FRC },
-	{ .ca_id = 0x18, .n_ch = 8,
-	  .mask = FL | FR | RC | FLC | FRC },
-	{ .ca_id = 0x19, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FLC | FRC },
-	{ .ca_id = 0x1a, .n_ch = 8,
-	  .mask = FL | FR | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1b, .n_ch = 8,
-	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
-	{ .ca_id = 0x1c, .n_ch = 8,
-	  .mask = FL | FR | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1d, .n_ch = 8,
-	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
 	{ .ca_id = 0x1e, .n_ch = 8,
 	  .mask = FL | FR | FC | RL | RR | FLC | FRC },
-	{ .ca_id = 0x1f, .n_ch = 8,
-	  .mask = FL | FR | LFE | FC | RL | RR | FLC | FRC },
+	{ .ca_id = 0x11, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | FLC | FRC },
+	{ .ca_id = 0x10, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | RLC | RRC },
+	{ .ca_id = 0x1c, .n_ch = 8,
+	  .mask = FL | FR | RL | RR | FLC | FRC },
+	{ .ca_id = 0x0f, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | RL | RR | RC },
+	{ .ca_id = 0x1b, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0e, .n_ch = 8,
+	  .mask = FL | FR | FC | RL | RR | RC },
+	{ .ca_id = 0x1a, .n_ch = 8,
+	  .mask = FL | FR | RC | FC | FLC | FRC },
+	{ .ca_id = 0x0d, .n_ch = 8,
+	  .mask = FL | FR | LFE | RL | RR | RC },
+	{ .ca_id = 0x19, .n_ch = 8,
+	  .mask = FL | FR | LFE | RC | FLC | FRC },
+	{ .ca_id = 0x0c, .n_ch = 8,
+	  .mask = FL | FR | RC | RL | RR },
+	{ .ca_id = 0x18, .n_ch = 8,
+	  .mask = FL | FR | RC | FLC | FRC },
+	{ .ca_id = 0x17, .n_ch = 8,
+	  .mask = FL | FR | LFE | FC | FLC | FRC },
+	{ .ca_id = 0x16, .n_ch = 8,
+	  .mask = FL | FR | FC | FLC | FRC },
+	{ .ca_id = 0x15, .n_ch = 8,
+	  .mask = FL | FR | LFE | FLC | FRC },
+	{ .ca_id = 0x14, .n_ch = 8,
+	  .mask = FL | FR | FLC | FRC },
 };
 
 struct hdmi_codec_priv {
-- 
2.17.1

