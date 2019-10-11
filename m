Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7048C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBF20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJKDXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:23:51 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:60053 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbfJKDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:23:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6C2C6181D33FC;
        Fri, 11 Oct 2019 03:23:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fire16_2146810e4a71c
X-Filterd-Recvd-Size: 1756
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 03:23:48 +0000 (UTC)
Message-ID: <8720b5d432ca5ba5e128c241efee22674e012af8.camel@perches.com>
Subject: Re: checkpatch: comparisons with a constant on the left
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 20:23:47 -0700
In-Reply-To: <20191011015225.GA27495@jagdpanzerIV>
References: <20191011015225.GA27495@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 10:52 +0900, Sergey Senozhatsky wrote:
> Hi Joe,

Hi Sergey.

> I noticed that this code
> 
> 	#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 18, 0)
> 
> triggers checkpatch's warning:
> 
> 	"WARNING: Comparisons should place the constant on
> 		  the right side of the test"
> 
> Both LINUX_VERSION_CODE and KERNEL_VERSION are constants, so
> I'm wondering if it's worth it to improve that check a tiny
> bit.

Probably not.

My preference is for people to ignore checkpatch
message bleats when they don't make overall sense.

checkpatch thinks anything that uses a form like
"name(<args...>)" is a function.

> I'm sure you'll have a better idea.

I suggest reversing the test if it really bothers you.

# if KERNEL_VERSION(4.18.0) < LINUX_VERSION_CODE

but then again just using LINUX_VERSION_CODE emits a
warning message, so it's better to remove whatever is
in the block anyway... <smile>

cheers, Joe

