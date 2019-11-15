Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020A2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qKMhIXsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKORJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:09:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKORJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:09:28 -0500
Received: from [10.133.216.62] (unknown [46.114.32.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77A0A1EC0D0C;
        Fri, 15 Nov 2019 18:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573837767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFnylH8db3KJwKcEae910K7PqT8B8oFlYNhXjdsP9M4=;
        b=qKMhIXsjTarTuL3LJU5s3WTBnoabpUNswF0C6pQIcGtkjnOuAPE/NQettIdEX0zPDv/+KF
        QcS4mB59jpsxK9/Xi9b3/P1nPrwCjUGhWKJ+5hIKx2aO4BKalbXOZKNITcAJiHs2WFXiWL
        GhA7Ot0qZz/hBTUpOSlvCieh6Qf5gvc=
Date:   Fri, 15 Nov 2019 18:09:25 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191115161445.30809-2-longman@redhat.com>
References: <20191115161445.30809-1-longman@redhat.com> <20191115161445.30809-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
CC:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <7EAED44C-A93E-405E-B57B-89AC3F779A70@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 15, 2019 5:14:44 PM GMT+01:00, Waiman Long <longman@redhat=2Eco=
m> wrote:
>For MDS vulnerable processors with TSX support, enabling either MDS or
>TAA mitigations will enable the use of VERW to flush internal processor
>buffers at the right code path=2E IOW, they are either both mitigated
>or both not=2E However, if the command line options are inconsistent,
>the vulnerabilites sysfs files may not report the mitigation status
>correctly=2E
>
>For example, with only the "mds=3Doff" option:
>
>  vulnerabilities/mds:Vulnerable; SMT vulnerable
>vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT
>vulnerable
>
>The mds vulnerabilities file has wrong status in this case=2E Similarly,
>the taa vulnerability file will be wrong with mds mitigation on, but
>taa off=2E
>
>Change taa_select_mitigation() to sync up the two mitigation status
>and have them turned off if both "mds=3Doff" and "tsx_async_abort=3Doff"
>are present=2E
>
>Both hw-vuln/mds=2Erst and hw-vuln/tsx_async_abort=2Erst are updated
>to emphasize the fact that both "mds=3Doff" and "tsx_async_abort=3Doff"
>have to be specified together for processors that are affected by both
>TAA and MDS to be effective=2E As kernel-parameter=2Etxt references both
>documents above, it is not necessary to update it=2E

What about kernel-parameters=2Etxt?

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
