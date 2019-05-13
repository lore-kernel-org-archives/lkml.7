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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FCC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E41920850
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZowbTbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEMUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:09:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35932 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:09:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id a17so15065716qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+s7lnSqwZyN597jPMc7dED4XuMMN0rMy+PtJcA3CCeM=;
        b=eZowbTbAkuBko0GXaT2xe3AmrBf3lA7OYkV1aM5cHh/Vn64FvXLQyQziduDH5lJ72E
         JKCbrQhvh2fRLNNu1mb/DHSQirJGFYi04E5dToCMeAnWn89gICQufDFgu7amYKACJKNq
         hJoDJRz6LHVPuIITDu+ddr3XvUMTU8mghV3x82lQ2qA2cGpGeqYraHhmeIbjV00TGRPh
         U0Dt+ujMAlpHiEy7/ob7lCRrLBo0wfBR+lNR1Cj6w+oH0mU/OkD/Oy6USgu5C3Oi9Z3+
         qg6kUg53ZA7UKTj+k0PCama6BeqbXTMvMqRCHRP4zvkiHhBjKyedTXJg3tsvivYMt/5i
         KTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+s7lnSqwZyN597jPMc7dED4XuMMN0rMy+PtJcA3CCeM=;
        b=X4tL/95o3C0VNbyUSsu5PniLdhIW53jvtI9wpvef715ZOBR/2xDKvyqiE65RVTNIs7
         ltsRJVc9FVEHCHgpASuAJUuDfgreQ5VdT6uEanzDEdz018deL2xcPM04DYD+NbthcM0O
         D1zL8ngdeJiAjtMgsENLuoNcNm3dKYjskATCx4s11AHpEOVhtgumB98L5MI/hWOnWUcm
         Qnmc2u/Svd/FfVUOwhC6XaDnKB8UOKTGgKA334qK5xmef8FOsONvt6n7gEpy+HjaNONZ
         BoZni4gA8cn0EiJ+nCr8k1nkRE5vi+A90+q8RC5wU4W0tfI6pbHazceukKwok9/wqVTh
         9BVQ==
X-Gm-Message-State: APjAAAWZCdCSusUs5vm9BCnfQtLvTPpoaZssKP1b/I8TT+todcNByzLL
        nJzXjZTvaCLJVhBNvPTyWW09kP7y
X-Google-Smtp-Source: APXvYqy/uoxfwUxI4gNppU212Mawbo5JP2HUbyDpBODJm937ea6poZLF42jOMmBL5D+CkEy1+43pzg==
X-Received: by 2002:a0c:d7cc:: with SMTP id g12mr24846548qvj.220.1557778172390;
        Mon, 13 May 2019 13:09:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id b123sm1174031qkd.45.2019.05.13.13.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 13:09:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41657403AD; Mon, 13 May 2019 17:09:27 -0300 (-03)
Date:   Mon, 13 May 2019 17:09:27 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] perf scripts python: exported-sql-viewer.py: Add
 context menu
Message-ID: <20190513200927.GE3198@kernel.org>
References: <20190503120828.25326-1-adrian.hunter@intel.com>
 <20190503120828.25326-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503120828.25326-6-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 03, 2019 at 03:08:27PM +0300, Adrian Hunter escreveu:
> Add a context menu (right-click) that provides options for copying to
> clipboard, including, for trees, the ability to copy only the cell under
> the mouse pointer.

