Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE14C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935E02186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDEJCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:02:04 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:49794 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfDEJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:02:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id B58511877B;
        Fri,  5 Apr 2019 11:02:01 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xnQSVffxmNWq; Fri,  5 Apr 2019 11:01:58 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id D806918795;
        Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8931E057;
        Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9170B1E04F;
        Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 85185218E;
        Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 751FA80D28; Fri,  5 Apr 2019 11:00:43 +0200 (CEST)
Date:   Fri, 5 Apr 2019 11:00:43 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Add NULL TTY driver
Message-ID: <20190405090043.vnsftwpdm56cx2hr@axis.com>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com>
 <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:39:43AM +0200, Enrico Weigelt, metux IT consult wrote:
> On 03.04.19 16:11, Vincent Whitchurch wrote:
> 
> > Especially on embedded systems, it would be convenient to have a simple
> > way to disable the console (both for kernel and userspace) on a system
> > which normally uses it, to free up the UART for other things.
> 
> Just symlinking to /dev/null does not work ?

No, /dev/null does not support the TTY ioctls.

> OTOH, if you're introducing a dummy console, wouldn't a ringbuffer that,
> can be read out later, a better option ?

There is already a ttyprintk driver in mainline to send these messages
to the printk ring buffer if one is actually intrested in what is
written to the console.  There's no option to enable it via console= in
mainline but I have a patch for that too.
