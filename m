Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83948C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD0E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHPLIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:08:02 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:43684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfHPLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:08:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A40B5182CED28;
        Fri, 16 Aug 2019 11:08:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scale69_62e0db138c018
X-Filterd-Recvd-Size: 2783
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 16 Aug 2019 11:07:59 +0000 (UTC)
Message-ID: <af4cbaaeb54589a5255bd39baf6bacc2b07bf7b5.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Aug 2019 04:07:58 -0700
In-Reply-To: <13106.1565951791@warthog.procyon.org.uk>
References: <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
         <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <12308.1565876416@warthog.procyon.org.uk>
         <13106.1565951791@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-16 at 11:36 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > Here the script would not convert the /* Fall through */
> > because the next non-blank line does not start with
> > case or default
> 
> Convert the "/* Fall through */" to what?
> 
> You said "for a script to appropriately convert case statement blocks with /*
> fallthrough */ comments to a macro".  Can you give an example of what the code
> would look like with this macro emplaced?

Sure.

The basic idea is to use a macro for __attribute__((__fallthrough__))
like:

#define fallthrough __attribute__((__fallthrough__))

though some would prefer __fallthrough to be more similar to
other attribute macros.  I prefer fallthrough; to be more
similar to break;

So it would end up like (just an example, won't apply)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index b86195e4dc6c..d962332008aa 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -284,7 +284,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
                call->unmarshall++;
 
                /* extract the FID array and its count in two steps */
-               /* fall through */
+               fallthrough;
        case 1:
                _debug("extract FID count");
                ret = afs_extract_data(call, true);
@@ -303,8 +303,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
                        return -ENOMEM;
                afs_extract_to_buf(call, call->count * 3 * 4);
                call->unmarshall++;
-
-               /* Fall through */
+               fallthrough;
        case 2:

