Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2283C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCC32183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfC3OQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:16:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfC3OQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:16:47 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E8E4A280B0E;
        Sat, 30 Mar 2019 14:16:44 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
Date:   Sat, 30 Mar 2019 15:16:37 +0100
Message-Id: <20190330141637.22632-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AT25 protocol fits pretty well in the spi-mem model. Convert the
at25 spi driver to a spi-mem driver and use the dirmap API instead of
forging SPI messages manually.
This makes the driver compatible with spi-mem-only controllers
(controllers implementing only the spi_mem ops).

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
 1 file changed, 176 insertions(+), 106 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 99de6939cd5a..818853babbd0 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 
 #include <linux/nvmem-provider.h>
-#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
 
@@ -29,12 +29,17 @@
  */
 
 struct at25_data {
-	struct spi_device	*spi;
+	struct spi_mem		*spimem;
 	struct mutex		lock;
 	struct spi_eeprom	chip;
 	unsigned		addrlen;
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
+	void			*scratchbuf;
+	struct {
+		struct spi_mem_dirmap_desc *rdesc[2];
+		struct spi_mem_dirmap_desc *wdesc[2];
+	} dirmap;
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -63,17 +68,89 @@ struct at25_data {
 
 #define	io_limit	PAGE_SIZE	/* bytes */
 
+static int at25_create_dirmaps(struct at25_data *at25)
+{
+	struct spi_mem_dirmap_info info = {
+		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_READ, 1),
+				      SPI_MEM_OP_ADDR(at25->addrlen, 0, 1),
+				      SPI_MEM_OP_NO_DUMMY,
+				      SPI_MEM_OP_DATA_IN(0, NULL, 1)),
+		.offset = 0,
+		.length = at25->chip.byte_len,
+	};
+	struct device *dev = &at25->spimem->spi->dev;
+
+	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
+		info.length = 256;
+
+	at25->dirmap.rdesc[0] = devm_spi_mem_dirmap_create(dev, at25->spimem,
+							   &info);
+	if (IS_ERR(at25->dirmap.rdesc[0]))
+		return PTR_ERR(at25->dirmap.rdesc[0]);
+
+	info.op_tmpl.cmd.opcode = AT25_WRITE;
+	info.op_tmpl.data.dir = SPI_MEM_DATA_OUT;
+
+	at25->dirmap.wdesc[0] = devm_spi_mem_dirmap_create(dev, at25->spimem,
+							   &info);
+	if (IS_ERR(at25->dirmap.wdesc[0]))
+		return PTR_ERR(at25->dirmap.wdesc[0]);
+
+	if (!(at25->chip.flags & EE_INSTR_BIT3_IS_ADDR))
+		return 0;
+
+	info.length = at25->chip.byte_len - 256;
+	info.op_tmpl.cmd.opcode = AT25_READ | AT25_INSTR_BIT3;
+	info.op_tmpl.data.dir = SPI_MEM_DATA_IN;
+
+	at25->dirmap.rdesc[1] = devm_spi_mem_dirmap_create(dev, at25->spimem,
+							   &info);
+	if (IS_ERR(at25->dirmap.rdesc[1]))
+		return PTR_ERR(at25->dirmap.rdesc[1]);
+
+	info.op_tmpl.cmd.opcode = AT25_WRITE | AT25_INSTR_BIT3;
+	info.op_tmpl.data.dir = SPI_MEM_DATA_OUT;
+
+	at25->dirmap.wdesc[1] = devm_spi_mem_dirmap_create(dev, at25->spimem,
+							   &info);
+	if (IS_ERR(at25->dirmap.wdesc[1]))
+		return PTR_ERR(at25->dirmap.wdesc[1]);
+
+	return 0;
+}
+
+static int at25_rdsr(struct at25_data *at25)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_RDSR, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(1, at25->scratchbuf, 1));
+	int ret;
+
+	ret = spi_mem_exec_op(at25->spimem, &op);
+	if (ret)
+		return ret;
+
+	return *((u8 *)at25->scratchbuf);
+}
+
+static int at25_wren(struct at25_data *at25)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(AT25_WREN, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_NO_DATA);
+
+	return spi_mem_exec_op(at25->spimem, &op);
+}
+
 static int at25_ee_read(void *priv, unsigned int offset,
 			void *val, size_t count)
 {
+	struct spi_mem_dirmap_desc *desc;
 	struct at25_data *at25 = priv;
-	char *buf = val;
-	u8			command[EE_MAXADDRLEN + 1];
-	u8			*cp;
+	unsigned int dirmap_offset;
 	ssize_t			status;
-	struct spi_transfer	t[2];
-	struct spi_message	m;
-	u8			instr;
 
 	if (unlikely(offset >= at25->chip.byte_len))
 		return -EINVAL;
@@ -82,38 +159,14 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	if (unlikely(!count))
 		return -EINVAL;
 
-	cp = command;
-
-	instr = AT25_READ;
-	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-		if (offset >= (1U << (at25->addrlen * 8)))
-			instr |= AT25_INSTR_BIT3;
-	*cp++ = instr;
-
-	/* 8/16/24-bit address is written MSB first */
-	switch (at25->addrlen) {
-	default:	/* case 3 */
-		*cp++ = offset >> 16;
-		/* fall through */
-	case 2:
-		*cp++ = offset >> 8;
-		/* fall through */
-	case 1:
-	case 0:	/* can't happen: for better codegen */
-		*cp++ = offset >> 0;
+	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && offset > 255) {
+		desc = at25->dirmap.rdesc[1];
+		dirmap_offset = offset - 256;
+	} else {
+		desc = at25->dirmap.rdesc[0];
+		dirmap_offset = offset;
 	}
 
-	spi_message_init(&m);
-	memset(t, 0, sizeof(t));
-
-	t[0].tx_buf = command;
-	t[0].len = at25->addrlen + 1;
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].rx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
-
 	mutex_lock(&at25->lock);
 
 	/* Read it all at once.
@@ -122,8 +175,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	 * other devices on the bus need to be accessed regularly or
 	 * this chip is clocked very slowly
 	 */
