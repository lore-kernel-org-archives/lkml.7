Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B27CC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFCC2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfFQNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:47:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:6282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFQNrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:47:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 06:47:44 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2019 06:47:42 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide book
In-Reply-To: <20190617125438.GA18554@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org> <87o930uvur.fsf@intel.com> <20190614140603.GB7234@kroah.com> <20190614122755.1c7b4898@coco.lan> <874l4ov16m.fsf@intel.com> <20190617125438.GA18554@kroah.com>
Date:   Mon, 17 Jun 2019 16:50:38 +0300
Message-ID: <87y320tj69.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 17, 2019 at 03:36:17PM +0300, Jani Nikula wrote:
>> On Fri, 14 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>> > Em Fri, 14 Jun 2019 16:06:03 +0200
>> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
>> >
>> >> On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:
>> >> > 2) Have the python extension read the ABI files directly, without an
>> >> >    extra pipeline.  
>> >> 
>> >> He who writes the script, get's to dictate the language of the script :)
>> 
>> The point is, it's an extension to a python based tool, written in perl,
>> using pipes for communication, and losing any advantages of integrating
>> with the tool it's extending.
>> 
>> I doubt you'd want to see system() to be used to subsequently extend the
>> perl tool.
>> 
>> I think it's just sad to see the documentation system slowly drift
>> further away from the ideals we had, and towards the old ways we worked
>> so hard to fix.
>
> What are those ideals?

For example, have a single coherent system, instead of a fragile pipe
with each stage written in a different language, each having its own
idiosynchracies, each step losing something in translation.

Have a system that a normal developer can actually look at and
understand. It didn't use to be that way.

> I thought the goal was to be able to write documentation in a as much
> as a normal text file as possible and have automation turn those files
> into "pretty" documentation that we can all use.
>
> And I think that fits with the way this patch set goes, right?  We are
> not on a quest for purity of scripts to generate the documentation at
> the expense of having to force hundreds, or thousands, of developers to
> change their ways, or to force a "flag day" conversion of existing
> documentation resulting in a huge merge mess.

Fair enough, let's dismiss the thought of changing the ABI files. But I
never meant that would somehow be for the "purity of scripts", or that
those two would somehow be at odds here.

> So, we are stuck with the current structure that I totally made up for
> Documentation/ABI/.  Turns out it is almost parsable, as Mauro's tool
> shows.  His tool also validates the existing text, which is great, and
> has caused fixes for it.
>
> If someone wants to write that tool in some other language, like python,
> wonderful, I have no objection, but as it is, this is a useful tool
> already, allowing us to validate, and search, existing documentation
> entries that we have never been able to do before.  It also provides an
> output that can be turned into pretty html/pdf/whatever files by other
> tools in the pipeline, a totally bonus benefit.
>
> So what is going backwards here?
>
> Maybe the processing pipeline isn't as nice as you would like, but
> remember to view this from a normal developer's point of view, not a
> documentation pipeline developer's point of view please.
>
> So, in short, my requirements are:
> 	- keep Documentation/ABI/ file formats as close as possible to
> 	  what we have today, preventing any flag-day issues or merge
> 	  problems
> 	- be able to query and validate Documentation/ABI/
> 	- be able to turn Documentation/ABI into pretty documentation.
>
> If you object to the mechanics of the last requirement here, I don't
> object either, provide something else that works better.  But don't
> throw away the whole thing just because you don't like how things are
> hooked up here.
>
> I'm going to go apply most of the rest of these patches to my
> driver-core tree, stopping at the "hook it up to the kernel
> documentation" point.  Is that ok?

I'll leave it all up to Jon's discretion; I trust he'll understand my
concerns. I have no authority beyond the opinion I've voiced here
anyway.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
