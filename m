Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D3F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j45NAW+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfIRIKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:10:17 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41775 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfIRIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:10:17 -0400
Received: by mail-pg1-f170.google.com with SMTP id x15so3548378pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0OJKqrOMfT3gQYmIuxyvEYCFGosdjavxJSBJmH5EopI=;
        b=j45NAW+P8VXhZAG1sXy3EoVvE1sWmossLDs+RTftL6VuJrd0YcUaW45qSlkSLNRl94
         Cqe8Q3ttxpYYcYPjWn7o67n4QVmob2kQoAKUOx2xd+cOv6YtMo4xi4JmXiFYRWY3iFWM
         QlyHAm+jpN9EJ45ld+50JfsV3Ojz8KKpLoCJWNzwVC92KvkbHBo64uCct7MATEv9YgsC
         Uhq/m0664Ngwmgm0+GaJGm1kVtgyvKwbunqXgh0JCfv+a7N87W46iCeFmg2o2kWaSPfv
         4GukDY7rOffvycnPfocX0Bgk+Ly4Nc54Q26GaytcidPQO/s+AGVDN6E+WENu3a9iCvKg
         a3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OJKqrOMfT3gQYmIuxyvEYCFGosdjavxJSBJmH5EopI=;
        b=kGKasAnpAu35vlZ+mEFB2GUyxr7/wu8VWSNNoSg65sHuKuj+NOKyc8UGBhSJg7wFkE
         HBf6cO+k7TgkzXRrbLD+7lemd7kaFcuQrBkFlHWTbdlTcaHwBvKoFtM3nnZSCpp0UM93
         shyxjTU8E2lO/bGWe0KwpynKlm3uHs92e4f2GrHQ+kKUfzVqdR82L2wQe8pZnUiD8BH0
         lh/g0TNkv/w3dpnuEZ5vKuFjTrPSplDjelUyHMCsxUjDfI1MIpx5tXITwflu3GhrwhiO
         Q2TQg9c4he+FmOo5aMaQJoUyqg3GnDa56z/cf44nTcmE1HGLeJxiNZ5eXJkrWifbiS3I
         f/NA==
X-Gm-Message-State: APjAAAXFARQA5/z0V05EURvnSvhu2jDlHeVe/X0K1SRq9TqzH3AYdxUE
        iB68VT6b6R9T2xfae7fO2lY=
X-Google-Smtp-Source: APXvYqy44tHtIn0+D+rYldCYXAdpnd84tN7ibv2xgGKUBor4nM7jYb1J/Fy/B83tFK+lntfKnESGJg==
X-Received: by 2002:aa7:9ddd:: with SMTP id g29mr2857763pfq.146.1568794216357;
        Wed, 18 Sep 2019 01:10:16 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id g12sm4177204pgb.26.2019.09.18.01.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:10:15 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:10:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918081012.GB37041@jagdpanzerIV>
References: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
 <20190918051933.GA220683@jagdpanzerIV>
 <87h85anj85.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h85anj85.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 09:42), John Ogness wrote:
> > It's going to be a bit harder when we have per-console kthread.
> 
> Each console has its own iterator. This iterators will need to advance,
> regardless if the message was printed via write() or write_atomic().

Great.

->atomic_write() path will make sure that kthread is parked or will
those compete for uart port?

	-ss
