Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ABC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA6C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RZG3AYXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfDVRPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:15:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfDVRPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:15:36 -0400
Received: from zn.tnic (p200300EC2F07AE003D173D9528C0693E.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:ae00:3d17:3d95:28c0:693e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD5D11EC0235;
        Mon, 22 Apr 2019 19:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555953334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qImhd0qnATi3Q8LNHxAlr75vYj0LFSftOjlYNnLEBYE=;
        b=RZG3AYXlDireYvM5Yx5mlK0aY/HzFTr8a4RYegl3tJyFXs3WtGFOQz29wFUVOwFc+4PjXx
        BfD3iAiGGgr6WYzF3hBVYpmXw0s2BVHIZH3E7L6MT7sw0x/aEMaCXw3bqJBSB8HAdSpEWW
        bzkG1YWET8PYTm5mft2SHp6l9SAPSDM=
Date:   Mon, 22 Apr 2019 19:15:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190422171532.GH21457@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <20190419000745.GA12291@agluck-desk>
 <20190419002911.GB559@zn.tnic>
 <20190419150400.GA12738@agluck-desk>
 <20190420094120.GB29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A404@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E90A404@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 03:59:16PM +0000, Luck, Tony wrote:
> > Err, this all sounds to me like the storm detection code should
> > *automatically* disable the CEC in such cases, I'd say.
> 
> Sounds good. But we should distinguish storms that have many different
> addresses from storms that just ping a few addresses.  CEC will see counts
> hit the threshold in the latter case, but it might not be able to take the pages
> offline (because they are locked, or in-use by kernel).
> 
> So I think the change might be to the return value from NOTIFY_STOP to NOTIFY_DONE
> ... but only if we are in the middle of a storm AND the CEC array is full.

Well, regardless of this specific use case, isn't that a generic enough
action that we should do always? I mean, the aspect of falling back to
logging to external agent.

However, currently we don't signal that the CEC is full - we simply
remove the LRU element in cec_add_elem() before we insert the new one.

We can either return a specific retval to say, CEC is full and we had to
delete an elem or we can add a cec_is_full() accessor...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