-	status = spi_sync(at25->spi, &m);
-	dev_dbg(&at25->spi->dev, "read %zu bytes at %d --> %zd\n",
+	status = spi_mem_dirmap_read(desc, dirmap_offset, count, val);
+	dev_dbg(&at25->spimem->spi->dev, "read %zu bytes at %d --> %zd\n",
 		count, offset, status);
 
 	mutex_unlock(&at25->lock);
@@ -149,7 +202,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	buf_size = at25->chip.page_size;
 	if (buf_size > io_limit)
 		buf_size = io_limit;
-	bounce = kmalloc(buf_size + at25->addrlen + 1, GFP_KERNEL);
+	bounce = kmalloc(buf_size, GFP_KERNEL);
 	if (!bounce)
 		return -ENOMEM;
 
@@ -158,48 +211,37 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	 */
 	mutex_lock(&at25->lock);
 	do {
+		struct spi_mem_dirmap_desc *desc;
 		unsigned long	timeout, retries;
 		unsigned	segment;
-		unsigned	offset = (unsigned) off;
-		u8		*cp = bounce;
+		unsigned int	dirmap_offset;
 		int		sr;
-		u8		instr;
 
-		*cp = AT25_WREN;
-		status = spi_write(at25->spi, cp, 1);
+		status = at25_wren(at25);
 		if (status < 0) {
-			dev_dbg(&at25->spi->dev, "WREN --> %d\n", status);
+			dev_dbg(&at25->spimem->spi->dev, "WREN --> %d\n",
+				status);
 			break;
 		}
 
-		instr = AT25_WRITE;
-		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-			if (offset >= (1U << (at25->addrlen * 8)))
-				instr |= AT25_INSTR_BIT3;
-		*cp++ = instr;
-
-		/* 8/16/24-bit address is written MSB first */
-		switch (at25->addrlen) {
-		default:	/* case 3 */
-			*cp++ = offset >> 16;
-			/* fall through */
-		case 2:
-			*cp++ = offset >> 8;
-			/* fall through */
-		case 1:
-		case 0:	/* can't happen: for better codegen */
-			*cp++ = offset >> 0;
+		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR && off > 255) {
+			desc = at25->dirmap.wdesc[1];
+			dirmap_offset = off -  256;
+		} else {
+			desc = at25->dirmap.wdesc[0];
+			dirmap_offset = off;
 		}
 
 		/* Write as much of a page as we can */
-		segment = buf_size - (offset % buf_size);
+		segment = buf_size - (dirmap_offset % buf_size);
 		if (segment > count)
 			segment = count;
-		memcpy(cp, buf, segment);
-		status = spi_write(at25->spi, bounce,
-				segment + at25->addrlen + 1);
-		dev_dbg(&at25->spi->dev, "write %u bytes at %u --> %d\n",
-			segment, offset, status);
+		memcpy(bounce, buf, segment);
+		status = spi_mem_dirmap_write(desc, dirmap_offset, segment,
+					      bounce);
+		dev_dbg(&at25->spimem->spi->dev,
+			"write %u bytes at %u --> %d\n",
+			segment, off, status);
 		if (status < 0)
 			break;
 
@@ -211,10 +253,9 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		timeout = jiffies + msecs_to_jiffies(EE_TIMEOUT);
 		retries = 0;
 		do {
-
-			sr = spi_w8r8(at25->spi, AT25_RDSR);
+			sr = at25_rdsr(at25);
 			if (sr < 0 || (sr & AT25_SR_nRDY)) {
-				dev_dbg(&at25->spi->dev,
+				dev_dbg(&at25->spimem->spi->dev,
 					"rdsr --> %d (%02x)\n", sr, sr);
 				/* at HZ=100, this is sloooow */
 				msleep(1);
@@ -225,9 +266,9 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		} while (retries++ < 3 || time_before_eq(jiffies, timeout));
 
 		if ((sr < 0) || (sr & AT25_SR_nRDY)) {
-			dev_err(&at25->spi->dev,
+			dev_err(&at25->spimem->spi->dev,
 				"write %u bytes offset %u, timeout after %u msecs\n",
-				segment, offset,
+				segment, off,
 				jiffies_to_msecs(jiffies -
 					(timeout - EE_TIMEOUT)));
 			status = -ETIMEDOUT;
@@ -304,7 +345,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	return 0;
 }
 
-static int at25_probe(struct spi_device *spi)
+static int at25_probe(struct spi_mem *spimem)
 {
 	struct at25_data	*at25 = NULL;
 	struct spi_eeprom	chip;
@@ -313,12 +354,12 @@ static int at25_probe(struct spi_device *spi)
 	int			addrlen;
 
 	/* Chip description */
-	if (!spi->dev.platform_data) {
-		err = at25_fw_to_chip(&spi->dev, &chip);
+	if (!spimem->spi->dev.platform_data) {
+		err = at25_fw_to_chip(&spimem->spi->dev, &chip);
 		if (err)
 			return err;
 	} else
-		chip = *(struct spi_eeprom *)spi->dev.platform_data;
+		chip = *(struct spi_eeprom *)spimem->spi->dev.platform_data;
 
 	/* For now we only support 8/16/24 bit addressing */
 	if (chip.flags & EE_ADDR1)
@@ -328,37 +369,49 @@ static int at25_probe(struct spi_device *spi)
 	else if (chip.flags & EE_ADDR3)
 		addrlen = 3;
 	else {
-		dev_dbg(&spi->dev, "unsupported address type\n");
+		dev_dbg(&spimem->spi->dev, "unsupported address type\n");
 		return -EINVAL;
 	}
 
-	/* Ping the chip ... the status register is pretty portable,
-	 * unlike probing manufacturer IDs.  We do expect that system
-	 * firmware didn't write it in the past few milliseconds!
-	 */
-	sr = spi_w8r8(spi, AT25_RDSR);
-	if (sr < 0 || sr & AT25_SR_nRDY) {
-		dev_dbg(&spi->dev, "rdsr --> %d (%02x)\n", sr, sr);
-		return -ENXIO;
-	}
-
-	at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
+	at25 = devm_kzalloc(&spimem->spi->dev, sizeof(struct at25_data),
+			    GFP_KERNEL);
 	if (!at25)
 		return -ENOMEM;
 
 	mutex_init(&at25->lock);
 	at25->chip = chip;
-	at25->spi = spi;
-	spi_set_drvdata(spi, at25);
+	at25->spimem = spimem;
+	spi_mem_set_drvdata(spimem, at25);
 	at25->addrlen = addrlen;
 
-	at25->nvmem_config.name = dev_name(&spi->dev);
-	at25->nvmem_config.dev = &spi->dev;
+	/*
+	 * Can't be allocated with devm_kmalloc() because we need a DMA-safe
+	 * buffer.
+	 */
+	at25->scratchbuf = kmalloc(1, GFP_KERNEL);
+
+	/* Ping the chip ... the status register is pretty portable,
+	 * unlike probing manufacturer IDs.  We do expect that system
+	 * firmware didn't write it in the past few milliseconds!
+	 */
+	sr = at25_rdsr(at25);
+	if (sr < 0 || sr & AT25_SR_nRDY) {
+		dev_dbg(&spimem->spi->dev, "rdsr --> %d (%02x)\n", sr, sr);
+		err = -ENXIO;
+		goto err_free_scratchbuf;
+	}
+
+	err = at25_create_dirmaps(at25);
+	if (err)
+		goto err_free_scratchbuf;
+
+	at25->nvmem_config.name = dev_name(&spimem->spi->dev);
+	at25->nvmem_config.dev = &spimem->spi->dev;
 	at25->nvmem_config.read_only = chip.flags & EE_READONLY;
 	at25->nvmem_config.root_only = true;
 	at25->nvmem_config.owner = THIS_MODULE;
 	at25->nvmem_config.compat = true;
-	at25->nvmem_config.base_dev = &spi->dev;
+	at25->nvmem_config.base_dev = &spimem->spi->dev;
 	at25->nvmem_config.reg_read = at25_ee_read;
 	at25->nvmem_config.reg_write = at25_ee_write;
 	at25->nvmem_config.priv = at25;
@@ -366,17 +419,34 @@ static int at25_probe(struct spi_device *spi)
 	at25->nvmem_config.word_size = 1;
 	at25->nvmem_config.size = chip.byte_len;
 
-	at25->nvmem = devm_nvmem_register(&spi->dev, &at25->nvmem_config);
-	if (IS_ERR(at25->nvmem))
-		return PTR_ERR(at25->nvmem);
+	at25->nvmem = devm_nvmem_register(&spimem->spi->dev,
+					  &at25->nvmem_config);
+	if (IS_ERR(at25->nvmem)) {
+		err = PTR_ERR(at25->nvmem);
+		goto err_free_scratchbuf;
+	}
 
-	dev_info(&spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
+	dev_info(&spimem->spi->dev, "%d %s %s eeprom%s, pagesize %u\n",
 		(chip.byte_len < 1024) ? chip.byte_len : (chip.byte_len / 1024),
 		(chip.byte_len < 1024) ? "Byte" : "KByte",
 		at25->chip.name,
 		(chip.flags & EE_READONLY) ? " (readonly)" : "",
 		at25->chip.page_size);
 	return 0;
+
+err_free_scratchbuf:
+	kfree(at25->scratchbuf);
+
+	return err;
+}
+
+static int at25_remove(struct spi_mem *spimem)
+{
+	struct at25_data *at25 = spi_mem_get_drvdata(spimem);
+
+	kfree(at25->scratchbuf);
+
+	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -387,15 +457,15 @@ static const struct of_device_id at25_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at25_of_match);
 
-static struct spi_driver at25_driver = {
-	.driver = {
-		.name		= "at25",
+static struct spi_mem_driver at25_driver = {
+	.spidrv.driver = {
+		.name = "at25",
 		.of_match_table = at25_of_match,
 	},
-	.probe		= at25_probe,
+	.probe = at25_probe,
+	.remove = at25_remove,
 };
-
-module_spi_driver(at25_driver);
+module_spi_mem_driver(at25_driver);
 
 MODULE_DESCRIPTION("Driver for most SPI EEPROMs");
 MODULE_AUTHOR("David Brownell");
-- 
2.20.1

