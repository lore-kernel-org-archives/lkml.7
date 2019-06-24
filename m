Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AE52133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561368914;
	bh=V+JNcIbt/6VMBYdQNX/9snknRFUTiqfcznYN8RZhvtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DphTuEPk+YCzXgP7CrE8SMLRtRabH3n472iGMhXZ8oV16GEVu4WeeAcPa0XmQUAVh
	 IxT0nZA8OJZMEt+Koxz0Ndbt+6AvACyeFN2174OcNYFOyJsA9RUQUFsCVsjRKEdqxP
	 QaxVN1xMDQoB6CGmLzucLWe4JFDkk6QA+8mcc4Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFXJfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFXJfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:35:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8EA2089F;
        Mon, 24 Jun 2019 09:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561368912;
        bh=V+JNcIbt/6VMBYdQNX/9snknRFUTiqfcznYN8RZhvtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZZkyhVjPxs92xmMnw0gDIRG16eJWCsvHc7Hg5RDsDJmTCBhHEBTojZ9qQ98hKZWk
         0+f3k5bX6F0Fkj813jbFbAW3IXULoD/yEAzXSX7dwjYgUVPKbDo/Z0piWvGWfN/gQt
         JgMhb1xlGDR29eCwqhAeDu4J6YRFoheN3QL2EW70=
Date:   Mon, 24 Jun 2019 10:35:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
Message-ID: <20190624093507.6m2quduiacuot3ne@willie-the-truck>
References: <1560461641.5154.19.camel@lca.pw>
 <20190614102017.GC10659@fuggles.cambridge.arm.com>
 <1560514539.5154.20.camel@lca.pw>
 <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
 <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian Cai,

On Sun, Jun 16, 2019 at 09:41:09PM -0400, Qian Cai wrote:
> > On Jun 16, 2019, at 9:32 PM, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > On 06/14/2019 05:45 PM, Qian Cai wrote:
> >> On Fri, 2019-06-14 at 11:20 +0100, Will Deacon wrote:
> >>> On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
> >>>> LTP hugemmap05 test case [1] could not exit itself properly and then degrade
> >>>> the
> >>>> system performance on arm64 with linux-next (next-20190613). The bisection
> >>>> so
> >>>> far indicates,
> >>>> 
> >>>> BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-next/core'
> >>>> GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-next/fixes'
> >>> 
> >>> Did you finish the bisection in the end? Also, what config are you using
> >>> (you usually have something fairly esoteric ;)?
> >> 
> >> No, it is still running.
> >> 
> >> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> >> 
> > 
> > Were you able to bisect the problem till a particular commit ?
> 
> Not yet, it turned out the test case needs to run a few times (usually
> within 5) to reproduce, so the previous bisection was totally wrong where
> it assume the bad commit will fail every time. Once reproduced, the test
> case becomes unkillable stuck in the D state.
> 
> I am still in the middle of running a new round of bisection. The current
> progress is,
> 
> 35c99ffa20ed GOOD (survived 20 times)
> def0fdae813d BAD

Just wondering if you got anywhere with this? We've failed to reproduce the
problem locally.

Will
