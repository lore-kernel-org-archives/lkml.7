Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596EEC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BB82082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+s/5d1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKYJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:28:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbfKYJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574674083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MI+IIVM68DkP2rM/tD2IsV9b/0Cz99N2MtX9/Xh5IZ8=;
        b=S+s/5d1sNTt0o9hSKtzFYljfzEKjHciYQNftq/xrFl09CugbaheoBzTrP1ETdkKNqfQfkh
        /DtPucYNZ+zSoO0zqvLQXoDZwBQJkUt9AlY+EoDc7XJWf24cThozfeh/Rm/ytMkykN0ZiG
        8q9nZJlmbiFG/NKxTl3VMbKHXyYUX7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-FaI1VS5AM4i_xS2_7jN2sg-1; Mon, 25 Nov 2019 04:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4C81107ACE8;
        Mon, 25 Nov 2019 09:28:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 749165D9CA;
        Mon, 25 Nov 2019 09:27:59 +0000 (UTC)
Date:   Mon, 25 Nov 2019 10:27:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191125092758.GA4675@krava>
References: <20191018002757.4112-1-changbin.du@gmail.com>
 <20191123040910.dfi65lbev7ydtbdo@mail.google.com>
MIME-Version: 1.0
In-Reply-To: <20191123040910.dfi65lbev7ydtbdo@mail.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FaI1VS5AM4i_xS2_7jN2sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 04:09:10AM +0000, Changbin Du wrote:
> Hi Jiri, In case you missed this one in your mailbox. :)

sry I mised this and can't apply this anymore.. could you please
rebase it to current Arnaldo's perf/core?

thanks,
jirka

>=20
> On Fri, Oct 18, 2019 at 08:27:55AM +0800, Changbin Du wrote:
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> >=20
> > v5:
> >   o doc default log path.
> > v4:
> >   o fix another segfault.
> > v3:
> >   o fix a segfault issue.
> > v2:
> >   o specific all debug options one time.
> >=20
> > Changbin Du (2):
> >   perf: support multiple debug options separated by ','
> >   perf: add support for logging debug messages to file
> >=20
> >  tools/perf/Documentation/perf.txt |  16 ++--
> >  tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
> >  2 files changed, 92 insertions(+), 48 deletions(-)
> >=20
> > --=20
> > 2.20.1
> >=20
>=20
> --=20
> Cheers,
> Changbin Du
>=20

