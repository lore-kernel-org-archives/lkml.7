Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A435CFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872FA2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394401AbfJPSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:48:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:21962 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391023AbfJPSsA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:48:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 11:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="225889320"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2019 11:47:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4D5163001C0; Wed, 16 Oct 2019 11:47:59 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:47:59 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Hide deprecated events by default
Message-ID: <20191016184759.GU9933@tassilo.jf.intel.com>
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
 <20191015091401.GE10951@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015091401.GE10951@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:14:01AM +0200, Jiri Olsa wrote:
> On Tue, Oct 15, 2019 at 10:53:57AM +0800, Jin Yao wrote:
> > There are some deprecated events listed by perf list. But we can't remove
> > them from perf list with ease because some old scripts may use them.
> > 
> > Deprecated events are old names of renamed events.  When an event gets
> > renamed the old name is kept around for some time and marked with
> > Deprecated. The newer Intel event lists in the tree already have these
> > headers.
> > 
> > So we need to keep them in the event list, but provide a new option to
> > show them. The new option is "--deprecated".
> > 
> > With this patch, the deprecated events are hidden by default but they can
> > be displayed when option "--deprecated" is enabled.
> 
> not sure it's wise to hide them, because people will not read man page
> to find --deprecated option, they will rather complain right away ;-)

perf list will have the same event with a different name.

If someone is using perf list presumably they don't know the event name,
and look at the description, and the description is still there,
just with a new name.

Old scripts of course still work because -e looks up deprecated
events too.

-Andi
