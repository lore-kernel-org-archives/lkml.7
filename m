Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B1C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF1020820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh3HKIg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfDJMyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:54:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42202 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbfDJMyg (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:54:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so2620284qtc.9
        for <Linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24LWhJMbWpfKCl9NIAeUFQBWfDLHnGzUp+8TuqZDdkg=;
        b=Wh3HKIg/Qmh1AFsSrMdo7bO6maHDep/KnKA/Lsi2lHlSMy3y2WPzzRoZ7n1DPYW1Bg
         o5eq0rYXwlOSKfhbPYA2vN5+m6pn3jV3Y5Stx3atLDvTA9bgSPmcrqRPtcCuIl6+Evs2
         GRHuLxbfBo3ryiwyMFzHHjAytdx2iD6WU77TQiNdIvhicqwuGAyttl3eIpHOA8DzGVpM
         8QslApmXuT6Fxxhn8J/Q7d+s9laOjpD/FEdGjebNiblsSriWLY43xuJy1UJmZn2KGhOh
         kwzA8+6susduXTwif0jQLefmM05PtoRTX6SOTJd4zuObJ2ANs/uDD061faIUyfT8R+Jh
         9SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24LWhJMbWpfKCl9NIAeUFQBWfDLHnGzUp+8TuqZDdkg=;
        b=nsVpGpBFJM88n2UlpJnAC34EWIV4f7ZwpjmtnETY3zVxoJp/eRmhk9pQLxpoCDOifJ
         WkFHbgNbbxK/L/qlmdla3WJ13Zy/tfX9uhc0OWLRTLLLcmENZ3SqqPl3XuwBofT5TL2l
         Jiqftzs7cdlRZMCcXEfnflUmM8xS+FpIDWhkSXCtVz3Z6CCb3ZgJaFOiYHTMLYTYJWsu
         OD9gQNCWJ9hQ4dVEQ42G/OuUNObc/dPz4FNu6sywP5uhDIA6Zo7v+fDCKHHQX2amoPCn
         AsW7IijcaJmAM/sTK9YRb2zRxySSGZMjNW8Eggh1nfY5D3bq9MZvzLdlqCPl5YAy+6Mx
         48nw==
X-Gm-Message-State: APjAAAW3XhPSd9ysElVca9Jpua8IV8Pnl/W8RNRNbdPcLwwNYX1wcbgL
        EsiyvM4bOPEjwig9FK9AyRI=
X-Google-Smtp-Source: APXvYqyDiHyA0SF1y/d1j9z+Flu+xqWFQwmMob+kXWciTQjdPImKGGdLsgxJN7CkbM+KtwsCYq6Grg==
X-Received: by 2002:aed:3427:: with SMTP id w36mr35631630qtd.54.1554900875357;
        Wed, 10 Apr 2019 05:54:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i33sm21447634qtb.64.2019.04.10.05.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 05:54:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 033E64039C; Wed, 10 Apr 2019 09:54:31 -0300 (-03)
Date:   Wed, 10 Apr 2019 09:54:31 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/4] perf: Add a 'percore' event qualifier
Message-ID: <20190410125431.GC13888@kernel.org>
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
 <1552985816-20915-2-git-send-email-yao.jin@linux.intel.com>
 <20190410123641.GA13888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410123641.GA13888@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 10, 2019 at 09:36:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 19, 2019 at 04:56:53PM +0800, Jin Yao escreveu:
> > Add a 'percore' event qualifier, like cpu/event=0,umask=0x3,percore=1/,
> > that sums up the event counts for both hardware threads in a core.
> > 
> > We can already do this with --per-core, but it's often useful to do
> > this together with other metrics that are collected per hardware thread.
> > So we need to support this per-core counting on a event level.
> > 
> > This can be implemented in only the user tool, no kernel support needed.
> > 
> >  v3:
> >  ---
> >  Simplify the code according to Jiri's comments.
> >  Before:
> >    "return term->val.percore ? true : false;"
> >  Now:
> >    "return term->val.percore;"
> > 
> >  v2:
> >  ---
> >  Change the qualifier name from 'coresum' to 'percore' according to
> >  comments from Jiri and Andi.
> 
> I'm applying this, but please, don't forget to, when adding a new
> qualifier, to update the documentation... I'm doing this for you this
> time.

The first patch didn't apply with 'git am', I did it manually, and added
the patch below

But then the second doesn't apply to my perf/core branch as well, please
refresh and resend a v4, thanks.

- Arnaldo

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 138fb6e94b3c..18ed1b0fceb3 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -199,6 +199,18 @@ also be supplied. For example:
 
   perf stat -C 0 -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
 
+EVENT QUALIFIERS:
+
+It is also possible to add extra qualifiers to an event:
+
+percore:
+
+Sums up the event counts for all hardware threads in a core, e.g.:
+
+
+  perf stat -e cpu/event=0,umask=0x3,percore=1/
+
+
 EVENT GROUPS
 ------------
 
