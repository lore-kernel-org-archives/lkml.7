Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21021C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE542087B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2DCDQq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfHJPme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 11:42:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40228 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHJPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 11:42:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so98750738qtn.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46Oo4g/AtPNOdkiXdZ4k1jVHoYFwbNd62QPI6sUtdFA=;
        b=c2DCDQq7XLRuVVGRe//UPgnQlXrUoPunl6R9vuYIPXpEX5S0qLIn5jXwtWU9j1ig8/
         woYu/A4ttHhsNJhofpqkXao66ZFUfObLoi9BvADLxF5BQm5EF84wxOOC8n2yX8DlfvUw
         7bu9mBwJ9YGPQRGYD1KHS/DrfNTFi/rPb04lrOF4xL+KlsPCcZnnK0t3vkzgn1Zh4dPi
         k+lSCzvhG5nTJugP+GzAL/vDZbillMxwSTPm3UP3jEKgguounYDiEpZ+1Anw7BApKyCa
         004npI4E+LtOeUssUwfmc21SPr5FjnaT9KB04hVCs69FJLHrfjflaxvokKPP36VI8tvm
         wI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46Oo4g/AtPNOdkiXdZ4k1jVHoYFwbNd62QPI6sUtdFA=;
        b=ga6JueiF+ynQw6Ufsq7MnYYbTia5UyxSqut+TXNbHoQcUZsRCI9dfMZzFFuBeQ6Tc2
         IqmKnqBWAblLivG8VC/60wXU299vH2yErV4B1uFHNNG1c3YmJHmDK3LUQmxAlYJzTMbN
         qiQXkRa7Rr5wndmZwJNE2TyFyyQsXeO9F++pvNjoMlQuFMMTxMVOVWrTlLPhqLPlUC7F
         zLqJvTlaK2lgijRE6NHpo7bO7UhUp988trG62yIuy2gpup1gSDjhumXGwqzte62l1R5G
         gm/WrWe9MZAjiPwJh1zizNmPne1zMBQ+Op2YQWrc3XxifkRQW9unpA1AGZYlZt4vWyg2
         DvAg==
X-Gm-Message-State: APjAAAVYDLIk+GV0aDiG93D9O5TKGFsEvQHoIiRHyF+6Fx9nrFsG4d86
        Fp3mzytEM0v1HfFitvPLQjmbK0TpzOI=
X-Google-Smtp-Source: APXvYqxNi5zoMU4CAlzU5ghao3l0QQy2Htvd80laEGJCXhQiPaD5++CGczw3NYQi8OaMwtQepor8cA==
X-Received: by 2002:a0c:bd18:: with SMTP id m24mr23485946qvg.118.1565451752230;
        Sat, 10 Aug 2019 08:42:32 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:22a::1])
        by smtp.gmail.com with ESMTPSA id o50sm16534808qtj.17.2019.08.10.08.42.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 08:42:31 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com,
        cphealy@gmail.com, l.stach@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] mfd: rave-sp: Add support for firmware update
Date:   Sat, 10 Aug 2019 12:43:00 -0300
Message-Id: <20190810154300.25950-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810154300.25950-1-festevam@gmail.com>
References: <20190810154300.25950-1-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add support for updating application firmware of RAVE SP devices.

It adds two sysfs entries:

    * update_fw        - used to initiate firmware update

    * update_fw_status - used to keep track of firmware update
      		         progress

Firmware update process is initiated by two consequitive writes for
"update_fw". First write (contents and size is arbitrary) is used to
switch RAVE SP device into bootloader mode. Second write (contents is
the name of the firmware file to request) will start the actuall
programming process.

Tested to work on RDU1 and RDU2 device, but should support any board
that has RAVE SP MCU.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
[fabio: Fixed checkpatch warnings]
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/mfd/rave-sp.c       | 406 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rave-sp.h |   4 +
 2 files changed, 410 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 546763d8a3e5..a46fa3c04808 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -12,6 +12,7 @@
 #include <linux/crc-ccitt.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/ihex.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -146,6 +147,33 @@ struct rave_sp_status {
 	u8  periph_power_shutoff;
 } __packed;
 
