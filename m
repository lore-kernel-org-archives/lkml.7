Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F91C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115802075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 00:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jMfgJdLf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVmGupCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKZAwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:52:15 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54001 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfKZAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 19:52:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CAE143CF;
        Mon, 25 Nov 2019 19:52:13 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 25 Nov 2019 19:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=de5M9VNVWlKR4JN9RrX0eR60xcbYSos
        84/HXhKNFvOQ=; b=jMfgJdLfhgeURci3oyPbTvshMCKIhpPx505hjTwEax/6lNH
        8XniliNLOQKlwHDku6AsgWWP51MzZx98zqzxOSUsgAtyh6oBzW8DC2j8l/0/FvVe
        NtYfsJ9Ig0s7WAHS40uChWmAIUs2E7s2I6Zo1gxZrkjOF2bwbcjh6c3vk+C6G7is
        fS3XbQvUZ/P5iqS4PkFZM1b4r7tR4fmYnfY67p8EbtdKgQ+8PZyv0GWIpBZpfhiI
        45iDt2CgLJTJ37d6EHaSPmuFHjSMT1hf5EjaNtgEtZ3k0/h70biqYDYUETY4PlzR
        J2S8b41DQqXUtpDhiG1u8HQ2BKvcO8oxNoWRxqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=de5M9V
        NVWlKR4JN9RrX0eR60xcbYSos84/HXhKNFvOQ=; b=eVmGupCP9IXkSiRZ1zYMQk
        aLagFKmH8jMCyZDhy0D5cTlxBTrkrsuIw0G2BKcdgTWPdqVEY9b0++xkAzdM611c
        n+nJph/aPtEcaqf09G/1zPvh6VuEXwxNl7Ak5xJheFTyCJxbJvXJx1O+/0h+pZvW
        5YBuxm8IQWUGlupucv0PoEy+QyQ82rqfS7b/PHh2dMSLEJf8qUwluhloQrCpgDXI
        ryHVCzEEaCbXufOBhy5ndiJ18/Tj8kUjOkxKvQMntgSljn6oJsCSV+5Ovlu9A0P7
        RLPdMkVHCSTorkHWqbmHyk7D2aEI9ETWY1BuNmrQKuPk5v+5msp0wW+O1S5Vmzuw
        ==
X-ME-Sender: <xms:PHfcXbWaHpIzHfjqfJum1W0O1oaed4qsHKbL4mQX4NrSsQg9s8jZOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeivddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
    grihhnpehsphgugidrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgif
    segrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PHfcXa_z6lh1_kwJ1-hTP8AYDbKdwRh0D-kpEznsYRF_3bHr7vxGrw>
    <xmx:PHfcXc__GlnxGWRcsidsmfqU3iPidp6EFRZucr_CJOlX5edTQAL42Q>
    <xmx:PHfcXSTBanKTSGCO0HvrqrPzz8IrRMknfFs7It_kmiDo71Jb1TiLiQ>
    <xmx:PXfcXbqfDofVnizO1Z2zvSHAwVOzZzqn5TvstyLC45Gys5QStB3-MQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 012EDE00A2; Mon, 25 Nov 2019 19:52:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <0cf4b8be-dee0-429b-baf2-df217d0efa3b@www.fastmail.com>
In-Reply-To: <c582d6c9-f088-c38e-6a6b-f014f17c6d31@linux.vnet.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-7-git-send-email-eajames@linux.ibm.com>
 <a600a526-2f11-4a37-b4f3-8f53c533db02@www.fastmail.com>
 <c582d6c9-f088-c38e-6a6b-f014f17c6d31@linux.vnet.ibm.com>
Date:   Tue, 26 Nov 2019 11:23:39 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.vnet.ibm.com>,
        "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, "Joel Stanley" <joel@jms.id.au>,
        maz@kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        tglx@linutronix.de, "Rob Herring" <robh+dt@kernel.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Nov 2019, at 05:45, Eddie James wrote:
