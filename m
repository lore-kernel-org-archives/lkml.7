Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF7421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDdnKE+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfEMUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:03:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38472 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:03:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so9177151qth.5;
        Mon, 13 May 2019 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P7dKq5pD6/ylsA9upBvHpkcpA3UJ1OCNbMsXtaUV8aE=;
        b=qDdnKE+jU2ZKBGWgfOqZvkCQ+LRX34FgR8YnpGHoZxOlzsfo6iWWw9ybJ5Ngf+8k1c
         vciIlwdeAMv1+ovqlXGD7yDFqIYpy3rBmnsmB0ljbBYkMKKafhmUeCQOgszbHk0Ly2LG
         bNjTAeLgNkTXIgpsz7libWbnzFFWL0JGWSWthmm7P14Q8o2U4syKTImqt+y6vxrzPtiX
         wFdxhr6IbDxH8wvYORKV+9YdJJXLZBVAgWyYT424XITPjIYihH0WojCErsI7Cw0aKnre
         Q8ugbl6o6WNmyzg+SHz5y4YcyfD3gwwKiUd3yjPao2CWR63Toj/Hbykg3g8llQTOM+0q
         DJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P7dKq5pD6/ylsA9upBvHpkcpA3UJ1OCNbMsXtaUV8aE=;
        b=G9tTLsORWg5L+HNj+A/LyjYtBOIWqEQOdAwMNHGCqUHYkUrESIeUlo/T+5vnql3yRh
         doZ44Co8GJS2pRNTKxg0ryqgKh1Nm5tpbkvwylKQdbe7ctn9yPGzTtzBs+AVYE8NGQ5Z
         Xe639k/DKaw0YxP9kPZJwWufvgVq4C3jjherhE3Dv8MsE/i3DRKRp4rL5903ToJFPzca
         c+Fzgy54WVLuTtxbW2y8SmjkmPNHDVOtqCqMLQY3ejAO816AaUC1MX5MXETLll7BQA04
         GeEJLmwQjuWQe5aL6yqDAU6MaGZON6dgUlnhzDBR84iqKFT+joFS4mNimE8lZFysROQW
         DXzA==
X-Gm-Message-State: APjAAAXSTBRhtNUxjEoVWjicvEAoIxaPi68ZwmWpQUzFfYY3eEQ1QLaE
        xL/VBSVEwht+pQIp5XtSC2Q=
X-Google-Smtp-Source: APXvYqxdzPP68jTjQRnLvkkObwydUs8p2YjUAeQgmgEzOpyurSyL7wJ1WcHUPMhLbYRfEv0DCKUMjw==
X-Received: by 2002:ac8:1aa9:: with SMTP id x38mr26013048qtj.172.1557777807190;
        Mon, 13 May 2019 13:03:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id u9sm6785110qtg.91.2019.05.13.13.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 13:03:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B15D403AD; Mon, 13 May 2019 17:03:23 -0300 (-03)
Date:   Mon, 13 May 2019 17:03:22 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf scripts python: exported-sql-viewer.py: Add
 copy to clipboard
Message-ID: <20190513200322.GD3198@kernel.org>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
 <20190503120828.25326-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503120828.25326-5-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 03, 2019 at 03:08:26PM +0300, Adrian Hunter escreveu:
> Add support for copying to clipboard. Two menu options are added to copy the
> selected rows / columns with normal spacing, or as comma-separated-values.
> In the case of trees, only entire rows can be copied.

