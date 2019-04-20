Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D679C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82A2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IEOuG6Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfDTJl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:41:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTJl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:41:27 -0400
Received: from zn.tnic (p200300EC2F112E00D040D7DB2F5373C5.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:d040:d7db:2f53:73c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6AEF1EC082D;
        Sat, 20 Apr 2019 11:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555753285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SNKvGACJEaqH1CY/EARCtlVxmHFSq26GHiL/RfUmhho=;
        b=IEOuG6JjQu8GF9fRrB0Wj307MKMbFlBYd2lKRnW5sD2qO4TCe9MG80Y9kPCzL9a6Yu04Cf
        f9quGawYIpRTM8OdfCC5vg5ly2RmyE7PiQYFG9uBJTmTHzhOpaWQE1j2+bfDDOm87GgKrD
        hp8fPohKhtkLldy5trrp4f6pKuwtB4o=
Date:   Sat, 20 Apr 2019 11:41:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190420094120.GB29704@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic>
 <20190419150400.GA12738@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419150400.GA12738@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 08:04:01AM -0700, Luck, Tony wrote:
> Now there isn't really anything better that CEC can do in
> this situation. It won't help to have a bigger array. Taking
> pages offline wouldn't solve the problem (though if that
> did happen at least it would break the silence).
> 
> Same situation for other DRAM failure modes that affect a
> wide range of pages (rank, bank, perhaps row ... though all
> the errors from a single row failure might fit in the CEC array).
> 
> Allowing the user to bypass CEC (without a reboot ... cloud folks
> hate to reboot their systems) would allow the sysadmin to see
> what is happening (either via /dev/mcelog, or via EDAC driver).

Err, this all sounds to me like the storm detection code should
*automatically* disable the CEC in such cases, I'd say. Because I
don't see a cloud admin going into the debugfs and turning it off.
Rather, if the detection heuristic we use is smart enough, disabling it
automatically should be a lot better serviceability action.

Hmmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
