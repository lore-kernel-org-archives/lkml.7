Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B034C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78A620820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ehzHlgOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfIDWMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:12:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfIDWMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:12:33 -0400
Received: from [10.161.240.246] (unknown [46.114.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 390121EC0A91;
        Thu,  5 Sep 2019 00:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567635152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BxOUiVFKBguy8GJUpMo0HYnSyrRDVPrj1TOB9eE+5U=;
        b=ehzHlgOlVn+qrPzzS4Sb59NWJXXd80ZgghcMes/MhXG5CknE2QbijAAJKEK0H6SHgTYC9s
        Pa35ATuKJYpiBtByl10zMD4JczRljKGPcILLGmj4yq0NMNG1BdPULFdTvY6i5hJXKyK9hP
        4y0tA7cyJlBEpE5vfzRoHkbIPU+B+GQ=
Date:   Thu, 05 Sep 2019 00:12:29 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
References: <1567056803-6640-1-git-send-email-ashok.raj@intel.com> <20190829060942.GA1312@zn.tnic> <20190829130213.GA23510@araj-mobl1.jf.intel.com> <20190903164630.GF11641@zn.tnic> <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if revision is unchanged
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
CC:     Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 5, 2019 12:06:54 AM GMT+02:00, Boris Ostrovsky <boris=2Eostrov=
sky@oracle=2Ecom> wrote:
>Why do we need to taint kernel here? We are not making any changes=2E

Because this is not a normal operation we want users to do=2E This is only=
 for testing microcode quicker=2E

>This won't allow people to load from new microcode blob which I thought
>was one of the objectives behind this new feature=2E

You load a new blob the usual way: echo 1 > =2E=2E=2E

This is the "unusual" way where you reload an already loaded revision only=
=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
