Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4658720873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnjc2S02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfJCNnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:43:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36827 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJCNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:43:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so3639227qtf.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xRF4UQuvmBO+pGGd7D5Co12GdfuY83tM3lojzxMDr+w=;
        b=Jnjc2S02McpYuQkXuoYKUdLDDERnjwtTm7SneIUw12GT2dJzZgbu0KI4qMS5S0MEAe
         w85o3Qyq2Di0VaZU3yCtQNKR0bhmc0Jk+2EjOTyqnVCkSZSN7FzvLuGFVZE9rB8zeb9c
         oD/yuvwDQnUdTonHB+wLxR30xKmYCtEl5IcEyo4T3d1s4mEw9RjjjyVvZD7KhLOUJOtK
         IWxAipO2yzbYqQvnr43Nye39SELD3gOmC7YoQwJAXfCHwj1kcxI10nBBBF5caDIBQQGC
         XFE4ZYjdHt5tcjFxaIGvp1zn2B171u6OdkDwMwWyqrrifDEcYVEZZQhqNEKDSq2aDrlV
         P9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xRF4UQuvmBO+pGGd7D5Co12GdfuY83tM3lojzxMDr+w=;
        b=NNBqF4aiPd6xkcC806RMPC0uXYPBDhPdG5JVdplsf6kxEMJirF/u4yNBzl396/mLhh
         YQIU5B+rLFjb2U9aDX6nnAR449+RCBvejiR+iSUqadRNNqvjnyEdWrR+eRCUbAjBkLrx
         4mhc/OaFzEYie0lH4H5YE/WO+rsrqQmZqTnAPDaFHbDc1fuOIwuLm88zfh+RvWXsegkz
         cZzpCZaCXtEBj6PnPuS2+fgPy4ULldvSq8qXAIBfOeweT4L4aXFUT/Qvi56iGQcRqkPg
         SeueLsxxMEmXB/EDCWO1fmWjMS+k3DY+bAi4/QZm0d5pwCIqZMwQLhQoJBrT9sg/MluN
         oIEg==
X-Gm-Message-State: APjAAAUj19ZIc+Hw3kzcsBiShacc3URfGXao/a2Qraav75Bwye+HEUoA
        hLJazUA2HehHET4haC8ufW0=
X-Google-Smtp-Source: APXvYqxbs63MzCQuh0bhPMSxEgdT2ebZiqBC+L09sSwLoX634kp/iTb0M+U/WxZeXrxpsUusrslJ3w==
X-Received: by 2002:a0c:91a2:: with SMTP id n31mr8641798qvn.182.1570110226017;
        Thu, 03 Oct 2019 06:43:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t63sm1366548qkf.48.2019.10.03.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:43:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E82BD40DD3; Thu,  3 Oct 2019 10:43:40 -0300 (-03)
Date:   Thu, 3 Oct 2019 10:43:40 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] perf scripts python: exported-sql-viewer.py: Add
 Time chart by CPU
Message-ID: <20191003134340.GB9369@kernel.org>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
 <6f55cdb7-a431-bd1b-8e7f-f8caf92399af@intel.com>
 <ed9138ac-d035-1be7-9fbd-e82e7f9ca6d0@intel.com>
 <20191003132531.GA9369@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003132531.GA9369@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 03, 2019 at 10:25:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Oct 03, 2019 at 02:01:16PM +0300, Adrian Hunter escreveu:
> > On 6/09/19 11:57 AM, Adrian Hunter wrote:
> > > On 21/08/19 11:32 AM, Adrian Hunter wrote:
> > >> Hi
> > >>
> > >> These patches to exported-sql-viewer.py, add a time chart based on context
> > >> switch information.  Context switch information was added to the database
> > >> export fairly recently, so the chart menu option will only appear if
> > >> context switch information is in the database.  Refer to the Exported SQL
> > >> Viewer Help option for more information about the chart.
> > >>
> > >>
> > >> Adrian Hunter (6):
> > >>       perf scripts python: exported-sql-viewer.py: Add LookupModel()
> > >>       perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
> > >>       perf scripts python: exported-sql-viewer.py: Add global time range calculations
> > >>       perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
> > >>       perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
> > >>       perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
> > >>
> > >>  tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
> > >>  1 file changed, 1531 insertions(+), 24 deletions(-)
> > > 
> > > Any comments?
> > > 
> > 
> > ping
> 
> Nice stuff, but please next time, when you add a new UI accessible
> visualization, provide precise steps to collect, then generate the DB
> and finally run the GUI, so that interested people (like me, when
> testing) can follow those instructions and compare the result described
> to the graph the test would see following these instructions.
> 
> I'm trying to do that now.

The F1 help text helps in that direction, but only once you're in the
GUI.

I did limited testing this time, couldn't get what is in the help text
in the GUI, close but not exactly, I'm applying, since this doesn't
affects anything outside these scripts and I think that if some set of
instructions, which I encourage you to detail next time, are followed,
then the expected result looks promising.

- Arnaldo
