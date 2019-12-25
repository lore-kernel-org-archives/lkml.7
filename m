Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4163C2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5AF206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="oTJwdi6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLYAST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:18:19 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33227 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLYAST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:18:19 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so13267555vsa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 16:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yCuRpH7BbmrbreKDqovi403sYnD6tC6qKrGIsVS/jJM=;
        b=oTJwdi6RwjzMkN4p0paNOBXlC8ZfSFJ9AnOehPSLSVg5HiFqF2KNlsfv7e/5Bpevlz
         lzs+CN7aCZ6q9ugm6afGwL/Z0R7txLOdBPuhuk+V6ayhpM621hgoIWmfO70oz2weAJt8
         aFCbYatD8WCbCRNsY3UJ3exBpnm7A0WNfaZgJG01YwAW8V9oSlIzeIwUA6RCYD+LRklF
         5q6cfpYC7EE3iqLXjn1jYEh3mLGlc5b0bvsFjsfF+OkjanMYlDeemNp0VUEOdvpfFEoM
         LldckjWa/243zGy+Rbto211Irz4qednujsYwBhd/ylszvdWb5l059EqYVDFfyeMK40hv
         bsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCuRpH7BbmrbreKDqovi403sYnD6tC6qKrGIsVS/jJM=;
        b=J7ReqNPVVQkq2O1oMOnq5mbph4gfgXi0xsUZDa7b8H5pKwBMlvzgoDrmVTWCQS0VgY
         hRxOWf1eXsahtD1tS/CcYgKItWHzVxxVHHj0opig+ffNU5Hincfxhz/kO/MejvoNqD7W
         qqsi/JZiH0Y2EpNNKqQsAX/WGh39tROVXGlqUu4dHU6CkqXJEHhVJB9BQKPjTwCKAIYO
         5FLnp6zoz5NxuQ/CuDTxplLPdE8g7c0jnzZE3/W2Zv3Q8rLsZwsHT8PVGZ0TDvaxOnNg
         6CHeMb23C2Gx1nBnMfvfFA8jna03k7vP6ve1TxHgHwTnZK/pfwx47q20jYe8Gb5zXvZ6
         W2Fw==
X-Gm-Message-State: APjAAAW+wpYy1icUTGNfF6HiC4m0gW/MlBbF32mLTcs6y+9jzJY3/f9W
        kihi5PaDarQKWlCOLOMEKG5LHQ==
X-Google-Smtp-Source: APXvYqypagj+QMckm31iwmbpP2cFdUI5EchakkJZdYsv3XqKpJmOxaoEbQVMFcwP3y3YJVj80taOnA==
X-Received: by 2002:a67:fd7c:: with SMTP id h28mr19869942vsa.150.1577233098204;
        Tue, 24 Dec 2019 16:18:18 -0800 (PST)
Received: from frank-laptop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id x9sm6231988vsf.7.2019.12.24.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 16:18:17 -0800 (PST)
Date:   Tue, 24 Dec 2019 19:18:17 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        saiprakash.ranjan@codeaurora.org, nachukannan@gmail.com
Subject: Re: [PATCH 2/3] docs: ftrace: Fix typos
Message-ID: <20191225001817.ca757l4xbyx2oyz3@frank-laptop>
References: <cover.1577209218.git.frank@generalsoftwareinc.com>
 <638f1c8b6f4a47e4e25b62a01fe960e70a8364bc.1577209218.git.frank@generalsoftwareinc.com>
 <4d8a764c-88fe-56c0-e655-ed4052ab6d2d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8a764c-88fe-56c0-e655-ed4052ab6d2d@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 03:11:34PM -0800, Randy Dunlap wrote:
> On 12/24/19 9:57 AM, Frank A. Cancio Bello wrote:
> > Fix minor typos in the doc.
> > 
> > Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> > ---
> >  Documentation/trace/ftrace.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 5a037bedbf6a..6c9f40d5a2f9 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -236,7 +236,7 @@ of ftrace. Here is a list of some of the key files:
> >  	This interface also allows for commands to be used. See the
> >  	"Filter commands" section for more details.
> >  
> > -	As a speed up, since processing strings can't be quite expensive
> > +	As a speed up, since processing strings can be quite expensive
> >  	and requires a check of all functions registered to tracing, instead
> >  	an index can be written into this file. A number (starting with "1")
> >  	written will instead select the same corresponding at the line position
> > @@ -383,7 +383,7 @@ of ftrace. Here is a list of some of the key files:
> >  
> >  	By default, 128 comms are saved (see "saved_cmdlines" above). To
> >  	increase or decrease the amount of comms that are cached, echo
> > -	in a the number of comms to cache, into this file.
> > +	in the number of comms to cache, into this file.
> 
> That repeats the inwardness of the echo (in + into).  How about:
> 
> +	the number of comms to cache into this file.
>

Thank you. I re-sent the patchset with this improvement.

frank a.

> >  
> >    saved_tgids:
> >  
> > @@ -3325,7 +3325,7 @@ directories after it is created.
> >  
> >  As you can see, the new directory looks similar to the tracing directory
> >  itself. In fact, it is very similar, except that the buffer and
> > -events are agnostic from the main director, or from any other
> > +events are agnostic from the main directory, or from any other
> >  instances that are created.
> >  
> >  The files in the new directory work just like the files with the
> > 
> 
> 
> -- 
> ~Randy
> 
