Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4342FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B82190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfJKOGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfJKOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E55A510C051D;
        Fri, 11 Oct 2019 14:05:50 +0000 (UTC)
Received: from krava (unknown [10.40.206.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CFEB45A3;
        Fri, 11 Oct 2019 14:05:49 +0000 (UTC)
Date:   Fri, 11 Oct 2019 16:05:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191011140548.GA20544@krava>
References: <20191007174120.12330-1-andi@firstfloor.org>
 <20191008115240.GE10009@krava>
 <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 14:05:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:21:44AM -0700, Andi Kleen wrote:
> On Tue, Oct 08, 2019 at 01:52:40PM +0200, Jiri Olsa wrote:
> > On Mon, Oct 07, 2019 at 10:41:20AM -0700, Andi Kleen wrote:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > The symbol the feature file checks for is now actually in -lbabeltrace,
> > > not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64
> > > 
> > > Always add both libraries to fix the feature detection.
> > 
> > well, we link with libbabeltrace-ctf.so which links with libbabeltrace.so
> > 
> > I guess we can link it as well, but where do you see it fail?
> 
> On FC30 the .so file is just a symlink, so it doesn't pull
> in the other library.
> 
> $ gcc test-libbabeltrace.c -lbabeltrace-ctf
> /usr/bin/ld:
> /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> undefined reference to `bt_packet_seek_get_error'
> /usr/bin/ld:
> /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> undefined reference to `bt_packet_seek_set_error'
> collect2: error: ld returned 1 exit status

I'm confused,
the test-libbabeltrace.c checks for bt_ctf_stream_class_get_packet_context_type
which is in libbabeltrace-ctf:

	[jolsa@dell-r440-01 feature]$ nm -D /usr/lib64/libbabeltrace-ctf.so | grep bt_ctf_stream_class_get_packet_context_type
	0000000000032960 T bt_ctf_stream_class_get_packet_context_type
	[jolsa@dell-r440-01 feature]$ cat /etc/redhat-release 
	Fedora release 30 (Thirty)
	[jolsa@dell-r440-01 feature]$ rpm -qa | grep  libbabeltrace-1.5.6-2.fc30.x86_64
	libbabeltrace-1.5.6-2.fc30.x86_64

I also get proper feature detection on F30:

	$ make VF=1
	...                 libbabeltrace: [ on  ]


jirka

> 
> $ ls -l /usr/lib64/libbabeltrace-ctf.so
> lrwxrwxrwx 1 root root 26 Jan 31  2019 /usr/lib64/libbabeltrace-ctf.so
> -> libbabeltrace-ctf.so.1.0.0
> 
> $ rpm -qf /usr/lib64/libbabeltrace-ctf.so
> libbabeltrace-devel-1.5.6-2.fc30.x86_64
> 
> -Andi
