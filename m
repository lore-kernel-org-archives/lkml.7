Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596320657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R0ZjBz3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCJQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:13:39 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:40955 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCJQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:13:38 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x2AGDIYg028844;
        Mon, 11 Mar 2019 01:13:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x2AGDIYg028844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552234399;
        bh=HpclfvC1mOug+KZhRP4YucgS6tqNenH8uIH104xvA48=;
        h=From:To:Cc:Subject:Date:From;
        b=R0ZjBz3T1AEPdw1x/0+dHZ8GiRG2LC+SYXVvC8UCB9C1IPwRfBv0O+Us71ns79MB6
         GAlKrBDmBoaz4LhaaUdSZS+ccsj8y7TgNc3korFyWg+Sp5FG0lHdldOl0hE1Q6pgVH
         RijN1kPfDgmScgTD/ymwq5ISXzFqsQoHKEaiJ75it0jydA4VP1GMVq8oRX4YbCz2J5
         xbzVMxaSsfpS++n+L9/mE0BqLgArwJf8X0wbQC+GSvuWh3s1d41u/HOBDm11G4MJ6N
         ke8UcCrWyh7UnDp6YLJ44vXWgaZfRf7ngEbYOUzAKRCKYnYnssjS1CExMPhUNlt5x+
         A5zzJ34NN8Tew==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: fix 'Save As' menu of xconfig
Date:   Mon, 11 Mar 2019 01:13:15 +0900
Message-Id: <1552234395-7699-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'Save As' menu of xconfig is not working; it always saves the
kernel configuration into the default file irrespective of the file
chosen in the dialog box.

The 'Save' menu always writes into the default file, but it would
make more sense to write into the file previously chosen by 'Load'
or 'Save As'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/qconf.cc | 42 +++++++++++++++++++++++++++++++++++-------
 scripts/kconfig/qconf.h  |  1 +
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 8be8a70..ce7fc87 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1392,6 +1392,8 @@ ConfigMainWindow::ConfigMainWindow(void)
 	conf_set_changed_callback(conf_changed);
 	// Set saveAction's initial state
 	conf_changed();
+	configname = xstrdup(conf_get_configname());
+
 	QAction *saveAsAction = new QAction("Save &As...", this);
 	  connect(saveAsAction, SIGNAL(triggered(bool)), SLOT(saveConfigAs()));
 	QAction *searchAction = new QAction("&Find", this);
@@ -1520,17 +1522,29 @@ ConfigMainWindow::ConfigMainWindow(void)
 
 void ConfigMainWindow::loadConfig(void)
 {
-	QString s = QFileDialog::getOpenFileName(this, "", conf_get_configname());
-	if (s.isNull())
+	QString str;
+	QByteArray ba;
+	const char *name;
+
+	str = QFileDialog::getOpenFileName(this, "", configname);
+	if (str.isNull())
 		return;
-	if (conf_read(QFile::encodeName(s)))
+
+	ba = str.toLocal8Bit();
+	name = ba.data();
+
+	if (conf_read(name))
 		QMessageBox::information(this, "qconf", "Unable to load configuration!");
+
+	free(configname);
+	configname = xstrdup(name);
+
 	ConfigView::updateListAll();
 }
 
 bool ConfigMainWindow::saveConfig(void)
 {
-	if (conf_write(NULL)) {
+	if (conf_write(configname)) {
 		QMessageBox::information(this, "qconf", "Unable to save configuration!");
 		return false;
 	}
@@ -1541,10 +1555,24 @@ bool ConfigMainWindow::saveConfig(void)
 
 void ConfigMainWindow::saveConfigAs(void)
 {
-	QString s = QFileDialog::getSaveFileName(this, "", conf_get_configname());
-	if (s.isNull())
+	QString str;
+	QByteArray ba;
+	const char *name;
+
+	str = QFileDialog::getSaveFileName(this, "", configname);
+	if (str.isNull())
 		return;
-	saveConfig();
+
+	ba = str.toLocal8Bit();
+	name = ba.data();
+
+	if (conf_write(name)) {
+		QMessageBox::information(this, "qconf", "Unable to save configuration!");
+	}
+	conf_write_autoconf(0);
+
+	free(configname);
+	configname = xstrdup(name);
 }
 
 void ConfigMainWindow::searchConfig(void)
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index 41df466..45bfe9b 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -291,6 +291,7 @@ public slots:
 class ConfigMainWindow : public QMainWindow {
 	Q_OBJECT
 
+	char *configname;
 	static QAction *saveAction;
 	static void conf_changed(void);
 public:
-- 
2.7.4

