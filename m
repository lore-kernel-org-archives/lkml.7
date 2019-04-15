Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C8E20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzg6vcBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfDOT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:26:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36878 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfDOT03 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:26:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so20569027qtn.4
        for <Linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NUtHB5ZRTSEGltO6O8A8ZvVQFxum+DmHZwL6+zGp0hA=;
        b=rzg6vcBZcGXBl8/FYc3rU51cxuiDfpXm9ELBsmI5oYNJiYnJ6vXJliyh6NanL2z7xm
         nMNja6olas3moFVoNsr4stlL4Bqi6k/DMkgUlNTfuwWcjV+6L84iGSzAKWzGAnZbJ9z1
         ZDggZ7fTGgaHRDqMRyxKF4M9hOwN23lvXAYmhedo2aFiUH/rmXCxpUM8nPGS1uK0PziI
         CLP1PtzbGdu9wwD2lvb2IHRnnIu9Qlz6i4Dgp+jYSi8dMOukwdRkZQzbmv73VxVLhp+U
         gcXFdXkMZ6TrtjVM6fhKrs3xPK7TsEDQhRO7WB79hnzpFrhlR0SDVFwsbeMr3FFeE1EP
         JElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUtHB5ZRTSEGltO6O8A8ZvVQFxum+DmHZwL6+zGp0hA=;
        b=tdF/wf9/nRZ2KDnnE/RByQvRewx1BstxRE+vbfEE460IeoxmZ/IX2zWW4uULovqKF3
         M7wEBGgGJBKQgbnn9p0vsOcVF9PGrKOrX+AxKzD6q7k+DM34H6lA3X9aakCBSFrFT8qi
         bjcATmtH+GBPJ6c+ohHUydX3Ibr7squhhjb8wKk51j/OX9fUvle2aOkCTApyO9BjuA6c
         1AaDuAKOpS8iBOwUPIdfJOu7VKJW4G8BE4Y7xvnfCiETSrxu8o6OEfh+iAvDSPBHTyyp
         a9e8c5WEJ3zDosdIn1BhGpLF8VDm4AR7QWrsd76BH6mSeORX9jsfrxyzs2OVy6+AS0tc
         GzEQ==
X-Gm-Message-State: APjAAAUtEOyqs+pJFS7D8WCAWJCfXuspZ4UAn8y02eoGUFyYqMm+Y4s7
        nuBXLJT38DR3+8UXlsMvNBY=
X-Google-Smtp-Source: APXvYqzKYTymHVbqUk+QxndPnohP9s4xzy+cuz2Cg4H7utkUwNL9D2jXU9Le9rZwRc38u5kU+pbPPQ==
X-Received: by 2002:aed:3647:: with SMTP id e65mr48704614qtb.44.1555356388662;
        Mon, 15 Apr 2019 12:26:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id m18sm33854172qki.64.2019.04.15.12.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 12:26:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAD684039C; Mon, 15 Apr 2019 16:26:23 -0300 (-03)
Date:   Mon, 15 Apr 2019 16:26:23 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/4] perf stat: Support 'percore' event qualifier
Message-ID: <20190415192623.GD11294@kernel.org>
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
 <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
 <bba8359b-7986-0938-16ea-9bc179ef76cb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba8359b-7986-0938-16ea-9bc179ef76cb@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 15, 2019 at 08:09:09PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 4/12/19 7:29 PM, Jin Yao wrote:
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > index 39c05f8..1e312c2 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -43,6 +43,10 @@ report::
> >  	  param1 and param2 are defined as formats for the PMU in
> >  	  /sys/bus/event_source/devices/<pmu>/format/*
> >  
> > +	  'percore' is a event qualifier that sums up the event counts for both
> > +	  hardware threads in a core.
> 
> s/both/all/  :
> 
>   $ lscpu | grep Thread
>   Thread(s) per core:    4
> 
> 
> Apart from that, for the series:
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Yeah I had fixed up that already, fixed up the patch description this
time around, "both" was being used there as well, changed to "all".

Thanks, added your Tested-by tag, appreciated.

- Arnaldo
