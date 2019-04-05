Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1921855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7wtC6fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDEXK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:10:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEXK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4uPEFjI26CdrZO1+hQCYaNO97SmBbyFBxeR8pvlemBk=; b=W7wtC6fTAnbedRNUPmRjl3ZIP
        bYIykBLVZyflrKrIkmKXzv172A3oxW6wsA12GN6E/b67dRSAkmyEvnAyPTNE03MMOQ/a/F6BxvkHO
        yZVyEdB6X+dGhcb913IcLHnYvF9udUeeo1TLmZp9MXLoO0jmWuFlan0AxLxVN4PG6gl1NHlWo0Kq4
        UwqOzpG/Y0aKP0Cke+X9asOjnCOyzujGImMK5amP1nBoNhJYhQ7mYHTBo3Duf2kNYDh4RhJIM9KnE
        Y5gL8tslDU3bx67yeWoFa8sBdX5jrOUJDNVaVcGHeO6xnbF/86MyhbWbOsh3TfIel6cL6Z97A2N7m
        E3vyg0XTQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCXyc-0007th-7n; Fri, 05 Apr 2019 23:10:26 +0000
Date:   Fri, 5 Apr 2019 16:10:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Let backtick and backslash escape percent
 sign
Message-ID: <20190405231024.GR22763@bombadil.infradead.org>
References: <20190405211820.17617-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405211820.17617-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:18:20PM -0700, Sean Christopherson wrote:
> There are a handful of instances where kernel doc comments want an
> actual '%' in the final output, e.g. vsnprintf() wants to display "%n"
> and "%p" to document format specifiers, and assembly functions that use
> a custom call ABI may want to document their register usage, e.g. %eax.
> 
> Because kernel-doc unconditionally interprets '%' followed by a word
> character as a constant definition, i.e. %CONST, it's impossible to get
> an actual '%\w' when kernel-doc is used to translate comments into rst
> format.  Treat backtick and backlash as escaping '%', the former to
> handle '%' in a ``LITERAL``, and the latter to allow '%' when using
> standard formatting.
> 
> An alternative option would be to define a fancier set of rules for
> interpreting '%' so that explicit escaping would not be required.  For
> example, require "%CONST" to be preceded by a recognized set of
> characters, e.g. whitespace, opening parenthesis, etc...  But the list
> of recognized characters is quite large even in the current code base,
> and using '\' to escape is more common and intuitive, i.e. most people
> will naturally try doing "\%..." to get the desired formatting, whereas
> losing %CONST formatting because of an unrecognized character is likely
> to cause confusion.

Would it make sense to have %% turn into % rather than forcing quotation
marks?
