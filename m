Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F5AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838C7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CNdkjNPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfH1TNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:13:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfH1TNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:13:42 -0400
Received: from zn.tnic (p200300EC2F0A5300A53AA9977BDEAF1A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5300:a53a:a997:7bde:af1a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38C0A1EC0503;
        Wed, 28 Aug 2019 21:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567019617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EEJZJDQSuaHwZRcR7GT4CllUYlT+YVmw/EcCSIF/Nc0=;
        b=CNdkjNPZTopEJ4kvqUGyaNVs1EhaS1E6SJmE1fzBvp42noz4A5/eKsi60o4ZaWHtQniAy3
        V7nhGURuncWa0IHMTwd6ORgN+IDgpVUxWNteyX85OLbzklrJ5sWFJR3kuc88l/+WhSwBAg
        +taOizm4N2NHjTpfzdW6snP5/8ho2UY=
Date:   Wed, 28 Aug 2019 21:13:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190828191331.GN4920@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <20190826202339.GA49895@otc-nc-03>
 <20190827122501.GD29752@zn.tnic>
 <20190828005630.GB47494@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828005630.GB47494@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:56:30PM -0700, Raj, Ashok wrote:
> > "Cloud customers have expressed discontent as services disappear for
> > a prolonged time. The restriction is that only one core (or only one
> > thread of a core in the case of an SMT system) goes through the update
> > while other cores (or respectively, SMT threads) are quiesced."
> 
> the last line seems to imply that only one core can be updated at a time.

Only one core *is* being updated at a time now, before the parallel
loading patch. Look at the code. I'm talking about what the code does,
not what the requirement is.

Maybe it should not say "restriction" above but the sentence should
start with: "Currently, only one core... "

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
