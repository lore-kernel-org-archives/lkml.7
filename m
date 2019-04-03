Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1107C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B272820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDCUJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:09:25 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:41057 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726064AbfDCUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:09:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DF58F100E86C4;
        Wed,  3 Apr 2019 20:09:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail86_17132dd0dc250
X-Filterd-Recvd-Size: 11986
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Apr 2019 20:09:18 +0000 (UTC)
Message-ID: <c2f6a9f0ea59dc1491a8429a51afe56e488dfb3c.camel@perches.com>
Subject: Re: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
From:   Joe Perches <joe@perches.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Date:   Wed, 03 Apr 2019 13:09:17 -0700
In-Reply-To: <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
References: <cover.1554114302.git.agx@sigxcpu.org>
         <20190403161735.GN5238@ulmo>
         <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 10:11 -0700, Joe Perches wrote:
> On Wed, 2019-04-03 at 18:17 +0200, Thierry Reding wrote:
> > On Mon, Apr 01, 2019 at 12:35:32PM +0200, Guido Günther wrote:
> > > v4 fixes up the DT binding example and uses a wider cc list since I
> > > failed to extend that when touching more files.
> []
> > Applied, thanks.
> > 
> > checkpatch does complain about the dsi_generic_write_seq() macro
> > definition, because it uses flow control statements, but there are
> > already similar macros in other drivers, so I let this slide. We may
> > want to eventually come up with something better and then replace these
> > macros for the other drivers as well.
> 
> Dunno about the other drivers, but the mechanism isn't
> particularly nice as it separates the init identifier
> from the data being written.
> 
> It might be better to use something like a struct for
> each command and a for loop for each block of commands.
> 
> Also the 0xBF value used in one of the init sequence
> writes does not have an identifier #define in the
> 'Manufacturer specific Commands send via DSI' block
> which is odd.

