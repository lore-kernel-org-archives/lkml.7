Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE20C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC192054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uNEVcBRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCWEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:04:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S1Z68NfE9bNYehM0kLb1gbJm3la0hffxhAqrAk/KpBs=; b=uNEVcBRmP/7cpAOiwdSQ+1FfJW
        yMm97MfI/WsBKdIH214GiHXKA++oOD1ND7RbM8YrWboBursuAdHnkAtnkiOiSJm7Cb0aUlel7oe08
        1QPBfp2DV0pQLe8tAm2kOaA7WhHiJ64g2bi6UcKALPAVEC9mMImxYEW0rv18owVWhvxrrXP3pLg5i
        eEwfkiu7YdZYqQrVLyXYFZO4/DCz86nbR/jF6yw3qzw3Abq9G66hyqDEReDt/SwR+JPvjrLMaMbPD
        uUoifbiX6YmqusZrQNaBZD3TIG0JWPT0g89B9dB6j6Gz9LvsRsTv0HsUuUlOZRqJPHlqZbm8b4hQx
        86QCmReg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBnzD-0002hc-Ow; Wed, 03 Apr 2019 22:03:59 +0000
Date:   Wed, 3 Apr 2019 15:03:58 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Mario.Limonciello@dell.com
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
Message-ID: <20190403220358.GD39081@wrath>
References: <1553696734-31282-1-git-send-email-mario.limonciello@dell.com>
 <20190403202338.GB39081@wrath>
 <643bcf131bc642cb821ba57f69707fc9@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <643bcf131bc642cb821ba57f69707fc9@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:54:27PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Darren Hart <dvhart@infradead.org>
> > Sent: Wednesday, April 3, 2019 3:24 PM
> > To: Limonciello, Mario
> > Cc: Andy Shevchenko; LKML; platform-driver-x86@vger.kernel.org
> > Subject: Re: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Wed, Mar 27, 2019 at 09:25:34AM -0500, Mario Limonciello wrote:
> > > When converting the driver two arguments were transposed leading
> > > to rfkill not working.
> > >
> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201427
> > > Reported-by: Pepijn de Vos <pepijndevos@gmail.com>
> > > Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM calls")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > Acked-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > Looks like this broken in 4.14? So Cc stable back to then? I'm surprised it's
> > been broken that long :-(
> > 
> 
> Not many "newer" platforms actually use this radio control anymore.  It's been
> superseded by other technologies.  So I think that would be the main reason.
> 
> Can you CC it to stable when it's committed or do I need to re-send or anything?
> 

I will add the Cc to stable. Just wanted to confirm our expectations were
aligned.

-- 
Darren Hart
VMware Open Source Technology Center
