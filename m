Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453F26C57
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL+Utz9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEaQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:44:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33212 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:44:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so1686414qtf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AFVFq9WLzLXZ1eNlaoYIXZA3L7rKM6wOyf5T47OWNks=;
        b=pL+Utz9e5dkeyQuxJ29Xdfiq/NslXjs9x7unc9wi6htCh6+29wS9mwP31Gb/94HwNV
         ecDeRKjyBAPQnS6liB47lV60A1+rDF+qlbPu6lR+wcEbfkQSW72Y3cjC6EkkfDAVYl/S
         hj2rkF9J/Avz40VU9niPZYITGMCJgjpE5J1BRk+2UTzMCxWL61Q8lCFeN8C21ddA+bq2
         jGymxuv5nnlJl11m5+EaJ6KOH8PYZO8tWQdxlcLOpk4UMhMz7F/gYi+iB994VSkt4G4z
         nhJKhNgvDzte9bELtto14/MTRDLsNxoge0yh5EojHoUaeWKqUuSOCTiTPbzfsqhGB1iU
         QUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AFVFq9WLzLXZ1eNlaoYIXZA3L7rKM6wOyf5T47OWNks=;
        b=CHYO9gGZiEevV01BWp2pMwBVZpXEWuvsaImO8JBtahEPOeY/qJGosB+HoyVAfOMQGV
         3vPKt66d2erS8j5uP74gMg63M3iGWhjWnPVpqpNqFtYaR1/EGafdYeWLhv3CzK7qHd5n
         Cf2ZJnezipG8ahaw/THCG9qUE5HbbLF6RbpkIJllWCPNptiH9kBAKBTgc29/rfzJUnkt
         CAK43Z8vNh4/qYmm66v5KMF1Dv0QCc7WfR2mRZjHrtpJpZtg/EYvW19gN+VzwOaylY+x
         D3LlArBVM4/NBFttApxy1Lf3JE44XmQg2piJbAm5TQuoDPTvpsggJR9DBlUb/Rue1Obh
         rDhw==
X-Gm-Message-State: APjAAAWPC8Ap8Ny/eIFW9McdTZo31ZRRtxjodrI6T5eK812x57wXFZK5
        INrogS5gCE/KhcCMcFzTPD0=
X-Google-Smtp-Source: APXvYqwqK01BL8K1+tQqhN+ru+C41DxeaKLTId8DyQE0wsW58V0b1nJWE7fcx165w/KpLOa3K6YQhA==
X-Received: by 2002:a0c:9e02:: with SMTP id p2mr9477905qve.150.1559321090662;
        Fri, 31 May 2019 09:44:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id c4sm3205797qkd.24.2019.05.31.09.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 09:44:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABE1641149; Fri, 31 May 2019 13:44:44 -0300 (-03)
Date:   Fri, 31 May 2019 13:44:44 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] perf scripts python: exported-sql-viewer.py: Add
 IPC information to the Branch reports
Message-ID: <20190531164444.GB20408@kernel.org>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-19-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520113728.14389-19-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 20, 2019 at 02:37:24PM +0300, Adrian Hunter escreveu:
> Enhance the "All branches" and "Selected branches" reports to display IPC
> information if it is available.

So, testing this I noticed that it all starts with the left arrow in every
line, that should mean there is some tree there, i.e. look at all those ▶
symbols:

Time              CPU Command         PID   TID   Branch Type  In Tx  Insn Cnt  Cyc Cnt  IPC  Branch
▶ 187836112195670 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
▶ 187836112195987 7   simple-retpolin 23003 23003 trace end    No     0         883      0    7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112199189 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
▶ 187836112199189 7   simple-retpolin 23003 23003 call         No     0         0        0    7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50 _dl_start (ld-2.28.so)
▶ 187836112199544 7   simple-retpolin 23003 23003 trace end    No     17        996      0.02 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112200939 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so)
▶ 187836112201229 7   simple-retpolin 23003 23003 trace end    No     1         816      0.00 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0 unknown (unknown)
▶ 187836112203500 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so)