Works as well:

    Committer testing:

      $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

      Simply right click and pick "Copy selection", that at this point has
      just the first line, not expanded, then see what was copied by pressing
      shift+control+v on a terminal:

    Call Path,Object,Count,Time (ns),Time (%),Branch Count,Branch Count (%)
    ▶ simple-retpolin,,,,,,

      Ditto after expanding, i.e. the selection continues to be just one
      line:

    Call Path           Object   Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
    ▼ simple-retpolin

       Now select all the lines with the mouse and control+shift+v again:

    Call Path                     Object             Count   Time (ns)   Time (%)   Branch Count   Branch Count (%)
      ▼ 14503:14503
        ▼ _start                  ld-2.28.so             1      156267      100.0          10602              100.0
          ▶ unknown               unknown                1        2276        1.5              1                0.0
          ▶ _dl_start             ld-2.28.so             1      137047       87.7          10088               95.2
          ▶ _dl_init              ld-2.28.so             1        9142        5.9            326                3.1
          ▼ _start                simple-retpoline       1        7457        4.8            182                1.7
            ▶ unknown             unknown                1         805       10.8              1                0.5
            ▶ __libc_start_main   libc-2.28.so           1        6347       85.1            179               98.4
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  .../scripts/python/exported-sql-viewer.py     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 5804d9705ab7..421f3828ea43 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -901,6 +901,8 @@ class TreeWindowBase(QMdiSubWindow):
>  		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
>  		self.view.CopyCellsToClipboard = CopyTreeCellsToClipboard
>  
> +		self.context_menu = TreeContextMenu(self.view)
> +
>  	def DisplayFound(self, ids):
>  		if not len(ids):
>  			return False
> @@ -1674,6 +1676,8 @@ class BranchWindow(QMdiSubWindow):
>  
>  		self.ResizeColumnsToContents()
>  
> +		self.context_menu = TreeContextMenu(self.view)
> +
>  		self.find_bar = FindBar(self, self, True)
>  
>  		self.finder = ChildDataItemFinder(self.model.root)
> @@ -2483,6 +2487,39 @@ def CopyCellsToClipboardHdr(view):
>  def CopyCellsToClipboardCSV(view):
>  	CopyCellsToClipboard(view, True, True)
>  
> +# Context menu
> +
> +class ContextMenu(object):
> +
> +	def __init__(self, view):
> +		self.view = view
> +		self.view.setContextMenuPolicy(Qt.CustomContextMenu)
> +		self.view.customContextMenuRequested.connect(self.ShowContextMenu)
> +
> +	def ShowContextMenu(self, pos):
> +		menu = QMenu(self.view)
> +		self.AddActions(menu)
> +		menu.exec_(self.view.mapToGlobal(pos))
> +
> +	def AddCopy(self, menu):
> +		menu.addAction(CreateAction("&Copy selection", "Copy to clipboard", lambda: CopyCellsToClipboardHdr(self.view), self.view))
> +		menu.addAction(CreateAction("Copy selection as CS&V", "Copy to clipboard as CSV", lambda: CopyCellsToClipboardCSV(self.view), self.view))
> +
> +	def AddActions(self, menu):
> +		self.AddCopy(menu)
> +
> +class TreeContextMenu(ContextMenu):
> +
> +	def __init__(self, view):
> +		super(TreeContextMenu, self).__init__(view)
> +
> +	def AddActions(self, menu):
> +		i = self.view.currentIndex()
> +		text = str(i.data()).strip()
> +		if len(text):
> +			menu.addAction(CreateAction('Copy "' + text + '"', "Copy to clipboard", lambda: QApplication.clipboard().setText(text), self.view))
> +		self.AddCopy(menu)
> +
>  # Table window
>  
>  class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
> @@ -2506,6 +2543,8 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
>  
>  		self.ResizeColumnsToContents()
>  
> +		self.context_menu = ContextMenu(self.view)
> +
>  		self.find_bar = FindBar(self, self, True)
>  
>  		self.finder = ChildDataItemFinder(self.data_model)
> @@ -2622,6 +2661,8 @@ class TopCallsWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
>  		self.view.setSelectionMode(QAbstractItemView.ContiguousSelection)
>  		self.view.CopyCellsToClipboard = CopyTableCellsToClipboard
>  
> +		self.context_menu = ContextMenu(self.view)
> +
>  		self.ResizeColumnsToContents()
>  
>  		self.find_bar = FindBar(self, self, True)
> -- 
> 2.17.1

-- 

- Arnaldo
