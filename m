Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC942C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1821537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560521168;
	bh=HvW4i1HSdGzIPSWAaduqcsQ2yNdYu3HmAf+Hbrmp8Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lWoWnh9ZuiWFfih+jpm5dSQiabUhdvRbtAWaKKjp4oag6JQP/k15nzC4VWI97l3j3
	 MeWYegbJa/o9DOsQSXzi7qt9WDpJWiVjQ/smmSYFFHh9zhIENoEz+aLiT7mlUzjPa/
	 jLtV0gYM8HsKDskDNRwX/H6w1QWswTaw4YWh6oaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfFNOGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfFNOGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959B920851;
        Fri, 14 Jun 2019 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560521166;
        bh=HvW4i1HSdGzIPSWAaduqcsQ2yNdYu3HmAf+Hbrmp8Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn/+N3KZQ+DBDA6jQ46F5+/XfPDsFAsZnoYWimfUop5680wrZeSFNSj9knmV0QR6g
         baEv3/NjYPJnk33eXXuD9vg5nXwXnKemQ+ZXTGMU8HS6ejp0M37qGcPylpliQBSGB2
         uxATOx32ADuHGWm9Xj7Av+1NtfajxgCH95PVynYg=
Date:   Fri, 14 Jun 2019 16:06:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190614140603.GB7234@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
 <87o930uvur.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o930uvur.fsf@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:
> On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> >
> > As we don't want a generic Sphinx extension to execute commands,
> > change the one proposed to Markus to call the abi_book.pl
> > script.
> >
> > Use a script to parse the Documentation/ABI directory and output
> > it at the admin-guide.
> 
> We had a legacy kernel-doc perl script so we used that instead of
> rewriting it in python. Just to keep it bug-for-bug compatible with the
> past. That was the only reason.
> 
> I see absolutely zero reason to add a new perl monstrosity with a python
> extension to call it. All of this could be better done in python,
> directly.
> 
> Please don't complicate the documentation build. I know you know we all
> worked hard to take apart the old DocBook Rube Goldberg machine to
> replace it with Sphinx. Please don't turn the Sphinx build to another
> complicated mess.
> 
> My strong preferences are, in this order:
> 
> 1) Convert the ABI documentation to reStructuredText

What would that exactly look like?  What would it require for new
developers for when they write new entries?  Why not rely on a helper
script, that allows us to validate things better?

> 2) Have the python extension read the ABI files directly, without an
>    extra pipeline.

He who writes the script, get's to dictate the language of the script :)

Personally, this looks sane to me, I'm going to apply the ABI fixups to
my tree at least, and then see how the script works out.  The script can
always be replaced with a different one in a different language at a
later point in time of people think it really mattes.

thanks,

greg k-h
