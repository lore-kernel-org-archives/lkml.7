Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A56C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D51E229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="onQS0xZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfGYVz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:55:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40742 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfGYVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fzoi6WTT/aaFWW+EuhftGIjPkQCTrBX+tQdM10oXzQs=; b=onQS0xZQENxHyCKqj50vHJgse
        VJTs1WxUKipVOOxrF17e1WtWT2eO9I0521g1Q/wxP2XCIF0Lp2s8fsl0LIn8HMInkmfMIExs94tNr
        IPCIDuPYtKWQcJFT0pSUPHlvA05IvoViM2QLHeEKDW4tDIBV+jn4eDZMgQrjL9iTR4DA4WyYfZDNf
        A/5HlTli48G/GAXowpO5qTNxrRMg0DvqPjieKrU3dYgIrWeDpp6uU3loaHQGfNFta3rxscJdPmjhZ
        KRwRlhmzN2JUYBLFZXVffXFUmYB61SLAwt/2ST9vZUFjtCrECRQHvpATZnm+MqeXjRvLgFhOuiPZA
        uqd3FBcoA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:44660)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hqliC-0002Xi-5p; Thu, 25 Jul 2019 22:55:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hqli8-00062p-5X; Thu, 25 Jul 2019 22:55:40 +0100
Date:   Thu, 25 Jul 2019 22:55:40 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: Fix null die() string for unhandled data and
 prefetch abort cases
Message-ID: <20190725215540.GM1330@shell.armlinux.org.uk>
References: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
 <20190720123023.GA1330@shell.armlinux.org.uk>
 <20190725213754.GA29898@mam-gdavis-lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725213754.GA29898@mam-gdavis-lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:37:54PM -0400, George G. Davis wrote:
> Hello Russell,
> 
> Thanks for your prompt reply!
> 
> On Sat, Jul 20, 2019 at 01:30:23PM +0100, Russell King - ARM Linux admin wrote:
> > On Fri, Jul 19, 2019 at 10:32:55PM -0400, George G. Davis wrote:
> > > When an unhandled data or prefetch abort occurs, the die() string
> > > is empty resulting in backtrace messages similar to the following:
> > > 
> > > 	Internal error: : 1 [#1] PREEMPT SMP ARM
> > > 
> > > Replace the null string with the name of the abort handler in order
> > > to provide more meaningful hints as to the cause of the fault.
> > 
> > NAK.
> > 
> > We already print the cause of the abort earlier in the dump, and we've
> > also added a "cut here" marker to help people include all the necessary
> > information when reporting a problem.
> 
> For what it's worth, I often receive crash dumps which lack the pr_alert
> messages and only include the pr_emerg messages which this change would at
> least provide extra hints, since the "Internal error" as at EMERG level
> wereas the initial messages are only at ALERT level. It's subtle but for
> cases where the end user has set loglevel such that they only see EMERG
> messages, the change is helpful, to me at least.
> 
> > It's unfortunate that we have the additional colon in the oops dump,
> 
> Agreed, it's rather unfortunate that the string is NULL in these cases.
> 
> > but repeating the information that we've printed on one of the previous
> > two lines is really not necessary.
> 
> It depends on the loglevel the user has set. So perhaps it's not such a
> bad thing to repeat the information?

Or maybe we should arrange for consistent usage of the log levels?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
