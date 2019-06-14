Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC7021848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560529468;
	bh=xnWJKgxlyuDpxuaPpWBR3nadN54eq+EqhsndI/EVnGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTOlao6PDQQ9bA/S1H52LzJ0owDAldCiDjOSstNeNVHXL/GeVEoj0BUwQFASYH3w7
	 yePMtoKPFwYfg34d2TvGwXil982/NBftbs2sUVPrCByOnQhgfuYsLGWL9QXMH/Yh7a
	 iWue/zLJ7WZ2UMnhEHthDlkD9Xhc1qqqALeQO4dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfFNQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:24:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9AD21537;
        Fri, 14 Jun 2019 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560529465;
        bh=xnWJKgxlyuDpxuaPpWBR3nadN54eq+EqhsndI/EVnGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqhNNRH8MfD7miy8rdc3nJEXAyrL7uP75s5goRv0a9I6G4FuDg6NyZfmXlvaQrW5u
         N7VZm7SCVBMaKySs/tz/6lATlBaLCYUrU/K4TJAev11hC5NmdZhFcx/stkphOH23c0
         YwsMXVsMJ0mWiTBBkyRfpBhwPF6LUAx6BQWLlEMc=
Date:   Fri, 14 Jun 2019 18:24:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/14] scripts: add an script to parse the ABI files
Message-ID: <20190614162422.GA25680@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org>
 <87r27wuwc3.fsf@intel.com>
 <20190614133933.GA1076@kroah.com>
 <87lfy4uuzs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfy4uuzs.fsf@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:00:55PM +0300, Jani Nikula wrote:
> On Fri, 14 Jun 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jun 14, 2019 at 04:31:56PM +0300, Jani Nikula wrote:
> >> On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> >> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >> >
> >> > Add a script to parse the Documentation/ABI files and produce
> >> > an output with all entries inside an ABI (sub)directory.
> >> >
> >> > Right now, it outputs its contents on ReST format. It shouldn't
> >> > be hard to make it produce other kind of outputs, since the ABI
> >> > file parser is implemented in separate than the output generator.
> >> 
> >> Hum, or just convert the ABI files to rst directly.
> >
> > And what would that look like?
> 
> That pretty much depends on the requirements we want to set on both the
> ABI source files and the generated output. Obviously the requirements
> can be conflicting; might be hard to produce fancy output if the input
> is very limited.
> 
> At the bare minimum, you could convert the files to contain
> reStructuredText field lists [1]. Add a colon at the start of the field
> name, and make sure field bodies (values) are not empty.
> 
> Conversion of a file selected at random; I've only added ":" and "N/A".

N/A should be allowed to just drop the line entirely, right?

And what does this end up looking like?

I also hate "flag days" where all of a chunk of stuff needs to be
converted into another style.  Also it doesn't deal with merges from the
100+ different trees that all end up adding stuff to this directory over
time (slowly though, unfortunately)

So ideally, I'd like to keep the original format if at all possible.
Having the tool here allows people to do nice things like search for a
specific file easily, or a device type, which is something that I know I
have wanted, and others have asked for in the past as well.

It also might allow us to find out where we are missing documentation, a
long-term goal of mine.

thanks,

greg k-h
