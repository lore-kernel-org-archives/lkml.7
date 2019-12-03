Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CE2206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfLCJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:23:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:16352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:23:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 01:23:38 -0800
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="204909504"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 01:23:36 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Joe Perches <joe@perches.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
In-Reply-To: <ea57f41e30f962227855d4f60a93c89a6bf0b2f0.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574906800-19901-1-git-send-email-krzk@kernel.org> <87a78gnyaz.fsf@intel.com> <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com> <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com> <ea57f41e30f962227855d4f60a93c89a6bf0b2f0.camel@perches.com>
Date:   Tue, 03 Dec 2019 11:23:33 +0200
Message-ID: <874kyhkbje.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Dec 2019, Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-12-03 at 16:40 +0800, Krzysztof Kozlowski wrote:
>> On Thu, 28 Nov 2019 at 17:35, Joe Perches <joe@perches.com> wrote:
>> > On Thu, 2019-11-28 at 11:29 +0200, Jani Nikula wrote:
>> > > On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > > > Kconfig should be indented with one tab for first level and tab+2 spaces
>> > > > for second level.  There are many mixups of this so add a checkpatch
>> > > > rule.
>> > > > 
>> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > > 
>> > > I agree unifying the indentation is nice, and without something like
>> > > this it'll start bitrotting before Krzysztof's done fixing them all... I
>> > > think there's been quite a few fixes merged lately.
>> > > 
>> > > I approve of the idea, but I'm clueless about the implementation.
>> > 
>> > I think that a grammar, or a least an array of words
>> > that are supposed to start on a tab should be used here.
>> 
>> This won't work for wrong indentation of help text. This is quite
>> popular Kconfig indentation violation so worth checking. I can then
>> check for:
>> 1. any white-space violations before array of Kconfig words - that
>> 2. spaces mixed with tab before any text,
>> 3. just spaces before any text,
>> 4. tab + wrong number of spaces before any text.
>> 
>> It would look like:
>> +               if ($realfile =~ /Kconfig/ &&
>> +                   (($rawline =~
>> /^\+\s+(?:config|menuconfig|choice|endchoice|if|endif|menu|endmenu|source|bool|tristate|prompt|help|---help---|depends|select)\b/
>
> Many of these are not correct.
>
> config, menuconfig, choice, endchoice, source
> are primarily used at the beginning of a line.
>
> if is odd as it's a logical block or test
>
> It really needs a lex grammar to work properly.

Alternatively, perhaps you could complain about indentation that is not
one of 1) empty string, 2) exactly one tab, or 3) exactly one tab
followed by exactly two spaces?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
