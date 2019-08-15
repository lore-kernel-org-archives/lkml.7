Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2ABC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEAB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHOXqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:46:05 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:35436 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbfHOXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:46:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 918DF18225E1B;
        Thu, 15 Aug 2019 23:46:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheet19_6eed4fd187f5f
X-Filterd-Recvd-Size: 2681
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Aug 2019 23:46:02 +0000 (UTC)
Message-ID: <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Aug 2019 16:46:01 -0700
In-Reply-To: <12308.1565876416@warthog.procyon.org.uk>
References: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <12308.1565876416@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 14:40 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > Make the code a bit easier for a script to appropriately convert
> > case statement blocks with /* fallthrough */ comments to a macro by
> > moving comments describing the next case block to the case statement.
> 
> This doesn't sound good.  Can you give an illustration of what a resulting
> case might look like?  Say taking the following as an example:
> 
> > @@ -282,10 +282,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
> >  	case 0:
> >  		afs_extract_to_tmp(call);
> >  		call->unmarshall++;
> > -
> > -		/* extract the FID array and its count in two steps */
> >  		/* fall through */
> > -	case 1:
> > +	case 1:		/* extract the FID array and its count in two steps */
> >  		_debug("extract FID count");
> >  		ret = afs_extract_data(call, true);
> >  		if (ret < 0)

This case above would not change, but this case below would:

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 114f281f3687..d9dc1bdfa695 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -341,8 +341,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
                }
                /* Fall through */
 
-               /* extract the returned data length */
-       case 1:
+       case 1:         /* extract the returned data length */
                _debug("extract data length");
                ret = afs_extract_data(call, true);
                if (ret < 0)

Here the script would not convert the /* Fall through */
because the next non-blank line does not start with
case or default