> 
> On 11/24/19 5:32 PM, Andrew Jeffery wrote:
> >
> > On Sat, 9 Nov 2019, at 06:48, Eddie James wrote:
> >> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> >> DMA operations between the SOC (acting as a BMC) and a host processor
> >> in a server.
> >>
> >> This commit adds a driver to control the XDMA engine and adds functions
> >> to initialize the hardware and memory and start DMA operations.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   MAINTAINERS                      |   2 +
> >>   drivers/soc/aspeed/Kconfig       |   8 +
> >>   drivers/soc/aspeed/Makefile      |   1 +
> >>   drivers/soc/aspeed/aspeed-xdma.c | 856 +++++++++++++++++++++++++++++++++++++++
> >>   include/uapi/linux/aspeed-xdma.h |  49 +++
> >>   5 files changed, 916 insertions(+)
> >>   create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
> >>   create mode 100644 include/uapi/linux/aspeed-xdma.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 540bd45..7eea32e4 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2696,6 +2696,8 @@ M:	Eddie James <eajames@linux.ibm.com>
> >>   L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> >>   S:	Maintained
> >>   F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> >> +F:	drivers/soc/aspeed/aspeed-xdma.c
> >> +F:	include/uapi/linux/aspeed-xdma.h
> >>   
> >>   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >>   M:	Corentin Chary <corentin.chary@gmail.com>
> >> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> >> index 323e177..2a6c16f 100644
> >> --- a/drivers/soc/aspeed/Kconfig
> >> +++ b/drivers/soc/aspeed/Kconfig
> >> @@ -29,4 +29,12 @@ config ASPEED_P2A_CTRL
> >>   	  ioctl()s, the driver also provides an interface for userspace mappings to
> >>   	  a pre-defined region.
> >>   
> >> +config ASPEED_XDMA
> >> +	tristate "Aspeed XDMA Engine Driver"
> >> +	depends on SOC_ASPEED && REGMAP && MFD_SYSCON && HAS_DMA
> >> +	help
> >> +	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2XXX
> >> +	  SOCs. The XDMA engine can perform automatic PCI DMA operations
> >> +	  between the AST2XXX (acting as a BMC) and a host processor.
> >> +
> >>   endmenu
> >> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> >> index b64be47..977b046 100644
> >> --- a/drivers/soc/aspeed/Makefile
> >> +++ b/drivers/soc/aspeed/Makefile
> >> @@ -2,3 +2,4 @@
> >>   obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
> >>   obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
> >>   obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
> >> +obj-$(CONFIG_ASPEED_XDMA)	+= aspeed-xdma.o
> >> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> >> new file mode 100644
> >> index 0000000..99041a6
> >> --- /dev/null
> >> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> >> @@ -0,0 +1,856 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> > This should be  "GPL-2.0-or-later" (https://spdx.org/licenses/)
> >
> >> +// Copyright IBM Corp 2019
> >> +
> >> +#include <linux/aspeed-xdma.h>
> > A device-specific header in this include path seems a little strange to me.
> 
> 
> It's under uapi... do I need to specify a different path?

No, I didn't circle around to removing the comment. Should be fine for uapi.

> 
> 
> >
> >> +#include <linux/bitfield.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/device.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/fs.h>
> >> +#include <linux/genalloc.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/jiffies.h>
> >> +#include <linux/mfd/syscon.h>
> >> +#include <linux/miscdevice.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/poll.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/reset.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/spinlock.h>
> >> +#include <linux/string.h>
> >> +#include <linux/uaccess.h>
> >> +#include <linux/wait.h>
> >> +#include <linux/workqueue.h>
> >> +
> >> +#define DEVICE_NAME				"aspeed-xdma"
> >> +
> >> +#define SCU_AST2500_STRAP			0x070
> >> +#define  SCU_AST2500_STRAP_VGA_MEM		 GENMASK(3, 2)
> >> +#define SCU_AST2600_STRAP			0x500
> >> +#define  SCU_AST2600_STRAP_VGA_MEM		 GENMASK(14, 13)
> > It could be easier to review if you add support for one SoC at a time.
> >
> >> +
> >> +#define SCU_AST2500_PCIE_CONF			0x180
> >> +#define SCU_AST2600_PCIE_CONF			0xc20
> >> +#define  SCU_PCIE_CONF_VGA_EN			 BIT(0)
> >> +#define  SCU_PCIE_CONF_VGA_EN_MMIO		 BIT(1)
> >> +#define  SCU_PCIE_CONF_VGA_EN_LPC		 BIT(2)
> >> +#define  SCU_PCIE_CONF_VGA_EN_MSI		 BIT(3)
> >> +#define  SCU_PCIE_CONF_VGA_EN_MCTP		 BIT(4)
> >> +#define  SCU_PCIE_CONF_VGA_EN_IRQ		 BIT(5)
> >> +#define  SCU_PCIE_CONF_VGA_EN_DMA		 BIT(6)
> >> +#define  SCU_PCIE_CONF_BMC_EN			 BIT(8)
> >> +#define  SCU_PCIE_CONF_BMC_EN_MMIO		 BIT(9)
> >> +#define  SCU_PCIE_CONF_BMC_EN_MSI		 BIT(11)
> >> +#define  SCU_PCIE_CONF_BMC_EN_MCTP		 BIT(12)
> >> +#define  SCU_PCIE_CONF_BMC_EN_IRQ		 BIT(13)
> >> +#define  SCU_PCIE_CONF_BMC_EN_DMA		 BIT(14)
> >> +
> >> +#define SCU_AST2500_BMC_CLASS_REV		0x19c
> >> +#define SCU_AST2600_BMC_CLASS_REV		0xc4c
> >> +#define  SCU_BMC_CLASS_REV_XDMA			 0xff000001
> >> +
> >> +#define SDMC_BASE				0x1e6e0000
> >> +#define SDMC_CONF				0x004
> >> +#define  SDMC_CONF_MEM				 GENMASK(1, 0)
> >> +#define SDMC_REMAP				0x008
> >> +#define  SDMC_AST2500_REMAP_MAGIC		 (BIT(16) | BIT(17))
> >> +#define  SDMC_AST2600_REMAP_MAGIC		 BIT(18)
> > Can we have something more descriptive than "MAGIC"? What these bits
> > are doing is well documented and defined.
> 
> 
> Maybe I missed it then... I wasn't able to correspond these necessary 
> bits to what is actually happening. The doc indicates it remaps "REQs" 
> to the highest memory space. What do the REQs correspond to, and why is 
> it these bits for these SOCs?

The REQ index corresponds to arbiter access priorities for each device. As the
REQ table describes all the devices the remapping register simply reuses the
REQ indexes to capture the remapping state for each device by mapping the
REQ index to a bit index for the remap word.

I suggest you do something like:

#define SDMC_AST2500_REMAP_PCIE_ACCESS BIT(16)
#define SDMC_AST2500_REMAP_XDMA_ACCESS BIT(17)
#define SDMC_AST2600_REMAP_XDMA1_ACCESS BIT(18)

> 
> 
> >
> >> +
> >> +#define XDMA_CMDQ_SIZE				PAGE_SIZE
> >> +#define XDMA_NUM_CMDS				\
> >> +	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
> >> +
> >> +/* Aspeed specification requires 10ms after switching the reset line */
> >> +#define XDMA_RESET_TIME_MS			10
> >> +
> >> +#define XDMA_DS_PCIE_REQ_SIZE_128		0
> >> +#define XDMA_DS_PCIE_REQ_SIZE_256		1
> >> +#define XDMA_DS_PCIE_REQ_SIZE_512		2
> >> +#define XDMA_DS_PCIE_REQ_SIZE_1K		3
> >> +#define XDMA_DS_PCIE_REQ_SIZE_2K		4
> >> +#define XDMA_DS_PCIE_REQ_SIZE_4K		5
> >> +
> >> +#define XDMA_CMD_AST2500_PITCH_SHIFT		3
> >> +#define XDMA_CMD_AST2500_PITCH_BMC		GENMASK_ULL(62, 51)
> >> +#define XDMA_CMD_AST2500_PITCH_HOST		GENMASK_ULL(46, 35)
> >> +#define XDMA_CMD_AST2500_PITCH_UPSTREAM		BIT_ULL(31)
> >> +#define XDMA_CMD_AST2500_PITCH_ADDR		GENMASK_ULL(29, 4)
> >> +#define XDMA_CMD_AST2500_PITCH_ID		BIT_ULL(0)
> >> +#define XDMA_CMD_AST2500_CMD_IRQ_EN		BIT_ULL(31)
> >> +#define XDMA_CMD_AST2500_CMD_LINE_NO		GENMASK_ULL(27, 16)
> >> +#define XDMA_CMD_AST2500_CMD_IRQ_BMC		BIT_ULL(15)
> >> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT	4
> >> +#define XDMA_CMD_AST2500_CMD_LINE_SIZE		\
> >> +	GENMASK_ULL(14, XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT)
> >> +#define XDMA_CMD_AST2500_CMD_ID			BIT_ULL(1)
> >> +
> >> +#define XDMA_CMD_AST2600_PITCH_BMC		GENMASK_ULL(62, 48)
> >> +#define XDMA_CMD_AST2600_PITCH_HOST		GENMASK_ULL(46, 32)
> >> +#define XDMA_CMD_AST2600_PITCH_ADDR		GENMASK_ULL(30, 0)
> >> +#define XDMA_CMD_AST2600_CMD_64_EN		BIT_ULL(40)
> >> +#define XDMA_CMD_AST2600_CMD_IRQ_BMC		BIT_ULL(37)
> >> +#define XDMA_CMD_AST2600_CMD_IRQ_HOST		BIT_ULL(36)
> >> +#define XDMA_CMD_AST2600_CMD_UPSTREAM		BIT_ULL(32)
> >> +#define XDMA_CMD_AST2600_CMD_LINE_NO		GENMASK_ULL(27, 16)
> >> +#define XDMA_CMD_AST2600_CMD_LINE_SIZE		GENMASK_ULL(14, 0)
> >> +#define XDMA_CMD_AST2600_CMD_MULTILINE_SIZE	GENMASK_ULL(14, 12)
> >> +
> >> +#define XDMA_AST2500_QUEUE_ENTRY_SIZE		4
> >> +#define XDMA_AST2500_HOST_CMDQ_ADDR0		0x00
> >> +#define XDMA_AST2500_HOST_CMDQ_ENDP		0x04
> >> +#define XDMA_AST2500_HOST_CMDQ_WRITEP		0x08
> >> +#define XDMA_AST2500_HOST_CMDQ_READP		0x0c
> >> +#define XDMA_AST2500_BMC_CMDQ_ADDR		0x10
> >> +#define XDMA_AST2500_BMC_CMDQ_ENDP		0x14
> >> +#define XDMA_AST2500_BMC_CMDQ_WRITEP		0x18
> >> +#define XDMA_AST2500_BMC_CMDQ_READP		0x1c
> >> +#define  XDMA_BMC_CMDQ_READP_MAGIC		 0xee882266
> > What's this about? Using a macro to abstract a magic number and then using the
> > word "magic" in the name isn't very helpful. I think it should be renamed or
> > documented, or both.
> 
> 
> Sure. It's the value to write to reset the read pointer.

maybe s/MAGIC/RESET/ then?
> 
> 
> >
> >> +#define XDMA_AST2500_CTRL			0x20
> >> +#define  XDMA_AST2500_CTRL_US_COMP		 BIT(4)
> >> +#define  XDMA_AST2500_CTRL_DS_COMP		 BIT(5)
> >> +#define  XDMA_AST2500_CTRL_DS_DIRTY		 BIT(6)
> >> +#define  XDMA_AST2500_CTRL_DS_SIZE		 GENMASK(19, 17)
> >> +#define  XDMA_AST2500_CTRL_DS_TIMEOUT		 BIT(28)
> >> +#define  XDMA_AST2500_CTRL_DS_CHECK_ID		 BIT(29)
> >> +#define XDMA_AST2500_STATUS			0x24
> >> +#define  XDMA_AST2500_STATUS_US_COMP		 BIT(4)
> >> +#define  XDMA_AST2500_STATUS_DS_COMP		 BIT(5)
> >> +#define  XDMA_AST2500_STATUS_DS_DIRTY		 BIT(6)
> >> +#define XDMA_AST2500_INPRG_DS_CMD1		0x38
> >> +#define XDMA_AST2500_INPRG_DS_CMD2		0x3c
> >> +#define XDMA_AST2500_INPRG_US_CMD00		0x40
> >> +#define XDMA_AST2500_INPRG_US_CMD01		0x44
> >> +#define XDMA_AST2500_INPRG_US_CMD10		0x48
> >> +#define XDMA_AST2500_INPRG_US_CMD11		0x4c
> >> +#define XDMA_AST2500_INPRG_US_CMD20		0x50
> >> +#define XDMA_AST2500_INPRG_US_CMD21		0x54
> >> +#define XDMA_AST2500_HOST_CMDQ_ADDR1		0x60
> >> +#define XDMA_AST2500_VGA_CMDQ_ADDR0		0x64
> >> +#define XDMA_AST2500_VGA_CMDQ_ENDP		0x68
> >> +#define XDMA_AST2500_VGA_CMDQ_WRITEP		0x6c
> >> +#define XDMA_AST2500_VGA_CMDQ_READP		0x70
> >> +#define XDMA_AST2500_VGA_CMD_STATUS		0x74
> >> +#define XDMA_AST2500_VGA_CMDQ_ADDR1		0x78
> >> +
> >> +#define XDMA_AST2600_QUEUE_ENTRY_SIZE		2
> >> +#define XDMA_AST2600_HOST_CMDQ_ADDR0		0x00
> >> +#define XDMA_AST2600_HOST_CMDQ_ADDR1		0x04
> >> +#define XDMA_AST2600_HOST_CMDQ_ENDP		0x08
> >> +#define XDMA_AST2600_HOST_CMDQ_WRITEP		0x0c
> >> +#define XDMA_AST2600_HOST_CMDQ_READP		0x10
> >> +#define XDMA_AST2600_BMC_CMDQ_ADDR		0x14
> >> +#define XDMA_AST2600_BMC_CMDQ_ENDP		0x18
> >> +#define XDMA_AST2600_BMC_CMDQ_WRITEP		0x1c
> >> +#define XDMA_AST2600_BMC_CMDQ_READP		0x20
> >> +#define XDMA_AST2600_VGA_CMDQ_ADDR0		0x24
> >> +#define XDMA_AST2600_VGA_CMDQ_ADDR1		0x28
> >> +#define XDMA_AST2600_VGA_CMDQ_ENDP		0x2c
> >> +#define XDMA_AST2600_VGA_CMDQ_WRITEP		0x30
> >> +#define XDMA_AST2600_VGA_CMDQ_READP		0x34
> >> +#define XDMA_AST2600_CTRL			0x38
> >> +#define  XDMA_AST2600_CTRL_US_COMP		 BIT(16)
> >> +#define  XDMA_AST2600_CTRL_DS_COMP		 BIT(17)
> >> +#define  XDMA_AST2600_CTRL_DS_DIRTY		 BIT(18)
> >> +#define  XDMA_AST2600_CTRL_DS_SIZE		 GENMASK(22, 20)
> >> +#define XDMA_AST2600_STATUS			0x3c
> >> +#define  XDMA_AST2600_STATUS_US_COMP		 BIT(16)
> >> +#define  XDMA_AST2600_STATUS_DS_COMP		 BIT(17)
> >> +#define  XDMA_AST2600_STATUS_DS_DIRTY		 BIT(18)
> >> +#define XDMA_AST2600_INPRG_DS_CMD00		0x40
> >> +#define XDMA_AST2600_INPRG_DS_CMD01		0x44
> >> +#define XDMA_AST2600_INPRG_DS_CMD10		0x48
> >> +#define XDMA_AST2600_INPRG_DS_CMD11		0x4c
> >> +#define XDMA_AST2600_INPRG_DS_CMD20		0x50
> >> +#define XDMA_AST2600_INPRG_DS_CMD21		0x54
> >> +#define XDMA_AST2600_INPRG_US_CMD00		0x60
> >> +#define XDMA_AST2600_INPRG_US_CMD01		0x64
> >> +#define XDMA_AST2600_INPRG_US_CMD10		0x68
> >> +#define XDMA_AST2600_INPRG_US_CMD11		0x6c
> >> +#define XDMA_AST2600_INPRG_US_CMD20		0x70
> >> +#define XDMA_AST2600_INPRG_US_CMD21		0x74
> >> +
> >> +enum versions { xdma_ast2500, xdma_ast2600 };
> >> +
> >> +struct aspeed_xdma_cmd {
> >> +	u64 host_addr;
> >> +	u64 pitch;
> >> +	u64 cmd;
> >> +	u64 reserved;
> >> +};
> >> +
> >> +struct aspeed_xdma_regs {
> >> +	u8 bmc_cmdq_addr;
> >> +	u8 bmc_cmdq_endp;
> >> +	u8 bmc_cmdq_writep;
> >> +	u8 bmc_cmdq_readp;
> >> +	u8 control;
> >> +	u8 status;
> >> +};
> >> +
> >> +struct aspeed_xdma_status_bits {
> >> +	u32 us_comp;
> >> +	u32 ds_comp;
> >> +	u32 ds_dirty;
> >> +};
> >> +
> >> +struct aspeed_xdma_client;
> >> +
> >> +struct aspeed_xdma {
> >> +	enum versions version;
> >> +	u32 control;
> >> +	unsigned int queue_entry_size;
> >> +	struct aspeed_xdma_regs regs;
> >> +	struct aspeed_xdma_status_bits status_bits;
> >> +
> >> +	struct device *dev;
> >> +	void __iomem *base;
> >> +	struct clk *clock;
> >> +	struct reset_control *reset;
> >> +
> >> +	bool in_progress;
> >> +	bool in_reset;
> >> +	bool upstream;
> >> +	unsigned int cmd_idx;
> >> +	struct mutex start_lock;
> >> +	struct delayed_work reset_work;
> >> +	spinlock_t client_lock;
> >> +	spinlock_t reset_lock;
> > What data are each of these locks protecting? Please add documentation
> > about how you intend to use them. Try to group the locks with the data they
> > protect if this is not already the case.
> 
> 
> Sure, though I feel the names are fairly descriptive.

Not descriptive enough for me. Please add documentation.

> 
> 
> >
> >> +	wait_queue_head_t wait;
> >> +	struct aspeed_xdma_client *current_client;
> >> +
> >> +	u32 vga_phys;
> >> +	u32 vga_size;
> >> +	void *cmdq;
> >> +	void __iomem *vga_virt;
> >> +	dma_addr_t cmdq_vga_phys;
> >> +	void *cmdq_vga_virt;
> >> +	struct gen_pool *vga_pool;
> >> +};
> >> +
> >> +struct aspeed_xdma_client {
> >> +	struct aspeed_xdma *ctx;
> >> +
> >> +	bool error;
> >> +	bool in_progress;
> >> +	void *virt;
> >> +	dma_addr_t phys;
> >> +	u32 size;
> >> +};
> >> +
> >> +static u32 aspeed_xdma_readl(struct aspeed_xdma *ctx, u8 reg)
> >> +{
> >> +	u32 v = readl(ctx->base + reg);
> >> +
> >> +	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
> >> +	return v;
> >> +}
> >> +
> >> +static void aspeed_xdma_writel(struct aspeed_xdma *ctx, u8 reg, u32 val)
> >> +{
> >> +	writel(val, ctx->base + reg);
> >> +	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, readl(ctx->base + reg));
> > That readl() seems a bit paranoid, and is probably evaluated whether or not
> > this dev_dbg() is enabled. What drove this approach?
> 
> 
> There is some tricky masking of writes of many of the engine registers, 
> so it was helpful to see what the actual result is. I could drop it.

Wouldn't you want to record what you were attempting to write vs the value
that stuck then?

> 
> 
> >
> >> +}
> >> +
> >> +static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
> >> +{
> >> +	aspeed_xdma_writel(ctx, ctx->regs.bmc_cmdq_endp,
> >> +			   ctx->queue_entry_size * XDMA_NUM_CMDS);
> >> +	aspeed_xdma_writel(ctx, ctx->regs.bmc_cmdq_readp,
> >> +			   XDMA_BMC_CMDQ_READP_MAGIC);
> >> +	aspeed_xdma_writel(ctx, ctx->regs.bmc_cmdq_writep, 0);
> >> +	aspeed_xdma_writel(ctx, ctx->regs.control, ctx->control);
> >> +	aspeed_xdma_writel(ctx, ctx->regs.bmc_cmdq_addr, ctx->cmdq_vga_phys);
> >> +
> >> +	ctx->cmd_idx = 0;
> >> +	ctx->in_progress = false;
> >> +}
> >> +
> >> +static unsigned int aspeed_xdma_ast2500_set_cmd(struct aspeed_xdma *ctx,
> >> +						struct aspeed_xdma_op *op,
> >> +						u32 bmc_addr)
> >> +{
> >> +	u64 cmd = XDMA_CMD_AST2500_CMD_IRQ_EN | XDMA_CMD_AST2500_CMD_IRQ_BMC |
> >> +		XDMA_CMD_AST2500_CMD_ID;
> >> +	u64 cmd_pitch = (op->direction ? XDMA_CMD_AST2500_PITCH_UPSTREAM : 0) |
> >> +		XDMA_CMD_AST2500_PITCH_ID;
> >> +	unsigned int line_size;
> >> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
> >> +	unsigned int line_no = 1;
> >> +	unsigned int pitch = 1;
> >> +	struct aspeed_xdma_cmd *ncmd =
> >> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
> >> +
> >> +	dev_dbg(ctx->dev, "xdma %s ast2500: bmc[%08x] len[%08x] host[%08x]\n",
> >> +		op->direction ? "upstream" : "downstream", bmc_addr, op->len,
> >> +		(u32)op->host_addr);
> >> +
> >> +	if (op->len > XDMA_CMD_AST2500_CMD_LINE_SIZE) {
> >> +		unsigned int rem;
> >> +		unsigned int total;
> >> +
> >> +		line_no = op->len / XDMA_CMD_AST2500_CMD_LINE_SIZE;
> >> +		total = XDMA_CMD_AST2500_CMD_LINE_SIZE * line_no;
> >> +		rem = (op->len - total) >>
> >> +			XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> >> +		line_size = XDMA_CMD_AST2500_CMD_LINE_SIZE;
> >> +		pitch = line_size >> XDMA_CMD_AST2500_PITCH_SHIFT;
> >> +		line_size >>= XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> > Can we clean up the configuration of line_size and pitch here? They are set to
> > constants in this case.
> 
> 
> I think this is as clean as it gets. They're used later on so unless I 
> have more if statements it makes sense to set them here.

No worries, was just curious.

> 
> 
> >
> >> +
> >> +		if (rem) {
> >> +			u32 rbmc = bmc_addr + total;
> >> +			struct aspeed_xdma_cmd *rcmd =
> >> +				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
> >> +
> >> +			rcmd->host_addr = op->host_addr + (u64)total;
> >> +			rcmd->pitch = cmd_pitch |
> >> +				((u64)rbmc & XDMA_CMD_AST2500_PITCH_ADDR) |
> >> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, 1) |
> >> +				FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, 1);
> >> +			rcmd->cmd = cmd |
> >> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, 1) |
> >> +				FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE,
> >> +					   rem);
> >> +
> >> +			print_hex_dump_debug("xdma rem", DUMP_PREFIX_OFFSET,
> >> +					     16, 1, rcmd, sizeof(*rcmd), true);
> >> +
> >> +			cmd &= ~(XDMA_CMD_AST2500_CMD_IRQ_EN |
> >> +				 XDMA_CMD_AST2500_CMD_IRQ_BMC);
> >> +
> >> +			nidx = (nidx + 1) % XDMA_NUM_CMDS;
> >> +		}
> >> +	} else {
> >> +		line_size = op->len >> XDMA_CMD_AST2500_CMD_LINE_SIZE_SHIFT;
> >> +	}
> >> +
> >> +	ncmd->host_addr = op->host_addr;
> >> +	ncmd->pitch = cmd_pitch |
> >> +		((u64)bmc_addr & XDMA_CMD_AST2500_PITCH_ADDR) |
> >> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_HOST, pitch) |
> >> +		FIELD_PREP(XDMA_CMD_AST2500_PITCH_BMC, pitch);
> >> +	ncmd->cmd = cmd | FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_NO, line_no) |
> >> +		FIELD_PREP(XDMA_CMD_AST2500_CMD_LINE_SIZE, line_size);
> >> +
> >> +	print_hex_dump_debug("xdma cmd", DUMP_PREFIX_OFFSET, 16, 1, ncmd,
> >> +			     sizeof(*ncmd), true);
> >> +
> >> +	return nidx;
> >> +}
> >> +
> >> +static unsigned int aspeed_xdma_ast2600_set_cmd(struct aspeed_xdma *ctx,
> >> +						struct aspeed_xdma_op *op,
> >> +						u32 bmc_addr)
> >> +{
> >> +	u64 cmd = XDMA_CMD_AST2600_CMD_IRQ_BMC |
> >> +		(op->direction ? XDMA_CMD_AST2600_CMD_UPSTREAM : 0);
> >> +	unsigned int line_size;
> >> +	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
> >> +	unsigned int line_no = 1;
> >> +	unsigned int pitch = 1;
> >> +	struct aspeed_xdma_cmd *ncmd =
> >> +		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
> >> +
> >> +	if ((op->host_addr + op->len) & 0xffffffff00000000ULL)
> >> +		cmd |= XDMA_CMD_AST2600_CMD_64_EN;
> >> +
> >> +	dev_dbg(ctx->dev, "xdma %s ast2600: bmc[%08x] len[%08x] "
> >> +		"host[%016llx]\n", op->direction ? "upstream" : "downstream",
> >> +		bmc_addr, op->len, op->host_addr);
> >> +
> >> +	if (op->len > XDMA_CMD_AST2600_CMD_LINE_SIZE) {
> >> +		unsigned int rem;
> >> +		unsigned int total;
> >> +
> >> +		line_no = op->len / XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
> >> +		total = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE * line_no;
> >> +		rem = op->len - total;
> >> +		line_size = XDMA_CMD_AST2600_CMD_MULTILINE_SIZE;
> >> +		pitch = line_size;
> >> +
> >> +		if (rem) {
> >> +			u32 rbmc = bmc_addr + total;
> >> +			struct aspeed_xdma_cmd *rcmd =
> >> +				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
> >> +
> >> +			rcmd->host_addr = op->host_addr + (u64)total;
> >> +			rcmd->pitch =
> >> +				((u64)rbmc & XDMA_CMD_AST2600_PITCH_ADDR) |
> >> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, 1) |
> >> +				FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, 1);
> >> +			rcmd->cmd = cmd |
> >> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, 1) |
> >> +				FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE,
> >> +					   rem);
> >> +
> >> +			print_hex_dump_debug("xdma rem", DUMP_PREFIX_OFFSET,
> >> +					     16, 1, rcmd, sizeof(*rcmd), true);
> >> +
> >> +			cmd &= ~XDMA_CMD_AST2600_CMD_IRQ_BMC;
> >> +
> >> +			nidx = (nidx + 1) % XDMA_NUM_CMDS;
> >> +		}
> >> +	} else {
> >> +		line_size = op->len;
> >> +	}
> >> +
> >> +	ncmd->host_addr = op->host_addr;
> >> +	ncmd->pitch = ((u64)bmc_addr & XDMA_CMD_AST2600_PITCH_ADDR) |
> >> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_HOST, pitch) |
> >> +		FIELD_PREP(XDMA_CMD_AST2600_PITCH_BMC, pitch);
> >> +	ncmd->cmd = cmd | FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_NO, line_no) |
> >> +		FIELD_PREP(XDMA_CMD_AST2600_CMD_LINE_SIZE, line_size);
> >> +
> >> +	print_hex_dump_debug("xdma cmd", DUMP_PREFIX_OFFSET, 16, 1, ncmd,
> >> +			     sizeof(*ncmd), true);
> >> +
> >> +	return nidx;
> >> +}
> >> +
> >> +static void aspeed_xdma_start(struct aspeed_xdma *ctx,
> >> +			      struct aspeed_xdma_op *op, u32 bmc_addr,
> >> +			      struct aspeed_xdma_client *client)
> >> +{
> >> +	unsigned int nidx;
> >> +
> >> +	mutex_lock(&ctx->start_lock);
> >> +
> >> +	switch (ctx->version) {
> >> +	default:
> >> +	case xdma_ast2500:
> >> +		nidx = aspeed_xdma_ast2500_set_cmd(ctx, op, bmc_addr);
> >> +		break;
> >> +	case xdma_ast2600:
> >> +		nidx = aspeed_xdma_ast2600_set_cmd(ctx, op, bmc_addr);
> >> +		break;
> >> +	}
> > What was the trade-off between the enum and function pointers? Is the
> > enum approach strictly better for some reason?
> 
> 
> No, I just decided to go with the switch.

I think this will go away with better use of the of match data.

> 
> 
> >
> >> +
> >> +	memcpy(ctx->cmdq_vga_virt, ctx->cmdq, XDMA_CMDQ_SIZE);
> >> +
> >> +	client->in_progress = true;
> >> +	ctx->current_client = client;
> >> +
> >> +	ctx->in_progress = true;
> > Do we need ctx->in_progress vs just using the NULL state of ctx->current_client?
> > Is it possible for ctx->current_client to be set and not have a transfer in progress?
> 
> 
> Good point, could probably drop that.
> 
> 
> >
> >> +	ctx->upstream = op->direction ? true : false;
> >> +
> >> +	aspeed_xdma_writel(ctx, ctx->regs.bmc_cmdq_writep,
> >> +			   nidx * ctx->queue_entry_size);
> >> +
> >> +	ctx->cmd_idx = nidx;
> >> +
> >> +	mutex_unlock(&ctx->start_lock);
> >> +}
> >> +
> >> +static void aspeed_xdma_done(struct aspeed_xdma *ctx, bool error)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	/*
> >> +	 * Lock to make sure simultaneous reset and transfer complete don't
> >> +	 * leave the client with the wrong error state.
> >> +	 */
> >> +	spin_lock_irqsave(&ctx->client_lock, flags);
> >> +
> >> +	if (ctx->current_client) {
> > You're testing ctx->current_client under ctx->client_lock here, but ctx->current_client
> > is set under ctx->start_lock in aspeed_xdma_start(), which does not take
> > ctx->client_lock. What data is protected by ctx->client_lock? What data is protected
> > by ctx->client_lock?
> 
> 
> client_lock is making sure the client.error and ctx.current_client are 
> updated atomically, as indicated by the comment. 

But you need to use a consistent lock, otherwise it's pointless.

> It's impossible to be 
> starting a transfer at the same time, since ctx.in_progress would be true.
> 
> 
> >
> >> +		ctx->current_client->error = error;
> >> +		ctx->current_client->in_progress = false;
> >> +		ctx->current_client = NULL;
> >> +	}
> >> +
> >> +	spin_unlock_irqrestore(&ctx->client_lock, flags);
> >> +
> >> +	ctx->in_progress = false;
> > You set ctx->in_progress under ctx->start_lock in aspeed_xdma_start() but you
> > do not take ctx->start_lock when setting it here. What data is ctx->start_lock
> > protecting?
> 
> 
> start_lock is making sure that the hardware register state, command 
> queue, and data associated with the current transfer are updated 
> atomically in the start function. It shouldn't be necessary to lock just 
> to reset in_progress

