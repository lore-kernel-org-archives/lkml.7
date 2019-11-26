Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA44C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0620727
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOUw6OyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfKZOSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:18:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43845 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKZOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:18:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so9239384pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBdouh9S1MhvrD/kNTcGzrKJl/ZApbLso5GEexYTgDs=;
        b=oOUw6OyGSa70IrR3M3csiqUs1mxCclXg+qT5ly/AS/plv+4+XEd82gpMMq6f3pithx
         MSA76asYj2csFqee0PNYx77K22cgN7M5ZisTbFQOa0x/sPn+hMsaQid2Ut/JAYovfngi
         oU8Gz8I8mOopZm4UWyHikNRTa8M3IJ4PSZvXTXZl9FGae2yVi/7kgEfRkFHJ16hK5UOR
         BDLDf9auF3wqAft4SdzunSE1W6TPMuV5/x4uVhpLwfrpyzTOOeZKJtegRLacYde4Gbk4
         aNSOnoTxA6IjT4T1eDoXaXwJ3rFbwAWhMRAzzUq0T5meq0nSwM/G9FBfhsoWmXyWKTCt
         /oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBdouh9S1MhvrD/kNTcGzrKJl/ZApbLso5GEexYTgDs=;
        b=YHgIn7UGeL8GezNaGpZ+ZUQ6yL1fZaPIngai1qWUC1HHysm0HBDvCS3CUEVmrOoSN9
         +T/d0eQ4mWOKqcfsFZlzGBi/cTYS07TJjFhkwjtGBxaJSPR7EB8J2XgSR9qU3fn/wcqK
         U1CzgNZegFGzpHywuek/YI+DoVxHtVnJOi8vmDhtH0HWyXBQuH2dvvonbXB5JgFYsnXJ
         2ziP1ScuN0PyxCMdwMah9tYIe8DUETf6W3DLqtsqwv/sgtpxmt72HCVnB5eKS5VHeEom
         UkqlMw0pB+fRl4kI3QTxQ0Ld1qdfw7Qo69KFEbZ11Y7OVETAD501HdoXHkOaDyOvtieA
         7DPQ==
X-Gm-Message-State: APjAAAUgjcjzP2Z77q0D6FAT+n2tXgxZOmhWkVCD4Cc2N01SVO4FFTL5
        n4FRlBikIBk7L52K3aUMs2M=
X-Google-Smtp-Source: APXvYqyOJ0edFAzQbhZry+oKTfK8vHS2o/PymwvgzLnrxG1JQbPzGn3gOqElUiFuRxnB8SWMcNwIvQ==
X-Received: by 2002:a63:190a:: with SMTP id z10mr34906983pgl.153.1574777912126;
        Tue, 26 Nov 2019 06:18:32 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id k24sm13189443pfk.63.2019.11.26.06.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:18:31 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:18:22 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] perf: support multiple debug options separated by
 ','
Message-ID: <20191126141820.kodiejolpyxwz5ck@mail.google.com>
References: <20191125151446.10948-1-changbin.du@gmail.com>
 <20191125151446.10948-2-changbin.du@gmail.com>
 <c22da5eb-71dd-511b-bc9a-4981c3b22d4c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22da5eb-71dd-511b-bc9a-4981c3b22d4c@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 11:10:45AM +0530, Ravi Bangoria wrote:
> 
> 
> On 11/25/19 8:44 PM, Changbin Du wrote:
> >   	List of debug variables allowed to set:
> > -	  verbose          - general debug messages
> > -	  ordered-events   - ordered events object debug messages
> > -	  data-convert     - data convert command debug messages
> > -	  stderr           - write debug output (option -v) to stderr
> > -	                     in browser mode
> > -	  perf-event-open  - Print perf_event_open() arguments and
> > -			     return value
> > +	  verbose=level		- general debug messages
> > +	  ordered-events=level	- ordered events object debug messages
> > +	  data-convert=level	- data convert command debug messages
> > +	  stderr		- write debug output (option -v) to stderr
> > +	  perf-event-open	- Print perf_event_open() arguments and
> > +	                          return value in browser mode
> Shouldn't this be:
> 
> 	  stderr		- write debug output (option -v) to stderr
> 	  			  in browser mode
> 	  perf-event-open	- Print perf_event_open() arguments and
> 	                          return value
> 
This is an accident when rebasing. Thank you.

> -Ravi
> 

-- 
Cheers,
Changbin Du
