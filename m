Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94061C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4D2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdZWNsAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfDTFur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 01:50:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35391 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTFur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 01:50:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so3466129plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvSG5OR929pS3IPf3bCOkN/nYor89+EQTLrefXhGPyc=;
        b=PdZWNsAc825n2ka4S87erTyF5q+3fCGCVe1n8pSy92ToiXVE03t4T16C1VOcdTjakM
         5nRMRAHs9YHY2gWzejG9cYsAZFgHoSwJ2q8AU8Mt9QYjSoKteFP79BjEJCOrWJEa8j2C
         y4w7Tf/Q7DwtUmMhqh32S89tIIYk4sLvLpVwUVoyXlYZPgROE6RS/buzTpVS4RYqPC23
         8J32N0yr1l7t6b/argCCiabL9OVs/tAUNxD1o1RqwlO0QbXQC6ZRNhJlo5ODaAauT7Ac
         LuemUA+kXWinIA3od5Xuv7VFDl0sl2nzGS+7HwBGAged+1jVX/xg8rS1+cVQaJRlQOTY
         z5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvSG5OR929pS3IPf3bCOkN/nYor89+EQTLrefXhGPyc=;
        b=kEXrnPageyMq9674/2ztp+bEF2gbnraxxB+ghTUKCGgtHMDoKRNykW1QKyo4fWrRrX
         efbDhCDIPJkLM43hcfBvVFPINHb6KlwLOxtXiMmvwGoCPDJfCYrIEZxCKodoHHz7miVj
         CVYKB43+dUB0Vv00fLCmLxFkMJbUW58MNuyIWtWSr7Gs18pKHNs3fFMQ7fs/NNl0Q7bC
         Z/3k6NJP/t3Y88HvtqLWX7Li32CYmJB2ssUmjq2SCKn8Cx/Sa+t3VOBv6uAvTL2m7uot
         6mj2QNVSy3zIL3cas9Va4kKBtpvOxKKS25MjDHOW+OTx/P56Sfq5BO1w/dhjUXphemPl
         DiFg==
X-Gm-Message-State: APjAAAUMDaeKhga+wOhM5R3LSh+S9dvG+og2/oRFZ9PHx5sd5qSzsX1p
        X0NnlnSjS6I7/FoRCEUu5A0BC/Lc7MNu9kyKya1DtQ==
X-Google-Smtp-Source: APXvYqzrDdERVr8MCTrSIy7vd/7aoSQm7XFCltbkLbqkblVUgieMiqjWscNs4qWydD53sZcnLmuj1PAlAsxSkm9R4js=
X-Received: by 2002:a17:902:eb8b:: with SMTP id cx11mr3719297plb.70.1555739446768;
 Fri, 19 Apr 2019 22:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com> <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic> <20190419000745.GA12291@agluck-desk>
In-Reply-To: <20190419000745.GA12291@agluck-desk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 19 Apr 2019 22:50:35 -0700
Message-ID: <CAM_iQpVgnNPaqN2kyNoPFbrU4pk1U_8=G4GOWJniLAhStMg2AA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:07 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Fri, Apr 19, 2019 at 01:29:10AM +0200, Borislav Petkov wrote:
> > Which reminds me, Tony, I think all those debugging files "pfn"
> > and "array" and the one you add now, should all be under a
> > CONFIG_RAS_CEC_DEBUG which is default off and used only for development.
> > Mind adding that too pls?
>
> Patch below, on top of previous patch.  Note that I didn't move "enable"
> into the RAS_CEC_DEBUG code. I think it has some value even on
> production systems.  It is still in debugfs (which many production
> systems don't mount) so I don't see that people are going to be randomly
> using it to disable the CEC.

For me, "enable" is useful to make mcelog work like before. Please see the
other email from me for all the details.

For debugfs, I believe many productions mount it, as tracing still uses debugfs
rather than tracefs (at least on CentOS7), and rasdaemon also uses trace
events to collect different errors.

Therefore, I believe your patch is fine as it is.

Thanks.
