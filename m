Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B9C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B912173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBclKO3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfDQJqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:46:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33627 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so11791164plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZyKJZ47f4xCb2UIIdx1GAFfeyl24qLjgluCWgbDS0Fk=;
        b=MBclKO3Q2+DkSAKDuAcoiW2DEBEJM7ysNu3Ra6OkomCLFkXfzIB3fe6/j25k7U6prF
         pA1ri/r05RM0Q5Oy8QgU5OZ0FOIA9Fh0MgIODWwrtOQxN0oGSi+xd48y4dPxBtv/Y9Xh
         gqACKuwx98xOovJ1LFxXP/pDZm9UYkBFadgD5mH4vZQecB/DLOtmaEktpiKp/jqdrbcn
         wcJ9QyaUi/krUF1Wz29ZTqhmI7q+ZUSRdpBlrtmuqXCRfA2F4/ijG/dAcb6dlxQEVq3S
         spV/dkjcQEEbuDAW7/+2CjMqpHlk4Ap38HZaYKZ0f1e27gU6BIfy4wdple+9cG39UOWk
         viCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZyKJZ47f4xCb2UIIdx1GAFfeyl24qLjgluCWgbDS0Fk=;
        b=c9IjprRa5WEYO2amYrGFqFZQ/wZtnKKYKfMQSnJ7M0n5ufvXUsf5HrXrDR+U/NTB0+
         SpAxpiG07J/LK9GeRY+/HdnkoEduhelHQbTSGirnKkRFcAnFg3ztK2wJg9GRnCbu8CNq
         2DmY3+S64q2R9w1SGY85lHbarxXdWrmsKKcon19KHWvojgmKXinwkKftEpNdsfQOK1gJ
         0cDvOURJdHy0IC4uPKLAexENWI1gRWsR3khaKge3kRgL67oTgo693VdQVO4u8nvNI9Rn
         lSDxb7F4w2wPnObsPeV2L63ASeYNbHwUxXs9fo7ABe3bdjL5WToyNdvjDx0vsXgDmg8I
         dBjA==
X-Gm-Message-State: APjAAAVQai/3F1MfWJ2R0Kb+BvujUcuXLkoynusSPEeM4XJ6iwKWk6nq
        maPnqqrw1eeINnLQyNQjAGc=
X-Google-Smtp-Source: APXvYqw6l4Pwqg8YjrC6g4FFyAMA8e2V19cPhV31MSi2GmXss/oRmYzAu1hQc8LplC3E3nS+lMuOhA==
X-Received: by 2002:a17:902:70c8:: with SMTP id l8mr88795321plt.177.1555494378670;
        Wed, 17 Apr 2019 02:46:18 -0700 (PDT)
Received: from localhost ([110.70.26.221])
        by smtp.gmail.com with ESMTPSA id r11sm96502426pga.87.2019.04.17.02.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 02:46:17 -0700 (PDT)
Date:   Wed, 17 Apr 2019 18:46:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190417094614.GB4260@jagdpanzerIV>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 11:18), Petr Mladek wrote:
> > My instant thought would be put the console_unlcok() and similar funcs
> > under CONFIG_PRINTK protection, while adding nop functions in the "else"
> > segment.
> > 
> > But complexer question will be when CONFIG_PRINTK=n, how those console_xxx
> > functions should consider these to make compiled binary smaller (though it
> > rarely happens). would wait for Petr/Sergey/Steven's insights.
> 
> I guess that it is because console_sem is historically used to
> synchronize some unrelated things, espcially in tty code.
> Unfortunately, it is not easy to clean this up.
> 
> For this patch, the best solution seems to be using scnprintf()
> instead of sprintf().

OK, since we have another chance to re-iterate this. Do we really
want to complicate console_unlock() printing loop any further?
Asking off chance, can we return back to the idea of adding enum
FLUSH_PENDING/FLUSH_ALL to console_flush_on_panic()?

Does not look too complex/ugly.

---
-void console_flush_on_panic(void)
+void console_flush_on_panic(enum console_flush_mode flush_mode)
 {
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -2549,6 +2549,10 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+	if (flush_mode == FLUSH_ALL) {
+		console_seq = log_first_seq;
+		console_idx = log_first_idx;
+	}
 	console_unlock();
 }
---

	-ss
