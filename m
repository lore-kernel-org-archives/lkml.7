Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CABC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9345521906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfJAKRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:17:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:51739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbfJAKRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:17:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:17:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="366286885"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:17:39 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Vishal Kulkarni <vishal@chelsio.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [PATCH v3] string-choice: add yesno(), onoff(), enableddisabled(), plural() helpers
In-Reply-To: <20191001095911.GA2945944@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <8e697984-03b5-44f3-304e-42d303724eaa@rasmusvillemoes.dk> <20191001080739.18513-1-jani.nikula@intel.com> <20191001093849.GA2945163@kroah.com> <87blv0dcol.fsf@intel.com> <20191001095911.GA2945944@kroah.com>
Date:   Tue, 01 Oct 2019 13:17:36 +0300
Message-ID: <878sq4db27.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 01, 2019 at 12:42:34PM +0300, Jani Nikula wrote:
>> On Tue, 01 Oct 2019, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> > On Tue, Oct 01, 2019 at 11:07:39AM +0300, Jani Nikula wrote:
>> >> The kernel has plenty of ternary operators to choose between constant
>> >> strings, such as condition ? "yes" : "no", as well as value == 1 ? "" :
>> >> "s":
>> >> 
>> >> $ git grep '? "yes" : "no"' | wc -l
>> >> 258
>> >> $ git grep '? "on" : "off"' | wc -l
>> >> 204
>> >> $ git grep '? "enabled" : "disabled"' | wc -l
>> >> 196
>> >> $ git grep '? "" : "s"' | wc -l
>> >> 25
>> >> 
>> >> Additionally, there are some occurences of the same in reverse order,
>> >> split to multiple lines, or otherwise not caught by the simple grep.
>> >> 
>> >> Add helpers to return the constant strings. Remove existing equivalent
>> >> and conflicting functions in i915, cxgb4, and USB core. Further
>> >> conversion can be done incrementally.
>> >> 
>> >> While the main goal here is to abstract recurring patterns, and slightly
>> >> clean up the code base by not open coding the ternary operators, there
>> >> are also some space savings to be had via better string constant
>> >> pooling.
>> >> 
>> >> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> >> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> >> Cc: intel-gfx@lists.freedesktop.org
>> >> Cc: Vishal Kulkarni <vishal@chelsio.com>
>> >> Cc: netdev@vger.kernel.org
>> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> Cc: linux-usb@vger.kernel.org
>> >> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> Cc: linux-kernel@vger.kernel.org
>> >> Cc: Julia Lawall <julia.lawall@lip6.fr>
>> >> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> >> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # v1
>> >
>> > As this is a totally different version, please drop my reviewed-by as
>> > that's really not true here :(
>> 
>> I did indicate it was for v1. Indeed v2 was different, but care to
>> elaborate what's wrong with v3?
>
> No idea, but I haven't reviewed it yet, so to put my tag on there isn't
> the nicest...

Apologies, no harm intended.

At times, I've seen the "# vN" notation used, I suppose both to indicate
that the *ideas* presented in the earlier version warranted Reviewed-by
from so-and-so, though this particular version still needs detailed
review, and that the approval of the reviewer of the earlier version
should be sought out before merging a subsequent version.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