+struct rave_sp_booloader_query_device_response {
+	u8  command;
+	u8  device_type;
+	struct rave_sp_version bootloader;
+	u8  is_app_valid;
+	u16 app_crc;
+	u32 app_start_addr;
+	u32 config_words_start;
+} __packed;
+
+#define RAVE_SP_WDT_FIRMWARE_DATA_PAYLOAD_SIZE	56
+
+struct rave_sp_firmware_data {
+	u8 command;
+	u32 address;
+	u8 size;
+	u8 payload[RAVE_SP_WDT_FIRMWARE_DATA_PAYLOAD_SIZE];
+} __packed;
+
+enum rave_sp_bootloader_command {
+	RAVE_SP_BOOTLOADER_CMD_QUERY_DEVICE     = 0xA1,
+	RAVE_SP_BOOTLOADER_CMD_ERASE_APP        = 0xA3,
+	RAVE_SP_BOOTLOADER_CMD_PROGRAM_DEVICE   = 0xA4,
+	RAVE_SP_BOOTLOADER_CMD_PROGRAM_COMPLETE = 0xA5,
+	RAVE_SP_BOOTLOADER_CMD_READ_APP         = 0xA6,
+};
+
 /**
  * struct rave_sp_variant_cmds - Variant specific command routines
  *
@@ -169,6 +197,15 @@ struct rave_sp_variant {
 	struct rave_sp_variant_cmds cmd;
 };
 
+struct rave_sp_update_state {
+	u32 start;
+	u32 end;
+	size_t size;
+	size_t progress;
+};
+
+#define RAVE_SP_FLAG_BOOTLOADER_MODE	BIT(0)
+
 /**
  * struct rave_sp - RAVE supervisory processor core
  *
@@ -198,8 +235,106 @@ struct rave_sp {
 
 	const char *part_number_firmware;
 	const char *part_number_bootloader;
+
+	unsigned long flags;
+
+	struct mutex update_lock;
+	atomic_t update_status;
+};
+
+static int rave_sp_update_firmware(struct rave_sp *, const struct firmware *);
+static int rave_sp_switch_to_bootloader(struct rave_sp *);
+
+static ssize_t update_fw_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct rave_sp *sp = dev_get_drvdata(dev);
+	int ret, err;
+
+	mutex_lock(&sp->update_lock);
+
+	if (rave_sp_is_in_bootloader_mode(sp)) {
+		const struct firmware *firmware;
+
+		ret = request_ihex_firmware(&firmware, buf, dev);
+		if (!ret) {
+			ret = rave_sp_update_firmware(sp, firmware);
+			release_firmware(firmware);
+		}
+	} else {
+		devm_of_platform_depopulate(dev);
+
+		ret = rave_sp_switch_to_bootloader(sp);
+		if (ret)
+			dev_err(dev, "Failed to switch to bootloader mode\n");
+		/*
+		 * In the event of above call to
+		 * rave_sp_start_update() failing we still want to try
+		 * to populate all of the platform devices back, so
+		 * we'd not end up not having watchdog petting driver.
+		 */
+		err = devm_of_platform_populate(dev);
+		if (err)
+			dev_err(dev, "Failed to populate devices\n");
+
+		ret = ret ?: err;
+	}
+
+	mutex_unlock(&sp->update_lock);
+
+	return ret ?: count;
+}
+
+static DEVICE_ATTR_WO(update_fw);
+
+static ssize_t update_fw_status_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct rave_sp *sp = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", atomic_read(&sp->update_status));
+}
+
+static DEVICE_ATTR_RO(update_fw_status);
+
+static struct attribute *rave_sp_attrs[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_update_fw_status.attr,
+	NULL,
 };
 
