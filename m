Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2344C47409
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75B224671
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCx6Hcds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLNKHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:07:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48406 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbfLNKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 05:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576318032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7DjxLpVUDmrMfYFPEAv8TSiRH6FhuBM4F+xzNTmV2w=;
        b=hCx6HcdsyaTF800VQphvj+AUcMTp4ViJCe58rsIxOwWoAOfiZA0v0M2bLjHWYyMuecSCWh
        TPrP9g1DH1DjgLqsxoGKQfB9ZziLoiG0/INljDcejR2O6qQRu7daTvd2Ij/m5RCHBZZLs7
        G8ieVIT9HA/5c8FWYoLMR+qQw4rZRFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-VQmF1x_SMJafxx7yLz7sDg-1; Sat, 14 Dec 2019 05:07:08 -0500
X-MC-Unique: VQmF1x_SMJafxx7yLz7sDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5761005512;
        Sat, 14 Dec 2019 10:07:06 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37CB219C4F;
        Sat, 14 Dec 2019 10:07:02 +0000 (UTC)
Date:   Sat, 14 Dec 2019 18:07:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191214100700.GK28917@MiWiFi-R3L-srv>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
 <20191212201916.GL4991@zn.tnic>
 <20191213132850.GG28917@MiWiFi-R3L-srv>
 <20191213141543.GA25899@zn.tnic>
 <20191213145448.GH28917@MiWiFi-R3L-srv>
 <20191213163818.GB25899@zn.tnic>
 <20191213232928.GI28917@MiWiFi-R3L-srv>
 <20191214071329.GA28635@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214071329.GA28635@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/19 at 08:13am, Borislav Petkov wrote:
> On Sat, Dec 14, 2019 at 07:29:28AM +0800, Baoquan He wrote:
> > OK, you mean parsing SRAT again before kernel_randomize_memory(). I
> > think this is what Masa made this patchset to avoid. Then we will have
> > three times SRAT parsing.
> 
> Can the SRAT parsing be *moved* up so that it is done before
> kernel_randomize_memory() ?
> 
> So that it doesn't happen 3 times and acpi_numa_init() can simply use
> the already parsed results.

Not very sure, It could be doable. Maybe Masa can have a try.

