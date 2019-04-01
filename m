Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD9720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+uL0HiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDASRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:17:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35182 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDASRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:17:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so12067131qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=izVDaH+1b216ceZ2OmicIrSjyGMtf2binyuIcjY9p4c=;
        b=W+uL0HiSuIzmTeXaToqKPOmC0kRIKNfRIAnXgPynqZao+sXs22SOmOTyKuTfiNI3kU
         N9txtHFTr7iauFhpsG9glvxRdFZxLN28VhK1Z9B7v7DRhhDV38I6ZlElgj6wzbC/rheb
         XLr6GR1lmOhdkyngykkDj93CQM04Fg/Wd+asCWO0svirpktFtd8YiIzdsMUEzyueYnIP
         VPRh0b14aGKUrpjJatp1O3toYNo29ZFMDZnVdDfe9qZXjkvEWSCRnFoDetvY3VmyUN4D
         7yKoXbE59t2ymoEzGQrsbssjs+i+OKbleBlUOBwNjVfmYwf0FFDimhh07/zPeHH+9Xc4
         9dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=izVDaH+1b216ceZ2OmicIrSjyGMtf2binyuIcjY9p4c=;
        b=ZcRga1ztPU2mg3FnD44g5YMRR0Hc4RwDpt8OBjRvvR1H/KKKdcn9foNqwjo+wisn0o
         OMoFU5qm3HXy8lh+lUnDJ+5a5awToQGlNR5E3QTMJH965FkZ8+Q7qt6lagsSSKoRxJW2
         u7cI7RV2qseWZE2Ze79O9gIoS68Vzs8qXHG/TFPwXALkHn4TiY+OhMWkl6EuXuhuzlGa
         DBk5v01gc0wTVyqrXFN+zTdl2KOEwr3PHWRldsQENCGDK3iZip4egV7dfqadd1nFAQaK
         cU28dOgT+IgrgwzHZwuQF4/Llv1awN2+ivrTaS+DDlIC3T5DhCFDirK+VSbks11J1e85
         Isiw==
X-Gm-Message-State: APjAAAV2Rpx+enSmo4ollMbM/9S5NzpXTdWEp/P2auc6N2YRzvnxKbtL
        8WEk/n3PCAGhQltXoQ3lz1Mp/iqk
X-Google-Smtp-Source: APXvYqy3GdZzCJuOactD7Jkt3aKBmS4mPq4BDPtR0/5KzyBjgxmJqHXjDNMAFXsQzcwIOleR8yCTPg==
X-Received: by 2002:a0c:81fa:: with SMTP id 55mr53323682qve.91.1554142671050;
        Mon, 01 Apr 2019 11:17:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id r15sm5878741qte.65.2019.04.01.11.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:17:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87ACB4039C; Mon,  1 Apr 2019 15:17:45 -0300 (-03)
Date:   Mon, 1 Apr 2019 15:17:45 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 00/15] tools/lib/traceevent: Continuing on the path to a
 stand alone library
Message-ID: <20190401181745.GG30617@kernel.org>
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401164305.359125441@goodmis.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 01, 2019 at 12:43:05PM -0400, Steven Rostedt escreveu:
> 
> Arnaldo,
> 
> These contain more patches to make libtraceevent a stand alone library.
> It also brings in some changes that are in the trace-cmd library.
> 
> There's a few name changes to the API function names to be more
> descriptive as well as closer to what they actually do.
> 
> The "pevent" has been renamed to "tep" as we no longer use "pevent"
> to represent the handle to the libtraceevent library descriptor.
> "tep" now stands for "Trace Event Parser".
> 
> The reason for the "(Red Hat)" in one of my patches is that the code
> was written when I was working for Red Hat, but added when working
> for VMware (which is in the Signed-off-by).

Thanks, applied.

  $ git log | grep Author | head -15
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
  Author: Tzvetomir Stoyanov <tstoyanov@vmware.com>
  Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
  Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
  $

- Arnaldo
