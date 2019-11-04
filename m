Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC61CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52353204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfKDWYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:24:43 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:48872 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729795AbfKDWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:24:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4CF6182CF668;
        Mon,  4 Nov 2019 22:24:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: end02_27dc66145ce01
X-Filterd-Recvd-Size: 2071
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 22:24:33 +0000 (UTC)
Message-ID: <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
Subject: Re: spdxcheck.py complains about the second OR?
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 04 Nov 2019 14:24:23 -0800
In-Reply-To: <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > scripts/spdxcheck.py warns the following two files.
> > 
> > $ ./scripts/spdxcheck.py
> > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
> > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR
> > 
> > I do not understand what is wrong with them.
> > 
> > I think "A OR B OR C" is sane.
> 
> Yes it is, but obviously we did not expect files with 3 possible
> alternative licenses.

Perhaps just this, but the generic logic
obviously isn't complete.
---
 scripts/spdxcheck.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 6374e0..00be34 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -150,6 +150,7 @@ class id_parser(object):
                 | ID WITH EXC
                 | expr AND expr
                 | expr OR expr
+                | expr OR expr OR expr
                 | LPAR expr RPAR'''
         pass
 


