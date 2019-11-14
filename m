Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B46C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA858206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fmn4z9oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKNWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:09:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKNWJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:09:29 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 204DB1EC0CEE;
        Thu, 14 Nov 2019 23:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573769368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xYhc/7wJXkbEuR1fJeyyXolDs5K2TwCt+X3apsTDfRM=;
        b=Fmn4z9oQ4xW1KxsQZ4VFzIEAiRhycldWylbPYxQ5mjoEnUkkIm/ltFZC5t8pROhg9+7Z8d
        t8agjx8UKiHXyn9Ck0Gpt9epASafRRFYn1V8qgbThS77hHFGQv5uvHZIYkhNfcwaIBcQPq
        62UIjgc9I5t0qAaxMyo9t2yP0bptVAo=
Date:   Thu, 14 Nov 2019 23:09:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
Message-ID: <20191114220924.GE7222@zn.tnic>
References: <20191113193350.24511-1-longman@redhat.com>
 <20191114201258.GA18745@guptapadev.amr>
 <71de9e2b-19b6-161a-2f78-093c71d9391d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71de9e2b-19b6-161a-2f78-093c71d9391d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 04:58:24PM -0500, Waiman Long wrote:
> > Maybe delay MDS mitigation print till TAA is evaluated.
> 
> I will see what can be done about that. However, this is not a critical
> issue and I may not change it if there is no easy solution.

Swapping the two mitigation selection calls in check_bugs() might
work...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
