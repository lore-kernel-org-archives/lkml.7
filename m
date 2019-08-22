Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7DEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7AC233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5G0dUIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbfHVKaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:30:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfHVKaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5B6dDBcMbW2BW7BmBEa/KK1lUoMqHmy7CmpP97KQczk=; b=r5G0dUIKUpI0VqxgnxKu1jDCU
        mCCvK4KF+/ZOR/10s948RX01UIW/LbwxpKJhc/im3kRXSOFat4Xe79TAayV+XU7GT9TVDu3Mp5nVa
        +WzpN1tRwVakWKvEyOEzM3JoUdfvjfhaSgdIaTJ05RZ58omE8Max+d9fl6a3Fj7pvmvINZadPvDFV
        /8+xxs0VQ6NDqDaV7DyqaIlKIvPe+QPPB2OI2QZgBUYxQYbvMUg3kJVSc5BFtBPmHUIUEI3JvrwEd
        p1AAjn4eliIXfsCGEtOCuKYlxPfqbjD8+qpasBmMUNoX+Kx8pJax1n3DlGI7uaFrw/HYUyysl+Z9I
        8R+od7/3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kLs-0001oI-Q4; Thu, 22 Aug 2019 10:29:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C8D9307598;
        Thu, 22 Aug 2019 12:29:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29ED6202D580F; Thu, 22 Aug 2019 12:29:55 +0200 (CEST)
Date:   Thu, 22 Aug 2019 12:29:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190822102955.GS2369@hirez.programming.kicks-ass.net>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
 <20190820145735.GW2332@hirez.programming.kicks-ass.net>
 <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821201845.GA29589@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:18:46PM -0700, Luck, Tony wrote:
> On Tue, Aug 20, 2019 at 04:57:35PM +0200, Peter Zijlstra wrote:

> As I mentioned above, there are some folks internally that think
> NP == Network Processor is too narrow a pigeonhole for this CPU.
> 
> But _NPAOS (Network Processor And Other Stuff) doesn't sound helpful.

So what is 'other stuff'; is there really no general term that describes
well what's been done to this SoC; or is it secret and we're in a catch
22 here?

> > Note that for the big cores we added the NNPI thing, which was for
> > Neural Network Processing something.
> 
> I'm sure that we will invent all sorts of strings for the "OPTDIFF"
> part of the name (many of which will only be used once or twice).

That's a bit sad; because as shown by the patches just send out; there
really isn't _that_ much variation right now.

Anyway, lets just give the thing a name; _NP whatever, and we can
rename it if needed.