Then why is it set under start_lock in aspeed_xdma_start()?

These questions are why I asked you to document what locks are protecting
which struct members above.

> 
> 
> >
> >> +	wake_up_interruptible_all(&ctx->wait);
> >> +}
> >> +
> >> +static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
> >> +{
> >> +	struct aspeed_xdma *ctx = arg;
> >> +	u32 status = aspeed_xdma_readl(ctx, ctx->regs.status);
> >> +
> >> +	if (status & ctx->status_bits.ds_dirty) {
> >> +		aspeed_xdma_done(ctx, true);
> >> +	} else {
> >> +		if (status & ctx->status_bits.us_comp) {
> >> +			if (ctx->upstream)
> >> +				aspeed_xdma_done(ctx, false);
> >> +		}
> >> +
> >> +		if (status & ctx->status_bits.ds_comp) {
> >> +			if (!ctx->upstream)
> >> +				aspeed_xdma_done(ctx, false);
> >> +		}
> >> +	}
> >> +
> >> +	aspeed_xdma_writel(ctx, ctx->regs.status, status);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static void aspeed_xdma_reset_finish(struct aspeed_xdma *ctx)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&ctx->reset_lock, flags);
> >> +
> >> +	ctx->in_reset = false;

Looking back at this, I'd interpret `in_reset` as answering the question
"is the device unusable?" In which case, it's not usable until after we've
completed the sleep below, so I'd hold off on clearing the in_reset state
until after the sleep completes.

