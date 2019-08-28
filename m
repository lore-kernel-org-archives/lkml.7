Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25832C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F7B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QY5wfUQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfH1TQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:16:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1TQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:16:20 -0400
Received: from zn.tnic (p200300EC2F0A5300A53AA9977BDEAF1A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5300:a53a:a997:7bde:af1a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 229831EC0503;
        Wed, 28 Aug 2019 21:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567019779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/IFK3pN48y0IrzamroRgDtjPL9FkQHX16Sbwg2AQAQQ=;
        b=QY5wfUQfZsNY516pyvoe3XMOQqGGwPgAG3honOPILIjFvrIi4GJwPlNI9QlCZ9B9FUosPy
        aSJDTv5tz9+m892d39f1gZeTiW1NDN2rm55rsjHq1u2z/tARLMm5UnO+7+jww+4ktAN23h
        kZm0g5pMsjwmrTmTodmjxtu0CiqT6u4=
Date:   Wed, 28 Aug 2019 21:16:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190828191618.GO4920@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
 <20190826203248.GB49895@otc-nc-03>
 <20190827194344.GA15361@bostrovs-us.us.oracle.com>
 <7d310cbd-ed4d-9a98-d8b0-4ac7dfd1ef93@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d310cbd-ed4d-9a98-d8b0-4ac7dfd1ef93@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:24:07PM -0400, Boris Ostrovsky wrote:
> This was a bit too aggressive with changes to arch-specific code, only
> changes to __reload_late() would be needed.

Yeah, it is not that ugly but the moment the microcode engine is not
shared between the SMT threads anymore, this needs to go. And frankly,
if there's nothing else speaking against the current variant, I'd like
to keep it simple.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