Cool, it works:

    Comitter testing:

      $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

    Select the lines, press control+C and on the same terminal,
    press control+shift+V and voilà:

    Call Path                           Object           Count  Time (ns)  Time (%)  Branch Count  Branch Count (%)
      ▼ 14503:14503
        ▼ _start                        ld-2.28.so           1     156267     100.0         10602             100.0
            unknown                     unknown              1       2276       1.5             1               0.0
          ▼ _dl_start                   ld-2.28.so           1     137047      87.7         10088              95.2
            ▶ unknown                   unknown              4       4127       3.0             4               0.0
              _dl_setup_hash            ld-2.28.so           1          0       0.0             1               0.0
            ▶ _dl_sysdep_start          ld-2.28.so           1     131342      95.8          9981              98.9
          ▼ _dl_init                    ld-2.28.so           1       9142       5.9           326               3.1
            ▼ call_init.part.0          ld-2.28.so           3       9133      99.9           319              97.9
              ▶ _init                   libc-2.28.so         1       6877      75.3           110              34.5
              ▶ check_stdfiles_vtables  libc-2.28.so         1         76       0.8             2               0.6
              ▶ init_cacheinfo          libc-2.28.so         1       1991      21.8           197              61.8
          ▶ _start                      simple-retpoline     1       7457       4.8           182               1.7

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index c0fb88d440ba..5804d9705ab7 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -898,6 +898,8 @@ class TreeWindowBase(QMdiSubWindow):
>  		self.find_bar = None
>  
>  		self.view = QTreeView()
> +		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
> +		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
>  
>  	def DisplayFound(self, ids):
>  		if not len(ids):
> @@ -1666,6 +1668,8 @@ class BranchWindow(QMdiSubWindow):
>  
>  		self.view = QTreeView()
>  		self.view.setUniformRowHeights(True)
> +		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
> +		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
>  		self.view.setModel(self.model)
>  
>  		self.ResizeColumnsToContents()
> @@ -2278,6 +2282,207 @@ class ResizeColumnsToContentsBase(QObject):
>  		self.data_model.rowsInserted.disconnect(self.UpdateColumnWidths)
>  		self.ResizeColumnsToContents()
>  
> +# Convert value to CSV
> +
> +def ToCSValue(val):
> +	if '"' in val:
> +		val = val.replace('"', '""')
> +	if "," in val or '"' in val:
> +		val = '"' + val + '"'
> +	return val
> +
> +# Key to sort table model indexes by row / column, assuming fewer than 1000 columns
> +
> +glb_max_cols = 1000
> +
> +def RowColumnKey(a):
> +	return a.row() * glb_max_cols + a.column()
> +
> +# Copy selected table cells to clipboard
> +
> +def CopyTableCellsToClipboard(view, as_csv=False, with_hdr=False):
> +	indexes = sorted(view.selectedIndexes(), key=RowColumnKey)
> +	idx_cnt = len(indexes)
> +	if not idx_cnt:
> +		return
> +	if idx_cnt == 1:
> +		with_hdr=False
> +	min_row = indexes[0].row()
> +	max_row = indexes[0].row()
> +	min_col = indexes[0].column()
> +	max_col = indexes[0].column()
> +	for i in indexes:
> +		min_row = min(min_row, i.row())
> +		max_row = max(max_row, i.row())
> +		min_col = min(min_col, i.column())
> +		max_col = max(max_col, i.column())
> +	if max_col > glb_max_cols:
> +		raise RuntimeError("glb_max_cols is too low")
> +	max_width = [0] * (1 + max_col - min_col)
> +	for i in indexes:
> +		c = i.column() - min_col
> +		max_width[c] = max(max_width[c], len(str(i.data())))
> +	text = ""
> +	pad = ""
> +	sep = ""
> +	if with_hdr:
> +		model = indexes[0].model()
> +		for col in range(min_col, max_col + 1):
> +			val = model.headerData(col, Qt.Horizontal)
> +			if as_csv:
> +				text += sep + ToCSValue(val)
> +				sep = ","
> +			else:
> +				c = col - min_col
> +				max_width[c] = max(max_width[c], len(val))
> +				width = max_width[c]
> +				align = model.headerData(col, Qt.Horizontal, Qt.TextAlignmentRole)
> +				if align & Qt.AlignRight:
> +					val = val.rjust(width)
> +				text += pad + sep + val
> +				pad = " " * (width - len(val))
> +				sep = "  "
> +		text += "\n"
> +		pad = ""
> +		sep = ""
> +	last_row = min_row
> +	for i in indexes:
> +		if i.row() > last_row:
> +			last_row = i.row()
> +			text += "\n"
> +			pad = ""
> +			sep = ""
> +		if as_csv:
> +			text += sep + ToCSValue(str(i.data()))
> +			sep = ","
> +		else:
> +			width = max_width[i.column() - min_col]
> +			if i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
> +				val = str(i.data()).rjust(width)
> +			else:
> +				val = str(i.data())
> +			text += pad + sep + val
> +			pad = " " * (width - len(val))
> +			sep = "  "
> +	QApplication.clipboard().setText(text)
> +
> +def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
> +	indexes = view.selectedIndexes()
> +	if not len(indexes):
> +		return
> +
> +	selection = view.selectionModel()
> +
> +	first = None
> +	for i in indexes:
> +		above = view.indexAbove(i)
> +		if not selection.isSelected(above):
> +			first = i
> +			break
> +
> +	if first is None:
> +		raise RuntimeError("CopyTreeCellsToClipboard internal error")
> +
> +	model = first.model()
> +	row_cnt = 0
> +	col_cnt = model.columnCount(first)
> +	max_width = [0] * col_cnt
> +
> +	indent_sz = 2
> +	indent_str = " " * indent_sz
> +
> +	expanded_mark_sz = 2
> +	if sys.version_info[0] == 3:
> +		expanded_mark = "\u25BC "
> +		not_expanded_mark = "\u25B6 "
> +	else:
> +		expanded_mark = unicode(chr(0xE2) + chr(0x96) + chr(0xBC) + " ", "utf-8")
> +		not_expanded_mark =  unicode(chr(0xE2) + chr(0x96) + chr(0xB6) + " ", "utf-8")
> +	leaf_mark = "  "
> +
> +	if not as_csv:
> +		pos = first
> +		while True:
> +			row_cnt += 1
> +			row = pos.row()
> +			for c in range(col_cnt):
> +				i = pos.sibling(row, c)
> +				if c:
> +					n = len(str(i.data()))
> +				else:
> +					n = len(str(i.data()).strip())
> +					n += (i.internalPointer().level - 1) * indent_sz
> +					n += expanded_mark_sz
> +				max_width[c] = max(max_width[c], n)
> +			pos = view.indexBelow(pos)
> +			if not selection.isSelected(pos):
> +				break
> +
> +	text = ""
> +	pad = ""
> +	sep = ""
> +	if with_hdr:
> +		for c in range(col_cnt):
> +			val = model.headerData(c, Qt.Horizontal, Qt.DisplayRole).strip()
> +			if as_csv:
> +				text += sep + ToCSValue(val)
> +				sep = ","
> +			else:
> +				max_width[c] = max(max_width[c], len(val))
> +				width = max_width[c]
> +				align = model.headerData(c, Qt.Horizontal, Qt.TextAlignmentRole)
> +				if align & Qt.AlignRight:
> +					val = val.rjust(width)
> +				text += pad + sep + val
> +				pad = " " * (width - len(val))
> +				sep = "   "
> +		text += "\n"
> +		pad = ""
> +		sep = ""
> +
> +	pos = first
> +	while True:
> +		row = pos.row()
> +		for c in range(col_cnt):
> +			i = pos.sibling(row, c)
> +			val = str(i.data())
> +			if not c:
> +				if model.hasChildren(i):
> +					if view.isExpanded(i):
> +						mark = expanded_mark
> +					else:
> +						mark = not_expanded_mark
> +				else:
> +					mark = leaf_mark
> +				val = indent_str * (i.internalPointer().level - 1) + mark + val.strip()
> +			if as_csv:
> +				text += sep + ToCSValue(val)
> +				sep = ","
> +			else:
> +				width = max_width[c]
> +				if c and i.data(Qt.TextAlignmentRole) & Qt.AlignRight:
> +					val = val.rjust(width)
> +				text += pad + sep + val
> +				pad = " " * (width - len(val))
> +				sep = "   "
> +		pos = view.indexBelow(pos)
> +		if not selection.isSelected(pos):
> +			break
> +		text = text.rstrip() + "\n"
> +		pad = ""
> +		sep = ""
> +
> +	QApplication.clipboard().setText(text)
> +
> +def CopyCellsToClipboard(view, as_csv=False, with_hdr=False):
> +	view.CopyCellsToClipboard(view, as_csv, with_hdr)
> +
> +def CopyCellsToClipboardHdr(view):
> +	CopyCellsToClipboard(view, False, True)
> +
> +def CopyCellsToClipboardCSV(view):
> +	CopyCellsToClipboard(view, True, True)
> +
>  # Table window
>  
>  class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
> @@ -2296,6 +2501,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
>  		self.view.verticalHeader().setVisible(False)
>  		self.view.sortByColumn(-1, Qt.AscendingOrder)
>  		self.view.setSortingEnabled(True)
> +		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
> +		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
>  
>  		self.ResizeColumnsToContents()
>  
> @@ -2412,6 +2619,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
>  		self.view.setModel(self.model)
>  		self.view.setEditTriggers(QAbstractItemView.NoEditTriggers)
>  		self.view.verticalHeader().setVisible(False)
> +		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
> +		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
>  
>  		self.ResizeColumnsToContents()
>  
> @@ -2749,6 +2958,8 @@ class MainWindow(QMainWindow):
>  		file_menu.addAction(CreateExitAction(glb.app, self))
>  
>  		edit_menu = menu.addMenu("&Edit")
> +		edit_menu.addAction(CreateAction("&Copy", "Copy to clipboard", self.CopyToClipboard, self, QKeySequence.Copy))
> +		edit_menu.addAction(CreateAction("Copy as CS&V", "Copy to clipboard as CSV", self.CopyToClipboardCSV, self))
>  		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
>  		edit_menu.addAction(CreateAction("Fetch &more records...", "Fetch more records", self.FetchMoreRecords, self, [QKeySequence(Qt.Key_F8)]))
>  		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
> @@ -2781,6 +2992,12 @@ class MainWindow(QMainWindow):
>  			except:
>  				pass
>  
> +	def CopyToClipboard(self):
> +		self.Try(CopyCellsToClipboardHdr)
> +
> +	def CopyToClipboardCSV(self):
> +		self.Try(CopyCellsToClipboardCSV)
> +
>  	def Find(self):
>  		win = self.mdi_area.activeSubWindow()
>  		if win:
> -- 
> 2.17.1

-- 

- Arnaldo
