Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B73C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B9527B6C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFCFvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:51:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:64428 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfFCFvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:51:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 22:51:23 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2019 22:51:21 -0700
Subject: Re: [PATCH 18/22] perf scripts python: exported-sql-viewer.py: Add
 IPC information to the Branch reports
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-19-adrian.hunter@intel.com>
 <20190531164444.GB20408@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <50fdb104-e965-feab-f1a6-e6b274269448@intel.com>
Date:   Mon, 3 Jun 2019 08:50:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531164444.GB20408@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/19 7:44 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 20, 2019 at 02:37:24PM +0300, Adrian Hunter escreveu:
>> Enhance the "All branches" and "Selected branches" reports to display IPC
>> information if it is available.
> 
> So, testing this I noticed that it all starts with the left arrow in every
> line, that should mean there is some tree there, i.e. look at all those ▶
> symbols:
> 
> Time              CPU Command         PID   TID   Branch Type  In Tx  Insn Cnt  Cyc Cnt  IPC  Branch
> ▶ 187836112195670 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
> ▶ 187836112195987 7   simple-retpolin 23003 23003 trace end    No     0         883      0    7f6f33d4f110 _start (ld-2.28.so) -> 0 unknown (unknown)
> ▶ 187836112199189 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4f110 _start (ld-2.28.so)
> ▶ 187836112199189 7   simple-retpolin 23003 23003 call         No     0         0        0    7f6f33d4f113 _start+0x3 (ld-2.28.so) -> 7f6f33d4ff50 _dl_start (ld-2.28.so)
> ▶ 187836112199544 7   simple-retpolin 23003 23003 trace end    No     17        996      0.02 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so) -> 0 unknown (unknown)
> ▶ 187836112200939 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff73 _dl_start+0x23 (ld-2.28.so)
> ▶ 187836112201229 7   simple-retpolin 23003 23003 trace end    No     1         816      0.00 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so) -> 0 unknown (unknown)
> ▶ 187836112203500 7   simple-retpolin 23003 23003 trace begin  No     0         0        0               0 unknown (unknown) -> 7f6f33d4ff7a _dl_start+0x2a (ld-2.28.so)
> 
> But if you click on it, that ▶ disappears and a new click doesn't make it
> reappear, looks buggy, but seems like a minor oddity that will not prevent me
> from applying it now, please check and provide a fix on top of this,

The arrow is to display disssassembly, but only if xed is installed and the
object is in the buildid cache.  Unfortunately, it is not efficient to
determine if there is anything to expand before the user clicks.
