Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B1F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LPOYFUx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfJXJKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:10:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfJXJKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:10:18 -0400
Received: from zn.tnic (p200300EC2F0F6D00111FCEB20B40B3F2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6d00:111f:ceb2:b40:b3f2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 807901EC0C31;
        Thu, 24 Oct 2019 11:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571908217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p2MX4Ow9Nchf/5umX33LnDQf+HNj5ziC3a5+3VA9nMw=;
        b=LPOYFUx05uRwUFWQ66WAoNjqsO4eppaWMZywV+KtOaGZTZP1SsbQhZY1QBHqX+o0aCdTFB
        6SDYd3fPsvTDVzeDsjH/H08UjQxde2tAY7gX2D0xcrndwQdn+uIpDBJ95uy5byb7atdndU
        ms4MPPNb3scm2RNU7dFOIKEnvBE0gEI=
Date:   Thu, 24 Oct 2019 11:10:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     'lijiang' <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191024091008.GA31060@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com>
 <20191022083015.GB31700@zn.tnic>
 <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
 <OSBPR01MB4006F33096F5E0AB8B8E648D956A0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4006F33096F5E0AB8B8E648D956A0@OSBPR01MB4006.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 08:13:25AM +0000, d.hatayama@fujitsu.com wrote:
> I don't find the corresponding patch in the v5 patchset, so I comment here.

You don't?

https://lore.kernel.org/lkml/20191023141912.29110-2-lijiang@redhat.com/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
