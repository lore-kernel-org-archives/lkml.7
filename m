Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE196C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967182187F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfHaUcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 16:32:06 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:41973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbfHaUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:32:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B1B09182CED28;
        Sat, 31 Aug 2019 20:32:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sleet46_4c2e89b9f004e
X-Filterd-Recvd-Size: 2290
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 31 Aug 2019 20:32:03 +0000 (UTC)
Message-ID: <762056d9c081c40f3fc760c9af79d6851f0a65e5.camel@perches.com>
Subject: Re: [PATCH v3 09/11] Input: alps - remove unlikely() from IS_ERR*()
 condition
From:   Joe Perches <joe@perches.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Denis Efremov <efremov@linux.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-input@vger.kernel.org
Date:   Sat, 31 Aug 2019 13:32:02 -0700
In-Reply-To: <20190831152500.eg7xqo5ace6wu427@pali>
References: <20190829165025.15750-1-efremov@linux.com>
         <20190829165025.15750-9-efremov@linux.com>
         <20190829175039.GA187474@dtor-ws> <20190831152500.eg7xqo5ace6wu427@pali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 17:25 +0200, Pali Rohár wrote:
> On Thursday 29 August 2019 10:50:39 Dmitry Torokhov wrote:
> > On Thu, Aug 29, 2019 at 07:50:23PM +0300, Denis Efremov wrote:
> > > "unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already uses
> > > unlikely() internally.
> > 
> > The keyword here is _internally_.
> > 
> > https://lore.kernel.org/lkml/20190821174857.GD76194@dtor-ws/
> > 
> > So please no.

I think it poor form not to simply restate your original
objection from 4 message levels below this link

https://lists.gt.net/linux/kernel/2269724

   Hm... I do not like this change. If I read code 
    
    if (unlikely(IS_ERR_OR_NULL(priv->dev3))) 
    
   then I know that it is really unlikely that condition will be truth and 
   so this is some case of error/exception or something that normally does 
   not happen too much. 
    
   But if I read code 
    
    if (IS_ERR_OR_NULL(priv->dev3)) 
    
   I know nothing about chance that this condition will be truth. Explicit 
   unlikely in previous example give me more information. 
    
I alslo think this argument is dubious as it also applies
to any IS_ERR and all the unlikely uses have been removed
from those.


