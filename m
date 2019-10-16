Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265FBFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F316D218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnX4/9cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405798AbfJPOpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:45:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJPOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:45:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id y18so18952153wrn.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2kmhxpHzT/W8YmXwqPn9jM6tjvYg2CfLXyu9jlga3E=;
        b=lnX4/9csxZeW/BQFOa425K21Hm+rofjHkJaxs2FNuV9sijpmgLwMR9uCTnc36WSKjw
         Nn6coLQzcbSWKO/5fJM33lZAdo/vnRJkH/ixmjnCXpgEk7kGOe+YB3elDOgBnuWpssSW
         oBvlZLUcf83k/rZGlBcVVSspvINLTKqzRQhrLQdvsIIoSS+UhBvnZHL//4eQjJZRt/QE
         IxMEJDlMA6L3RZedUbPanQOgKbjUJl1M55ph/S+mtqBd0hQ5yBsokaY3LrAETeOifWw7
         Z/2Bviq5MjIjbuqX+42gznD1CNlPRDSWqbe6BWfP9KXSGWu8LSiHAiOBoxwpe0Ahk4ZM
         OSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2kmhxpHzT/W8YmXwqPn9jM6tjvYg2CfLXyu9jlga3E=;
        b=WXKUG5Lx0P8Ui2lTprHnDGCXih8Q/thQrdmLgr20Z5P7b02ww3P2Gd5VAbZT39nPDu
         84fNRK/2g/spGPdibJ+V7IA7xLQ0w0O6ORQOnNj9W98B2xbGzrfJs4OGmys7QgoC7cuo
         +SHfM5qoTe3T7Me2CiYP9UfsAx1TKkiLTWj+SgrfgUuXhNZ3k22fYRoLIkzcZWy7gG06
         uhPMUr9tdcOL6m0LTMowoxd5xfBpl7J7ejtDi27ND/Qjs2t4Ccqizz1KuqHAMMYYfKoj
         N+NL5kXZmDsEjbebJ/GQ7ysVMxOzKtJX/lt1PyZvLkF6iYrPCcnlM/utGSWiXaBfGhym
         DamA==
X-Gm-Message-State: APjAAAUdR7PMeJgSBWRJmVX/7uxXJR3NW5iLFKFWClOt7FU4odI5oBgD
        HjtlHpmGr0QSa4kTTIo/rpma2OlG
X-Google-Smtp-Source: APXvYqwphoX3NKpjlDQIPrJ5NiNPpTPXR6/fV0+svh+VYlot2u7K2+Y10+3vHavNWs0Ry96lhdGGCg==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr3167654wrw.175.1571237146714;
        Wed, 16 Oct 2019 07:45:46 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q3sm22211733wru.33.2019.10.16.07.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:45:46 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/4] parport: daisy: use new parport device model
Date:   Wed, 16 Oct 2019 15:45:40 +0100
Message-Id: <20191016144540.18810-4-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
References: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify parport daisy driver to use the new parallel port device model.

Last attempt was '1aec4211204d ("parport: daisy: use new parport device
model")' which failed as daisy was also trying to load the low level
driver and that resulted in a deadlock.

Cc: Michal Kubecek <mkubecek@suse.cz>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

Steven, Michal,
Can you please test this series in your test environment and verify that
I am not breaking anything this time.

 drivers/parport/daisy.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 5484a46dafda..95b5c3363582 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -45,6 +45,7 @@ static struct daisydev {
 static DEFINE_SPINLOCK(topology_lock);
 
 static int numdevs;
+static bool daisy_init_done;
 
 /* Forward-declaration of lower-level functions. */
 static int mux_present(struct parport *port);
@@ -87,6 +88,24 @@ static struct parport *clone_parport(struct parport *real, int muxport)
 	return extra;
 }
 
+static int daisy_drv_probe(struct pardevice *par_dev)
+{
+	struct device_driver *drv = par_dev->dev.driver;
+
+	if (strcmp(drv->name, "daisy_drv"))
+		return -ENODEV;
+	if (strcmp(par_dev->name, daisy_dev_name))
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct parport_driver daisy_driver = {
+	.name = "daisy_drv",
+	.probe = daisy_drv_probe,
+	.devmodel = true,
+};
+
 /* Discover the IEEE1284.3 topology on a port -- muxes and daisy chains.
  * Return value is number of devices actually detected. */
 int parport_daisy_init(struct parport *port)
@@ -98,6 +117,23 @@ int parport_daisy_init(struct parport *port)
 	int i;
 	int last_try = 0;
 
+	if (!daisy_init_done) {
+		/*
+		 * flag should be marked true first as
+		 * parport_register_driver() might try to load the low
+		 * level driver which will lead to announcing new ports
+		 * and which will again come back here at
+		 * parport_daisy_init()
+		 */
+		daisy_init_done = true;
+		i = parport_register_driver(&daisy_driver);
+		if (i) {
+			pr_err("daisy registration failed\n");
+			daisy_init_done = false;
+			return i;
+		}
+	}
+
 again:
 	/* Because this is called before any other devices exist,
 	 * we don't have to claim exclusive access.  */
@@ -213,10 +249,12 @@ void parport_daisy_fini(struct parport *port)
 struct pardevice *parport_open(int devnum, const char *name)
 {
 	struct daisydev *p = topology;
+	struct pardev_cb par_cb;
 	struct parport *port;
 	struct pardevice *dev;
 	int daisy;
 
+	memset(&par_cb, 0, sizeof(par_cb));
 	spin_lock(&topology_lock);
 	while (p && p->devnum != devnum)
 		p = p->next;
@@ -230,7 +268,7 @@ struct pardevice *parport_open(int devnum, const char *name)
 	port = parport_get_port(p->port);
 	spin_unlock(&topology_lock);
 
-	dev = parport_register_device(port, name, NULL, NULL, NULL, 0, NULL);
+	dev = parport_register_dev_model(port, name, &par_cb, devnum);
 	parport_put_port(port);
 	if (!dev)
 		return NULL;
-- 
2.11.0

