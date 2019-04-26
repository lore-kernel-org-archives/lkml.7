Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AF0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZLbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:31:20 -0400
Received: from smtp1.goneo.de ([85.220.129.30]:33670 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDZLbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:31:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id E7D0B23F296;
        Fri, 26 Apr 2019 13:31:16 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IGS607Rw8s9R; Fri, 26 Apr 2019 13:31:16 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-248-137-208.ewe-ip-backbone.de [91.248.137.208])
        by smtp1.goneo.de (Postfix) with ESMTPSA id A50E923F35F;
        Fri, 26 Apr 2019 13:31:15 +0200 (CEST)
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20190425200125.12302-1-corbet@lwn.net>
 <20190425200125.12302-2-corbet@lwn.net> <87tvelrv8d.fsf@intel.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <d0190209-ce72-1107-8012-a521984f2d0f@darmarit.de>
Date:   Fri, 26 Apr 2019 13:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tvelrv8d.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.19 um 11:06 schrieb Jani Nikula:
> On Thu, 25 Apr 2019, Jonathan Corbet<corbet@lwn.net>  wrote:
>> Rather than fill our text files with :c:func:`function()` syntax, just do
>> the markup via a hook into the sphinx build process.  As is always the
>> case, the real problem is detecting the situations where this markup should
>> *not*  be done.
> This is basically a regex based pre-processing step in front of Sphinx,
> but it's not independent as it embeds a limited understanding/parsing of
> reStructuredText syntax. This is similar to what we do in kernel-doc the
> Perl monster, except slightly different.
> 
> I understand the motivation, and I sympathize with the idea of a quick
> regex hack to silence the mob. But I fear this will lead to hard to
> solve corner cases and the same style of "impedance mismatches" we had
> with the kernel-doc/docproc/docbook Rube Goldberg machine of the past.
> 
> It's more involved, but I think the better place to do this (as well as
> the kernel-doc transformations) would be in the doctree-read event,
> after the rst parsing is done. You can traverse the doctree and find the
> places which weren't special for Sphinx, and replace the plain text
> nodes in-place. I've toyed with this in the past, but alas I didn't have
> (and still don't) have the time to finish the job. There were some
> unresolved issues with e.g. replacing nodes that had syntax highlighting
> (because I wanted to make the references work also within preformatted
> blocks).
> 
> If you decide to go with regex anyway, I'd at least consider pulling the
> transformations/highlights from kernel-doc the script to the Sphinx
> extension, and use the exact same transformations for stuff in source
> code comments and rst files.

FWIW mentioning: I fully agree with Jan.

   -- Markus --
