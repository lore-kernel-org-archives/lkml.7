Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A036120640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 06:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UMYw0f+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbfIQGqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 02:46:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60016 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfIQGqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:46:19 -0400
Received: from nazgul.tnic (unknown [193.86.95.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB7771EC0200;
        Tue, 17 Sep 2019 08:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568702778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9Q0Z13rG711uvWRmfQeCjyd2F/ANVybw/Hkd7OjcJ+k=;
        b=UMYw0f+j81fcQuCG7ECcpHsVLbVG9alHrC0/6b8TqoWSohdnLoJyU/hHYtNk8lTLsbMLU/
        EF9zGd03VHAckmOpVQvt4YVaVkT39pU1toKGQuSjHJnX5qUHUspRS4y2kiMsESxoxNbCKP
        dRxae3zO6LYvSxKaji6M0M4BGLV+rbo=
Date:   Tue, 17 Sep 2019 08:46:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190917064612.GA12174@nazgul.tnic>
References: <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
 <20190907003338.GA14807@araj-mobl1.jf.intel.com>
 <alpine.DEB.2.21.1909071236120.1902@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1909161227060.10731@nanos.tec.linutronix.de>
 <20190917003122.GA3005@otc-nc-03>
 <alpine.DEB.2.21.1909170824220.2066@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909170824220.2066@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:37:10AM +0200, Thomas Gleixner wrote:
> So what happens if the ucode update "fixes" one of the executed
> instructions on the fly? Is that guaranteed to be safe? There is nothing
> which says so.

You'd expect that when you load microcode on the core, the one thread
does the loading and the other SMT thread is in a holding pattern. That
would be optimal.

Considering the dancing through hoops we're doing to keep all threads
quiesced, I'd be sceptical that is the case...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
