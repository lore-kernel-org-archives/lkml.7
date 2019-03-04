Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3472082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQn4ZJHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfCDDdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:33:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45779 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDDdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:33:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so1941973pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 19:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AUQjPpWxOgRO7RmQXXoDOzSBJpoF2ynwOJOEsUPztw=;
        b=cQn4ZJHjMA9aWtsSPy1bNqD31C1MkK8dLuxoKOxhs+hrqzuigVBTwpP0IcdKAI8/lW
         uI8IqtfIlJRaABMcnThvWtKRqpKgFj77219MuDy6+z+aylq1pUUqG8Nymoi8lOgD1URW
         vPFIAxH0iZyWTzdasWJPn3DEEAms7NlHJu+r29SMhk9seS8QOzP2mW+kR6Zkkb/jcomp
         FECcvBPqYxbkmELMspgBh2iXvIJD3did4RmUmUU61G+Tnnki/xNswUlNmW5NAXn/2dbq
         NT9Y46zKDJXb7tH6a1JG2vYDI0M9W8WaBKrRLPKuJ7lgVm0Wpa6H2ZF7rDjZzyWNW/PF
         YCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AUQjPpWxOgRO7RmQXXoDOzSBJpoF2ynwOJOEsUPztw=;
        b=CqsbgjblW1ioOB5tB8VdlKZJB6DzOrKPMDgmHFdWymrMLbHsd69S0wgWtB4jZgKkm6
         MMNSSUP8t83YkCkLYuMf6sxm3Cy9eUykD+/1E729VYSAjOFkC9c1lxgb/Bk5/u2s5+aA
         WARQgh4lH0mZGpu8OpxRb4QA/KNmBO14cvsU9U5BcW+BuLMrNkzT3/q39sTcliBEh0mI
         ukIBykHRsSFHHc7SiFrBYdBtola9De5KrFDajY+/A5ynjxHKXaPkawztNsdddqdSRY5u
         PKSynZCpMaO771GlEQeLq/lE36Hg+WwMNwSTC64QlMF9Wtlhj4EX4f8KTnIWezIodNdb
         ObLA==
X-Gm-Message-State: AHQUAuaUJvKFZPa6KM2PrSMnOhlNIw9MnrglYPBz60S2rk9TRXd4aYM7
        BfDrSiYyuI8aumoAe3pelKU=
X-Google-Smtp-Source: APXvYqyJs0zS8oXhNVmbomzQzdAqdzScarGwNN6V0p9zn2kAziCTQVXDSLTZOZpaja25N8oUJTDTlw==
X-Received: by 2002:a62:ea10:: with SMTP id t16mr17651941pfh.3.1551670384214;
        Sun, 03 Mar 2019 19:33:04 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id p2sm8367480pfi.95.2019.03.03.19.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 19:33:03 -0800 (PST)
Date:   Mon, 4 Mar 2019 12:33:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about
 dropped messages
Message-ID: <20190304033300.GA26291@jagdpanzerIV>
References: <20190226124945.7078-1-pmladek@suse.com>
 <87k1hmzfam.fsf@linutronix.de>
 <20190227083043.j6nw7t6nqulim6t7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227083043.j6nw7t6nqulim6t7@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/27/19 09:30), Petr Mladek wrote:
> Good point! There is a simple fix for this. We could print the warning
> also when all messages are proceed and we are about to leave
> the for-cycle.

I'd prefer to have lost-messages reporting be less of a summary
and more of an "error". I think the sooner we report it the better.
I don't think that the time we need to print lost-messages on the
consoles is significant enough to worry about it; if call_console_drivers()
becomes such a problem that any extra char we print causes message-drop then
we can disable printk_time or/and printk caller_id prefix printout (can
save us more CPU cycles).

	-ss
