Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C5DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E463217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFtrkQ7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfK2Ntn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:49:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50669 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbfK2Ntn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575035381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xCy0nxTbAZVp5vEUkYIW3ozNj+sxeQG2POsXKW5FaE=;
        b=OFtrkQ7dHOKU/FvtLR7+oK4AeWkzlMISiPyJj4Cf25sqhjzONSfK8/bBjiI6hEbvhFBq56
        JoeDWA6jc5lWe+x3+4Us1Ag9/VgEd+FDRdK/CNyo7WkADZjsoKZTgg79Y1s9g2fjxDJrgP
        GP83JG+xBylRHd0PyyqiLr/GsB3ZWjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-QijvxbDoNciiPLjItl4oYQ-1; Fri, 29 Nov 2019 08:49:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B86910054E3;
        Fri, 29 Nov 2019 13:49:32 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id B182460BF1;
        Fri, 29 Nov 2019 13:49:30 +0000 (UTC)
Date:   Fri, 29 Nov 2019 14:49:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: perf is unable to read dward from go programs
Message-ID: <20191129134929.GA26903@krava>
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QijvxbDoNciiPLjItl4oYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:15:20PM -0800, Ivan Babrou wrote:
> There were no response in linux-perf-users@, so I think it's fair to
> ask maintainers.
>=20
> On Fri, Nov 8, 2019 at 3:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > I have a simple piece of code that burns CPU for 1s:
> >
> > * https://gist.github.com/bobrik/cf022ff6950d09032fa13a984e2272ed
> >
> > I can build it just fine: go build -o /tmp/burn burn.go
> >
> > And I can see correct stacks if I record with fp:
> >
> > perf record -e cpu-clock -g -F 99 /tmp/burn
> >
> > But if I record with gwarf:
> >
> > perf record -e cpu-clock -g -F 99 --call-graph dwarf /tmp/burn
> >
> > Then stacks are lost with the following complaints during "perf script"=
:
> >
> > BFD: Dwarf Error: found dwarf version '376', this reader only handles
> > version 2, 3 and 4 information.
> > BFD: Dwarf Error: found dwarf version '31863', this reader only
> > handles version 2, 3 and 4 information.
> > BFD: Dwarf Error: found dwarf version '65271', this reader only
> > handles version 2, 3 and 4 information.
> > BFD: Dwarf Error: found dwarf version '289', this reader only handles
> > version 2, 3 and 4 information.

hi,
the binary generated by go has compressed debug info (on my setup)
and libunwind (default dwarf unwinder) does not seem to support that

but when I compile perf with libdw unwind support:

  $ make DEBUG=3D1 VF=3D1 NO_LIBUNWIND=3D1

I'm getting proper backtraces (below), maybe it's time to change
the default dwarf unwinder ;-)

thanks,
jirka


---
    51.63%  ex       ex                [.] crypto/sha512.blockAVX2
            |
            ---crypto/sha512.blockAVX2
               |         =20
                --51.48%--crypto/sha512.block
                          crypto/sha512.(*digest).Write
                          crypto/sha512.(*digest).checkSum
                          crypto/sha512.(*digest).Sum
                          main.burn
                          main.main
                          runtime.main
                          runtime.goexit

    11.55%  ex       ex                [.] runtime.mallocgc
            |
            ---runtime.mallocgc
               |         =20
               |--7.45%--runtime.newobject
               |          |         =20
               |           --7.45%--main.burn
               |                     main.main
               |                     runtime.main
               |                     runtime.goexit
               |         =20
                --3.40%--runtime.growslice
                          crypto/sha512.(*digest).Sum
                          main.burn
                          main.main
                          runtime.main
                          runtime.goexit

     3.69%  ex       ex                [.] crypto/sha512.(*digest).Write
            |
            ---crypto/sha512.(*digest).Write
               |         =20
               |--2.91%--crypto/sha512.(*digest).checkSum
               |          crypto/sha512.(*digest).Sum
               |          main.burn
               |          main.main
               |          runtime.main
               |          runtime.goexit
               |         =20
                --0.57%--main.burn
                          main.main
                          runtime.main
                          runtime.goexit

     3.44%  ex       ex                [.] runtime.memclrNoHeapPointers
            |
            ---runtime.memclrNoHeapPointers
               |         =20
                --2.92%--runtime.(*mheap).alloc
                          runtime.(*mcentral).grow
                          runtime.(*mcentral).cacheSpan
                          runtime.(*mcache).refill
                          runtime.(*mcache).nextFree
                          runtime.mallocgc
                          |         =20
                          |--2.27%--runtime.newobject
                          |          main.burn
                          |          main.main
                          |          runtime.main
                          |          runtime.goexit
                          |         =20
                           --0.64%--runtime.growslice
                                     crypto/sha512.(*digest).Sum
                                     main.burn
                                     main.main
                                     runtime.main
                                     runtime.goexit
...

