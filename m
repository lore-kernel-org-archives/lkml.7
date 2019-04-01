Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A9206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554137945;
	bh=OgSS/Dnu9EVnhraInl2aMHUtMTzuniAfoseu5t+mJIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h44ZiXlztnxNGgiboSBdOdxHe1DOx+D1V+ey5a3+u6SvA4ojUh3NLV3otTpA9iNi+
	 tpqByHIIz6XryITtoqKpkdUTaXDVBUeh0ICXZ4w11cOufD+2d2HGotOH1K76vJtzUD
	 sKjCOZC6uXcPAF6a8CJCedZXFWLf+YQYF6tCuZks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfDAQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfDAQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:59:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C466B206B6;
        Mon,  1 Apr 2019 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554137941;
        bh=OgSS/Dnu9EVnhraInl2aMHUtMTzuniAfoseu5t+mJIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYbZeeYtxpse1wRg4cMRQi1N0Sq8z/5vupp4RvtYf1feHh4Q/kaefEG+asw1HHEpU
         onHshLm7++WQ1vvY0xVAB5/Uh42nbmiyOxxefKcp4E0PxbdEtnzcJ9vrNTN1EE5Car
         KcWDcPjaezk5b/FIug5b5kTZFozEgbgI+57HMxZI=
Date:   Mon, 1 Apr 2019 18:58:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: missing patch
Message-ID: <20190401165853.GA1929@kroah.com>
References: <CADqhmmcCA_UjV899cHn8SOTSp89BvjMgnd5TcijCWqp6KnhdJw@mail.gmail.com>
 <20190401160629.GA20725@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401160629.GA20725@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 06:06:29PM +0200, Greg KH wrote:
> On Sat, Mar 30, 2019 at 06:13:16PM +0200, Evalds Iodzevics wrote:
> > Hi back in the December of 2016 there was commit
> > "1c52d859cb2d417e7216d3e56bb7fea88444cec9"
> > 
> > witch was followed shortly by  "c198b121b1a1d7a7171770c634cd49191bac4477"
> > 
> > Unfortunately only the first commit was later included in long-term kernel
> > branches such as 4.4 and 4.9 witch left some of microcode functionality
> > broken on 32 bit systems
> > 
> > I guess it should be easily fixed by including
> > "c198b121b1a1d7a7171770c634cd49191bac4477" in those branches
> 
> Now queued up, thanks!

Hm, no, it causes a bunch of build warnings that look like things are
about to break:
arch/x86/kernel/alternative.o: warning: objtool: do_sync_core()+0x1b: unsupported instruction in callable function
arch/x86/kernel/alternative.o: warning: objtool: text_poke_early()+0x83: unsupported instruction in callable function
arch/x86/kernel/alternative.o: warning: objtool: apply_alternatives()+0x366: unsupported instruction in callable function
arch/x86/kernel/alternative.o: warning: objtool: text_poke()+0x196: unsupported instruction in callable function

So I'm going to drop this patch from both trees now.  Can you provide a
working backported version, or find what else needs to be applied as
well for this patch?

thanks,

greg k-h
