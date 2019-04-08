Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD62C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7FC20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q1i5Dr78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDHIUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:20:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbfDHIUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:20:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x388BUsB019494;
        Mon, 8 Apr 2019 10:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=CqHs/jaitMSztqlNiSrgbDEl5Iddpk+ykCl1Y5V5RM0=;
 b=q1i5Dr78BJ2wnyM/1RrrJN0tpUn+IoOT4Gr0b1zBn13OOBI4JXP5Jbkz7bVHvotHa1hV
 NdMU6SahdLMqzPFafQ3eakncWFpxrNo4xuCcHjJY93B3G2wZ+EfiPFsP60WTyURSrQZW
 +TxxOVokoi5vnywOuZZYpiBET/AE3EWCBd85TzsPpEZbvhdh95rt9d09KivgB9s3fCyM
 /ongPSMXt65ppG1sbFRyDUFLIAs2+K/Gq2ZlLviuNUIu2pwBGO73pDPAZ35cPgh9zMSN
 Zj/OoNiMktDAEVcYX1xxtCkXi1+JzAw/gCHgby7CgCEwFul8KSa+Jh9s13W9WIIt6cNn xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7w9u47-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 10:20:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0779941;
        Mon,  8 Apr 2019 08:20:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AAA0134F;
        Mon,  8 Apr 2019 08:20:10 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 10:20:09 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 8 Apr 2019 10:20:09 +0200
From:   Mickael GUENE <mickael.guene@st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Hugues FRUCHET" <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "Ricardo Ribalda Delgado" <ricardo@ribalda.com>,
        Jason Chen <jasonx.z.chen@intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Alan Chiang <alanx.chiang@intel.com>
