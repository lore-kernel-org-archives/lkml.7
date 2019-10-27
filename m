Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA40CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADC8214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hq6TNTn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfJ0XKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:10:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44137 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfJ0XKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:10:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so5359887pgd.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blFqHbffraQMI10j6s/3n9UD9zu64v5eV4E8qMDqUrk=;
        b=Hq6TNTn+sLKjBLwxqoCgBwzlivjH4+IEWHpak5X95f2wKJg3FBq4EZ6oEX5+5z1MKU
         fmBdMnOU+LnqXIi4aKvhSu6KZo7/MlfnZgpg8gdQy5t1cF7T/4h6Dtdl6qefIy6WU3V6
         038sNr1PKK9CXP3ELYfOsgIaXcn8nChNweTQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blFqHbffraQMI10j6s/3n9UD9zu64v5eV4E8qMDqUrk=;
        b=HD4l0UP23lA3v+jKBbqr0M9yGL8VQRc0nfpoYQ1hZS1cOyJGHqgpL53wjDvb8U0Hea
         75pg6jff8czFX7FA3Bqiy/TNCF2rl0QaCPwVGtszxo72eKvoiiFltX7qDJWt0hO020Fq
         wZw3Vh624ZOEoSFDhZ7kikUHlLn1kk0b+zdhgWNjXYVuZZ1KSOtFX3Tf9DWzsm3X0wnc
         D7cCwfzQhDKkBMrophpKqDdSbCZ0f5jupCm1UVp94aj0kJDxatbe1FJ9srMa7OEZ609n
         qGz8CMflv2AXv7l1SQnqd9PR2JFcvasAgAXCxyd9qmR6YakqqZfOuQtbnUbipvT4lQX8
         xTJw==
X-Gm-Message-State: APjAAAUeQmfCe8AykAJm+YFV9wR/ghmgGyeh3plR8lOLnsrO4C5D/b4l
        XWFFTIkt94Dr3anYISVdLSzoAQ==
X-Google-Smtp-Source: APXvYqyyy+gEPsOmR8YmTt15ybMx1U7uBVPD7/3X3o8duMqpzB/SCmseAaGsnSC8rMkEQJj1NrPakg==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr9744426pjc.85.1572217808173;
        Sun, 27 Oct 2019 16:10:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id d5sm7641200pjw.31.2019.10.27.16.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 13/18] iio: cros_ec: Move function description to .c file
Date:   Sun, 27 Oct 2019 16:09:16 -0700
Message-Id: <20191027230921.205251-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent comment rot, move function description to
cros_ec_sensors_core.c.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v3:
  fix spelling.
New in v2.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 69 ++++++++++++++++
 .../linux/iio/common/cros_ec_sensors_core.h   | 80 -------------------
 2 files changed, 69 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 81a7f692de2f3..b47da497a3c37 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -83,6 +83,14 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