+struct attribute_group rave_sp_group = {
+	.attrs = rave_sp_attrs,
+};
+
+static void devm_rave_sp_sysfs_group_release(struct device *dev, void *res)
+{
+	sysfs_remove_group(&dev->kobj, &rave_sp_group);
+}
+
+static int devm_rave_sysfs_create_group(struct rave_sp *sp)
+{
+	struct rave_sp **rc;
+	struct device *dev = &sp->serdev->dev;
+	int ret;
+
+	rc = devres_alloc(devm_rave_sp_sysfs_group_release, sizeof(*rc),
+			  GFP_KERNEL);
+	if (!rc)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(&dev->kobj, &rave_sp_group);
+	if (!ret) {
+		*rc = sp;
+		devres_add(dev, rc);
+	} else {
+		devres_free(rc);
+	}
+
+	return ret;
+}
+
 static bool rave_sp_id_is_event(u8 code)
 {
 	return (code & 0xF0) == RAVE_SP_EVNT_BASE;
@@ -640,6 +775,8 @@ static int rave_sp_default_cmd_translate(enum rave_sp_command command)
 		return 0x1F;
 	case RAVE_SP_CMD_RMB_EEPROM:
 		return 0x20;
+	case RAVE_SP_CMD_BOOTLOADER:
+		return 0x2A;
 	default:
 		return -EINVAL;
 	}
@@ -765,6 +902,267 @@ static const struct serdev_device_ops rave_sp_serdev_device_ops = {
 	.write_wakeup = serdev_device_write_wakeup,
 };
 
