Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8941021929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tMfQjo2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfCVRr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:47:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33067 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfCVRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:47:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so2028647pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u0uNQgdU9iPi2AZeRa/JpiB2eMPriaZmBEZB7zw2ODY=;
        b=tMfQjo2J5b4Ie59iqxG7Mf0GQx3uzZheqE3eZnF37crg1+rgbgdWibKaxu3r3WfdRT
         XGjkXUX6cBTlKx7N0Ufy5sh6pEf44WLxi5m0w9CkA3UCmWEaVCTx7E5YZPAgtobA8+Cu
         VAz/NDQXr63ZnvFIo7ze0Xr9hu6RlOlayw3nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u0uNQgdU9iPi2AZeRa/JpiB2eMPriaZmBEZB7zw2ODY=;
        b=Nm3rIVaMxlpWwBBQr3w9Q0RwVpV9ldbBR8BTtCnfC4HXULd4UHmDVQ+GoWKcR3AIbM
         zZKLtrG0MCk40XsGgZ3ubCS5HJjSpz0hU+5YkuuRDfwyrAgN5ChyuMHhkCEv43pqgcdw
         1H1BUuIheb5ZrIy3L2FscRVovaQi8pKc3B9zqJyjrbv95hldkKBU3UhK4I7r6cCjWXtA
         kMHuDCT1UXrhEAKU/V7/tC03fDX/pLQ0vUKSTFV84ECrmbJ2Rk3IE55TuglJmaNFWoBM
         HNjvoCFbDkmtZc4l/pNjJOWWoQtW/Bae+CsmtWQLXs8CnZ1kfxROxvIOHydjxkQ8/zFP
         J1XQ==
X-Gm-Message-State: APjAAAXEl7C7j61nWmtVS5B7cYDOfSQPUt/g/Og4IoYi6qT4QHZVxG2s
        tabznI/3iw2/2sUbacAb5Cu9rw==
X-Google-Smtp-Source: APXvYqwFhO2CTRE4uTw9aTfSTJFvnhmcTLTF00a8sW30riT/gKhZKqUJpKXl6lPXY7UzdTnG5BLlJw==
X-Received: by 2002:a62:7049:: with SMTP id l70mr10513791pfc.78.1553276875878;
        Fri, 22 Mar 2019 10:47:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m79sm18890920pfi.60.2019.03.22.10.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 10:47:54 -0700 (PDT)
Date:   Fri, 22 Mar 2019 13:47:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-ID: <20190322174753.GA106077@google.com>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
 <20190322165259.uorw6ymewjybxwwx@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322165259.uorw6ymewjybxwwx@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:52:59PM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 21, 2019 at 03:01:06PM -0700, Andrew Morton wrote:
> > On Thu, 21 Mar 2019 20:03:26 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> > 
> > > Hello.
> > > 
> > > This is the v2 of the https://lkml.org/lkml/2018/10/19/786 rework. Instead of
> > > referring you to that link, i will go through it again describing the improved
> > > allocation method and provide changes between v1 and v2 in the end.
> > > 
> > > ...
> > >
> > 
> > > Performance analysis
> > > --------------------
> > 
> > Impressive numbers.  But this is presumably a worst-case microbenchmark.
> > 
> > Are you able to describe the benefits which are observed in some
> > real-world workload which someone cares about?
> > 
> We work with Android. Google uses its own tool called UiBench to measure
> performance of UI. It counts dropped or delayed frames, or as they call it,
> jank. Basically if we deliver 59(should be 60) frames per second then we
> get 1 junk/drop.

Agreed. Strictly speaking, "1 Jank" is not necessarily "1 frame drop". A
delayed frame is also a Jank. Just because a frame is delayed does not mean
it is dropped, there is double buffering etc to absorb delays.

> I see that on our devices avg-jank is lower. In our case Android graphics
> pipeline uses vmalloc allocations which can lead to delays of UI content
> to GPU. But such behavior depends on your platform, parts of the system
> which make use of it and if they are critical to time or not.
> 
> Second example is indirect impact. During analysis of audio glitches
> in high-resolution audio the source of drops were long alloc_vmap_area()
> allocations.
> 
> # Explanation is here
> ftp://vps418301.ovh.net/incoming/analysis_audio_glitches.txt
> 
> # Audio 10 seconds sample is here.
> # The drop occurs at 00:09.295 you can hear it
> ftp://vps418301.ovh.net/incoming/tst_440_HZ_tmp_1.wav

Nice.

> > It's a lot of new code. I t looks decent and I'll toss it in there for
> > further testing.  Hopefully someone will be able to find the time for a
> > detailed review.
> > 
> Thank you :)

I can try to do a review fwiw. But I am severely buried right now. I did look
at vmalloc code before for similar reasons (preempt off related delays
causing jank / glitches etc). Any case, I'll take another look soon (in next
1-2 weeks).

> > Trivial point: the code uses "inline" a lot.  Nowadays gcc cheerfully
> > ignores that and does its own thing.  You might want to look at the
> > effects of simply deleting all that.  Is the generated code better or
> > worse or the same?  If something really needs to be inlined then use
> > __always_inline, preferably with a comment explaining why it is there.
> > 
> When the main core functionalities are "inlined" i see the benefit. 
> At least, it is noticeable by the "test driver". But i agree that
> i should check one more time to see what can be excluded and used
> as a regular call. Thanks for the hint, it is worth to go with
> __always_inline instead.

I wonder how clang behaves as far as inline hints go. That is how Android
images build their kernels.

thanks,

 - Joel

