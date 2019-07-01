Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F31C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A90216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfGAQj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:39:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:25953 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbfGAQjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:39:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="361893750"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2019 09:39:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0B15F30120F; Mon,  1 Jul 2019 09:39:25 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:39:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] x86/xsave: Make XSAVE check the base CPUID
 features before enabling
Message-ID: <20190701163924.GB31027@tassilo.jf.intel.com>
References: <20171005215256.25659-1-andi@firstfloor.org>
 <20171005215256.25659-5-andi@firstfloor.org>
 <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36a8cc2-3d9e-dc70-bbe4-bfc5edef395a@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The commit for this patch in mainline
> (ccb18db2ab9d923df07e7495123fe5fb02329713) causes the kernel to hang on
> boot when passing the "nofxsr" option:

Thanks.

Hmm, I'm not sure nofxsr ever worked on 64bit. Certainly SSE cannot be
saved/restored in any other way during the context switch. 

So even if you pass it successfully I doubt user space will really work
for very long.  64bit binaries require SSE.

AFAIK it is only useful on systems without SSE, presumably
running 32bit kernels.

Should check that case.

My recommended solution would be to just get rid of the option.

Presumably it's just some old chicken bit.

-Anfi

