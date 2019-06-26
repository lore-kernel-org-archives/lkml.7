Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E9C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8802133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifNVdZNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfFZH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:59:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44396 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:59:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so976423plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4ccwwpO5oRzKymdnY/55sXpZJv1GlqtCN/M5c5AvmY=;
        b=ifNVdZNFnY/2v4zh/dDKfkaBnMcIoW/YPwoxRXpDgBPjIpbAtY9RULlxulJ0n8osIW
         oikinqGd5ACHyhyJfm8gEuflttq5znCoqv/p9W9o3DxtDKiY/dP6y0QK32QnOFT1ly8W
         OcslnNnxHhZ5fimkjloj72FgwhbwVoVMRBnmB3Dfowpb+y5KghzISjOl/m7LRcPNmTHa
         Sp4glE1irTzNlJ7dDmLNmoSbPP8ehBwblXYBdax57+UceVwebOuP7G6weJfhcJLCPFdb
         BCGvhc1R6AjuxfCzusrGdYXVQMx46iZqUGeUdt7S88Ci2Dbu5+rvzOl4dNhoau1g+3PO
         GULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4ccwwpO5oRzKymdnY/55sXpZJv1GlqtCN/M5c5AvmY=;
        b=Fdf/XMeH4pQjMZXMboZh4zXwEX6yRmSUpQH+1NwBhgbLn+5k1evdKZrVfUwOtSTNNK
         MXb4LinGW+Fi5KH+Ds5S+bYETvC+Pjsz06FTv2BLckX4NKOS73+zZ8jMGx/ECyx27202
         WTZqgWlsFlK278pTviyKWIBcW3VOxpRXsXFRMLd/9cDmt1v1AlTTdCQtAWj4fs57hgdF
         ki7wXZ6P2FIbJt2uAK91SVyA6NwRYhPoVjHS59JyOEyvypSdEHOwluPzzU7CmAzpMjcP
         b1rTud8XalCvaaw+32OrtVXFIi0I5k14Rl7ckaxwvWp093iLSkmRQ2jBEcgXsLh6hYXr
         JwUQ==
X-Gm-Message-State: APjAAAVWDPsQpGKzHk5g1gCK7A7rACajQWypmuXvHB+7OgD3/alMKeEO
        gL5UiR2DmXw1tRdMV7Fc1lI=
X-Google-Smtp-Source: APXvYqwb0Kc9S0n5E7F36S1KdjVeYBGXxGk/mESd3n76+oCdkdana+gh3ApUne4sMUzL5pIyTnPR5Q==
X-Received: by 2002:a17:902:5ac4:: with SMTP id g4mr3986808plm.80.1561535954603;
        Wed, 26 Jun 2019 00:59:14 -0700 (PDT)
Received: from localhost ([175.223.45.10])
        by smtp.gmail.com with ESMTPSA id k22sm19500304pfg.77.2019.06.26.00.59.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 00:59:13 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:59:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626075910.GA2936@jagdpanzerIV>
References: <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
 <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
 <20190625100322.GD532@jagdpanzerIV>
 <87woh9hnxg.fsf@linutronix.de>
 <20190626020837.GA25178@jagdpanzerIV>
 <87mui43jgk.fsf@linutronix.de>
 <20190626074718.n7fmxugeul3lyyq6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626074718.n7fmxugeul3lyyq6@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/19 09:47), Petr Mladek wrote:
[..]
> If the data might change under the hood then we have bigger
> problems. For example, there might be a race when the trailing
> "\0" has not been written yet.

Current printk would not handle such cases. I'm only talking about
transition from one consistent state to another, when
	sprintf(NULL, ptr) == A && sprintf(buf, ptr) != A
Wether it's a corner case or not is entirely unclear to me but I
probably would not call it "an impossible scenario".

	-ss
