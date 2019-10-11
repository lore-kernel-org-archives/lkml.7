Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1679921D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570795642;
	bh=luSFrTkBXjevkpaPvjpFIgRDMR8A/l9LbZkUpNdfjqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hiwFr5NTRoHgEBywSWBMGTy9zSA2kmwYHbNoKH39OuECPtvigscXPC+uF80Ajx/Av
	 X2IuiSxB90YjEdAuW8Kn1IvLtdfbpCBYTavIAs/39z93Ml0GhgVQcc5mb1Bt0DTsAz
	 fzVBPAFhsSBi83HQnzwd/MIJT0dGbAzCJ8JOn5MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJKMHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:07:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8858F214E0;
        Fri, 11 Oct 2019 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570795640;
        bh=luSFrTkBXjevkpaPvjpFIgRDMR8A/l9LbZkUpNdfjqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StRBtloyZl+V2nooPzdDNkLeY8Q4RNnUXngMumOm1NmCO/jAbLVdStLemjlsMRsaR
         6PJ+fO0t/wk6xuELos57cHKMIchR/bo8EXVkZKNHfLrg1GUu9jJLZCkH4mGUn03jsz
         iUahYDmgI9vAejsgc4bHuUrEh+kFy7k+pe8MwwTo=
Date:   Fri, 11 Oct 2019 14:07:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: rtl8723bs: Remove comparisons to NULL in
 conditionals
Message-ID: <20191011120717.GA1143018@kroah.com>
References: <cover.1570712632.git.wambui.karugax@gmail.com>
 <f4752d3a49e02193ed7b47a353e18e56d94b5a68.1570712632.git.wambui.karugax@gmail.com>
 <20191011105404.GA4774@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011105404.GA4774@kadam>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:54:04PM +0300, Dan Carpenter wrote:
> On Thu, Oct 10, 2019 at 04:15:29PM +0300, Wambui Karuga wrote:
> >  	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
> > -	if (psetauthparm == NULL) {
> > -		kfree(pcmd);
> > +	if (!psetauthparm) {
> > +		kfree((unsigned char *)pcmd);
> 
> This new cast is unnecessary and weird.

Ah, I missed that, good catch.  I'll go drop this patch now.

Wambui, please fix up and resend.

thanks

greg k-h
