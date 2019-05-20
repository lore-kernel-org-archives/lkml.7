Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA07C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF6C216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz3KjvUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfETOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:39:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46654 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfETOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:39:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so16494988qtz.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnKagkhm5U6N7QSx0MOcmsmOUR9BRTPQzriDtjeS1mU=;
        b=sz3KjvUigPLdigL93ki3l+n1mRYgH9ptIORkJMoSYQqpCam1Ln7TNTvTwCVzefXHih
         sp5h9AJIdHh/qWPaddNgCmPr3PiO/AIe6RYIJmU6vHcSi7TEsXk7XetBhqKpQxsLQVDZ
         8bi1iTunjFT27cJ1CcoywQPojN82mZXaaRElGkaixToWwyQTRUXHt+PwOzICRo4omkDV
         EkqMdf9On3+bAQAxjENWlJlFhE8V5G4Kuu6Z62VwPxqj73tJGLxsFwUsTXLVa1SQkK+x
         StgtTEDriJj1UjMgYas9HxZKI6aKMQCdsITFDO6TVfgHpidODclpoU3UqqJcRhz5gxxQ
         FDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnKagkhm5U6N7QSx0MOcmsmOUR9BRTPQzriDtjeS1mU=;
        b=pPNQ+7lSLSM7K5O2s4wL32T4hhk/T1kF2SYql0VzUYErytvyUCrYA12QRzzlSmkjS9
         W4TLzRV3yefKmns4Eek/PRVTaqylKBiMBa73e87hOtahbA716wUnFaxRdyx8TU7v9fXw
         ZRd7OZKg4D98z1gU/pTvGHi+yNPEVrdIl8Ft6dHaBofihhyf40oxAZH1t49cDKZHRW8q
         go2Tf1D5ojhDytI2y7NPDst2OYVzE+Cu2QQr/l28LHrQ9CZebXmr0Gxq2dYliCusJlI4
         O8DlmQN9OidLbK5xqRcJ8lsDvRBNZUkK/nDiZci5deUoQQhvngCML0JI5F9isMfu0xz7
         Wfrg==
X-Gm-Message-State: APjAAAW3iZYm7PuHdZaReeqbYxewAKYv31dRsQ6NaRiOslknHk2icnaS
        Ti0lFYibqRsOwJqq9VUjubk=
X-Google-Smtp-Source: APXvYqwueDUwMebFGPpRSMD8a45iBen83s2up0ylCN+i6/Qj4hNrmmXUT5IqpWNvMPltuMg3hQtMYg==
X-Received: by 2002:a0c:b6d8:: with SMTP id h24mr59992753qve.178.1558363190254;
        Mon, 20 May 2019 07:39:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.215.206])
        by smtp.gmail.com with ESMTPSA id b11sm8268479qtt.6.2019.05.20.07.39.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 07:39:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37C8F404A1; Mon, 20 May 2019 11:39:43 -0300 (-03)
Date:   Mon, 20 May 2019 11:39:43 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] perf scripts python: Support pyside2 and misc Intel
 PT
Message-ID: <20190520143943.GK8945@kernel.org>
References: <20190412113830.4126-1-adrian.hunter@intel.com>
 <10798ccb-7da8-1f29-2a75-bf3aeeb29c96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10798ccb-7da8-1f29-2a75-bf3aeeb29c96@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 29, 2019 at 10:28:20AM +0300, Adrian Hunter escreveu:
> On 12/04/19 2:38 PM, Adrian Hunter wrote:
> > Hi
> > 
> > Here are patches to add support for pyside2 to the db-export scripts,
> > and a couple of Intel PT patches.
> > 
> > 
> > Adrian Hunter (8):
> >       perf scripts python: exported-sql-viewer.py: Change python2 to python
> >       perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
> >       perf scripts python: exported-sql-viewer.py: Add support for pyside2
> >       perf scripts python: export-to-sqlite.py: Add support for pyside2
> >       perf scripts python: export-to-postgresql.py: Add support for pyside2
> >       perf tools: perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
> >       perf intel-pt: Improve sync_switch
> >       perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
> > 
> >  tools/perf/perf-with-kcore.sh                     |  5 ---
> >  tools/perf/scripts/python/export-to-postgresql.py | 43 +++++++++++++++----
> >  tools/perf/scripts/python/export-to-sqlite.py     | 44 ++++++++++++++++---
> >  tools/perf/scripts/python/exported-sql-viewer.py  | 51 ++++++++++++++++-------
> >  tools/perf/util/intel-pt.c                        | 44 +++++++++++++++++--
> >  5 files changed, 150 insertions(+), 37 deletions(-)
> 
> Are these ok?

Thanks, applied.

- Arnaldo
