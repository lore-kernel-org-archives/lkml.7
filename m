Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA6FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911422473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573216620;
	bh=w5zfCeUX9i5B82TJRkTa+MWcnAYSb0as6CxzkjQ/Mfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKew5faG8Cr6xP21oNVE3cIROVdD9YzbA3lghE3j9QdgYPoGJ18aLCLXCC9Nr1iIn
	 KzO7jvuR7rOky2hV8eGGDITw1VezK+uvQpLpHQX4w8r57maq5ES5TWCjJVmUPjt5DP
	 Yr7pelaM1O2co2vSE0uvcxB0btZf9GihUh215lTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKHMg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfKHMg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:36:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5B3222CE;
        Fri,  8 Nov 2019 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573216617;
        bh=w5zfCeUX9i5B82TJRkTa+MWcnAYSb0as6CxzkjQ/Mfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGnAKLwSEjwEZR42zMQWeWurK04crK14YZvSXe3pOdSajfzC9qmC9WCrUsZMNZoaX
         t9AiUOSFEle3OE2ai8ZN0gPsksifXgPNK8WqkRfI317IX+wRm7fRZBJatbsdxmVE6t
         xHg/9x5YVUyEWC6xPTFHZRhI818qbyY+6lTFHVNo=
Date:   Fri, 8 Nov 2019 13:36:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] interconnect changes for 5.5
Message-ID: <20191108123655.GA733294@kroah.com>
References: <dd4ff7e3-920d-979b-c29b-7535d84d360f@linaro.org>
 <20191108105355.GA683899@kroah.com>
 <25808ada-dbe6-db38-c68d-26a263942a28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25808ada-dbe6-db38-c68d-26a263942a28@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 01:47:51PM +0200, Georgi Djakov wrote:
> On 8.11.19 г. 12:53 ч., Greg Kroah-Hartman wrote:
> > On Fri, Nov 08, 2019 at 10:59:11AM +0200, Georgi Djakov wrote:
> >> Hi Greg,
> >>
> >> This is the updated pull request with interconnect patches for the 5.5 merge
> >> window. The details are in the signed tag. Please pull into char-misc-next.
> > 
> > Ugh, ok, can we just go back to sending patches instead?
> > 
> > The first two patches have "Fixes:" tags for older kernels, yet no
> > stable tags.  That's not ok.
> 
> These two patches are for the current 5.4 release and you have them in your
> char-misc-linus branch already. I assume that you will get them in -next later
> via back merge anyway, so will drop them.

Ah, yeah, that's odd, don't send me stuff like that unless there is a
build dependency on them.

> Should we use Fixes and stable tags always together and only when we fix
> something in older kernels and not in the current one?

stable, no, fixes is fine.  It wasn't obvious that these were already in
another branch of mine.

Because of all of this, let's just stick to patches in emails please.

thanks,

greg k-h
