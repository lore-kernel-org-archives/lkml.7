Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF725C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1982082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfDMQ5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:57:31 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:55150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727048AbfDMQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:57:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 068CB100E86C3;
        Sat, 13 Apr 2019 16:57:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: place65_5e71ef0784718
X-Filterd-Recvd-Size: 1951
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Apr 2019 16:57:28 +0000 (UTC)
Message-ID: <fc4a23f95ba26f308b3a00eed5141051dc40324b.camel@perches.com>
Subject: Re: [PATCH 1/2] driver core: printk to pr_*
From:   Joe Perches <joe@perches.com>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Sat, 13 Apr 2019 09:57:27 -0700
In-Reply-To: <20190412154753.ouafktmagb3sw6gj@macpro-scc.lancs.ac.uk>
References: <20190412154753.ouafktmagb3sw6gj@macpro-scc.lancs.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-12 at 16:47 +0100, Willy Wolff wrote:
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>

Most people seem to prefer some type of commit message before
your sign-off.

And trivia:

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
[]
> @@ -602,8 +601,8 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>  	ret = really_probe(dev, drv);
>  	rettime = ktime_get();
>  	delta = ktime_sub(rettime, calltime);
> -	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
> -	       dev_name(dev), ret, (s64) ktime_to_us(delta));
> +	pr_debug("probe of %s returned %d after %lld usecs\n",
> +		 dev_name(dev), ret, (s64) ktime_to_us(delta));

While I think this particular change is fine, and you may
already know this, but converting a
	printk(KERN_DEBUG ...)
to
	pr_debug(...)
changes object code and output.

The first is always emitted, the second is not emitted
unless DEBUG is defined or CONFIG_DYNAMIC_DEBUG is enabled.  

Your commit message should show this understanding.


