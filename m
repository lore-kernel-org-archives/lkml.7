Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BE42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552487819;
	bh=A3Gte8lDDNh0I5q4tokM3IJevhgw3hMXZxSNRnO1M1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EguVD83pqVok8NJ4OsXveH/HT2V09kdwVuSwbVMQQVy1ur5B/XsPoA/eyLyX7A4is
	 IRLJ2GsJIJt2qUyvTUI+0mXBtYCs8j5d+puxDCWlRviwMNAQ80tfqqCJmg2S5bqILj
	 LOHwz4ZXKqhlbnjpC9Cz9kK+JNcGLY/fL2Ieeu8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCMOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:36:55 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFEC22087C;
        Wed, 13 Mar 2019 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552487814;
        bh=A3Gte8lDDNh0I5q4tokM3IJevhgw3hMXZxSNRnO1M1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1oj1KoIZSQzbdIP0jX4/DVh2EEROukAvWkvJtyTnzsYMvcH9wTMojdEIIT09ZHF8
         m+wZbnT7O03migW/aVvKjvS2Grxzd9G06LtppNe1WHUUJwrEDvoNvwOP7y/SMOa7cq
         qG5pJkFSYxS/GGxtfuSKChJfMX1+pYG+4SUlze1I=
Date:   Wed, 13 Mar 2019 07:36:54 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Message-ID: <20190313143654.GA7489@kroah.com>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:59:53AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 12.03.19 17:33, Greg KH wrote:
> > On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> ---
> >>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > No changelog or signed-off-by, sorry, please fix up the series and
> > resend.
> 
> Maybe the threading got messed up somehow (at least my tbird doesn't
> show it correctly), so you've probably didn't see my intro letter: there
> I wrote that this is yet WIP, not meant for actual submission, instead
> just to ask you folks whether my approach in general would be work.
> 

Threading worked just fine, but you still shouldn't send out patches
like this without any independant information in the patch itself saying
what it does and what it is for.  That's just bad engineering :)

Also, usually RFC like patches and series are ignored, I know I almost
always ignore them because if the author doesn't think they are ready to
be reviewed, why would I spend time on them compared to other patches
that their authors think are ready for review.

Remember, patch review is the most limited resource we have.

thanks,

greg k-h