I'm not sure that having `in_reset` represent the literal reset state of
the device (given the additional constraints) as it stands is useful.

> >> +	reset_control_deassert(ctx->reset);
> >> +
> >> +	spin_unlock_irqrestore(&ctx->reset_lock, flags);
> >> +
> >> +	msleep(XDMA_RESET_TIME_MS);
> >> +
> >> +	aspeed_xdma_init_eng(ctx);
> >> +	aspeed_xdma_done(ctx, true);
> >> +}
> >> +
> >> +static bool aspeed_xdma_reset_start(struct aspeed_xdma *ctx)
> >> +{
> >> +	bool rc = true;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&ctx->reset_lock, flags);
> >> +
> >> +	if (ctx->in_reset) {
> >> +		rc = false;
> >> +	} else {
> >> +		ctx->in_reset = true;
> >> +		reset_control_assert(ctx->reset);
> >> +	}
> > Do start and finish need to be split in this way?
> 
> 
> Yes, in order to prevent waiting for 10ms in interrupt context during 
> the reset.

Do we absolutely need to kick the reset off from interrupt context? 
Why not just queue the entire reset job from interrupt context?

> 
> 
> >
> >> +
> >> +	spin_unlock_irqrestore(&ctx->reset_lock, flags);
> >> +
> >> +	return rc;
> >> +}
> >> +
> >> +static void aspeed_xdma_reset_work(struct work_struct *work)
> >> +{
> >> +	struct delayed_work *dwork = to_delayed_work(work);
> >> +	struct aspeed_xdma *ctx = container_of(dwork, struct aspeed_xdma,
> >> +					       reset_work);
> >> +
> >> +	/*
> >> +	 * Lock to make sure operations aren't started while the engine is
> >> +	 * in an undefined state coming out of reset and waiting to init.
> > Shouldn't we be holding it across both aspeed_xdma_reset_start() and
> > aspeed_xdma_reset_finish()?
> 
> 
> No, it isn't necessary and also start_lock is a mutex which can't be 
> locked in interrupt context. It isn't necessary because a reset before, 
> during, or after starting a transfer will simply cause the transfer to 
> do nothing until the reset completes, when it will be put into an error 
> state.

So why do we lock it at all?

> 
> 
> >
> >> +	 */
> >> +	mutex_lock(&ctx->start_lock);
> >> +
> >> +	aspeed_xdma_reset_finish(ctx);
> >> +
> >> +	mutex_unlock(&ctx->start_lock);
> >> +}
> >> +
> >> +static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
> >> +{
> >> +	struct aspeed_xdma *ctx = arg;
> >> +
> >> +	dev_dbg(ctx->dev, "pcie reset\n");
> >> +
> >> +	if (aspeed_xdma_reset_start(ctx))
> >> +		schedule_delayed_work(&ctx->reset_work,
> >> +				      msecs_to_jiffies(XDMA_RESET_TIME_MS));

With the suggestion above, instead of having aspeed_xdma_reset_start() /
aspeed_xdma_reset_finish() and the existing implementation of
aspeed_xdma_reset_work(), we'd have just aspeed_xdma_reset(),
and aspeed_xdma_reset_work() would look like:

static void aspeed_xdma_reset_work(struct work_struct *work)
{
struct delayed_work *dwork = to_delayed_work(work);
struct aspeed_xdma *ctx = container_of(dwork, struct aspeed_xdma, reset_work);

mutex_lock(&ctx->start_lock);
aspeed_xdma_reset(ctx)
mutex_unlock(&ctx->start_lock);
}

and aspeed_xdma_pcie_irq() becomes:

static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
{
struct aspeed_xdma *ctx = arg;
unsigned long flags;

dev_dbg(ctx->dev, "pcie reset\n");
spin_lock_irqsave(&ctx->reset_lock, flags);
if (ctx->in_reset) {
    spin_unlock_irqrestore(&ctx->reset_lock, flags);
    return IRQ_HANDLED;
}
ctx->in_reset = true;
spin_unlock_irqrestore(&ctx->reset_lock, flags);
schedule_delayed_work(&ctx->reset_work, msecs_to_jiffies(XDMA_RESET_TIME_MS));
return IRQ_HANDLED;
}

> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int aspeed_xdma_init(struct aspeed_xdma *ctx)
> >> +{
> >> +	int rc;
> >> +	struct regmap *scu;
> >> +	u32 conf;
> >> +	u32 mem_size;
> >> +	u32 remap;
> >> +	u32 scu_bmc_class;
> >> +	u32 scu_pcie_conf;
> >> +	u32 scu_strap;
> >> +	u32 sdmc_remap_magic;
> >> +	u32 strap = 0;
> >> +	const u32 bmc = SCU_PCIE_CONF_BMC_EN | SCU_PCIE_CONF_BMC_EN_MSI |
> >> +		SCU_PCIE_CONF_BMC_EN_MCTP
> > Do we need MCTP here?
> 
> 
> I don't know, I used the default value which has MCTP enabled.

Ok. I'd tend to clear it, but it probably doesn't matter.

> 
> 
> >
> >   | SCU_PCIE_CONF_BMC_EN_IRQ |
> >> +		SCU_PCIE_CONF_BMC_EN_DMA;
> >> +	const u32 vga = SCU_PCIE_CONF_VGA_EN | SCU_PCIE_CONF_VGA_EN_MSI |
> >> +		SCU_PCIE_CONF_VGA_EN_MCTP
> > Do we need MCTP here?
> >
> >   | SCU_PCIE_CONF_VGA_EN_IRQ |
> >> +		SCU_PCIE_CONF_VGA_EN_DMA;
> >> +	u32 mem_sizes[4] = { 0x8000000, 0x10000000, 0x20000000, 0x40000000 };
> >> +	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
> >> +	void __iomem *sdmc_base = ioremap(SDMC_BASE, 0x100);
> > Surely this should be a phandle from the devicetree? And what about conflicts
> > with a potential SDMC driver? I don't think what you have is the right approach.
> >
> >> +
> >> +	if (!sdmc_base) {
> >> +		dev_err(ctx->dev, "Failed to ioremap mem controller regs.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	switch (ctx->version) {
> >> +	default:
> >> +	case xdma_ast2500:
> >> +		scu_bmc_class = SCU_AST2500_BMC_CLASS_REV;
> >> +		scu_pcie_conf = SCU_AST2500_PCIE_CONF;
> >> +		scu_strap = SCU_AST2500_STRAP;
> >> +		sdmc_remap_magic = SDMC_AST2500_REMAP_MAGIC;
> > Can't this be described statically? The values should be derived from the
> > devicetree compatible.
> >
> >> +
> >> +		scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
> > I think we should do this via phandle in the devicetree.
> >
> >> +		break;
> >> +	case xdma_ast2600:
> >> +		scu_bmc_class = SCU_AST2600_BMC_CLASS_REV;
> >> +		scu_pcie_conf = SCU_AST2600_PCIE_CONF;
> >> +		scu_strap = SCU_AST2600_STRAP;
> >> +		sdmc_remap_magic = SDMC_AST2600_REMAP_MAGIC;
> > Can't this be described statically? The values should be derived from the
> > devicetree compatible.
> >
> >> +
> >> +		mem_sizes[0] *= 2;
> >> +		mem_sizes[1] *= 2;
> >> +		mem_sizes[2] *= 2;
> >> +		mem_sizes[3] *= 2;
> > Same query as above.
> >
> >> +
> >> +		scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
> > I think we should do this via phandle in the devicetree.
> >
> >> +		break;
> >> +	};
> >> +
> >> +	if (!scu) {
> >> +		dev_err(ctx->dev, "Failed to grab SCU regs.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	/* Set SOC to use the BMC PCIe device and set the device class code */
> >> +	regmap_update_bits(scu, scu_pcie_conf, bmc | vga, bmc);
> >> +	regmap_write(scu, scu_bmc_class, SCU_BMC_CLASS_REV_XDMA);
> > This should be selectable, probably via the devicetree.
> >
> >> +
> >> +	/*
> >> +	 * Calculate the VGA memory size and physical address from the SCU and
> >> +	 * memory controller registers.
> >> +	 */
> >> +	regmap_read(scu, scu_strap, &strap);
> >> +
> >> +	switch (ctx->version) {
> >> +	case xdma_ast2500:
> >> +		ctx->vga_size = vga_sizes[FIELD_GET(SCU_AST2500_STRAP_VGA_MEM,
> >> +						    strap)];
> >> +		break;
> >> +	case xdma_ast2600:
> >> +		ctx->vga_size = vga_sizes[FIELD_GET(SCU_AST2600_STRAP_VGA_MEM,
> >> +						    strap)];
> >> +		break;
> > Can't this be described statically? The values should be derived from the
> > devicetree compatible.
> >
> >> +	}
> >> +
> >> +	conf = readl(sdmc_base + SDMC_CONF);
> >> +	remap = readl(sdmc_base + SDMC_REMAP);
> >> +	remap |= sdmc_remap_magic;
> >> +	writel(remap, sdmc_base + SDMC_REMAP);
> >> +	mem_size = mem_sizes[conf & SDMC_CONF_MEM];
> > See previous objection to this.
> >
> >> +
> >> +	iounmap(sdmc_base);
> >> +
> >> +	ctx->vga_phys = (mem_size - ctx->vga_size) + 0x80000000;
> > RAM base should be extracted from the devicetree. Better yet, the VGA space should
> > be extracted from the devicetree and this calculation avoided altogether.
> 
> 
> Ok, I'll use the devicetree for all this instead.
> 
> 
> >
> >> +
> >> +	ctx->cmdq = devm_kzalloc(ctx->dev, XDMA_CMDQ_SIZE, GFP_KERNEL);
> >> +	if (!ctx->cmdq) {
> >> +		dev_err(ctx->dev, "Failed to allocate command queue.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	ctx->vga_virt = ioremap(ctx->vga_phys, ctx->vga_size);
> > Use devm_ioremap() to avoid the cleanup.
> >
> >> +	if (!ctx->vga_virt) {
> >> +		dev_err(ctx->dev, "Failed to ioremap VGA memory.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	rc = gen_pool_add_virt(ctx->vga_pool, (unsigned long)ctx->vga_virt,
> >> +			       ctx->vga_phys, ctx->vga_size, -1);
> >> +	if (rc) {
> >> +		dev_err(ctx->dev, "Failed to add memory to genalloc pool.\n");
> >> +		iounmap(ctx->vga_virt);
> >> +		return rc;
> >> +	}
> >> +
> >> +	ctx->cmdq_vga_virt = gen_pool_dma_alloc(ctx->vga_pool, XDMA_CMDQ_SIZE,
> >> +						&ctx->cmdq_vga_phys);
> > Can you educate me on this a little? Why is a command queue being allocated in
> > memory writable by the host? Aren't we opening ourselves up to potential corruption?
> 
> 
> In it's current configuration, the engine can't access anything except 
> the VGA memory. That includes the location for the command queue. Not 
> sure much can be done about this. 

Okay, yes, not much can be done about that.

> What path can the host use to access this memory though?

The host can drive DMAs to the VGA region as well, "independent" of the BMC.

> 
> 
> >
> >> +	if (!ctx->cmdq_vga_virt) {
> >> +		dev_err(ctx->dev, "Failed to genalloc cmdq.\n");
> >> +		iounmap(ctx->vga_virt);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	dev_dbg(ctx->dev, "VGA mapped at phys[%08x], size[%08x].\n",
> >> +		ctx->vga_phys, ctx->vga_size);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int aspeed_xdma_probe(struct platform_device *pdev)
> >> +{
> >> +	int irq;
> >> +	int pcie_irq;
> >> +	int rc;
> >> +	enum versions vs = xdma_ast2500;
> >> +	struct device *dev = &pdev->dev;
> >> +	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> >> +	const void *md = of_device_get_match_data(dev);
> >> +
> >> +	if (!ctx)
> >> +		return -ENOMEM;
> >> +
> >> +	if (md)
> >> +		vs = (enum versions)md;
> >> +
> >> +	switch (vs) {
> >> +	default:
> >> +	case xdma_ast2500:
> >> +		ctx->version = xdma_ast2500;
> >> +		ctx->control = XDMA_AST2500_CTRL_US_COMP |
> >> +			XDMA_AST2500_CTRL_DS_COMP |
> >> +			XDMA_AST2500_CTRL_DS_DIRTY |
> >> +			FIELD_PREP(XDMA_AST2500_CTRL_DS_SIZE,
> >> +				   XDMA_DS_PCIE_REQ_SIZE_256) |
> >> +			XDMA_AST2500_CTRL_DS_TIMEOUT |
> >> +			XDMA_AST2500_CTRL_DS_CHECK_ID;
> >> +		ctx->queue_entry_size = XDMA_AST2500_QUEUE_ENTRY_SIZE;
> >> +		ctx->regs.bmc_cmdq_addr = XDMA_AST2500_BMC_CMDQ_ADDR;
> >> +		ctx->regs.bmc_cmdq_endp = XDMA_AST2500_BMC_CMDQ_ENDP;
> >> +		ctx->regs.bmc_cmdq_writep = XDMA_AST2500_BMC_CMDQ_WRITEP;
> >> +		ctx->regs.bmc_cmdq_readp = XDMA_AST2500_BMC_CMDQ_READP;
> >> +		ctx->regs.control = XDMA_AST2500_CTRL;
> >> +		ctx->regs.status = XDMA_AST2500_STATUS;
> >> +		ctx->status_bits.us_comp = XDMA_AST2500_STATUS_US_COMP;
> >> +		ctx->status_bits.ds_comp = XDMA_AST2500_STATUS_DS_COMP;
> >> +		ctx->status_bits.ds_dirty = XDMA_AST2500_STATUS_DS_DIRTY;
> > Why not include all this in the match data?
> 
> 
> Sure.
> 
> 
> >
> >> +		break;
> >> +	case xdma_ast2600:
> >> +		ctx->version = xdma_ast2600;
> >> +		ctx->control = XDMA_AST2600_CTRL_US_COMP |
> >> +			XDMA_AST2600_CTRL_DS_COMP |
> >> +			XDMA_AST2600_CTRL_DS_DIRTY |
> >> +			FIELD_PREP(XDMA_AST2600_CTRL_DS_SIZE,
> >> +				   XDMA_DS_PCIE_REQ_SIZE_256);
> >> +		ctx->queue_entry_size = XDMA_AST2600_QUEUE_ENTRY_SIZE;
> >> +		ctx->regs.bmc_cmdq_addr = XDMA_AST2600_BMC_CMDQ_ADDR;
> >> +		ctx->regs.bmc_cmdq_endp = XDMA_AST2600_BMC_CMDQ_ENDP;
> >> +		ctx->regs.bmc_cmdq_writep = XDMA_AST2600_BMC_CMDQ_WRITEP;
> >> +		ctx->regs.bmc_cmdq_readp = XDMA_AST2600_BMC_CMDQ_READP;
> >> +		ctx->regs.control = XDMA_AST2600_CTRL;
> >> +		ctx->regs.status = XDMA_AST2600_STATUS;
> >> +		ctx->status_bits.us_comp = XDMA_AST2600_STATUS_US_COMP;
> >> +		ctx->status_bits.ds_comp = XDMA_AST2600_STATUS_DS_COMP;
> >> +		ctx->status_bits.ds_dirty = XDMA_AST2600_STATUS_DS_DIRTY;
> > Same query as above
> >
> >> +		break;
> >> +	};
> >> +
> >> +	ctx->dev = dev;
> >> +	platform_set_drvdata(pdev, ctx);
> >> +	mutex_init(&ctx->start_lock);
> >> +	INIT_DELAYED_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
> >> +	spin_lock_init(&ctx->client_lock);
> >> +	spin_lock_init(&ctx->reset_lock);
> >> +	init_waitqueue_head(&ctx->wait);
> >> +
> >> +	ctx->base = devm_platform_ioremap_resource(pdev, 0);
> >> +	if (IS_ERR(ctx->base)) {
> >> +		dev_err(dev, "Unable to ioremap registers.\n");
> >> +		return PTR_ERR(ctx->base);
> >> +	}
> >> +
> >> +	irq = platform_get_irq(pdev, 0);
> >> +	if (irq < 0) {
> >> +		dev_err(dev, "Unable to find IRQ.\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, IRQF_SHARED,
> >> +			      DEVICE_NAME, ctx);
> >> +	if (rc < 0) {
> >> +		dev_err(dev, "Unable to request IRQ %d.\n", irq);
> >> +		return rc;
> >> +	}
> >> +
> >> +	ctx->clock = devm_clk_get(dev, NULL);
> >> +	if (IS_ERR(ctx->clock)) {
> >> +		dev_err(dev, "Unable to request clock.\n");
> >> +		return PTR_ERR(ctx->clock);
> >> +	}
> >> +
> >> +	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
> >> +	if (IS_ERR(ctx->reset)) {
> >> +		dev_err(dev, "Unable to request reset control.\n");
> >> +		return PTR_ERR(ctx->reset);
> >> +	}
> >> +
> >> +	ctx->vga_pool = devm_gen_pool_create(dev, ilog2(PAGE_SIZE), -1, NULL);
> >> +	if (!ctx->vga_pool) {
> >> +		dev_err(dev, "Unable to setup genalloc pool.\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	clk_prepare_enable(ctx->clock);
> > Check for errors
> >
> >> +	msleep(XDMA_RESET_TIME_MS);
> >> +
> >> +	reset_control_deassert(ctx->reset);
> > Check for errors.
> >
> >> +	msleep(XDMA_RESET_TIME_MS);
> >> +
> >> +	rc = aspeed_xdma_init(ctx);
> >> +	if (rc) {
> >> +		reset_control_assert(ctx->reset);
> >> +		clk_disable_unprepare(ctx->clock);
> >> +		return rc;
> >> +	}
> >> +
> >> +	aspeed_xdma_init_eng(ctx);
> >> +
> >> +	/*
> >> +	 * This interrupt could fire immediately so only request it once the
> >> +	 * engine and driver are initialized.
> >> +	 */
> >> +	pcie_irq = platform_get_irq(pdev, 1);
> >> +	if (pcie_irq < 0) {
> >> +		dev_warn(dev, "Unable to find PCI-E IRQ.\n");
> >> +	} else {
> >> +		rc = devm_request_irq(dev, pcie_irq, aspeed_xdma_pcie_irq,
> >> +				      IRQF_SHARED, DEVICE_NAME, ctx);
> >> +		if (rc < 0)
> >> +			dev_warn(dev, "Unable to request PCI-E IRQ %d.\n", rc);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int aspeed_xdma_remove(struct platform_device *pdev)
> >> +{
> >> +	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
> >> +
> >> +	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
> >> +		      XDMA_CMDQ_SIZE);
> > You've used devm_gen_pool_create(), so no need to explicitly free it.
> >
> >> +	iounmap(ctx->vga_virt);
> > This is unnecessary if we use devm_ioremap() as suggested above.
> >
> >> +
> >> +	reset_control_assert(ctx->reset);
> >> +	clk_disable_unprepare(ctx->clock);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct of_device_id aspeed_xdma_match[] = {
> >> +	{
> >> +		.compatible = "aspeed,ast2500-xdma",
> >> +		.data = (void *)xdma_ast2500,
> > I'd prefer you create a struct as discussed throughout.
> >
> >> +	},
> >> +	{
> >> +		.compatible = "aspeed,ast2600-xdma",
> >> +		.data = (void *)xdma_ast2600,
> >> +	},
> >> +	{ },
> >> +};
> >> +
> >> +static struct platform_driver aspeed_xdma_driver = {
> >> +	.probe = aspeed_xdma_probe,
> >> +	.remove = aspeed_xdma_remove,
> >> +	.driver = {
> >> +		.name = DEVICE_NAME,
> >> +		.of_match_table = aspeed_xdma_match,
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(aspeed_xdma_driver);
> >> +
> >> +MODULE_AUTHOR("Eddie James");
> >> +MODULE_DESCRIPTION("Aspeed XDMA Engine Driver");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
> >> new file mode 100644
> >> index 0000000..7f3a031
> >> --- /dev/null
> >> +++ b/include/uapi/linux/aspeed-xdma.h
> >> @@ -0,0 +1,49 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> >> +/* Copyright IBM Corp 2019 */
> >> +
> >> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
> >> +#define _UAPI_LINUX_ASPEED_XDMA_H_
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +/*
> >> + * aspeed_xdma_direction
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_DOWNSTREAM: transfers data from the host to the BMC
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_UPSTREAM: transfers data from the BMC to the host
> >> + *
> >> + * ASPEED_XDMA_DIRECTION_RESET: resets the XDMA engine
> >> + */
> >> +enum aspeed_xdma_direction {
> >> +	ASPEED_XDMA_DIRECTION_DOWNSTREAM = 0,
> >> +	ASPEED_XDMA_DIRECTION_UPSTREAM,
> >> +	ASPEED_XDMA_DIRECTION_RESET,
> >> +};
> >> +
> >> +/*
> >> + * aspeed_xdma_op
> >> + *
> >> + * host_addr: the DMA address on the host side, typically configured by PCI
> >> + *            subsystem
> >> + *
> >> + * len: the size of the transfer in bytes
> >> + *
> >> + * direction: an enumerator indicating the direction of the DMA operation; see
> >> + *            enum aspeed_xdma_direction
> >> + *
> >> + * bmc_addr: the virtual address to DMA on the BMC side; this parameter is
> >> + *           unused on current platforms since the XDMA engine is restricted to
> >> + *           accessing the VGA memory space
> > This doesn't make sense to me - if it's a virtual address then talking about the VGA
> > space doesn't make sense to me as where the memory lives is an implementation
> > detail. If the parameter is a physical address then it makes sense, but we'd always
> > want it specified regardless?
> 
> 
> As the comment says, it's unused. I added the parameter to future-proof 
> the API in case the engine is configured differently, allowing arbitrary 
> memory access by the engine. In that case, the user would pass the 
> virtual address of their data.

Hmm. Wouldn't we still use the mmap() interface and derive the addresses that way
regardless of where the backing memory is located? What do you think the model of
interaction would be if we made use of this parameter?

Andrew
