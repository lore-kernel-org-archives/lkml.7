Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F67C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADFE2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/eIHtIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfCARz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:55:58 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46850 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCARz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:55:58 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so14777599qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6EXAsK6RaxTz/pJI3aStQRwOQ+vP2wRS3V8ssfPUwOE=;
        b=s/eIHtIj4MTFncucqhpdNIrgrY6z8tMTgkJo7kSOg935DgE6A7nUmUAXyzaHnUkUwu
         cmW9g1fVvqW8tX0GoheAU6MRvYsmLcy+PEhoKflw67fmOvJ1hUuYabIioLxc+wpAzlO0
         c0k/VtaINUKhW/dPgTAxi3BpDeS8yVgFEI8QNmNrTxvgSEF57kpk5mXFRG0dvRZ2/Pnq
         Giq4wolDJcpMDdZEVU3ry3AVMQE/jgxx0oJnjfM0FbusrTnuMD6aQT9KWPRw0hhGEgxz
         zCvuyLs1T1WNZ6Ma1IdKIajn0wTDDx3/xCCxdRm9ryvwOV16opqZmMfUNj1KsqVz08Yi
         JjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EXAsK6RaxTz/pJI3aStQRwOQ+vP2wRS3V8ssfPUwOE=;
        b=M68qQkkEmt6QF8P1riT+ECE82BzAHKAvfVde5QxjTJLcQkhr78cgM0kDfJ5gUPgCpw
         rDGx87qCLlWiRVjJEX2ILW0pFpGSmXF+gFGQYjcqho/+4qnJkeAOjYSEV9BpYX/Cyw2z
         eBNGK7n6jE0CLmgh1pnQXZx4+S8mS5oJK9xjjbUuGtIoTKQmx9CwBY4TbSeeeronPohd
         lZl5JQzYWKnb3cU27PYY89QeU59j3I03TYM9ORI8fJZvrYa5bjjalLh4hwarZh4+5Erb
         L3uHsKfxnHdbs+Q5ghFYrZhkOxUE0bIe5OaJ/MakBQSVzySV+RIz4V0SZDcSBeTqZTzM
         /iWA==
X-Gm-Message-State: APjAAAWzyfV+OD9XK6xaPKvwOWcAqtffYQtzbTdqqhGEFcxxk0/oPfl5
        T3wh5LcHss8Sz1UxjFYjlwp99vR8IWE=
X-Google-Smtp-Source: APXvYqw3dbGu/Is+FzKF3Dullxa4UcCjhoN5kWLCmWiU9oEhKgI3bBbh0an5YhB/1os+o2pnwBTzJA==
X-Received: by 2002:a37:a14d:: with SMTP id k74mr4615054qke.242.1551462957172;
        Fri, 01 Mar 2019 09:55:57 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id a43sm4604888qtk.86.2019.03.01.09.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:55:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3ED7F4039C; Fri,  1 Mar 2019 14:55:53 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:55:53 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] perf scripts python: exported-sql-viewer.py: Improve
 TreeModel abstraction
Message-ID: <20190301175553.GQ13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-7-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:29PM +0200, Adrian Hunter escreveu:
> Instead of passing the tree root, get it from a method that can be
> implemented in any derived class.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../perf/scripts/python/exported-sql-viewer.py  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index df854f0a69f0..b2a22525549d 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -167,9 +167,10 @@ class Thread(QThread):
>  
>  class TreeModel(QAbstractItemModel):
>  
> -	def __init__(self, root, parent=None):
> +	def __init__(self, glb, parent=None):
>  		super(TreeModel, self).__init__(parent)
> -		self.root = root
> +		self.glb = glb
> +		self.root = self.GetRoot()
>  		self.last_row_read = 0
>  
>  	def Item(self, parent):
> @@ -562,8 +563,10 @@ class CallGraphRootItem(CallGraphLevelItemBase):
>  class CallGraphModel(TreeModel):
>  
>  	def __init__(self, glb, parent=None):
> -		super(CallGraphModel, self).__init__(CallGraphRootItem(glb), parent)
> -		self.glb = glb
> +		super(CallGraphModel, self).__init__(glb, parent)
> +
> +	def GetRoot(self):
> +		return CallGraphRootItem(self.glb)
>  
>  	def columnCount(self, parent=None):
>  		return 7
> @@ -1339,8 +1342,7 @@ class BranchModel(TreeModel):
>  	progress = Signal(object)
>  
>  	def __init__(self, glb, event_id, where_clause, parent=None):
> -		super(BranchModel, self).__init__(BranchRootItem(), parent)
> -		self.glb = glb
> +		super(BranchModel, self).__init__(glb, parent)
>  		self.event_id = event_id
>  		self.more = True
>  		self.populated = 0
> @@ -1364,6 +1366,9 @@ class BranchModel(TreeModel):
>  		self.fetcher.done.connect(self.Update)
>  		self.fetcher.Fetch(glb_chunk_sz)
>  
> +	def GetRoot(self):
> +		return BranchRootItem()
> +
>  	def columnCount(self, parent=None):
>  		return 8
>  
> -- 
> 2.17.1

-- 

- Arnaldo
