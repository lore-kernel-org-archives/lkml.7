Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF2320692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5+k1mpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKSK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:58:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43550 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKSK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:58:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so22637795qtn.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UsTh+xCjjdK6+MdMQmxQsp/kaHq+eV0gtDwAeRePTrE=;
        b=b5+k1mpu6wgISw6nVP/2vItt0wQPufEHT1DfUeuREjhfn7tm+9aByMLEvQf1jfUQL8
         /LcQGFpyGm2i83kRvTyJZeO87CxjcWkpPkfmxjsA7hWB3QC8M3lKVgKBZyQA56qHHsSG
         sn4AdGKZztZU8YnwL3l//+WLY09hWUpnE91YxEImMvouGhJM6hyuaVQUT8atKa8nFNDw
         JUSXQBLWcpoG6qX2hp6TftobV9fbd7jzhFwF6Xw+O7ao0ah+dSILG2sXR2506/opEThq
         oWuR7TxGNoG2kArfmOsyNhUpZAQXOG/cHBaj51UaTIrC9kpDRGbO2pDe4ox3bTq9R/GT
         VTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UsTh+xCjjdK6+MdMQmxQsp/kaHq+eV0gtDwAeRePTrE=;
        b=riR7R4ObYh8nusUjGf4OGdNv1bKKkvxGBr8tvrFeBOVoD/12UgWpIrpx/ii44OSG5N
         C2kFXkn03nUNQWOCNLMz7x9Y6vv8tdv5PEe073GZTogpYmW+WdoajBoDpaTkjL6XYNzq
         s7QefwquE+v5oKQjQbS0i1Cr9XItFXRpC185dvyHjWHAMKD4HLoMXr0XhxQoMPGPwZwi
         MbHfhFT9lDCsMUgxa5WkMgAlt1WLuISPv54/NxtB4kO3CO9/XBCAvRTWUkTOXb1teXWH
         AoWk17YTCZeExigwq1adLIIXKhBmf4aa1F7AThW35sslmjbfnj+i3jyKT2CJJuS2DI3g
         wC+A==
X-Gm-Message-State: APjAAAWLPgtHrUsmyszbMm6ntDPjiTY3MnEaTQsiVK+z5mY/rXKRTF8r
        mjEjOOvQSGxAyzZX6Dkoyw60NBFU
X-Google-Smtp-Source: APXvYqzUXcYJov6MspF3hJ+8eTM/8Ppc39qvoWp26a8gmLzksgB6xpl0eZk/28vEEekLOxRpnuIHWw==
X-Received: by 2002:ac8:35c4:: with SMTP id l4mr31820128qtb.151.1574161123713;
        Tue, 19 Nov 2019 02:58:43 -0800 (PST)
Received: from quaco.ghostprotocols.net ([2804:1b1:210b:b531:3262:b41d:99d:28e1])
        by smtp.gmail.com with ESMTPSA id 76sm10165517qke.111.2019.11.19.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:58:43 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2840740D3E; Tue, 19 Nov 2019 07:58:26 -0300 (-03)
Date:   Tue, 19 Nov 2019 07:58:26 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Subho Banerjee <ssbanerje@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events: Make the power8/power9 event files
 valid JSON
Message-ID: <20191119105826.GB24290@kernel.org>
References: <20191117231600.27632-1-ssbanerje@gmail.com>
 <20191118221316.GG20465@kernel.org>
 <E980D3B0-4519-451C-A0D7-7A8CE1A5AB2C@gmail.com>
 <5b051139-039c-4e16-76b8-05af17eb9113@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b051139-039c-4e16-76b8-05af17eb9113@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 19, 2019 at 08:53:10AM +0530, Ravi Bangoria escreveu:
> 
> 
> On 11/19/19 8:48 AM, Subho Banerjee wrote:
> > Hi Arnaldo,
> > I am uncertain which commit you are working on.
> 
> https://git.kernel.org/acme/c/835e5bd90926f8
> https://git.kernel.org/acme/c/da3ef7f6cd5222

Yeah, I'm prepping a pull request to Ingo that will include those.

- Arnaldo
