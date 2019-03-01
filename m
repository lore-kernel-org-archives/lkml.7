Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562292084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYrBaECQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbfCARzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:55:17 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:46675 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCARzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:55:15 -0500
Received: by mail-qt1-f170.google.com with SMTP id z25so28693639qti.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBDhpnXyGSGfWXFqaK2HaAwdsce6nJ709696QI9uoAc=;
        b=MYrBaECQvEomvvPOkx7LH4IONN9HAQmlC+FVuwkkMzKHAm8pXLm5VcewFtKy6dOSka
         rcB1eFu/G3iQAq1vDfCVC0tVaK+wev95E9baNF7zOCt2ziTE6/ZGKrq53N6DpOQOL3y4
         ncQggEFofxYLcaaqzfGBN6hpCtzAkkGdiYPvsnUP7Ht9oa8Pv6aY0vAwFKW5jCKpglAH
         PcSR3ytrpFU//XmWwTP8X8Fm8Hcs0EdRKhVywGK5jqtB9k/4/6I6q2VXnZYweYYRUUS9
         lALzeYErcjuPFcYddQOtx4G5y131I2DMXEHzVIdNQS63mGe5XP/Hys+m5RClCafXC4uD
         hYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBDhpnXyGSGfWXFqaK2HaAwdsce6nJ709696QI9uoAc=;
        b=pYOC1yCeiW0HM9lVVvFp9nx1SSWAR/JyVePDyhQVR1AEH5etTFz/4bn/vpH5xtT9cF
         3z8Og47WJvx34Uuj5UMLIReaEi7zRCC92atPPnBIr+vy9oc940NcZkj19S/cZuR+LFYX
         0trgO6b4h82PlZJ2M6dZ1woDEwkgztNRGzhdmE1ngQzW15YaQb1stEWp/vZOlJTIjA7u
         sWzIcHVpYrWnWV5/e5/Ok5zs8he6lWis7UhlJF41tFLcPsfU73t6HFnyiEYSQr5oo1rF
         9nwcBrIOGCIIQ2SLZ0SNPwJvp9zykvASP2q3Ve4BI+V+n9DEJqWPN+XMRI0Ot0fGOj2i
         VvmA==
X-Gm-Message-State: APjAAAW5werZ6qkf/iXIklpYywcgC4scawJrngrDOcBKrCeZ8YjHSmpY
        kfF1t8Thjr957ZA7vVFboHqvwMk8Vlc=
X-Google-Smtp-Source: APXvYqyPDfoX+FbBWhJavevDxaAdqLVFHMGoov57Zmn4HEi94O9+O7Lkg/X1XcX4KsM0XgILwyZOqw==
X-Received: by 2002:aed:221c:: with SMTP id n28mr4767899qtc.21.1551462914048;
        Fri, 01 Mar 2019 09:55:14 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id v26sm13996161qtk.22.2019.03.01.09.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:55:13 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 445684039C; Fri,  1 Mar 2019 14:55:09 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:55:09 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] perf scripts python: exported-sql-viewer.py: Factor
 out TreeWindowBase
Message-ID: <20190301175509.GP13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-6-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:28PM +0200, Adrian Hunter escreveu:
> Factor out a base class TreeWindowBase from CallGraphWindow, so that
> TreeWindowBase can be reused.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 50 ++++++++++++-------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 09ce73b07d35..df854f0a69f0 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -693,28 +693,16 @@ class VBox():
>  	def Widget(self):
>  		return self.vbox
>  
> -# Context-sensitive call graph window
> -
> -class CallGraphWindow(QMdiSubWindow):
> -
> -	def __init__(self, glb, parent=None):
> -		super(CallGraphWindow, self).__init__(parent)
> +# Tree window base
>  
> -		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
> +class TreeWindowBase(QMdiSubWindow):
>  
> -		self.view = QTreeView()
> -		self.view.setModel(self.model)
> -
> -		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
> -			self.view.setColumnWidth(c, w)
> -
> -		self.find_bar = FindBar(self, self)
> -
> -		self.vbox = VBox(self.view, self.find_bar.Widget())
> -
> -		self.setWidget(self.vbox.Widget())
> +	def __init__(self, parent=None):
> +		super(TreeWindowBase, self).__init__(parent)
>  
> -		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
> +		self.model = None
> +		self.view = None
> +		self.find_bar = None
>  
>  	def DisplayFound(self, ids):
>  		if not len(ids):
> @@ -747,6 +735,30 @@ class CallGraphWindow(QMdiSubWindow):
>  		if not found:
>  			self.find_bar.NotFound()
>  
> +
> +# Context-sensitive call graph window
> +
> +class CallGraphWindow(TreeWindowBase):
> +
> +	def __init__(self, glb, parent=None):
> +		super(CallGraphWindow, self).__init__(parent)
> +
> +		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
> +
> +		self.view = QTreeView()
> +		self.view.setModel(self.model)
> +
> +		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
> +			self.view.setColumnWidth(c, w)
> +
> +		self.find_bar = FindBar(self, self)
> +
> +		self.vbox = VBox(self.view, self.find_bar.Widget())
> +
> +		self.setWidget(self.vbox.Widget())
> +
> +		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
> +
>  # Child data item  finder
>  
>  class ChildDataItemFinder():
> -- 
> 2.17.1

-- 

- Arnaldo
