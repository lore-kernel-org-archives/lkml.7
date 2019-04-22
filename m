Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r4NApQPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfDVSIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:08:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfDVSIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:08:41 -0400
Received: from zn.tnic (p200300EC2F07AE003D173D9528C0693E.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:ae00:3d17:3d95:28c0:693e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 674801EC014A;
        Mon, 22 Apr 2019 20:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555956519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gGlFFQPL3NfzS1wRGaX2oOYmbtY30q5BaDGVcvIPJns=;
        b=r4NApQPDUe0g/dFEwh8nMUTF0vFAcOpV4PA1rSHHqjhIiGnG7oHbsDBeFosIqnxJknVWEt
        WspqZEMCh3xMuOSeaek/It8IqWbJZ7XLzBM0/UgI2f1Iw5I558Gw9URfIdoB0NRm+dmTEz
        3jsJp5WR8ci82yxK+c2EEEs5sgliPr0=
Date:   Mon, 22 Apr 2019 20:08:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190422180831.GK21457@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic>
 <20190419150400.GA12738@agluck-desk>
 <20190420094120.GB29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A404@ORSMSX104.amr.corp.intel.com>
 <20190422171532.GH21457@zn.tnic>
 <20190422174415.GA21890@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422174415.GA21890@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:44:15AM -0700, Luck, Tony wrote:
> Yes. Automating this would be a very good idea.

Yeah, in general integrating the CEC better with the rest of the error
chain is something we still need to discuss and do.

> In the case of many errors at different addresses we are deleting
> the entry with the lowest count. But all of the entries have low
> counts because we are just thrashing the array with many different
> addresses. In this situation a warning would be helpful.

Can we detect that situation reliably even? You can have many errors at
different addresses which have accumulated over time, due to a slow but
constant stream of errors. Dunno if that is possible though... someone
needs to analyze error occurrence patterns :-\

> But in the case where the system has been up for months and
> we very slowly accumlated logs of bit flips. The periodic
> spring cleaning means they all have generation "00", but
> we never actually drop an old entry because of age.

Yes, we drop only on insertion and when the array is full or when we
soft-offline.

> In this case dropping one entry to make space for a new one is fine
> and doesn't need any action.
>
> Perhaps we can distinguish the cases by the generation? If
> we are dropping an entry that was recently added, then it
> will still have generation "11" (or at least not "00").
> Use that to trigger an action?

That and the fact that we're in an error storm is probably a good enough
heurstic. And then when the storm subsides, we reenable it? We basically
say, error storm is over, the error rate should go back to normal so we
can stick the CEC in front of it again.

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