Subject: Re: [PATCH v4 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL bridge
 driver
Thread-Topic: [PATCH v4 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL
 bridge driver
Thread-Index: AQHU5INPBzEuyOAdaEy6/O7Wikj2j6Yu5B6AgAL5EgA=
Date:   Mon, 8 Apr 2019 08:20:09 +0000
Message-ID: <4feccc4c-5873-5854-c1b8-6a32d6fc473f@st.com>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-3-git-send-email-mickael.guene@st.com>
 <20190406105606.rciacao5d4hljbbu@kekkonen.localdomain>
In-Reply-To: <20190406105606.rciacao5d4hljbbu@kekkonen.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9BC368CE8BE35C489D3D69E2F707BB00@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/6/19 12:56, Sakari Ailus wrote:
> Hi Mickael,
>=20
> On Wed, Mar 27, 2019 at 10:55:44AM +0100, Mickael Guene wrote:
>> This V4L2 subdev driver enables STMicroelectronics MIPID02 device.
>>
>> Signed-off-by: Mickael Guene <mickael.guene@st.com>
>> ---
>>
>> Changes in v4:
>> - Add support of enum_mbus_code
>> - Only use V4L2_CID_PIXEL_RATE to compute link speed
>> - Use MEDIA_BUS_FMT_UYVY8_1X16 instead of MEDIA_BUS_FMT_UYVY8_2X8 for CS=
I-2 link
>> - Fix miscellaneous typos
>> - Fix wrong code behavior for set_fmt and get_fmt
>>
>> Changes in v3:
>> - Fix potential wrong error code for mipid02_stream_disable and mipid02_=
stream_enable
>> - Remove useless memset for ep in mipid02_parse_rx_ep and mipid02_parse_=
tx_ep
>> - Add second CSI-2 input pad even if it's not yet supported
>> - Add support of get_fmt, set_fmt and link_validate and only access subd=
ev connected to mipid02
>>
>> Changes in v2:
>> - Merge MAINTAINERS patch 3 into patch 1 and 2
>> - Fix line too long in Kconfig
>> - Add missing delay after reset release
>> - Various style fixes
>> - Fix mipid02_stream_enable returning no error when mipid02_find_sensor =
failed
>>
>>  MAINTAINERS                    |    1 +
>>  drivers/media/i2c/Kconfig      |   14 +
>>  drivers/media/i2c/Makefile     |    1 +
>>  drivers/media/i2c/st-mipid02.c | 1043 +++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 1059 insertions(+)
>>  create mode 100644 drivers/media/i2c/st-mipid02.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 74da99d..a14fe81 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14673,6 +14673,7 @@ M:	Mickael Guene <mickael.guene@st.com>
>>  L:	linux-media@vger.kernel.org
>>  T:	git git://linuxtv.org/media_tree.git
>>  S:	Maintained
>> +F:	drivers/media/i2c/st-mipid02.c
>>  F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
>> =20
>>  ST STM32 I2C/SMBUS DRIVER
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index 1a1746b..2dc9e15 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -1135,6 +1135,20 @@ config VIDEO_I2C
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called video-i2c
>> =20
>> +config VIDEO_ST_MIPID02
>> +	tristate "STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge"
>> +	depends on I2C && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
>> +	depends on MEDIA_CAMERA_SUPPORT
>> +	depends on MEDIA_CONTROLLER
>=20
> VIDEO_V4L2_SUBDEV_API already requires MEDIA_CONTROLLER, so
> MEDIA_CONTROLLER here is redundant.
>=20
ok I will remove it.
>> +	select V4L2_FWNODE
>> +	help
>> +	  Support for STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge.
>> +	  It is used to allow usage of CSI-2 sensor with PARALLEL port
>> +	  controller.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called st-mipid02.
>> +
>>  endmenu
>> =20
>>  endif
>> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
>> index a64fca8..d8ad9da 100644
>> --- a/drivers/media/i2c/Makefile
>> +++ b/drivers/media/i2c/Makefile
>> @@ -113,5 +113,6 @@ obj-$(CONFIG_VIDEO_IMX258)	+=3D imx258.o
>>  obj-$(CONFIG_VIDEO_IMX274)	+=3D imx274.o
>>  obj-$(CONFIG_VIDEO_IMX319)	+=3D imx319.o
>>  obj-$(CONFIG_VIDEO_IMX355)	+=3D imx355.o
>> +obj-$(CONFIG_VIDEO_ST_MIPID02) +=3D st-mipid02.o
>> =20
>>  obj-$(CONFIG_SDR_MAX2175) +=3D max2175.o
>> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid=
02.c
>> new file mode 100644
>> index 0000000..1d09bae
>> --- /dev/null
>> +++ b/drivers/media/i2c/st-mipid02.c
>> @@ -0,0 +1,1043 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for ST MIPID02 CSI-2 to PARALLEL bridge
>> + *
>> + * Copyright (C) STMicroelectronics SA 2019
>> + * Authors: Mickael Guene <mickael.guene@st.com>
>> + *          for STMicroelectronics.
>> + *
>> + *
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of_graph.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <media/v4l2-async.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-fwnode.h>
>> +#include <media/v4l2-subdev.h>
>> +
>> +#define MIPID02_CLK_LANE_WR_REG1			0x01
>> +#define MIPID02_CLK_LANE_REG1				0x02
>> +#define MIPID02_CLK_LANE_REG3				0x04
>> +#define MIPID02_DATA_LANE0_REG1				0x05
>> +#define MIPID02_DATA_LANE0_REG2				0x06
>> +#define MIPID02_DATA_LANE1_REG1				0x09
>> +#define MIPID02_DATA_LANE1_REG2				0x0a
>> +#define MIPID02_MODE_REG1				0x14
>> +#define MIPID02_MODE_REG2				0x15
>> +#define MIPID02_DATA_ID_RREG				0x17
>> +#define MIPID02_DATA_SELECTION_CTRL			0x19
>> +#define MIPID02_PIX_WIDTH_CTRL				0x1e
>> +#define MIPID02_PIX_WIDTH_CTRL_EMB			0x1f
>> +
>> +/* Bits definition for MIPID02_CLK_LANE_REG1 */
>> +#define CLK_ENABLE					BIT(0)
>> +/* Bits definition for MIPID02_CLK_LANE_REG3 */
>> +#define CLK_MIPI_CSI					BIT(1)
>> +/* Bits definition for MIPID02_DATA_LANE0_REG1 */
>> +#define DATA_ENABLE					BIT(0)
>> +/* Bits definition for MIPID02_DATA_LANEx_REG2 */
>> +#define DATA_MIPI_CSI					BIT(0)
>> +/* Bits definition for MIPID02_MODE_REG1 */
>> +#define MODE_DATA_SWAP					BIT(2)
>> +#define MODE_NO_BYPASS					BIT(6)
>> +/* Bits definition for MIPID02_MODE_REG2 */
>> +#define MODE_HSYNC_ACTIVE_HIGH				BIT(1)
>> +#define MODE_VSYNC_ACTIVE_HIGH				BIT(2)
>> +/* Bits definition for MIPID02_DATA_SELECTION_CTRL */
>> +#define SELECTION_MANUAL_DATA				BIT(2)
>> +#define SELECTION_MANUAL_WIDTH				BIT(3)
>> +
>> +static const u32 mipid02_supported_fmt_codes[] =3D {
>> +	MEDIA_BUS_FMT_SBGGR8_1X8, MEDIA_BUS_FMT_SGBRG8_1X8,
>> +	MEDIA_BUS_FMT_SGRBG8_1X8, MEDIA_BUS_FMT_SRGGB8_1X8,
>> +	MEDIA_BUS_FMT_SBGGR10_1X10, MEDIA_BUS_FMT_SGBRG10_1X10,
>> +	MEDIA_BUS_FMT_SGRBG10_1X10, MEDIA_BUS_FMT_SRGGB10_1X10,
>> +	MEDIA_BUS_FMT_SBGGR12_1X12, MEDIA_BUS_FMT_SGBRG12_1X12,
>> +	MEDIA_BUS_FMT_SGRBG12_1X12, MEDIA_BUS_FMT_SRGGB12_1X12,
>> +	MEDIA_BUS_FMT_UYVY8_1X16, MEDIA_BUS_FMT_BGR888_1X24
>> +};
>> +
>> +/* regulator supplies */
>> +static const char * const mipid02_supply_name[] =3D {
>> +	"VDDE", /* 1.8V digital I/O supply */
>> +	"VDDIN", /* 1V8 voltage regulator supply */
>> +};
>> +
>> +#define MIPID02_NUM_SUPPLIES		ARRAY_SIZE(mipid02_supply_name)
>> +
>> +#define MIPID02_SINK_0			0
>> +#define MIPID02_SINK_1			1
>> +#define MIPID02_SOURCE			2
>> +#define MIPID02_PAD_NB			3
>> +
>> +struct mipid02_dev {
>> +	struct i2c_client *i2c_client;
>> +	struct regulator_bulk_data supplies[MIPID02_NUM_SUPPLIES];
>> +	struct v4l2_subdev sd;
>> +	struct media_pad pad[MIPID02_PAD_NB];
>> +	struct clk *xclk;
>> +	struct gpio_desc *reset_gpio;
>> +	/* endpoints info */
>> +	struct v4l2_fwnode_endpoint rx;
>> +	u64 link_frequency;
>> +	struct v4l2_fwnode_endpoint tx;
>> +	/* remote source */
>> +	struct v4l2_async_subdev asd;
>> +	struct v4l2_async_notifier notifier;
>> +	struct v4l2_subdev *s_subdev;
>> +	/* registers */
>> +	struct {
>> +		u8 clk_lane_reg1;
>> +		u8 data_lane0_reg1;
>> +		u8 data_lane1_reg1;
>> +		u8 mode_reg1;
>> +		u8 mode_reg2;
>> +		u8 data_id_rreg;
>> +		u8 pix_width_ctrl;
>> +		u8 pix_width_ctrl_emb;
>> +	} r;
>> +	/* lock to protect all members below */
>> +	struct mutex lock;
>> +	bool streaming;
>> +	struct v4l2_mbus_framefmt fmt;
>> +};
>> +
>> +static int bpp_from_code(__u32 code)
>> +{
>> +	switch (code) {
>> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
>> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
>> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
>> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
>> +		return 8;
>> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
>> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
>> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
>> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
>> +		return 10;
>> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
>> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
>> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
>> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
>> +		return 12;
>> +	case MEDIA_BUS_FMT_UYVY8_1X16:
>> +		return 16;
>> +	case MEDIA_BUS_FMT_BGR888_1X24:
>> +		return 24;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static u8 data_type_from_code(__u32 code)
>> +{
>> +	switch (code) {
>> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
>> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
>> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
>> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
>> +		return 0x2a;
>> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
>> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
>> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
>> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
>> +		return 0x2b;
>> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
>> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
>> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
>> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
>> +		return 0x2c;
>> +	case MEDIA_BUS_FMT_UYVY8_1X16:
>> +		return 0x1e;
>> +	case MEDIA_BUS_FMT_BGR888_1X24:
>> +		return 0x24;
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>> +static void init_format(struct v4l2_mbus_framefmt *fmt)
>> +{
>> +	fmt->code =3D MEDIA_BUS_FMT_SBGGR8_1X8;
>> +	fmt->field =3D V4L2_FIELD_NONE;
>> +	fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
>> +	fmt->ycbcr_enc =3D V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB);
>> +	fmt->quantization =3D V4L2_QUANTIZATION_FULL_RANGE;
>> +	fmt->xfer_func =3D V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB);
>> +	fmt->width =3D 640;
>> +	fmt->height =3D 480;
>> +}
>> +
>> +static __u32 get_fmt_code(__u32 code)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(mipid02_supported_fmt_codes); i++) {
>> +		if (code =3D=3D mipid02_supported_fmt_codes[i])
>> +			return code;
>> +	}
>> +
>> +	return mipid02_supported_fmt_codes[0];
>> +}
>> +
>> +static __u32 serial_to_parallel_code(__u32 serial)
>> +{
>> +	if (serial =3D=3D MEDIA_BUS_FMT_UYVY8_1X16)
>> +		return MEDIA_BUS_FMT_UYVY8_2X8;
>> +
>> +	return serial;
>> +}
>> +
>> +static inline struct mipid02_dev *to_mipid02_dev(struct v4l2_subdev *sd=
)
>> +{
>> +	return container_of(sd, struct mipid02_dev, sd);
>> +}
>> +
>> +static int mipid02_read_reg(struct mipid02_dev *bridge, u16 reg, u8 *va=
l)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct i2c_msg msg[2];
>> +	u8 buf[2];
>> +	int ret;
>> +
>> +	buf[0] =3D reg >> 8;
>> +	buf[1] =3D reg & 0xff;
>> +
>> +	msg[0].addr =3D client->addr;
>> +	msg[0].flags =3D client->flags;
>> +	msg[0].buf =3D buf;
>> +	msg[0].len =3D sizeof(buf);
>> +
>> +	msg[1].addr =3D client->addr;
>> +	msg[1].flags =3D client->flags | I2C_M_RD;
>> +	msg[1].buf =3D val;
>> +	msg[1].len =3D 1;
>> +
>> +	ret =3D i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0) {
>> +		dev_dbg(&client->dev, "%s: %x i2c_transfer, reg: %x =3D> %d\n",
>> +			    __func__, client->addr, reg, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_write_reg(struct mipid02_dev *bridge, u16 reg, u8 va=
l)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct i2c_msg msg;
>> +	u8 buf[3];
>> +	int ret;
>> +
>> +	buf[0] =3D reg >> 8;
>> +	buf[1] =3D reg & 0xff;
>> +	buf[2] =3D val;
>> +
>> +	msg.addr =3D client->addr;
>> +	msg.flags =3D client->flags;
>> +	msg.buf =3D buf;
>> +	msg.len =3D sizeof(buf);
>> +
>> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
>> +	if (ret < 0) {
>> +		dev_dbg(&client->dev, "%s: i2c_transfer, reg: %x =3D> %d\n",
>> +			    __func__, reg, ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_get_regulators(struct mipid02_dev *bridge)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i =3D 0; i < MIPID02_NUM_SUPPLIES; i++)
>> +		bridge->supplies[i].supply =3D mipid02_supply_name[i];
>> +
>> +	return devm_regulator_bulk_get(&bridge->i2c_client->dev,
>> +				       MIPID02_NUM_SUPPLIES,
>> +				       bridge->supplies);
>> +}
>> +
>> +static void mipid02_apply_reset(struct mipid02_dev *bridge)
>> +{
>> +	gpiod_set_value_cansleep(bridge->reset_gpio, 0);
>> +	usleep_range(5000, 10000);
>> +	gpiod_set_value_cansleep(bridge->reset_gpio, 1);
>> +	usleep_range(5000, 10000);
>> +	gpiod_set_value_cansleep(bridge->reset_gpio, 0);
>> +	usleep_range(5000, 10000);
>> +}
>> +
>> +static int mipid02_set_power_on(struct mipid02_dev *bridge)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int ret;
>> +
>> +	ret =3D clk_prepare_enable(bridge->xclk);
>> +	if (ret) {
>> +		dev_err(&client->dev, "%s: failed to enable clock\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D regulator_bulk_enable(MIPID02_NUM_SUPPLIES,
>> +				    bridge->supplies);
>> +	if (ret) {
>> +		dev_err(&client->dev, "%s: failed to enable regulators\n",
>> +			    __func__);
>> +		goto xclk_off;
>> +	}
>> +
>> +	if (bridge->reset_gpio) {
>> +		dev_dbg(&client->dev, "apply reset");
>> +		mipid02_apply_reset(bridge);
>> +	} else {
>> +		dev_dbg(&client->dev, "don't apply reset");
>> +		usleep_range(5000, 10000);
>> +	}
>> +
>> +	return 0;
>> +
>> +xclk_off:
>> +	clk_disable_unprepare(bridge->xclk);
>> +	return ret;
>> +}
>> +
>> +static void mipid02_set_power_off(struct mipid02_dev *bridge)
>> +{
>> +	regulator_bulk_disable(MIPID02_NUM_SUPPLIES, bridge->supplies);
>> +	clk_disable_unprepare(bridge->xclk);
>> +}
>> +
>> +static int mipid02_detect(struct mipid02_dev *bridge)
>> +{
>> +	u8 reg;
>> +
>> +	/*
>> +	 * There is no version registers. Just try to read register
>> +	 * MIPID02_CLK_LANE_WR_REG1.
>> +	 */
>> +	return mipid02_read_reg(bridge, MIPID02_CLK_LANE_WR_REG1, &reg);
>> +}
>> +
>> +static u32 mipid02_get_link_freq_from_cid_pixel_rate(struct mipid02_dev=
 *bridge,
>> +						     struct v4l2_subdev *subdev)
>> +{
>> +	struct v4l2_fwnode_endpoint *ep =3D &bridge->rx;
>> +	struct v4l2_ctrl *ctrl;
>> +	u32 pixel_clock;
>> +	u32 bpp =3D bpp_from_code(bridge->fmt.code);
>> +
>> +	ctrl =3D v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
>> +	if (!ctrl)
>> +		return 0;
>> +	pixel_clock =3D v4l2_ctrl_g_ctrl_int64(ctrl);
>> +
>> +	return pixel_clock * bpp / (2 * ep->bus.mipi_csi2.num_data_lanes);
>> +}
>> +
>> +/*
>> + * We need to know link frequency to setup clk_lane_reg1 timings. Link =
frequency
>> + * will be computed using connected device V4L2_CID_PIXEL_RATE, bit per=
 pixel
>> + * and number of lanes.
>> + */
>> +static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct v4l2_subdev *subdev =3D bridge->s_subdev;
>> +	u32 link_freq;
>> +
>> +	link_freq =3D mipid02_get_link_freq_from_cid_pixel_rate(bridge, subdev=
);
>> +	if (!link_freq) {
>> +		dev_err(&client->dev, "Failed to detect link frequency");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(&client->dev, "detect link_freq =3D %d Hz", link_freq);
>> +	bridge->r.clk_lane_reg1 |=3D (2000000000 / link_freq) << 2;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_configure_clk_lane(struct mipid02_dev *bridge)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct v4l2_fwnode_endpoint *ep =3D &bridge->rx;
>> +	bool *polarities =3D ep->bus.mipi_csi2.lane_polarities;
>> +
>> +	/* midid02 doesn't support clock lane remapping */
>> +	if (ep->bus.mipi_csi2.clock_lane !=3D 0) {
>> +		dev_err(&client->dev, "clk lane must be map to lane 0\n");
>> +		return -EINVAL;
>> +	}
>> +	bridge->r.clk_lane_reg1 |=3D (polarities[0] << 1) | CLK_ENABLE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_configure_data0_lane(struct mipid02_dev *bridge, int=
 nb,
>> +					bool are_lanes_swap, bool *polarities)
>> +{
>> +	bool are_pin_swap =3D are_lanes_swap ? polarities[2] : polarities[1];
>> +
>> +	if (nb =3D=3D 1 && are_lanes_swap)
>> +		return 0;
>> +
>> +	/*
>> +	 * data lane 0 as pin swap polarity reversed compared to clock and
>> +	 * data lane 1
>> +	 */
>> +	if (!are_pin_swap)
>> +		bridge->r.data_lane0_reg1 =3D 1 << 1;
>> +	bridge->r.data_lane0_reg1 |=3D DATA_ENABLE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_configure_data1_lane(struct mipid02_dev *bridge, int=
 nb,
>> +					bool are_lanes_swap, bool *polarities)
>> +{
>> +	bool are_pin_swap =3D are_lanes_swap ? polarities[1] : polarities[2];
>> +
>> +	if (nb =3D=3D 1 && !are_lanes_swap)
>> +		return 0;
>> +
>> +	if (are_pin_swap)
>> +		bridge->r.data_lane1_reg1 =3D 1 << 1;
>> +	bridge->r.data_lane1_reg1 |=3D DATA_ENABLE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_configure_from_rx(struct mipid02_dev *bridge)
>> +{
>> +	struct v4l2_fwnode_endpoint *ep =3D &bridge->rx;
>> +	bool are_lanes_swap =3D ep->bus.mipi_csi2.data_lanes[0] =3D=3D 2;
>> +	bool *polarities =3D ep->bus.mipi_csi2.lane_polarities;
>> +	int nb =3D ep->bus.mipi_csi2.num_data_lanes;
>> +	int ret;
>> +
>> +	ret =3D mipid02_configure_clk_lane(bridge);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D mipid02_configure_data0_lane(bridge, nb, are_lanes_swap,
>> +					   polarities);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D mipid02_configure_data1_lane(bridge, nb, are_lanes_swap,
>> +					   polarities);
>> +	if (ret)
>> +		return ret;
>> +
>> +	bridge->r.mode_reg1 |=3D are_lanes_swap ? MODE_DATA_SWAP : 0;
>> +	bridge->r.mode_reg1 |=3D (nb - 1) << 1;
>> +
>> +	return mipid02_configure_from_rx_speed(bridge);
>> +}
>> +
>> +static int mipid02_configure_from_tx(struct mipid02_dev *bridge)
>> +{
>> +	struct v4l2_fwnode_endpoint *ep =3D &bridge->tx;
>> +
>> +	bridge->r.pix_width_ctrl =3D ep->bus.parallel.bus_width;
>> +	bridge->r.pix_width_ctrl_emb =3D ep->bus.parallel.bus_width;
>> +	if (ep->bus.parallel.flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH)
>> +		bridge->r.mode_reg2 |=3D MODE_HSYNC_ACTIVE_HIGH;
>> +	if (ep->bus.parallel.flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH)
>> +		bridge->r.mode_reg2 |=3D MODE_VSYNC_ACTIVE_HIGH;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_configure_from_code(struct mipid02_dev *bridge)
>> +{
>> +	u8 data_type;
>> +
>> +	bridge->r.data_id_rreg =3D 0;
>> +	data_type =3D data_type_from_code(bridge->fmt.code);
>> +	if (!data_type)
>> +		return -EINVAL;
>> +	bridge->r.data_id_rreg =3D data_type;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mipid02_stream_disable(struct mipid02_dev *bridge)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int ret;
>> +
>> +	/* Disable all lanes */
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG1, 0);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG1, 0);
>> +	if (ret)
>> +		goto error;
>> +error:
>> +	if (ret)
>> +		dev_err(&client->dev, "failed to stream off %d", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_stream_enable(struct mipid02_dev *bridge)
>> +{
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int ret =3D -EINVAL;
>> +
>> +	if (!bridge->s_subdev)
>> +		goto error;
>> +
>> +	memset(&bridge->r, 0, sizeof(bridge->r));
>> +	/* build registers content */
>> +	ret =3D mipid02_configure_from_rx(bridge);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_configure_from_tx(bridge);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_configure_from_code(bridge);
>> +	if (ret)
>> +		goto error;
>> +
>> +	/* write mipi registers */
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1,
>> +		bridge->r.clk_lane_reg1);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG3, CLK_MIPI_CSI)=
;
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG1,
>> +		bridge->r.data_lane0_reg1);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE0_REG2,
>> +		DATA_MIPI_CSI);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG1,
>> +		bridge->r.data_lane1_reg1);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_LANE1_REG2,
>> +		DATA_MIPI_CSI);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_MODE_REG1,
>> +		MODE_NO_BYPASS | bridge->r.mode_reg1);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_MODE_REG2,
>> +		bridge->r.mode_reg2);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_ID_RREG,
>> +		bridge->r.data_id_rreg);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_DATA_SELECTION_CTRL,
>> +		SELECTION_MANUAL_DATA | SELECTION_MANUAL_WIDTH);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_PIX_WIDTH_CTRL,
>> +		bridge->r.pix_width_ctrl);
>> +	if (ret)
>> +		goto error;
>> +	ret =3D mipid02_write_reg(bridge, MIPID02_PIX_WIDTH_CTRL_EMB,
>> +		bridge->r.pix_width_ctrl_emb);
>> +	if (ret)
>> +		goto error;
>> +
>> +	return 0;
>> +
>> +error:
>> +	dev_err(&client->dev, "failed to stream on %d", ret);
>> +	mipid02_stream_disable(bridge);
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_s_stream(struct v4l2_subdev *sd, int enable)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int ret =3D 0;
>> +
>> +	dev_dbg(&client->dev, "%s : requested %d / current =3D %d", __func__,
>> +		    enable, bridge->streaming);
>> +	mutex_lock(&bridge->lock);
>> +
>> +	if (bridge->streaming =3D=3D enable)
>> +		goto out;
>> +
>> +	ret =3D enable ? mipid02_stream_enable(bridge) :
>> +		       mipid02_stream_disable(bridge);
>> +	if (!ret)
>> +		bridge->streaming =3D enable;
>> +
>> +out:
>> +	dev_dbg(&client->dev, "%s current now =3D %d / %d", __func__,
>> +		    bridge->streaming, ret);
>> +	mutex_unlock(&bridge->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_enum_mbus_code(struct v4l2_subdev *sd,
>> +				 struct v4l2_subdev_pad_config *cfg,
>> +				 struct v4l2_subdev_mbus_code_enum *code)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +	int ret =3D 0;
>> +
>> +	switch (code->pad) {
>> +	case MIPID02_SINK_0:
>> +		if (code->index >=3D ARRAY_SIZE(mipid02_supported_fmt_codes))
>> +			ret =3D -EINVAL;
>> +		else
>> +			code->code =3D mipid02_supported_fmt_codes[code->index];
>> +		break;
>> +	case MIPID02_SOURCE:
>> +		if (code->index =3D=3D 0)
>> +			code->code =3D serial_to_parallel_code(bridge->fmt.code);
>> +		else
>> +			ret =3D -EINVAL;
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_get_fmt(struct v4l2_subdev *sd,
>> +			   struct v4l2_subdev_pad_config *cfg,
>> +			   struct v4l2_subdev_format *format)
>> +{
>> +	struct v4l2_mbus_framefmt *mbus_fmt =3D &format->format;
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct v4l2_mbus_framefmt *fmt;
>> +
>> +	dev_dbg(&client->dev, "%s probe %d", __func__, format->pad);
>> +
>> +	if (format->pad >=3D MIPID02_PAD_NB)
>> +		return -EINVAL;
>> +	/* second CSI-2 pad not yet supported */
>> +	if (format->pad =3D=3D MIPID02_SINK_1)
>> +		return -EINVAL;
>> +
>> +	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY)
>> +		fmt =3D v4l2_subdev_get_try_format(&bridge->sd, cfg, format->pad);
>> +	else
>> +		fmt =3D &bridge->fmt;
>> +
>> +	mutex_lock(&bridge->lock);
>> +
>> +	*mbus_fmt =3D *fmt;
>> +	/* code may need to be converted for source */
>> +	if (format->pad =3D=3D MIPID02_SOURCE)
>> +		mbus_fmt->code =3D serial_to_parallel_code(mbus_fmt->code);
>> +
>> +	mutex_unlock(&bridge->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mipid02_set_fmt_source(struct v4l2_subdev *sd,
>> +				   struct v4l2_subdev_pad_config *cfg,
>> +				   struct v4l2_subdev_format *format)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +
>> +	/* source pad mirror active sink pad */
>> +	format->format =3D bridge->fmt;
>> +	/* but code may need to be converted */
>> +	format->format.code =3D serial_to_parallel_code(format->format.code);
>> +
>> +	/* only apply format for V4L2_SUBDEV_FORMAT_TRY case */
>> +	if (format->which !=3D V4L2_SUBDEV_FORMAT_TRY)
>> +		return;
>> +
>> +	*v4l2_subdev_get_try_format(sd, cfg, format->pad) =3D format->format;
>> +}
>> +
>> +static void mipid02_set_fmt_sink(struct v4l2_subdev *sd,
>> +				 struct v4l2_subdev_pad_config *cfg,
>> +				 struct v4l2_subdev_format *format)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +	struct v4l2_mbus_framefmt *fmt;
>> +
>> +	format->format.code =3D get_fmt_code(format->format.code);
>> +
>> +	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY)
>> +		fmt =3D v4l2_subdev_get_try_format(sd, cfg, format->pad);
>> +	else
>> +		fmt =3D &bridge->fmt;
>> +
>> +	*fmt =3D format->format;
>> +}
>> +
>> +static int mipid02_set_fmt(struct v4l2_subdev *sd,
>> +			   struct v4l2_subdev_pad_config *cfg,
>> +			   struct v4l2_subdev_format *format)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int ret =3D 0;
>> +
>> +	dev_dbg(&client->dev, "%s for %d", __func__, format->pad);
>> +
>> +	if (format->pad >=3D MIPID02_PAD_NB)
>> +		return -EINVAL;
>> +	/* second CSI-2 pad not yet supported */
>> +	if (format->pad =3D=3D MIPID02_SINK_1)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&bridge->lock);
>> +
>> +	if (bridge->streaming) {
>> +		ret =3D -EBUSY;
>> +		goto error;
>> +	}
>> +
>> +	if (format->pad =3D=3D MIPID02_SOURCE)
>> +		mipid02_set_fmt_source(sd, cfg, format);
>> +	else
>> +		mipid02_set_fmt_sink(sd, cfg, format);
>> +
>> +error:
>> +	mutex_unlock(&bridge->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct v4l2_subdev_video_ops mipid02_video_ops =3D {
>> +	.s_stream =3D mipid02_s_stream,
>> +};
>> +
>> +static const struct v4l2_subdev_pad_ops mipid02_pad_ops =3D {
>> +	.enum_mbus_code =3D mipid02_enum_mbus_code,
>> +	.get_fmt =3D mipid02_get_fmt,
>> +	.set_fmt =3D mipid02_set_fmt,
>> +};
>> +
>> +static const struct v4l2_subdev_ops mipid02_subdev_ops =3D {
>> +	.video =3D &mipid02_video_ops,
>> +	.pad =3D &mipid02_pad_ops,
>> +};
>> +
>> +static const struct media_entity_operations mipid02_subdev_entity_ops =
=3D {
>> +	.link_validate =3D v4l2_subdev_link_validate,
>> +};
>> +
>> +static int mipid02_async_bound(struct v4l2_async_notifier *notifier,
>> +			       struct v4l2_subdev *s_subdev,
>> +			       struct v4l2_async_subdev *asd)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(notifier->sd);
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	int source_pad;
>> +	int ret;
>> +
>> +	dev_dbg(&client->dev, "sensor_async_bound call %p", s_subdev);
>> +
>> +	source_pad =3D media_entity_get_fwnode_pad(&s_subdev->entity,
>> +						 s_subdev->fwnode,
>> +						 MEDIA_PAD_FL_SOURCE);
>> +	if (source_pad < 0) {
>> +		dev_err(&client->dev, "Couldn't find output pad for subdev %s\n",
>> +			s_subdev->name);
>> +		return source_pad;
>> +	}
>> +
>> +	ret =3D media_create_pad_link(&s_subdev->entity, source_pad,
>> +				    &bridge->sd.entity, 0,
>> +				    MEDIA_LNK_FL_ENABLED |
>> +				    MEDIA_LNK_FL_IMMUTABLE);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Couldn't create media link %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	bridge->s_subdev =3D s_subdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mipid02_async_unbind(struct v4l2_async_notifier *notifier,
>> +				 struct v4l2_subdev *s_subdev,
>> +				 struct v4l2_async_subdev *asd)
>> +{
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(notifier->sd);
>> +
>> +	bridge->s_subdev =3D NULL;
>> +}
>> +
>> +static const struct v4l2_async_notifier_operations mipid02_notifier_ops=
 =3D {
>> +	.bound		=3D mipid02_async_bound,
>> +	.unbind		=3D mipid02_async_unbind,
>> +};
>> +
>> +static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>> +{
>> +	struct v4l2_fwnode_endpoint ep =3D { .bus_type =3D V4L2_MBUS_CSI2_DPHY=
 };
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct device_node *ep_node;
>> +	int ret;
>> +
>> +	/* parse rx (endpoint 0) */
>> +	ep_node =3D of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_n=
ode,
>> +						0, 0);
>> +	if (!ep_node) {
>> +		dev_err(&client->dev, "unable to find port0 ep");
>> +		ret =3D -EINVAL;
>> +		goto error;
>> +	}
>> +
>> +	ret =3D v4l2_fwnode_endpoint_alloc_parse(of_fwnode_handle(ep_node), &e=
p);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Could not parse v4l2 endpoint %d\n",
>> +			ret);
>> +		goto error_of_node_put;
>> +	}
>> +
>> +	/* do some sanity checks */
>> +	if (ep.bus.mipi_csi2.num_data_lanes > 2) {
>> +		dev_err(&client->dev, "max supported data lanes is 2 / got %d",
>> +			ep.bus.mipi_csi2.num_data_lanes);
>> +		ret =3D -EINVAL;
>> +		goto error_v4l2_fwnode_endpoint_free;
>> +	}
>> +
>> +	/* register it for later use */
>> +	bridge->rx =3D ep;
>> +	v4l2_fwnode_endpoint_free(&ep);
>=20
> As you don't use variable size properties, you could use
> v4l2_fwnode_endpoint_parse() instead. The note in
> v4l2_fwnode_endpoint_parse() telling to use
> v4l2_fwnode_endpoint_alloc_parse() in new drivers isn't actully entirely
> correct; the old function is just fine if you don't need any variable siz=
e
> properties. I'll submit a patch to change that.
>=20
Ok. I forgot to change it when I remove link_frequencies usage.
>> +
>> +	/* register async notifier so we get noticed when sensor is connected =
*/
>> +	bridge->asd.match.fwnode =3D
>> +		fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep_node));
>> +	bridge->asd.match_type =3D V4L2_ASYNC_MATCH_FWNODE;
>> +	of_node_put(ep_node);
>> +
>> +	v4l2_async_notifier_init(&bridge->notifier);
>> +	ret =3D v4l2_async_notifier_add_subdev(&bridge->notifier, &bridge->asd=
);
>> +	if (ret) {
>> +		dev_err(&client->dev, "fail to register asd to notifier %d",
>> +			ret);
>> +		goto error_fwnode_handle_put;
>> +	}
>> +	bridge->notifier.ops =3D &mipid02_notifier_ops;
>> +
>> +	ret =3D v4l2_async_subdev_notifier_register(&bridge->sd,
>> +						  &bridge->notifier);
>> +	if (ret)
>> +		v4l2_async_notifier_cleanup(&bridge->notifier);
>> +
>> +	return ret;
>> +
>> +error_v4l2_fwnode_endpoint_free:
>> +	v4l2_fwnode_endpoint_free(&ep);
>> +error_of_node_put:
>> +	of_node_put(ep_node);
>> +error:
>> +
>> +	return ret;
>> +
>> +error_fwnode_handle_put:
>> +	fwnode_handle_put(bridge->asd.match.fwnode);
>=20
> You only go here once; please drop the label and goto and move the code
> where it's used.
>=20
Ok
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_parse_tx_ep(struct mipid02_dev *bridge)
>> +{
>> +	struct v4l2_fwnode_endpoint ep =3D { .bus_type =3D V4L2_MBUS_PARALLEL =
};
>> +	struct i2c_client *client =3D bridge->i2c_client;
>> +	struct device_node *ep_node;
>> +	int ret;
>> +
>> +	/* parse tx (endpoint 2) */
>> +	ep_node =3D of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_n=
ode,
>> +						2, 0);
>> +	if (!ep_node) {
>> +		dev_err(&client->dev, "unable to find port1 ep");
>> +		ret =3D -EINVAL;
>> +		goto error;
>> +	}
>> +
>> +	ret =3D v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
>> +	if (ret) {
>> +		dev_err(&client->dev, "Could not parse v4l2 endpoint\n");
>> +		goto error_of_node_put;
>> +	}
>> +
>> +	of_node_put(ep_node);
>> +	bridge->tx =3D ep;
>> +
>> +	return 0;
>> +
>> +error_of_node_put:
>> +	of_node_put(ep_node);
>> +error:
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int mipid02_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct device *dev =3D &client->dev;
>> +	struct mipid02_dev *bridge;
>> +	u32 clk_freq;
>> +	int ret;
>> +
>> +	bridge =3D devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
>> +	if (!bridge)
>> +		return -ENOMEM;
>> +
>> +	init_format(&bridge->fmt);
>> +
>> +	bridge->i2c_client =3D client;
>> +	v4l2_i2c_subdev_init(&bridge->sd, client, &mipid02_subdev_ops);
>> +
>> +	/* got and check clock */
>> +	bridge->xclk =3D devm_clk_get(dev, "xclk");
>> +	if (IS_ERR(bridge->xclk)) {
>> +		dev_err(dev, "failed to get xclk\n");
>> +		return PTR_ERR(bridge->xclk);
>> +	}
>> +
>> +	clk_freq =3D clk_get_rate(bridge->xclk);
>> +	if (clk_freq < 6000000 || clk_freq > 27000000) {
>> +		dev_err(dev, "xclk freq must be in 6-27 Mhz range. got %d Hz\n",
>> +			clk_freq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	bridge->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +
>> +	ret =3D mipid02_get_regulators(bridge);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get regulators %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	mutex_init(&bridge->lock);
>> +	bridge->sd.flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
>> +	bridge->sd.entity.function =3D MEDIA_ENT_F_VID_IF_BRIDGE;
>> +	bridge->sd.entity.ops =3D &mipid02_subdev_entity_ops;
>> +	bridge->pad[0].flags =3D MEDIA_PAD_FL_SINK;
>> +	bridge->pad[1].flags =3D MEDIA_PAD_FL_SINK;
>> +	bridge->pad[2].flags =3D MEDIA_PAD_FL_SOURCE;
>> +	ret =3D media_entity_pads_init(&bridge->sd.entity, MIPID02_PAD_NB,
>> +				     bridge->pad);
>> +	if (ret) {
>> +		dev_err(&client->dev, "pads init failed %d", ret);
>=20
> mutex_destroy(&bridge->lock);
>=20
> Please add a label and change return to goto below.
>=20
Ok. I missed mutex_destroy ...
>> +		return ret;
>> +	}
>> +
>> +	/* enable clock, power and reset device if available */
>> +	ret =3D mipid02_set_power_on(bridge);
>> +	if (ret)
>> +		goto entity_cleanup;
>> +
>> +	ret =3D mipid02_detect(bridge);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to detect mipid02 %d", ret);
>> +		goto power_off;
>> +	}
>> +
>> +	ret =3D mipid02_parse_tx_ep(bridge);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to parse tx %d", ret);
>> +		goto power_off;
>> +	}
>> +
>> +	ret =3D mipid02_parse_rx_ep(bridge);
>> +	if (ret) {
>> +		dev_err(&client->dev, "failed to parse rx %d", ret);
>> +		goto power_off;
>> +	}
>> +
>> +	ret =3D v4l2_async_register_subdev(&bridge->sd);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "v4l2_async_register_subdev failed %d",
>> +			    ret);
>> +		goto unregister_notifier;
>> +	}
>> +
>> +	dev_info(&client->dev, "mipid02 device probe successfully");
>> +
>> +	return 0;
>> +
>> +unregister_notifier:
>> +	v4l2_async_notifier_unregister(&bridge->notifier);
>> +	v4l2_async_notifier_cleanup(&bridge->notifier);
>> +power_off:
>> +	mipid02_set_power_off(bridge);
>> +entity_cleanup:
>> +	media_entity_cleanup(&bridge->sd.entity);
>> +
>> +	return ret;
>> +}
>> +
>> +static int mipid02_remove(struct i2c_client *client)
>> +{
>> +	struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
>> +	struct mipid02_dev *bridge =3D to_mipid02_dev(sd);
>> +
>> +	v4l2_async_notifier_unregister(&bridge->notifier);
>> +	v4l2_async_notifier_cleanup(&bridge->notifier);
>> +	v4l2_async_unregister_subdev(&bridge->sd);
>> +	mipid02_set_power_off(bridge);
>> +	media_entity_cleanup(&bridge->sd.entity);
>=20
> mutex_destroy(&bridge->lock);
>=20
Ok
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id mipid02_id[] =3D {
>> +	{ "st-mipid02", 0},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mipid02_id);
>> +
>> +static const struct of_device_id mipid02_dt_ids[] =3D {
>> +	{ .compatible =3D "st,st-mipid02" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mipid02_dt_ids);
>> +
>> +static struct i2c_driver mipid02_i2c_driver =3D {
>> +	.driver =3D {
>> +		.name  =3D "st-mipid02",
>> +		.of_match_table =3D mipid02_dt_ids,
>> +	},
>> +	.id_table =3D mipid02_id,
>> +	.probe    =3D mipid02_probe,
>=20
> Probe_new, and you can omit the I=B2C ID table. Unless it's needed, of
> course, but generally it isn't.
 It isn't need. I will switch to probe_new.

> The above are just minor improvements and cleanups. If you're fine with t=
he
> proposed change to the first patch, I can merge this version of the patch=
es
> and you could submit changes to the above in a separate patch.
>=20
Thanks for the proposal, but I prefer to to a full v5 if you agree ?
I will also add MEDIA_BUS_FMT_BGR888_3X8 or MEDIA_BUS_FMT_BGR888_3X8_BE
support.
>> +	.remove   =3D mipid02_remove,
>> +};
>> +
>> +module_i2c_driver(mipid02_i2c_driver);
>> +
>> +MODULE_AUTHOR("Mickael Guene <mickael.guene@st.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics MIPID02 CSI-2 bridge driver");
>> +MODULE_LICENSE("GPL v2");
> =
