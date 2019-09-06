Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D282C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AFD2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="GxRJcKNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394597AbfIFOsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:48:51 -0400
Received: from out.bound.email ([141.193.244.10]:38215 "EHLO out.bound.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbfIFOsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:48:51 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 10:48:50 EDT
Received: from mail.sventech.com (localhost [127.0.0.1])
        by out.bound.email (Postfix) with ESMTP id C36368A30DF;
        Fri,  6 Sep 2019 07:40:39 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
        id A540016001D9; Fri,  6 Sep 2019 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
        s=default; t=1567780839;
        bh=qFCKmF98sxj89IxjUAyQ/fJTX4Sbri4zk3r9SCHTo9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxRJcKNKVbvW9eXHrii2JC70Hd94BQyeseRNJnztRKicbLXvWI78VbJ4PzUF/39I2
         yEnhhgK5GpiflbbM8LVUrqC8jBwfum1ec70kfJfNb+e5NM8eXw5uq+y/nKUOZaF6MY
         crcKcughqT5gkEh85T3nY0oRBjQOlviwroRmkQuw=
Date:   Fri, 6 Sep 2019 07:40:39 -0700
From:   Johannes Erdfelt <johannes@erdfelt.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906144039.GA29569@sventech.com>
References: <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019, Thomas Gleixner <tglx@linutronix.de> wrote:
> What your customers are asking for is a receipe for disaster. They can
> check the safety of late loading forever, it will not magically become safe
> because they do so.
> 
> If you want late loading, then the whole approach needs to be reworked from
> ground up. You need to make sure that all CPUs are in a safe state,
> i.e. where switching of CPU feature bits of all sorts can be done with the
> guarantee that no CPU will return to the wrong code path after coming out
> of safe state and that any kernel internal state which depends on the
> previous set of CPU feature bits has been mopped up and switched over
> before CPUs are released.

You say that switching of CPU feature bits is problematic, but adding
new features should result only in a warning ("x86/CPU: CPU features
have changed after loading microcode, but might not take effect.").

Removing a CPU feature bit could be problematic. Other than HLE being
removed on Haswell (which the kernel shouldn't use anyway), have there
been any other cases?

I ask because we have successfully used late microcode loading on tens
of thousands of hosts. I'm a bit worried to see that there is a push to
remove a feature that we currently rely on.

JE

