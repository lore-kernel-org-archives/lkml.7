Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0FDC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A711F256B6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LCpbGaIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfE3Juw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:50:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36712 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfE3Juw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:50:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v22so3417896wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iSdK26IrmOEc/B9VC/Q0XsQRMEkKcuvxsa2POFBAfWg=;
        b=LCpbGaIPpV5r99H6iR6FLlmoZ3ctc0Wo0tAaXSBSHw6z4REiqnyT7PkFbOzd+UPe5l
         sK0Z4FkJ1KPKDQ/Wssfmzm5JrLnfiFJaVvCUvp7coOL1SGorMfV3kiLVeRVzWKiJzycw
         lGaUA5D/+pAfiiopfPIWvDalUZjZWblLTfOZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSdK26IrmOEc/B9VC/Q0XsQRMEkKcuvxsa2POFBAfWg=;
        b=RgRX6yJIbyaBpjAw/SHfcZLdgEEJZtIlaibuM+2IL2VgVjuO9zX5zic9YrurzSrjti
         RlYhdQ7te0nkwT4KWcOvtGZ4nD/BNCy07XBNqW9lYbTPWJ2m8/G9st4APKBRuKQIxvpk
         srZMKkSY4Nk7F+yWeNsFo8rOOFqFvewquJWqg4275ocu13ZfjrWFRKDiXiAn0/KTEKau
         iU4T/2gt2/w1sUsdASQfH9PyrVT5Objk9houRd1urY8GfGb68DttEf5dau44SwlRBREl
         3P2TQP63COpSFftueoztju+SjiR3ITdomWnDONblFp5vAVoMDfTq2KFhTOz0KszMzn4/
         l5tA==
X-Gm-Message-State: APjAAAVXZ5N6CPd0qGvAUB5CFMoeV16PBQY7rRu+s48bx1HvEclPDmQb
        ZQlAceQJHfIvc9UbSKKQUm8k+g==
X-Google-Smtp-Source: APXvYqw3JemapasX1/My3YJlram8J8fq6dLm3PSfYNtI5KnSufTCDzzS1B4NA4dYJrfzNDS+QjZaeA==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr1700893wmg.30.1559209849831;
        Thu, 30 May 2019 02:50:49 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id x68sm2239214wmf.13.2019.05.30.02.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:50:48 -0700 (PDT)
Date:   Thu, 30 May 2019 11:50:39 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        raven@themaw.net, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190530095039.GA5137@andrea>
References: <20190528231218.GA28384@kroah.com>
 <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
 <31936.1559146000@warthog.procyon.org.uk>
 <20190529231112.GB3164@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529231112.GB3164@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Looking at the perf ring buffer, there appears to be a missing barrier in
> > perf_aux_output_end():
> > 
> > 	rb->user_page->aux_head = rb->aux_head;
> > 
> > should be:
> > 
> > 	smp_store_release(&rb->user_page->aux_head, rb->aux_head);
> > 
> > It should also be using smp_load_acquire().  See
> > Documentation/core-api/circular-buffers.rst
> > 
> > And a (partial) patch has been proposed: https://lkml.org/lkml/2018/5/10/249
> 
> So, if that's all that needs to be fixed, can you use the same
> buffer/code if that patch is merged?

That's about one year old...: let me add the usual suspects in Cc:  ;-)
since I'm not sure what the plan was (or if I'm missing something) ...

Speaking of ring buffer implementations (and relatively "old" patches),
here's another quite interesting:

  https://lkml.kernel.org/r/20181211034032.32338-1-yuleixzhang@tencent.com

Thanks,
  Andrea
