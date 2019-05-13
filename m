Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C6C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18E2208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyIG9DWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEMT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:57:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33696 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:57:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so13226389qtf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bxx9qTEQPZCN6By8b0tqb6gxSLbpWnZePTX9GDWKGNA=;
        b=WyIG9DWNoKGWKTOfK7IfWSWYYWkD64s4Z+NGsHP4f+n6jd1n8LCzCfyTY/LFd5Ux0E
         AyHyea61j+xDN63EpzbFZY/TtI1MhiPwPvOlpID7HWDlW/moU4+PUDTXAgF7PpPuvVW3
         Xak5i4WnRDcSgWEbg+hsXzuexe/e5awUJtxMxBJrVA5W12PUs6Rp7w2nfoS/poQsqvnx
         mErZdHlM41ih6gPTIM8CHAzPNcJqlhu+VqNsscaloh4tAwTgImAzvFCnolRZmTsamM4r
         3sh5duuCss1kOXnXAsC7EjZ+4/4wofQTIByj7cZ3uWrmwJua4fxpqMhsApkimuO8fjxK
         VZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bxx9qTEQPZCN6By8b0tqb6gxSLbpWnZePTX9GDWKGNA=;
        b=NKP7Xkf8FtzYL8hRNjLw7/4IoXHsE7W1miW2D/XploT6qxql5XvBnMG+Pn806KXkNi
         8HOvJfkbHulYlHS8roJWgi/9QVWHaJpKuJt0GKb5qCSzlZX3oo2HW68YGQ8oVMJV4oz3
         dnHJxj+3OQYnoSBSM/vhYx0LUdmLUIi/RFdGNObLol8oy1btekgvTw5RB5+VzvrUtWTo
         5j4EJeu+DNBVnHU8PK1+eJKc2lTOI7RrQSY8Dy84symZ3ms3GRWh83z1N8f3MP6hGoW3
         tggN8htj5JJ/AyRnoEVbBSP1mbqDOPJRAraUkmeRu13ffMiQyklZf5yp4yEY9nhFusMc
         OSBQ==
X-Gm-Message-State: APjAAAXdLAhWUqDEGfoPcl0zMBAUIDvG+4yWU8Ln6+rqNLYvI/o8TC3E
        ddCyrjOfrKFIGDOJgpDK5fw=
X-Google-Smtp-Source: APXvYqwqot8tE34mvP0GQ/5QVPNJZZIzO6eK0oVlc39k+IOLKOTbdTCHlLmeI1tH2wkF2YFfNfTfkA==
X-Received: by 2002:a0c:b78a:: with SMTP id l10mr3468054qve.62.1557777467135;
        Mon, 13 May 2019 12:57:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id 124sm6782932qkj.59.2019.05.13.12.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 12:57:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C26A4403AD; Mon, 13 May 2019 16:57:32 -0300 (-03)
Date:   Mon, 13 May 2019 16:57:32 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] perf scripts python: exported-sql-viewer.py: Fix
 error when shrinking / enlarging font
Message-ID: <20190513195732.GC3198@kernel.org>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
 <20190503120828.25326-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503120828.25326-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 03, 2019 at 03:08:23PM +0300, Adrian Hunter escreveu:
> Fix the following error if shrink / enlarge font is used with the help
> window.
> 
>   Traceback (most recent call last):
>     File "tools/perf/scripts/python/exported-sql-viewer.py", line 2791, in ShrinkFont
>       ShrinkFont(win.view)
>   AttributeError: 'HelpWindow' object has no attribute 'view'

Humm, this is kinda frustrating, I tried it and expected it to either
enlarge/shrink or tell me that that is not possible, and why :-\

Anyway, if you think this is the best approach, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/scripts/python/exported-sql-viewer.py | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index c586abfb2b46..289e8dbd1444 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -2770,6 +2770,14 @@ class MainWindow(QMainWindow):
>  		help_menu = menu.addMenu("&Help")
>  		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
>  
> +	def Try(self, fn):
> +		win = self.mdi_area.activeSubWindow()
> +		if win:
> +			try:
> +				fn(win.view)
> +			except:
> +				pass
> +
>  	def Find(self):
>  		win = self.mdi_area.activeSubWindow()
>  		if win:
> @@ -2787,12 +2795,10 @@ class MainWindow(QMainWindow):
>  				pass
>  
>  	def ShrinkFont(self):
> -		win = self.mdi_area.activeSubWindow()
> -		ShrinkFont(win.view)
> +		self.Try(ShrinkFont)
>  
>  	def EnlargeFont(self):
> -		win = self.mdi_area.activeSubWindow()
> -		EnlargeFont(win.view)
> +		self.Try(EnlargeFont)
>  
>  	def EventMenu(self, events, reports_menu):
>  		branches_events = 0
> -- 
> 2.17.1

-- 

- Arnaldo
