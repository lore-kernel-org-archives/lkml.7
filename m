Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84B52084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="rz0wAKUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGLO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:56:25 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:39750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbfGLO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxs5qsCeuNYH4/4UzT2697l/lLthrTP3fqzCCYPStp8=;
 b=rz0wAKUoJ3qcguchaDOockQ0SsT2CV8lSzSLs9siVC54EnnBnjmPrNNYH2jEsmySTBVeN8qSIPCl3a1k+dBCH2gZN211hIOEKN0CIi/rE6jj0HPMO1pIB5MBFmFIgwvPi1exs520ywcVYKQgwcYi0lWoDXHKRqHQJEmmziamHjY=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5508.eurprd05.prod.outlook.com (20.177.119.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Fri, 12 Jul 2019 14:56:08 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::c860:b386:22a:8ec9%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 14:56:08 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute control
Thread-Topic: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute
 control
Thread-Index: AQHVOMHvGSHQf0Ud+UKXY+OtRfqyFg==
Date:   Fri, 12 Jul 2019 14:56:08 +0000
Message-ID: <20190712145550.27500-7-oleksandr.suvorov@toradex.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:208:55::32) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c81af039-086d-4742-89a9-08d706d91247
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5508;
x-ms-traffictypediagnostic: AM6PR05MB5508:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR05MB5508A3E5DEACCD21F18962D1F9F20@AM6PR05MB5508.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(199004)(189003)(102836004)(186003)(66476007)(52116002)(305945005)(26005)(66946007)(64756008)(66446008)(6506007)(5660300002)(6436002)(86362001)(478600001)(1411001)(66556008)(53936002)(8676002)(386003)(7736002)(316002)(76176011)(66066001)(1076003)(6916009)(54906003)(99286004)(50226002)(14454004)(36756003)(71200400001)(71190400001)(68736007)(6116002)(3846002)(486006)(6512007)(2616005)(6486002)(6306002)(2906002)(966005)(44832011)(11346002)(446003)(8936002)(81166006)(81156014)(4326008)(476003)(256004)(14444005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5508;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xj0zT1vxzCE+6OrGnCIXJrwLTaWZc0G+y2ViOglVfZ+rZ24JTTbfJmit6PF2nllc9RE3YHIevqkxwynuCPf8K8kf7oq+QkJTxcMdS1vXpD6jQLkH1s9yP4eQNmH7qaJaOD+1qM0kD+LauTofU+blyNWLFPc52XMp9h3jViFVyfO+iEwO7bHxOsuL2C5z7qVfGM+6gdXiR7n+BSPGUu5l2OoPMRDKav0DJb4QXfQ+4dM5jwSGBZzQ3TpfCPESOc1P5ps7/TjAbfnKf49oBxcazYzUanzKFCAX76UdJJkt0G5iPlpXrKzrbcJ2L2YYoXO5YVWRweoAjJPFJYA4K3ophkDVCUFbJAZc4Ox/oeVldNGywvrBTk/2XjCHO3un31EiLL32vPn867CV3Y+cr13Fk7UZcMwhuS1JZjPHdipI+j4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81af039-086d-4742-89a9-08d706d91247
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 14:56:08.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change VAG power on/off control according to the following algorithm:
- turn VAG power ON on the 1st incoming event.
- keep it ON if there is any active VAG consumer (ADC/DAC/HP/Line-In).
- turn VAG power OFF when there is the latest consumer's pre-down event
  come.
- always delay after VAG power OFF to avoid pop.
- delay after VAG power ON if the initiative consumer is Line-In, this
  prevents pop during line-in muxing.

Also, according to the data sheet [1], to avoid any pops/clicks,
the outputs should be muted during input/output
routing changes.

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message

Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 227 +++++++++++++++++++++++++++++++-----
 1 file changed, 195 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c256162750d16..9318d9fea72c7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -31,6 +31,13 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
=20
+/* Delay for the VAG ramp up */
+#define SGTL5000_VAG_POWERUP_DELAY 500 /* ms */
+/* Delay for the VAG ramp down */
+#define SGTL5000_VAG_POWERDOWN_DELAY 500 /* ms */
+
+#define SGTL5000_OUTPUTS_MUTE (SGTL5000_HP_MUTE | SGTL5000_LINE_OUT_MUTE)
+
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] =3D {
 	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
@@ -123,6 +130,18 @@ enum  {
 	I2S_SCLK_STRENGTH_HIGH,
 };
=20
+enum {
+	HP_POWER_EVENT,
+	DAC_POWER_EVENT,
+	ADC_POWER_EVENT
+};
+
+struct sgtl5000_mute_state {
+	u16 hp_event;
+	u16 dac_event;
+	u16 adc_event;
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -137,8 +156,109 @@ struct sgtl5000_priv {
 	u8 micbias_voltage;
 	u8 lrclk_strength;
 	u8 sclk_strength;
+	struct sgtl5000_mute_state mute_state;
 };
=20
+static inline int hp_sel_input(struct snd_soc_component *component)
+{
+	return (snd_soc_component_read32(component, SGTL5000_CHIP_ANA_CTRL) &
+		SGTL5000_HP_SEL_MASK) >> SGTL5000_HP_SEL_SHIFT;
+}
+
+static inline u16 mute_output(struct snd_soc_component *component,
+			      u16 mute_mask)
+{
+	u16 mute_reg =3D snd_soc_component_read32(component,
+					      SGTL5000_CHIP_ANA_CTRL);
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+			    mute_mask, mute_mask);
+	return mute_reg;
+}
+
+static inline void restore_output(struct snd_soc_component *component,
+				  u16 mute_mask, u16 mute_reg)
+{
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		mute_mask, mute_reg);
+}
+
+static void vag_power_on(struct snd_soc_component *component, u32 source)
+{
+	if (snd_soc_component_read32(component, SGTL5000_CHIP_ANA_POWER) &
+	    SGTL5000_VAG_POWERUP)
+		return;
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
+			    SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+
+	/* When VAG powering on to get local loop from Line-In, the sleep
+	 * is required to avoid loud pop.
+	 */
+	if (hp_sel_input(component) =3D=3D SGTL5000_HP_SEL_LINE_IN &&
+	    source =3D=3D HP_POWER_EVENT)
+		msleep(SGTL5000_VAG_POWERUP_DELAY);
+}
+
+static int vag_power_consumers(struct snd_soc_component *component,
+			       u16 ana_pwr_reg, u32 source)
+{
+	int consumers =3D 0;
+
+	/* count dac/adc consumers unconditional */
+	if (ana_pwr_reg & SGTL5000_DAC_POWERUP)
+		consumers++;
+	if (ana_pwr_reg & SGTL5000_ADC_POWERUP)
+		consumers++;
+
+	/*
+	 * If the event comes from HP and Line-In is selected,
+	 * current action is 'DAC to be powered down'.
+	 * As HP_POWERUP is not set when HP muxed to line-in,
+	 * we need to keep VAG power ON.
+	 */
+	if (source =3D=3D HP_POWER_EVENT) {
+		if (hp_sel_input(component) =3D=3D SGTL5000_HP_SEL_LINE_IN)
+			consumers++;
+	} else {
+		if (ana_pwr_reg & SGTL5000_HP_POWERUP)
+			consumers++;
+	}
+
+	return consumers;
+}
+
+static void vag_power_off(struct snd_soc_component *component, u32 source)
+{
+	u16 ana_pwr =3D snd_soc_component_read32(component,
+					     SGTL5000_CHIP_ANA_POWER);
+
+	if (!(ana_pwr & SGTL5000_VAG_POWERUP))
+		return;
+
+	/*
+	 * This function calls when any of VAG power consumers is disappearing.
+	 * Thus, if there is more than one consumer at the moment, as minimum
+	 * one consumer will definitely stay after the end of the current
+	 * event.
+	 * Don't clear VAG_POWERUP if 2 or more consumers of VAG present:
+	 * - LINE_IN (for HP events) / HP (for DAC/ADC events)
+	 * - DAC
+	 * - ADC
+	 * (the current consumer is disappearing right now)
+	 */
+	if (vag_power_consumers(component, ana_pwr, source) >=3D 2)
+		return;
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
+		SGTL5000_VAG_POWERUP, 0);
+	/* In power down case, we need wait 400-1000 ms
+	 * when VAG fully ramped down.
+	 * As longer we wait, as smaller pop we've got.
+	 */
+	msleep(SGTL5000_VAG_POWERDOWN_DELAY);
+}
+
 /*
  * mic_bias power on/off share the same register bits with
  * output impedance of mic bias, when power on mic bias, we
@@ -170,40 +290,79 @@ static int mic_bias_event(struct snd_soc_dapm_widget =
*w,
 	return 0;
 }
=20
-/*
- * As manual described, ADC/DAC only works when VAG powerup,
- * So enabled VAG before ADC/DAC up.
- * In power down case, we need wait 400ms when vag fully ramped down.
- */
-static int power_vag_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
+static void vag_and_mute_control(struct snd_soc_component *component,
+				 int event, int event_source,
+				 u16 mute_mask, u16 *mute_reg)
 {
-	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->dapm=
);
-	const u32 mask =3D SGTL5000_DAC_POWERUP | SGTL5000_ADC_POWERUP;
-
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
-		msleep(400);
+	case SND_SOC_DAPM_PRE_PMU:
+		*mute_reg =3D mute_output(component, mute_mask);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		vag_power_on(component, event_source);
+		restore_output(component, mute_mask, *mute_reg);
 		break;
