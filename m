Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90DE20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553009412;
	bh=vcUsJMcNmVonyVgiA4PslIhmChd2/nNhU6pK22B0D74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wc+mWWVvscrMPxTm8kMPIZskFkoivdNPe+IEfVWVuALv/vBd3mn52Tr93q7YfOWpR
	 UX3Oi4LwG/txRQBFXx6LpNlM9CXzaZJS4GyM2csH2Jen9K9MLR+wdGlXnlV+KQPDxL
	 tjG50ZHNiDV/askedvU0RPKY6FFOdy0bDvdqGX/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfCSPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:30:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37530 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:30:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id w66so16216536ywd.4;
        Tue, 19 Mar 2019 08:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tuUUgxmNDvPHeoCaS/B39ohupSnY/F5JmNXASuRQpfA=;
        b=XQgz9JRe7G3v6Bf0k06XNxAYz5ZN1xFugwQpDyYwDLHbTJiv1jvFSHPu4Lf534O1Ut
         x2SMu1THN/dji7Q8ywYpJK26IZ0aKbPy0X5ngjXfrMjRX+YSy5OCFpLNlvniGSrm7+oV
         h0HnOdPfBfk6oF9A0CuzvRARumaBbbvLM87e8vuDsXejvKt92GJdozxVHik7D6gOg0Gf
         7ergkIAxQ9exNKf8p+LEbmqqurac8vsd7OFdVUcnCnVDmhug/mkPDlK6taM9aem+5cxN
         fmttMK7NWf9YYOJ94fwlrU0OVBu45mkhwCkdjXFbUIOuZt6oBg9iBt7wVjwN554HQIF4
         jLJg==
X-Gm-Message-State: APjAAAUC1OG2BSeNY+ntbIU1CffYtxQ4Sy+C8YW9j5faHtXkbULPzJrF
        zIQBDN52ZfpP0eoFgucnlJ8=
X-Google-Smtp-Source: APXvYqysNdLzJOdWHtKw6viwfgku8O/E5aJA/G++/0+gUk4paLJHhml4PWnlMSN13EbX7AVKurDSVA==
X-Received: by 2002:a81:a7ca:: with SMTP id e193mr2503776ywh.410.1553009409114;
        Tue, 19 Mar 2019 08:30:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b67sm1154399ywb.102.2019.03.19.08.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:30:07 -0700 (PDT)
Received: by 42.do-not-panic.com (sSMTP sendmail emulation); Tue, 19 Mar 2019 15:30:05 +0000
Date:   Tue, 19 Mar 2019 15:30:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
Message-ID: <20190319153005.GA1146@42.do-not-panic.com>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <0ffd0eea-ca64-0128-2835-a9856b224e07@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ffd0eea-ca64-0128-2835-a9856b224e07@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:43:09PM -0600, Eric Sandeen wrote:
> On 2/20/19 5:32 PM, Eric Sandeen wrote:
> > Today, proc_do_large_bitmap() truncates a large write input buffer
> > to PAGE_SIZE - 1, which may result in misparsed numbers at the
> > (truncated) end of the buffer.  Further, it fails to notify the caller
> > that the buffer was truncated, so it doesn't get called iteratively
> > to finish the entire input buffer.
> > 
> > Tell the caller if there's more work to do by adding the skipped
> > amount back to left/*lenp before returning.
> > 
> > To fix the misparsing, reset the position if we have completely
> > consumed a truncated buffer (or if just one char is left, which
> > may be a "-" in a range), and ask the caller to come back for
> > more.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> Would be nice to fix this bug.  I submitted the test node patch as well
> as an attempt to integrate it into the test harness, though there's
> wonkiness there still, and I could use more experienced eyes.

Sorry for the delay.

I'm rolling these changes in with some minor adjustments, can you send
me your respective lib/test_sysctl.c changes? I don't see that they had
been sent.

  Luis
