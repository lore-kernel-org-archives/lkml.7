Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DE20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDHJ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:58:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:18639 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfDHJ6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:58:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 02:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="162361982"
Received: from cbackhau-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.45.163])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2019 02:58:07 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Let backtick and backslash escape percent sign
In-Reply-To: <20190405231024.GR22763@bombadil.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190405211820.17617-1-sean.j.christopherson@intel.com> <20190405231024.GR22763@bombadil.infradead.org>
Date:   Mon, 08 Apr 2019 12:58:17 +0300
Message-ID: <87sgusizt2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, Apr 05, 2019 at 02:18:20PM -0700, Sean Christopherson wrote:
>> There are a handful of instances where kernel doc comments want an
>> actual '%' in the final output, e.g. vsnprintf() wants to display "%n"
>> and "%p" to document format specifiers, and assembly functions that use
>> a custom call ABI may want to document their register usage, e.g. %eax.
>> 
>> Because kernel-doc unconditionally interprets '%' followed by a word
>> character as a constant definition, i.e. %CONST, it's impossible to get
>> an actual '%\w' when kernel-doc is used to translate comments into rst
>> format.  Treat backtick and backlash as escaping '%', the former to
>> handle '%' in a ``LITERAL``, and the latter to allow '%' when using
>> standard formatting.
>> 
>> An alternative option would be to define a fancier set of rules for
>> interpreting '%' so that explicit escaping would not be required.  For
>> example, require "%CONST" to be preceded by a recognized set of
>> characters, e.g. whitespace, opening parenthesis, etc...  But the list
>> of recognized characters is quite large even in the current code base,
>> and using '\' to escape is more common and intuitive, i.e. most people
>> will naturally try doing "\%..." to get the desired formatting, whereas
>> losing %CONST formatting because of an unrecognized character is likely
>> to cause confusion.
>
> Would it make sense to have %% turn into % rather than forcing quotation
> marks?

The problem is not limited to % though.

I see two long-term solutions to the problem:

1) Define proper escaping and quoting rules for kernel-doc to pass
   through stuff as-is to Sphinx. This may be difficult to implement
   because, well, see kernel-doc source.

2) Figure out how to do the kernel-doc references and highlights in the
   Sphinx extension after all the reStructuredText processing.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