But if you click on it, that ▶ disappears and a new click doesn't make it
reappear, looks buggy, but seems like a minor oddity that will not prevent me
from applying it now, please check and provide a fix on top of this,

Thanks,

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 102 ++++++++++++++----
>  1 file changed, 83 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 6fe553258ce5..a607235c8cd9 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -1369,11 +1369,11 @@ class FetchMoreRecordsBar():
>  
>  class BranchLevelTwoItem():
>  
> -	def __init__(self, row, text, parent_item):
> +	def __init__(self, row, col, text, parent_item):
>  		self.row = row
>  		self.parent_item = parent_item
> -		self.data = [""] * 8
> -		self.data[7] = text
> +		self.data = [""] * (col + 1)
> +		self.data[col] = text
>  		self.level = 2
>  
>  	def getParentItem(self):
> @@ -1405,6 +1405,7 @@ class BranchLevelOneItem():
>  		self.dbid = data[0]
>  		self.level = 1
>  		self.query_done = False
> +		self.br_col = len(self.data) - 1
>  
>  	def getChildItem(self, row):
>  		return self.child_items[row]
> @@ -1485,7 +1486,7 @@ class BranchLevelOneItem():
>  				while k < 15:
>  					byte_str += "   "
>  					k += 1
> -				self.child_items.append(BranchLevelTwoItem(0, byte_str + " " + text, self))
> +				self.child_items.append(BranchLevelTwoItem(0, self.br_col, byte_str + " " + text, self))
>  				self.child_count += 1
>  			else:
>  				return
> @@ -1536,16 +1537,37 @@ class BranchRootItem():
>  	def getData(self, column):
>  		return ""
>  
> +# Calculate instructions per cycle
> +
> +def CalcIPC(cyc_cnt, insn_cnt):
> +	if cyc_cnt and insn_cnt:
> +		ipc = Decimal(float(insn_cnt) / cyc_cnt)
> +		ipc = str(ipc.quantize(Decimal(".01"), rounding=ROUND_HALF_UP))
> +	else:
> +		ipc = "0"
> +	return ipc
> +
>  # Branch data preparation
>  
> -def BranchDataPrep(query):
> -	data = []
> -	for i in xrange(0, 8):
> -		data.append(query.value(i))
> +def BranchDataPrepBr(query, data):
>  	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
>  			" (" + dsoname(query.value(11)) + ")" + " -> " +
>  			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
>  			" (" + dsoname(query.value(15)) + ")")
> +
> +def BranchDataPrepIPC(query, data):
> +	insn_cnt = query.value(16)
> +	cyc_cnt = query.value(17)
> +	ipc = CalcIPC(cyc_cnt, insn_cnt)
> +	data.append(insn_cnt)
> +	data.append(cyc_cnt)
> +	data.append(ipc)
> +
> +def BranchDataPrep(query):
> +	data = []
> +	for i in xrange(0, 8):
> +		data.append(query.value(i))
> +	BranchDataPrepBr(query, data)
>  	return data
>  
>  def BranchDataPrepWA(query):
> @@ -1555,10 +1577,26 @@ def BranchDataPrepWA(query):
>  	data.append("{:>19}".format(query.value(1)))
>  	for i in xrange(2, 8):
>  		data.append(query.value(i))
> -	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
> -			" (" + dsoname(query.value(11)) + ")" + " -> " +
> -			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
> -			" (" + dsoname(query.value(15)) + ")")
> +	BranchDataPrepBr(query, data)
> +	return data
> +
> +def BranchDataWithIPCPrep(query):
> +	data = []
> +	for i in xrange(0, 8):
> +		data.append(query.value(i))
> +	BranchDataPrepIPC(query, data)
> +	BranchDataPrepBr(query, data)
> +	return data
> +
> +def BranchDataWithIPCPrepWA(query):
> +	data = []
> +	data.append(query.value(0))
> +	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
> +	data.append("{:>19}".format(query.value(1)))
> +	for i in xrange(2, 8):
> +		data.append(query.value(i))
> +	BranchDataPrepIPC(query, data)
> +	BranchDataPrepBr(query, data)
>  	return data
>  
>  # Branch data model
> @@ -1572,10 +1610,20 @@ class BranchModel(TreeModel):
>  		self.event_id = event_id
>  		self.more = True
>  		self.populated = 0
> +		self.have_ipc = IsSelectable(glb.db, "samples", columns = "insn_count, cyc_count")
> +		if self.have_ipc:
> +			select_ipc = ", insn_count, cyc_count"
> +			prep_fn = BranchDataWithIPCPrep
> +			prep_wa_fn = BranchDataWithIPCPrepWA
> +		else:
> +			select_ipc = ""
> +			prep_fn = BranchDataPrep
> +			prep_wa_fn = BranchDataPrepWA
>  		sql = ("SELECT samples.id, time, cpu, comm, pid, tid, branch_types.name,"
>  			" CASE WHEN in_tx = '0' THEN 'No' ELSE 'Yes' END,"
>  			" ip, symbols.name, sym_offset, dsos.short_name,"
>  			" to_ip, to_symbols.name, to_sym_offset, to_dsos.short_name"
> +			+ select_ipc +
>  			" FROM samples"
>  			" INNER JOIN comms ON comm_id = comms.id"
>  			" INNER JOIN threads ON thread_id = threads.id"
> @@ -1589,9 +1637,9 @@ class BranchModel(TreeModel):
>  			" ORDER BY samples.id"
>  			" LIMIT " + str(glb_chunk_sz))
>  		if pyside_version_1 and sys.version_info[0] == 3:
> -			prep = BranchDataPrepWA
> +			prep = prep_fn
>  		else:
> -			prep = BranchDataPrep
> +			prep = prep_wa_fn
>  		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
>  		self.fetcher.done.connect(self.Update)
>  		self.fetcher.Fetch(glb_chunk_sz)
> @@ -1600,13 +1648,23 @@ class BranchModel(TreeModel):
>  		return BranchRootItem()
>  
>  	def columnCount(self, parent=None):
> -		return 8
> +		if self.have_ipc:
> +			return 11
> +		else:
> +			return 8
>  
>  	def columnHeader(self, column):
> -		return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
> +		if self.have_ipc:
> +			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Insn Cnt", "Cyc Cnt", "IPC", "Branch")[column]
> +		else:
> +			return ("Time", "CPU", "Command", "PID", "TID", "Branch Type", "In Tx", "Branch")[column]
>  
>  	def columnFont(self, column):
> -		if column != 7:
> +		if self.have_ipc:
> +			br_col = 10
> +		else:
> +			br_col = 7
> +		if column != br_col:
>  			return None
>  		return QFont("Monospace")
>  
> @@ -2114,10 +2172,10 @@ def GetEventList(db):
>  
>  # Is a table selectable
>  
> -def IsSelectable(db, table, sql = ""):
> +def IsSelectable(db, table, sql = "", columns = "*"):
>  	query = QSqlQuery(db)
>  	try:
> -		QueryExec(query, "SELECT * FROM " + table + " " + sql + " LIMIT 1")
> +		QueryExec(query, "SELECT " + columns + " FROM " + table + " " + sql + " LIMIT 1")
>  	except:
>  		return False
>  	return True
> @@ -2854,6 +2912,12 @@ cd xed
>  sudo ./mfile.py --prefix=/usr/local install
>  sudo ldconfig
>  </pre>
> +<h3>Instructions per Cycle (IPC)</h3>
> +If available, IPC information is displayed in columns 'insn_cnt', 'cyc_cnt' and 'IPC'.
> +<p><b>Intel PT note:</b> The information applies to the blocks of code ending with, and including, that branch.
> +Due to the granularity of timing information, the number of cycles for some code blocks will not be known.
> +In that case, 'insn_cnt', 'cyc_cnt' and 'IPC' are zero, but when 'IPC' is displayed it covers the period
> +since the previous displayed 'IPC'.
>  <h3>Find</h3>
>  Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
>  Refer to Python documentation for the regular expression syntax.
> -- 
> 2.17.1
