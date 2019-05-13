Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DCC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDRBMuy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfEMUMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:12:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41100 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:12:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id y22so12897035qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjLmPUC5EYix8dBe332weUn+GEIBtnzy7IAoHgqZQC8=;
        b=vDRBMuy7ra8kbjxQ2kCAnDhPQlhiGV4C5d5MN16CX2WgwH0gRsUjGKpxc04iDUB0H8
         nMFNUayvus9ZXCT8b10eXzsmDbVHYh+r9SNkr7GThk2Q+CR6IsMvPKz2SjLsaEaoFOyE
         vnGgTJzYfVaUhx7SkFjnzxeqjsm4gfvUwcRMviFxp4Wreg4OcjfgJPOm907DozuN4Lpf
         5oNypSeGPmHhVK4vTC88M37ETLwsBmS9XsWDvNYfADXNgG3X/SgWzlQhrbe4nTFewO51
         Q6xadT7wYELn0qlMCyI95sQNTYh4gWWhw9G2D4qLpdYdaq9z2vlDyxvC+8+5DnnfO2dD
         cCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjLmPUC5EYix8dBe332weUn+GEIBtnzy7IAoHgqZQC8=;
        b=Bd4VruMKCJRmHTG7aJEZ6wDjbXQHfcYzzV1pmn28dIETtPSf++/B4QTgHc2649dy9d
         Un3cIq7zB9mYrHHFAhgg7bgrQFps43H0FnZ1Wr/lLZ+Mrw+ln8miuMaR48OD5BJ5sWV8
         EHFi0w6H1s3g1gYjtXEWuthd72TG9pzOTdpUqLQCYLbczEWLOkR44UHUbLkCec04RMpI
         kJiJeWCkVuKFKXf8BpaLYZCQDCtgbWhP9edcfu7sNaM9sfH9O0r8coLGnydnIo8x39+u
         2fh8YMmg3aVYjzyyovMExYLqFzIwymSzaBcat8qWJkkKTQfV6hjVEedC4aazQLbTX5EZ
         nL9w==
X-Gm-Message-State: APjAAAV1eDZTybZQlcHy2Fv8TN6f8ONiZNaLstaxN1b5NRFJ9gb+kiES
        tRq6l5Pz5oe+ay3s01Cev8s=
X-Google-Smtp-Source: APXvYqwePIubWAmnsrAfKQjf5kRVDzMyP7fz43w8jYYr3eJk1QmsZq7W3q3t2JABoioZjrAUj1pLzg==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr26694569qtn.177.1557778355478;
        Mon, 13 May 2019 13:12:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id g12sm7796643qkk.88.2019.05.13.13.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 13:12:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32604403AD; Mon, 13 May 2019 17:12:31 -0300 (-03)
Date:   Mon, 13 May 2019 17:12:31 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf scripts python: exported-sql-viewer.py: Add
 'About' dialog box
Message-ID: <20190513201231.GF3198@kernel.org>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
 <20190503120828.25326-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503120828.25326-7-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 03, 2019 at 03:08:28PM +0300, Adrian Hunter escreveu:
> With support for Python 2 or 3 and PySide 1 or 2 (Qt 4 or 5), it is useful
> to see what versions are in use. Add an 'About' dialog box that displays
> Python, PySide, Qt and database server (SQLite or PostgreSQL) version
> numbers.

Works as well, here:

Committer testing:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

  Then go to 'Help', then 'About', select all the lines with the mouse
  press 'Control+C', then, on the same terminal press control+shift+V
  which shows my current environment:

Python version:     2.7.16
PySide version:     1
Qt version:         4.8.7
SQLite version:     3.26.0


-------------------

Patchkit applied, thanks.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 421f3828ea43..6fe553258ce5 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -2927,6 +2927,60 @@ class HelpOnlyWindow(QMainWindow):
>  
>  		self.setCentralWidget(self.text)
>  
> +# PostqreSQL server version
> +
> +def PostqreSQLServerVersion(db):
> +	query = QSqlQuery(db)
> +	QueryExec(query, "SELECT VERSION()")
> +	if query.next():
> +		v_str = query.value(0)
> +		v_list = v_str.strip().split(" ")
> +		if v_list[0] == "PostgreSQL" and v_list[2] == "on":
> +			return v_list[1]
> +		return v_str
> +	return "Unknown"
> +
> +# SQLite version
> +
> +def SQLiteVersion(db):
> +	query = QSqlQuery(db)
> +	QueryExec(query, "SELECT sqlite_version()")
> +	if query.next():
> +		return query.value(0)
> +	return "Unknown"
> +
> +# About dialog
> +
> +class AboutDialog(QDialog):
> +
> +	def __init__(self, glb, parent=None):
> +		super(AboutDialog, self).__init__(parent)
> +
> +		self.setWindowTitle("About Exported SQL Viewer")
> +		self.setMinimumWidth(300)
> +
> +		pyside_version = "1" if pyside_version_1 else "2"
> +
> +		text = "<pre>"
> +		text += "Python version:     " + sys.version.split(" ")[0] + "\n"
> +		text += "PySide version:     " + pyside_version + "\n"
> +		text += "Qt version:         " + qVersion() + "\n"
> +		if glb.dbref.is_sqlite3:
> +			text += "SQLite version:     " + SQLiteVersion(glb.db) + "\n"
> +		else:
> +			text += "PostqreSQL version: " + PostqreSQLServerVersion(glb.db) + "\n"
> +		text += "</pre>"
> +
> +		self.text = QTextBrowser()
> +		self.text.setHtml(text)
> +		self.text.setReadOnly(True)
> +		self.text.setOpenExternalLinks(True)
> +
> +		self.vbox = QVBoxLayout()
> +		self.vbox.addWidget(self.text)
> +
> +		self.setLayout(self.vbox);
> +
>  # Font resize
>  
>  def ResizeFont(widget, diff):
> @@ -3024,6 +3078,7 @@ class MainWindow(QMainWindow):
>  
>  		help_menu = menu.addMenu("&Help")
>  		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
> +		help_menu.addAction(CreateAction("&About Exported SQL Viewer", "About this application", self.About, self))
>  
>  	def Try(self, fn):
>  		win = self.mdi_area.activeSubWindow()
> @@ -3109,6 +3164,10 @@ class MainWindow(QMainWindow):
>  	def Help(self):
>  		HelpWindow(self.glb, self)
>  
> +	def About(self):
> +		dialog = AboutDialog(self.glb, self)
> +		dialog.exec_()
> +
>  # XED Disassembler
>  
>  class xed_state_t(Structure):
> -- 
> 2.17.1

-- 

- Arnaldo
