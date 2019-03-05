Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3938C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CE6213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="r7WOgFS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfCETyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:54:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60992 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCETyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:54:36 -0500
Received: from zn.tnic (p200300EC2BCD6B00ECFD1928E9AB0C1D.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:ecfd:1928:e9ab:c1d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7A4C1EC08EF;
        Tue,  5 Mar 2019 20:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551815674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+EYZ94zZGu5h+Wyrip3oL58/J9UxafKDW+CtnaAXhNM=;
        b=r7WOgFS9CVyJdH4AvuzWLW3Pbd0FWZjMbaQOp/Ji97r+klztTYhBzOjo5DEAefgQkmswdp
        VacihEsWGIAFCoV/7qxrEf0YnlJ5SqXsmcVuPYhpBuvzGwB7W59Lt/+m0O5I8/MMjDfRqC
        vYAwsgas7GvJp5XtHw7JNGQQcb3qFPU=
Date:   Tue, 5 Mar 2019 20:54:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
Message-ID: <20190305195432.GI8256@zn.tnic>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
 <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
 <9f17f1aa-f258-fb18-0736-04a5c03cf40e@redhat.com>
 <cef82f75-8dc6-8198-ac41-492c200f6d57@redhat.com>
 <57b32bc1-8ef2-1e1e-a70f-04444f5919a2@amd.com>
 <6fbcd261-f9e2-1685-1ef7-f148007aab9d@redhat.com>
 <51078b59-161a-0e13-6d8d-87d37c3375f2@redhat.com>
 <62f91d1a-4dc7-9628-5c87-5ffca0cd1a0f@amd.com>
 <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92a886e1-1eca-7b94-2c62-9f42abc66bcf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:40:02PM +0100, Hans de Goede wrote:
> Finger pointing at the firmware if there are multiple vendors involved
> is really not going to help here. Esp. since most OEMs will just respond
> with "the machine works fine with Windows"

Yes, because windoze simply doesn't report that spurious IRQ, most
likely.

Firmware is fiddling with some crap underneath and it ends up raising
IRQs. tglx told you that too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