+static void rave_sp_set_update_fw_status(struct rave_sp *sp, int status)
+{
+	struct device *dev = &sp->serdev->dev;
+
+	atomic_set(&sp->update_status, status);
+	sysfs_notify(&dev->kobj, NULL, "update_fw_status");
+}
+
+bool rave_sp_is_in_bootloader_mode(struct rave_sp *sp)
+{
+	return test_bit(RAVE_SP_FLAG_BOOTLOADER_MODE, &sp->flags);
+}
+EXPORT_SYMBOL_GPL(rave_sp_is_in_bootloader_mode);
+
+static int rave_sp_switch_to_bootloader(struct rave_sp *sp)
+{
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_JUMP_TO_BOOTLOADER,
+		/*
+		 * Even though this is a no-response command ACK-ID is
+		 * still expected to be present in command
+		 * payload. Since it's there only for correct layout's
+		 * sake pass a 0, instead of trying to obtain a proper
+		 * ACK id from corresponding atomic counter.
+		 */
+		[1] = 0,
+	};
+	int ret;
+
+	ret = rave_sp_write(sp, cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+	/*
+	 * Arbitrary sleep delay to wait for bootloader firmware to boot
+	 */
+	msleep(1000);
+	set_bit(RAVE_SP_FLAG_BOOTLOADER_MODE, &sp->flags);
+
+	return 0;
+}
+
+static int rave_sp_query_device(struct rave_sp *sp,
+				struct rave_sp_update_state *update)
+{
+	struct rave_sp_booloader_query_device_response r;
+	struct device *dev = &sp->serdev->dev;
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_BOOTLOADER,
+		[1] = 0,
+		[2] = RAVE_SP_BOOTLOADER_CMD_QUERY_DEVICE,
+	};
+	int ret;
+
+	ret = rave_sp_exec(sp, cmd, sizeof(cmd), &r, sizeof(r));
+	if (ret)
+		return ret;
+
+	update->start = r.app_start_addr;
+	/*
+	 * Unfortunately QUERY_DEVICE command does not explicitly
+	 * report the last address we can program, however all types
+	 * for PIC MCU used for RAVE SP share the same relationship
+	 * between that and the start of config word region.
+	 */
+	update->end   = r.config_words_start - 0xff8;
+
+	dev_dbg(dev, "device type:         %02x\n", r.device_type);
+	dev_dbg(dev, "bootloader hardware: %02d\n", r.bootloader.hardware);
+	dev_dbg(dev, "bootloader major:    %02d\n", r.bootloader.major);
+	dev_dbg(dev, "bootloader minor:    %02d\n", r.bootloader.minor);
+	dev_dbg(dev, "bootloader letters:  %c%c\n", r.bootloader.letter[0],
+		r.bootloader.letter[1]);
+	dev_dbg(dev, "is app valid:        %02x\n", r.is_app_valid);
+	dev_dbg(dev, "app crc:             %04x\n", r.app_crc);
+	dev_dbg(dev, "app start addr:      %08x\n", r.app_start_addr);
+	dev_dbg(dev, "config words start:  %08x\n", r.config_words_start);
+
+	return 0;
+}
+
+static int rave_sp_program_complete(struct rave_sp *sp)
+{
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_BOOTLOADER,
+		[1] = 0,
+		[2] = RAVE_SP_BOOTLOADER_CMD_PROGRAM_COMPLETE,
+	};
+
+	return rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
+}
+
+static int rave_sp_erase_app(struct rave_sp *sp)
+{
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_BOOTLOADER,
+		[1] = 0,
+		[2] = RAVE_SP_BOOTLOADER_CMD_ERASE_APP,
+	};
+
+	return rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
+}
+
+static int rave_sp_program_ihex_record(struct rave_sp *sp,
+				       struct rave_sp_update_state *update,
+				       const struct ihex_binrec *rec)
+{
+	struct device *dev = &sp->serdev->dev;
+	u8 cmd[2 + sizeof(struct rave_sp_firmware_data)] = {
+		[0] = RAVE_SP_CMD_BOOTLOADER,
+		[1] = 0,
+	};
+	struct rave_sp_firmware_data *fwdata = (void *)&cmd[2];
+	size_t residue = be16_to_cpu(rec->len);
+	u32 address = be32_to_cpu(rec->addr);
+	const u8 *data = rec->data;
+	size_t chunk;
+	int ret;
+
+	do {
+		size_t status;
+
+		chunk = min(residue, sizeof(fwdata->payload));
+		/*
+		 * All firmware addresses are specified in units of
+		 * 16-bit words
+		 */
+		fwdata->address = address / 2;
+		/*
+		 * If the chunk we are about to program crosses
+		 * starting point of allowed range we artificially
+		 * split it in two by shrinking immediate write size
+		 * to cover only the porting that lies completely
+		 * outsize
+		 */
+		if (fwdata->address < update->start &&
+		    fwdata->address + chunk / 2 > update->start)
+			chunk = (update->start - fwdata->address) * 2;
+		/*
+		 * Bootloader will ignore all of the requests to write
+		 * data whose start addresses fall outside of the
+		 * [update->start; update->end) region.
+		 */
+		if (update->start <= fwdata->address &&
+		    fwdata->address <= update->end) {
+
+			fwdata->size = chunk;
+			fwdata->command =
+				RAVE_SP_BOOTLOADER_CMD_PROGRAM_DEVICE;
+
+			memcpy(fwdata->payload, data, chunk);
+
+			print_hex_dump_debug("programmed chunk: ",
+					     DUMP_PREFIX_NONE,
+					     16, 1, data, chunk, false);
+
+			ret = rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
+			if (ret)
+				return ret;
+			/*
+			 * Second, read it back and verify contents
+			 */
+			fwdata->command = RAVE_SP_BOOTLOADER_CMD_READ_APP;
+
+			ret = rave_sp_exec(sp, cmd,
+					   sizeof(cmd) -
+					   sizeof(fwdata->payload),
+					   fwdata,
+					   sizeof(fwdata->command) +
+					   sizeof(fwdata->size) +
+					   sizeof(fwdata->address) +
+					   chunk);
+			if (ret)
+				return ret;
+
+			print_hex_dump_debug("read chunk: ", DUMP_PREFIX_NONE,
+					     16, 1, fwdata->payload,
+					     fwdata->size, false);
+
+			if (memcmp(data, fwdata->payload, chunk)) {
+				dev_err(dev,
+					"Programmed data @0x%08x doesn't match\n",
+					fwdata->address);
+				return -EIO;
+			}
+		}
+
+		residue -= chunk;
+		address += chunk;
+		data    += chunk;
+
+		update->progress += chunk;
+		status = (update->progress * 100) / update->size;
+		/*
+		 * We only go up to 99 here and reserve 100 to
+		 * indicate completion of the last step of firmware
+		 * update process done by
+		 * rave_sp_wdt_program_complete()
+		 */
+		status = min(status, 99U);
+
+		rave_sp_set_update_fw_status(sp, status);
+	} while (residue);
+
+	return 0;
+}
+
+static size_t rave_sp_firmware_size(const struct firmware *firmware)
+{
+	const struct ihex_binrec *rec;
+	size_t size = 0;
+
+	for (rec = (void *)firmware->data; rec; rec = ihex_next_binrec(rec))
+		size += be16_to_cpu(rec->len);
+
+	return size;
+}
+
+static int rave_sp_update_firmware(struct rave_sp *sp,
+				   const struct firmware *firmware)
+{
+	struct device *dev = &sp->serdev->dev;
+	struct rave_sp_update_state update = {
+		.progress = 0,
+		.size = rave_sp_firmware_size(firmware),
+	};
+	const struct ihex_binrec *rec;
+	int ret;
+
+	rave_sp_set_update_fw_status(sp, 0);
+
+	ret = rave_sp_query_device(sp, &update);
+	if (ret) {
+		dev_err(dev, "Failed to query device\n");
+		return ret;
+	}
+
+	ret = rave_sp_erase_app(sp);
+	if (ret) {
+		dev_err(dev, "Failed to erase device\n");
+		return ret;
+	}
+
+	for (rec = (void *)firmware->data; rec; rec = ihex_next_binrec(rec)) {
+		ret = rave_sp_program_ihex_record(sp, &update, rec);
+		if (ret) {
+			dev_err(dev, "Failed to program device\n");
+			return ret;
+		}
+	}
+
+	ret = rave_sp_program_complete(sp);
+	if (ret) {
+		dev_err(dev, "Failed to write CRC\n");
+		return ret;
+	}
+
+	rave_sp_set_update_fw_status(sp, 100);
+
+	return ret;
+}
+
 static int rave_sp_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