Perhaps something like this below
(though adding a bunch of lines to avoid a macro goto isn't great)
It does seem to read a bit better to me though.
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 210 +++++++++++++--------
 1 file changed, 136 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index 158a6d548068..7862863db5f7 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -20,27 +20,6 @@
 
 #define DRV_NAME "panel-rocktech-jh057n00900"
 
-/* Manufacturer specific Commands send via DSI */
-#define ST7703_CMD_ALL_PIXEL_OFF 0x22
-#define ST7703_CMD_ALL_PIXEL_ON	 0x23
-#define ST7703_CMD_SETDISP	 0xB2
-#define ST7703_CMD_SETRGBIF	 0xB3
-#define ST7703_CMD_SETCYC	 0xB4
-#define ST7703_CMD_SETBGP	 0xB5
-#define ST7703_CMD_SETVCOM	 0xB6
-#define ST7703_CMD_SETOTP	 0xB7
-#define ST7703_CMD_SETPOWER_EXT	 0xB8
-#define ST7703_CMD_SETEXTC	 0xB9
-#define ST7703_CMD_SETMIPI	 0xBA
-#define ST7703_CMD_SETVDC	 0xBC
-#define ST7703_CMD_SETSCR	 0xC0
-#define ST7703_CMD_SETPOWER	 0xC1
-#define ST7703_CMD_SETPANEL	 0xCC
-#define ST7703_CMD_SETGAMMA	 0xE0
-#define ST7703_CMD_SETEQ	 0xE3
-#define ST7703_CMD_SETGIP1	 0xE9
-#define ST7703_CMD_SETGIP2	 0xEA
-
 struct jh057n {
 	struct device *dev;
 	struct drm_panel panel;
@@ -51,75 +30,153 @@ struct jh057n {
 	struct dentry *debugfs;
 };
 
+struct st7703_cmd {
+	const size_t	size;
+	const u8	data[];
+};
+
+#define st7703_cmd_data(cmd, ...)					\
+	.size = 1 + (sizeof((u8[]){__VA_ARGS__})/sizeof(u8)),		\
+	.data = {cmd, __VA_ARGS__}
+
+/* Manufacturer specific Commands send via DSI */
+static const struct st7703_cmd ST7703_CMD_ALL_PIXEL_OFF = {
+	st7703_cmd_data(0x22)
+};
+static const struct st7703_cmd ST7703_CMD_ALL_PIXEL_ON = {
+	st7703_cmd_data(0x23)
+};
+static const struct st7703_cmd ST7703_CMD_SETDISP = {
+	st7703_cmd_data(0xB2,
+			0xF0, 0x12, 0x30)
+};
+static const struct st7703_cmd ST7703_CMD_SETRGBIF = {
+	st7703_cmd_data(0xB3,
+			0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
+			0x00, 0x00)
+};
+static const struct st7703_cmd ST7703_CMD_SETCYC = {
+	st7703_cmd_data(0xB4,
+			0x80)
+};
+static const struct st7703_cmd ST7703_CMD_SETBGP = {
+	st7703_cmd_data(0xB5,
+			0x08, 0x08)
+};
+static const struct st7703_cmd ST7703_CMD_SETVCOM = {
+	st7703_cmd_data(0xB6,
+			0x3F, 0x3F)
+};
+static const struct st7703_cmd ST7703_CMD_SETOTP = {
+	st7703_cmd_data(0xB7)
+};
+static const struct st7703_cmd ST7703_CMD_SETPOWER_EXT = {
+	st7703_cmd_data(0xB8)
+};
+static const struct st7703_cmd ST7703_CMD_SETEXTC = {
+	st7703_cmd_data(0xB9,
+			0xF1, 0x12, 0x83)
+};
+static const struct st7703_cmd ST7703_CMD_SETMIPI = {
+	st7703_cmd_data(0xBA)
+};
+static const struct st7703_cmd ST7703_CMD_SETVDC = {
+	st7703_cmd_data(0xBC,
+			0x4E)
+};
+static const struct st7703_cmd ST7703_CMD_SETSCR = {
+	st7703_cmd_data(0xC0,
+			0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
+			0x00)
+};
+static const struct st7703_cmd ST7703_CMD_SETPOWER = {
+	st7703_cmd_data(0xC1)
+};
+static const struct st7703_cmd ST7703_CMD_SETPANEL = {
+	st7703_cmd_data(0xCC,
+			0x0B)
+};
+static const struct st7703_cmd ST7703_CMD_SETGAMMA = {
+	st7703_cmd_data(0xE0,
+			0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
+			0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
+			0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
+			0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
+			0x11, 0x18)
+};
+static const struct st7703_cmd ST7703_CMD_SETEQ = {
+	st7703_cmd_data(0xE3,
+			0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
+			0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10)
+};
+static const struct st7703_cmd ST7703_CMD_SETGIP1 = {
+	st7703_cmd_data(0xE9,
+			0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
+			0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
+			0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
+			0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
+			0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
+			0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
+};
+
+static const struct st7703_cmd ST7703_CMD_SETGIP2 = {
+	st7703_cmd_data(0xEA,
+			0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
+			0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
+			0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
+			0xA5, 0x00, 0x00, 0x00, 0x00)
+};
+
 static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
 {
 	return container_of(panel, struct jh057n, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int jh057n_init_sequence(struct jh057n *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct device *dev = ctx->dev;
+	int i;
 	int ret;
+	static const struct {
+		const struct st7703_cmd *cmd;
+		int msleep;
+	} st7703_init[] = {
+		{&ST7703_CMD_SETEXTC, 0},
+		{&ST7703_CMD_SETRGBIF, 0},
+		{&ST7703_CMD_SETSCR, 0},
+		{&ST7703_CMD_SETVDC, 0},
+		{&ST7703_CMD_SETPANEL, 0},
+		{&ST7703_CMD_SETCYC, 0},
+		{&ST7703_CMD_SETDISP, 0},
+		{&ST7703_CMD_SETEQ, 0},
+		{&ST7703_CMD_SETBGP, 20},
+		{&ST7703_CMD_SETVCOM, 0},
+		{&ST7703_CMD_SETGIP1, 0},
+		{&ST7703_CMD_SETGIP2, 0},
+		{&ST7703_CMD_SETGAMMA, 20},
+};
 
 	/*
 	 * Init sequence was supplied by the panel vendor. Most of the commands
 	 * resemble the ST7703 but the number of parameters often don't match
 	 * so it's likely a clone.
 	 */
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
-			      0xF1, 0x12, 0x83);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
-			      0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
-			      0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
-			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
-			      0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
-			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
-			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
-	msleep(20);
 
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
-	dsi_generic_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
-			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
-			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
-			      0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
-			      0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
-			      0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
-			      0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			      0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
-			      0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
-			      0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
-			      0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
-			      0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
-			      0xA5, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
-			      0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
-			      0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
-			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
-			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
-			      0x11, 0x18);
-	msleep(20);
+	for (i = 0; i < ARRAY_SIZE(st7703_init); i++) {
+		ret = mipi_dsi_generic_write(dsi, st7703_init[i].cmd->data,
+					     st7703_init[i].cmd->size);
+		if (ret < 0)
+			return ret;
+		if (st7703_init[i].msleep)
+			msleep(st7703_init[i].msleep);
+	}
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -240,9 +297,14 @@ static int allpixelson_set(void *data, u64 val)
 {
 	struct jh057n *ctx = data;
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
 
 	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
-	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
+	ret = mipi_dsi_generic_write(dsi, ST7703_CMD_ALL_PIXEL_ON.data,
+				     ST7703_CMD_ALL_PIXEL_ON.size);
+	if (ret < 0)							\
+		return ret;						\
+
 	msleep(val * 1000);
 	/* Reset the panel to get video back */
 	drm_panel_disable(&ctx->panel);