+/**
+ * cros_ec_sensors_core_init() - basic initialization of the core structure
+ * @pdev:		platform device created for the sensors
+ * @indio_dev:		iio device structure of the device
+ * @physical_device:	true if the device refers to a physical device
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device)
@@ -160,6 +168,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
+/**
+ * cros_ec_motion_send_host_cmd() - send motion sense host command
+ * @state:		pointer to state information for device
+ * @opt_length:	optional length to reduce the response size, useful on the data
+ *		path. Otherwise, the maximal allowed response size is used
+ *
+ * When called, the sub-command is assumed to be set in param->cmd.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
 				 u16 opt_length)
 {
@@ -422,6 +440,14 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_read_lpc);
 
+/**
+ * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
+ * @indio_dev:	pointer to IIO device
+ * @scan_mask:	bitmap of the sensor indices to scan
+ * @data:	location to store data
+ *
+ * Return: 0 on success, -errno on failure.
+ */
 int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 			     unsigned long scan_mask, s16 *data)
 {
@@ -446,6 +472,18 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
 
+/**
+ * cros_ec_sensors_capture() - the trigger handler function
+ * @irq:	the interrupt number.
+ * @p:		a pointer to the poll function.
+ *
+ * On a trigger event occurring, if the pollfunc is attached then this
+ * handler is called as a threaded interrupt (and hence may sleep). It
+ * is responsible for grabbing data from the device and pushing it into
+ * the associated buffer.
+ *
+ * Return: IRQ_HANDLED
+ */
 irqreturn_t cros_ec_sensors_capture(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -481,6 +519,16 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
 
+/**
+ * cros_ec_sensors_core_read() - function to request a value from the sensor
+ * @st:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @val:	will contain one element making up the returned value
+ * @val2:	will contain another element making up the returned value
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	the type of value returned by the device
+ */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
@@ -521,6 +569,17 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
 
+/**
+ * cros_ec_sensors_core_read_avail() - get available values
+ * @indio_dev:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @vals:	list of available values
+ * @type:	type of data returned
+ * @length:	number of data returned in the array
+ * @mask:	specifies which values to be requested
+ *
+ * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
+ */
 int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan,
 				    const int **vals,
@@ -542,6 +601,16 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
 
+/**
+ * cros_ec_sensors_core_write() - function to write a value to the sensor
+ * @st:		pointer to state information for device
+ * @chan:	channel specification structure table
+ * @val:	first part of value to write
+ * @val2:	second part of value to write
+ * @mask:	specifies which values to write
+ *
+ * Return:	the type of value returned by the device
+ */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask)
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index bb331e6356a9c..0af918978f975 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -79,95 +79,25 @@ struct cros_ec_sensors_core_state {
 	int frequencies[3];
 };
 
-/**
- * cros_ec_sensors_read_lpc() - retrieve data from EC shared memory
- * @indio_dev:	pointer to IIO device
- * @scan_mask:	bitmap of the sensor indices to scan
- * @data:	location to store data
- *
- * This is the safe function for reading the EC data. It guarantees that the
- * data sampled was not modified by the EC while being read.
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
 			     s16 *data);
 
-/**
- * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
- * @indio_dev:	pointer to IIO device
- * @scan_mask:	bitmap of the sensor indices to scan
- * @data:	location to store data
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
 			     s16 *data);
 
 struct platform_device;
-/**
- * cros_ec_sensors_core_init() - basic initialization of the core structure
- * @pdev:		platform device created for the sensors
- * @indio_dev:		iio device structure of the device
- * @physical_device:	true if the device refers to a physical device
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev, bool physical_device);
 
-/**
- * cros_ec_sensors_capture() - the trigger handler function
- * @irq:	the interrupt number.
- * @p:		a pointer to the poll function.
- *
- * On a trigger event occurring, if the pollfunc is attached then this
- * handler is called as a threaded interrupt (and hence may sleep). It
- * is responsible for grabbing data from the device and pushing it into
- * the associated buffer.
- *
- * Return: IRQ_HANDLED
- */
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
 
-/**
- * cros_ec_motion_send_host_cmd() - send motion sense host command
- * @st:		pointer to state information for device
- * @opt_length:	optional length to reduce the response size, useful on the data
- *		path. Otherwise, the maximal allowed response size is used
- *
- * When called, the sub-command is assumed to be set in param->cmd.
- *
- * Return: 0 on success, -errno on failure.
- */
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
 				 u16 opt_length);
 
-/**
- * cros_ec_sensors_core_read() - function to request a value from the sensor
- * @st:		pointer to state information for device
- * @chan:	channel specification structure table
- * @val:	will contain one element making up the returned value
- * @val2:	will contain another element making up the returned value
- * @mask:	specifies which values to be requested
- *
- * Return:	the type of value returned by the device
- */
 int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask);
 
-/**
- * cros_ec_sensors_core_read_avail() - get available values
- * @indio_dev:		pointer to state information for device
- * @chan:	channel specification structure table
- * @vals:	list of available values
- * @type:	type of data returned
- * @length:	number of data returned in the array
- * @mask:	specifies which values to be requested
- *
- * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
- */
 int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan,
 				    const int **vals,
@@ -175,16 +105,6 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
 				    int *length,
 				    long mask);
 
-/**
- * cros_ec_sensors_core_write() - function to write a value to the sensor
- * @st:		pointer to state information for device
- * @chan:	channel specification structure table
- * @val:	first part of value to write
- * @val2:	second part of value to write
- * @mask:	specifies which values to write
- *
- * Return:	the type of value returned by the device
- */
 int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
-- 
2.23.0.866.gb869b98d4c-goog

