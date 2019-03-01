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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E398BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L341YetD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbfCAR4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:56:42 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44682 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:56:41 -0500
Received: by mail-qt1-f179.google.com with SMTP id d2so28694800qti.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PgkxpuNlOTGavPzU2eofvDAoeaXXOoWHabO+ciYgwoI=;
        b=L341YetDvOEtj2ykHT8RRvPHoWAv0+c+XTh9zWH+DnTSgiWp1vSlOdB2PV+rmNc7oY
         8+8uA86d7WVtCteXVy9R1mi3/a2J9WXOwT/rgv/4HEjKcUkYcvwCG+v5FQuc5OarDkde
         3EvhtwigqMVxCcp1j1lHlUMjFwMfGNqLhXLWRKGeyWUH+wdoRwPktQI5w4TSj3/NYMs2
         ZEn5kM8ITJ78P2uxh0BhB9Nid0gmvQ9KkyVQ4NFfQ9XXkKIKBH3qrsLRIxZouko23ZuA
         TSEtLe7MpQANiFTa9DtpDUNi/6Nj8QoIYI50xNeBfODABNdtelFXr7Fx69x//KMwkw+Z
         j+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PgkxpuNlOTGavPzU2eofvDAoeaXXOoWHabO+ciYgwoI=;
        b=Pk7RWDk9yYjB/KboWRTQPlSsnKw4LfZBj3Wf3JD6EJtnwef6xm+DnCCg35OjNIsjNW
         QftrB/u2fO0CRkbzH3W/8ctaio34suW0g7SvYODZXKkleAqUyBMKcRK0ZYLWy9qweIrg
         zB6+ncmWQzS2KrS6x5OYvF+ilp/iuUB0EaDljjHujQTYnUwun2eILJK0TuFASuH1ICuK
         fSF1rX7YTCqRN4ZkX9te9fB+wqrNgxg4qg/F3JLtvm1md11hDs0QR27BttF9t23dUbuo
         hlnm/oitjc8kalcFOQcMbAagKyLKzssjApxn9jtCTpsswDjknYpzsTfy1jaUrPT7v3gS
         PuJw==
X-Gm-Message-State: APjAAAXqN09JnmUPvQdIsZXz46/ofxlV4+OGM2A7rczeKUE6sJz6MCSk
        qcDx+5Z6GFEKxg/pUeAs/XE2Nucji0k=
X-Google-Smtp-Source: APXvYqx+XDk4Q/8z9r8cGLxnOdto3/HwYVf5hB+WEAq/YJDGqVgTrEFiX9PSVNyQpRCG/9ABL2m3Zw==
X-Received: by 2002:ac8:2427:: with SMTP id c36mr5074537qtc.124.1551463000697;
        Fri, 01 Mar 2019 09:56:40 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id u1sm15719387qki.36.2019.03.01.09.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:56:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 920D34039C; Fri,  1 Mar 2019 14:56:36 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:56:36 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] perf scripts python: exported-sql-viewer.py: Factor
 out CallGraphModelBase
Message-ID: <20190301175636.GR13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-8-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:30PM +0200, Adrian Hunter escreveu:
> Factor out a base class CallGraphModelBase from CallGraphModel, so that
> CallGraphModelBase can be reused.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 100 ++++++++++--------
>  1 file changed, 55 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index b2a22525549d..c4a2134d85f5 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -558,26 +558,12 @@ class CallGraphRootItem(CallGraphLevelItemBase):
>  			self.child_items.append(child_item)
>  			self.child_count += 1
>  
> -# Context-sensitive call graph data model
> +# Context-sensitive call graph data model base
>  
> -class CallGraphModel(TreeModel):
> +class CallGraphModelBase(TreeModel):
>  
>  	def __init__(self, glb, parent=None):
> -		super(CallGraphModel, self).__init__(glb, parent)
> -
> -	def GetRoot(self):
> -		return CallGraphRootItem(self.glb)
> -
> -	def columnCount(self, parent=None):
> -		return 7
> -
> -	def columnHeader(self, column):
> -		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
> -		return headers[column]
> -
> -	def columnAlignment(self, column):
> -		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
> -		return alignment[column]
> +		super(CallGraphModelBase, self).__init__(glb, parent)
>  
>  	def FindSelect(self, value, pattern, query):
>  		if pattern:
> @@ -597,34 +583,7 @@ class CallGraphModel(TreeModel):
>  				match = " GLOB '" + str(value) + "'"
>  		else:
>  			match = " = '" + str(value) + "'"
> -		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
> -						" FROM calls"
> -						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
> -						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
> -						" WHERE symbols.name" + match +
> -						" GROUP BY comm_id, thread_id, call_path_id"
> -						" ORDER BY comm_id, thread_id, call_path_id")
> -
> -	def FindPath(self, query):
> -		# Turn the query result into a list of ids that the tree view can walk
> -		# to open the tree at the right place.
> -		ids = []
> -		parent_id = query.value(0)
> -		while parent_id:
> -			ids.insert(0, parent_id)
> -			q2 = QSqlQuery(self.glb.db)
> -			QueryExec(q2, "SELECT parent_id"
> -					" FROM call_paths"
> -					" WHERE id = " + str(parent_id))
> -			if not q2.next():
> -				break
> -			parent_id = q2.value(0)
> -		# The call path root is not used
> -		if ids[0] == 1:
> -			del ids[0]
> -		ids.insert(0, query.value(2))
> -		ids.insert(0, query.value(1))
> -		return ids
> +		self.DoFindSelect(query, match)
>  
>  	def Found(self, query, found):
>  		if found:
> @@ -678,6 +637,57 @@ class CallGraphModel(TreeModel):
>  	def FindDone(self, thread, callback, ids):
>  		callback(ids)
>  
> +# Context-sensitive call graph data model
> +
> +class CallGraphModel(CallGraphModelBase):
> +
> +	def __init__(self, glb, parent=None):
> +		super(CallGraphModel, self).__init__(glb, parent)
> +
> +	def GetRoot(self):
> +		return CallGraphRootItem(self.glb)
> +
> +	def columnCount(self, parent=None):
> +		return 7
> +
> +	def columnHeader(self, column):
> +		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
> +		return headers[column]
> +
> +	def columnAlignment(self, column):
> +		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
> +		return alignment[column]
> +
> +	def DoFindSelect(self, query, match):
> +		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
> +						" FROM calls"
> +						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
> +						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
> +						" WHERE symbols.name" + match +
> +						" GROUP BY comm_id, thread_id, call_path_id"
> +						" ORDER BY comm_id, thread_id, call_path_id")
> +
> +	def FindPath(self, query):
> +		# Turn the query result into a list of ids that the tree view can walk
> +		# to open the tree at the right place.
> +		ids = []
> +		parent_id = query.value(0)
> +		while parent_id:
> +			ids.insert(0, parent_id)
> +			q2 = QSqlQuery(self.glb.db)
> +			QueryExec(q2, "SELECT parent_id"
> +					" FROM call_paths"
> +					" WHERE id = " + str(parent_id))
> +			if not q2.next():
> +				break
> +			parent_id = q2.value(0)
> +		# The call path root is not used
> +		if ids[0] == 1:
> +			del ids[0]
> +		ids.insert(0, query.value(2))
> +		ids.insert(0, query.value(1))
> +		return ids
> +
>  # Vertical widget layout
>  
>  class VBox():
> -- 
> 2.17.1

-- 

- Arnaldo
