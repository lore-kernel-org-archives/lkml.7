Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46DAC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BDB206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557994593;
	bh=PdCpmUbmpqpTdBKFLPFgjQgpSknHTPpWqz0nse0/6GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hfoHLS4v9PvnawhOY+0PpAcUqP4hht4nDvVd2WZRlJuXc+4iW3qUmqZvCybrRAEZH
	 qE4/qAFDMZOdWnkkpyOU/qLjLmp5cO0aOToiYP1sw9/anWXFoTuR1rmkD+ACdNGCDz
	 CSZnmlg8BW7pUN560PdudckQjYi6dBUh3uGzCpfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEPIQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:16:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45223 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfEPIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:16:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so2233123wrq.12;
        Thu, 16 May 2019 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fnfe8Q9cs3mUyaf6ypStYy6Jn39oq2+1juaIcTgyT8=;
        b=qPMurDwKMikN+99yRkycl0UBlF9+bsgsK+t/KBSNF8dv9njkGn+bh2cyDWKlBylvhS
         nrWkZN3AKrr55HSxYWe5KBWlgve2PUg5PqqPyO8xS2zzkT5VmLjvTNqmeygfcb5sl91h
         mgBBlfBPtcZl3Y62KgjR8eBflUdFMjQZscpHF3A/TGuKGFWoCJqum4nWCrVigh/K03u+
         hICm2254MRLzISmjKns22x9SW1zP7o7VxGOfMu+wCr9MnJRGx8B4z9N+H6fKIoO8Dsvy
         Cz9LjM/6XATDqdmm/wU/4PUmmzxB5T0W1wUiM84beF2/0dUDKTeY2JUW1kkgpt8KoYIl
         CYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fnfe8Q9cs3mUyaf6ypStYy6Jn39oq2+1juaIcTgyT8=;
        b=tkEWMuPksBrTgcu0qIA3Zq3AWagYn8IXd8Umi9ckPTnyaz73HDOtJqfuRtV02APmNu
         LKnNLWHMuTbx0s7UBKDFwNmHzRiNkT/npqTMjHPhlObbe6J9HzohIP5HJwW78dfk6hEt
         QDty8GnoRIy5K2YVGieygVIWCc7QpNBLpOK3DFi+U5qTiBgM6BqSyXqb3ds0uROeoKRY
         C8UwARmGn4susKkMIAQSZcUfjW+IyIHi5og+4VMOqietu4e8BtY5MnlbxEd4O4p/1kvT
         MCLdFIcRvSuTsXemINzUpUvNLKfLhmV+YQYPRiZcb80z+1EmSaMj+3NI6LDiIFb7iSfb
         RTIQ==
X-Gm-Message-State: APjAAAXlhpYywPjKquxPqOX2pWcY3qvUMgcDtUBDBm75qsgXaA3wHkym
        vkhBrTTq6ep4W+CBTTram74=
X-Google-Smtp-Source: APXvYqxjSfJRXAtTYKgQve1Gfd36DHEOs3ixCCYsa6uTbx/h4372ohZLd7H2PLAYHboVJJ5dTV5H9Q==
X-Received: by 2002:adf:afdf:: with SMTP id y31mr26761723wrd.315.1557994590605;
        Thu, 16 May 2019 01:16:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d3sm6175861wmf.46.2019.05.16.01.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 01:16:29 -0700 (PDT)
Date:   Thu, 16 May 2019 10:16:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpu/speculation: Warn on unsupported mitigations=
 parameter
Message-ID: <20190516081627.GA109450@gmail.com>
References: <20190516070935.22546-1-geert@linux-m68k.org>
 <nycvar.YFH.7.76.1905160947210.22183@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905160947210.22183@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 16 May 2019, Geert Uytterhoeven wrote:
> 
> > Currently, if the user specifies an unsupported mitigation strategy on
> > the kernel command line, it will be ignored silently.  The code will
> > fall back to the default strategy, possibly leaving the system more
> > vulnerable than expected.
> 
> Honestly, I am not convinced. We are not doing this for vast majority of 
> other cmdline options either, if for any at all.

That's really a weakness - I've been bitten by this previously: I typoed 
or mis-remembered a command line option and didn't have it while I 
thought I had it.

Our boot-commandline library is pretty user-unfriendly.

Thanks,

	Ingo