@@ -794,6 +1192,8 @@ static int rave_sp_probe(struct serdev_device *serdev)
 	mutex_init(&sp->reply_lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&sp->event_notifier_list);
 
+	mutex_init(&sp->update_lock);
+
 	serdev_device_set_client_ops(serdev, &rave_sp_serdev_device_ops);
 	ret = devm_serdev_device_open(dev, serdev);
 	if (ret)
@@ -822,6 +1222,12 @@ static int rave_sp_probe(struct serdev_device *serdev)
 	dev_info(dev, "Firmware version: %s",   sp->part_number_firmware);
 	dev_info(dev, "Bootloader version: %s", sp->part_number_bootloader);
 
+	ret = devm_rave_sysfs_create_group(sp);
+	if (ret) {
+		dev_warn(dev, "Failed to create sysfs group: %d\n", ret);
+		return ret;
+	}
+
 	return devm_of_platform_populate(dev);
 }
 
diff --git a/include/linux/mfd/rave-sp.h b/include/linux/mfd/rave-sp.h
index 11eef77ef976..aca55920d088 100644
--- a/include/linux/mfd/rave-sp.h
+++ b/include/linux/mfd/rave-sp.h
@@ -26,6 +26,8 @@ enum rave_sp_command {
 	RAVE_SP_CMD_RESET			= 0xA7,
 	RAVE_SP_CMD_RESET_REASON		= 0xA8,
 
+	RAVE_SP_CMD_JUMP_TO_BOOTLOADER		= 0xB0,
+	RAVE_SP_CMD_BOOTLOADER			= 0xB1,
 	RAVE_SP_CMD_REQ_COPPER_REV		= 0xB6,
 	RAVE_SP_CMD_GET_I2C_DEVICE_STATUS	= 0xBA,
 	RAVE_SP_CMD_GET_SP_SILICON_REV		= 0xB9,
@@ -59,4 +61,6 @@ struct device;
 int devm_rave_sp_register_event_notifier(struct device *dev,
 					 struct notifier_block *nb);
 
+bool rave_sp_is_in_bootloader_mode(struct rave_sp *sp);
+
 #endif /* _LINUX_RAVE_SP_H_ */
-- 
2.17.1

