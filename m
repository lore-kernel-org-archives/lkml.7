Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EEEC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E83206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qQeuTWK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHXIwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 04:52:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfHXIwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:52:01 -0400
Received: from zn.tnic (p200300EC2F1E9400E161D1CD3EE01E5E.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:9400:e161:d1cd:3ee0:1e5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 471CD1EC01AF;
        Sat, 24 Aug 2019 10:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566636720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y/+jWvyBGR7LYBkrvHd7rN/Y5tkpI17UT0DIamRbBg8=;
        b=qQeuTWK3L6xlmCAWyxD6p/I6iruhE/vyJqBwBcl6RjtJSlJIB2Vu6ITLa+KdohfH42Kma/
        B0RwxcGYryo01sVr8RLO/yI5i37jq/5Xhsx36MyqD82YGaTuY5/kJVDwFQ3ESdApWYcWlX
        un5EcEazliTTlYNg7TBOW4b35CVEs0o=
Date:   Sat, 24 Aug 2019 10:51:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH] x86/microcode: Update microcode for all cores in parallel
Message-ID: <20190824085156.GA16813@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:43:47PM +0300, Mihai Carabas wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> Microcode update was changed to be serialized due to restrictions after
> Spectre days. Updating serially on a large multi-socket system can be
> painful since we do this one CPU at a time. Cloud customers have expressed
> discontent as services disappear for a prolonged time. The restriction is
> that only one core goes through the update while other cores are quiesced.
> The update is now done only on the first thread of each core while other
> siblings simply wait for this to complete.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c  | 44 ++++++++++++++++++++++++-----------
>  arch/x86/kernel/cpu/microcode/intel.c | 14 ++++-------
>  2 files changed, 36 insertions(+), 22 deletions(-)

Thanks, I did some cleaning up and smoke testing. It looks ok so far.
The versions I'm going to hammer on more - and I'd appreciate it if you
did so too, when possible - as a reply to this message.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