-
 	case SND_SOC_DAPM_PRE_PMD:
-		/*
-		 * Don't clear VAG_POWERUP, when both DAC and ADC are
-		 * operational to prevent inadvertently starving the
-		 * other one of them.
-		 */
-		if ((snd_soc_component_read32(component, SGTL5000_CHIP_ANA_POWER) &
-				mask) !=3D mask) {
-			snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_VAG_POWERUP, 0);
-			msleep(400);
-		}
+		*mute_reg =3D mute_output(component, mute_mask);
+		vag_power_off(component, event_source);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		restore_output(component, mute_mask, *mute_reg);
 		break;
 	default:
 		break;
 	}
+}
+
+/*
+ * Mute Headphone when power it up/down.
+ * Control VAG power on HP power path.
+ */
+static int headphone_pga_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, HP_POWER_EVENT,
+			     SGTL5000_HP_MUTE,
+			     &sgtl5000->mute_state.hp_event);
+
+	return 0;
+}
+
+/* As manual describes, ADC/DAC powering up/down requires
+ * to mute outputs to avoid pops.
+ * Control VAG power on ADC/DAC power path.
+ */
+static int adc_updown_depop(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, ADC_POWER_EVENT,
+			     SGTL5000_OUTPUTS_MUTE,
+			     &sgtl5000->mute_state.adc_event);
+
+	return 0;
+}
+
+static int dac_updown_depop(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, DAC_POWER_EVENT,
+			     SGTL5000_OUTPUTS_MUTE,
+			     &sgtl5000->mute_state.dac_event);
=20
 	return 0;
 }
@@ -280,7 +439,10 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_=
widgets[] =3D {
 			    mic_bias_event,
 			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
=20
-	SND_SOC_DAPM_PGA("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_E("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0,
+			   headphone_pga_event,
+			   SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
 	SND_SOC_DAPM_PGA("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0),
=20
 	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
@@ -301,11 +463,12 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm=
_widgets[] =3D {
 				0, SGTL5000_CHIP_DIG_POWER,
 				1, 0),
=20
-	SND_SOC_DAPM_ADC("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0),
-	SND_SOC_DAPM_DAC("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0),
-
-	SND_SOC_DAPM_PRE("VAG_POWER_PRE", power_vag_event),
-	SND_SOC_DAPM_POST("VAG_POWER_POST", power_vag_event),
+	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0,
+			   adc_updown_depop, SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0,
+			   dac_updown_depop, SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
 };
=20
 /* routes for sgtl5000 */
--=20
2.20.1

