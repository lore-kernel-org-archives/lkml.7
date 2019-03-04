Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE443C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8592B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfqYzSfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfCDCRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:17:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:17:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so1888700pgf.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 18:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gp6FsIBeEB2eF+QQhnkOtu/SFRoYZGjfV3jGDOoq5Wc=;
        b=PfqYzSfoMwEGqT+/1fUW73s5mAW2nk4i/nIIWe5NK4P9kFr13DolHIkAIEtHTZFDJj
         /Gu47q0W2ByO9ZnqTOD/ulvXojjdz1j8a1c2gYNDxYDQ+EfIpnDlcFHoo5hmBUMOcmhn
         px7+vtYlMhvxGdn/P6Mm77iLqG7zaT+Nk8yCE16S+UV0FyhUYl3Btz30DzuOMrUDynBg
         x2wtTES4gBHfIVckPDUsOpOPGxv+shZ90FUtB1TkAa36nRifu6BQpwnwBRxyfHAhbL/L
         eje/S/1/S+qXioosq0EQWATjbOx/GbUbDhS90xbOAmRYcSvpCyvKD3sfHgE3u1yfyw1E
         VG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gp6FsIBeEB2eF+QQhnkOtu/SFRoYZGjfV3jGDOoq5Wc=;
        b=nKd6XAjkYAqydcATxnp9t8tzxQ3jJQ3WIEdlnWw5lV3H3cVdczdv8ZAq8PR2dNdy7T
         pr48tQhazj85cJBFpEYaq0TmPRAl60rT6mtT2q+uPLN/mvuXV5vg5CXWRMa6dIdAqjCY
         H7XYiPArdGsWqe4NNkOAY8/dGefuNHFt70eLW0XB2V8yqUQFfwcK+8qKahGkeWLOZ1k4
         igxtHWZO3wSypbJEWYKnn8rNhv1xBfo7u8X/oytmMcz8hCHUZdb/8spTRij3mepYlZ05
         TF60hgEGhxBqPcvAfyucbeylidpd6r2/+bX5SQvYRoURnvatY82qzcr85VnlptyrdBAV
         8cng==
X-Gm-Message-State: APjAAAVgu5aXbTL5C0GKIbpSEB/r1kI/Oj1pb0ZzQTuVacraMQOeyWRy
        R+FJ42IWbPelOdsSsMitlkY=
X-Google-Smtp-Source: APXvYqwPMueZgKHmX1CK0Cm2lsL3jleGK09bfhiO1tpwvo/f4E+y5YZ4k67GbrXb2V8TLq7eSVj0Aw==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr18156422pls.103.1551665870985;
        Sun, 03 Mar 2019 18:17:50 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id 71sm8882466pgc.23.2019.03.03.18.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 18:17:49 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:17:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6] panic: Avoid the extra noise dmesg
Message-ID: <20190304021745.GA23578@jagdpanzerIV>
References: <1551430186-24169-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551430186-24169-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/01/19 16:49), Feng Tang wrote:
> When kernel panic happens, it will first print the panic call stack,
> then the ending msg like:
> 
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------
> 
> The above message are very useful for debugging.
> 
> But if system is configured to not reboot on panic, say the "panic_timeout"
> parameter equals 0, it will likely print out many noisy message like
> WARN() call stack for each and every CPU except the panic one, messages
> like below:
[..]

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
