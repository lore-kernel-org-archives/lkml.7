Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B94AC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BFE20644
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfFQMdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:33:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:28929 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfFQMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 05:33:24 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2019 05:33:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide book
In-Reply-To: <20190614122755.1c7b4898@coco.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org> <87o930uvur.fsf@intel.com> <20190614140603.GB7234@kroah.com> <20190614122755.1c7b4898@coco.lan>
Date:   Mon, 17 Jun 2019 15:36:17 +0300
Message-ID: <874l4ov16m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> Em Fri, 14 Jun 2019 16:06:03 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
>
>> On Fri, Jun 14, 2019 at 04:42:20PM +0300, Jani Nikula wrote:
>> > 2) Have the python extension read the ABI files directly, without an
>> >    extra pipeline.  
>> 
>> He who writes the script, get's to dictate the language of the script :)

The point is, it's an extension to a python based tool, written in perl,
using pipes for communication, and losing any advantages of integrating
with the tool it's extending.

I doubt you'd want to see system() to be used to subsequently extend the
perl tool.

I think it's just sad to see the documentation system slowly drift
further away from the ideals we had, and towards the old ways we worked
so hard to fix.

> No idea about how much time it would take if written in python,
> but this perl script is really fast:
>
> 	$ time ./scripts/get_abi.pl search voltage_max >/dev/null
> 	real	0m0,139s
> 	user	0m0,132s
> 	sys	0m0,006s
>
> That's the time it takes here (SSD disks) to read all files under
> Documentation/ABI, parse them and seek for a string.
>
> That's about half of the time a python script takes to just import the
> the sphinx modules and print its version, running at the same machine:
>
> 	$ time sphinx-build --version >/dev/null
>
> 	real	0m0,224s
> 	user	0m0,199s
> 	sys	0m0,024s

Please at least use fair and sensible comparisons. If you want to make
the extension usable standalone on the command-line, bypassing Sphinx,
you can do that. No need to factor in Sphinx to your comparisons.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
