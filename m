Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B09C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C6220693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="q1mENjsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfDPKcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:32:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53814 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDPKcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:32:00 -0400
Received: from zn.tnic (p200300EC2F0D6900D0FA583685BBD9D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:d0fa:5836:85bb:d9d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F16C01EC0513;
        Tue, 16 Apr 2019 12:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555410719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LECkOkuhUcVrxdxxTmVMCwNfDHXpKkrXY/d7puf8lNY=;
        b=q1mENjsM3iNSK8/ZUJnyJyJ9pbFBxJmWnpOvSX+YlH0A6H5GvAYCDKVFqBx7AZM0gFyeMk
        Ie1gZzezC51zvzYBHRiwdUXk/7uuuJ1ADgKX2BpjFz70gyZWU5+6aGBs1TRN9EuPPf4c3Q
        JOxUoDIrIdh4ktRz9GzYS9i8o2Yac0k=
Date:   Tue, 16 Apr 2019 12:31:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190416103154.GC31772@zn.tnic>
References: <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic>
 <20190416100226.GA117053@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416100226.GA117053@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:02:26PM +0200, Ingo Molnar wrote:
> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > I'll queue the below in the next days if there are no more complaints:
> 
> Just a minor style nit, this was inherited from existing code:
> 
> > +			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
> > +			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;
> 
> You might want to update that to the canonical form of:
> 
> > +			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
> > +			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
> 
> Looks good otherwise.

Fixed, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
