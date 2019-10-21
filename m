Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBFC47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FA320B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571648969;
	bh=x7bs6fm6mP5jMDBqAyWDPtiv15yyLHQyVc9aUDfO++o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JkjG1Xpm3FZ/6HQ/YqgVEpnXB/p6dWrqwSNxRx/K4Ao7vEcJam+1vc+tiR42XWt2b
	 qZkYPgHWP/zeFT6oPMq6xxFzIEWXQu/wwxnJ8++jLc0DTVOd4fwr6N7RvlZkH9WMn7
	 UILR/ybMsBE6OfSrjtFeorgOdE4yNN/27hB4cxdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJUJJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:09:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54110 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJUJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:09:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so12355342wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACnSDfY3WLdIK8yLvxqYzCcQMuqtaxuGafDRrIP+wGE=;
        b=FfDnuoMVYTPX9W+nl5uQDeViT1AK8HpPpq583HfZJ44Z1j5lOVO/sVesBcFYlu9Nur
         deXBL8opPlVPpcAxvImipMdsfFrAziX6ZC61NAvIAMf50mFUUumGtUTN7odUSCvApwkN
         /T50gYTxuvrliL+5y06auItlbUl/eOGvzmRMJ0wPGNbQKaLbtvJ4Hc/SUoP/3BloBjB6
         97hUVZp+uIEWJKkAlK5hm6dnKabI3jZfx5MsK0rCOI5vOt0SsrY2Ty6nzV+dBRf4z613
         7IZZwduCdsKl+v2xzzXjXCNKfaO9aHOa4bC8EhJtAfDelMDOfdsO4iL9RPvp2S93blA8
         XLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACnSDfY3WLdIK8yLvxqYzCcQMuqtaxuGafDRrIP+wGE=;
        b=Ojd8EZcoli2LxsfR4wtuh+EQz2eOh3RuDKdHJNawCgCoF7lfNb4qgPrUkxFQgPwZpq
         p/sOB+PUSVBRSeGz50eyPsi2HlxMR79BEVpwpHaD8+2oQzXsgOrokwCixvLNX0/mUOcl
         XfRqwkTFRZtXwv/HacheyPngq7YPAv6MXaRT+aPtw1PnLipmhvbZil6DmeRQY/KqZ42/
         dhshXCP4p6gbG1V6wWmMuE22wUTQ/Si3Q6Beoi5ch+PVzYOrBXRFbuEUtZg0tAlcWA8q
         1gFMuqcs9/F6NVLNLueP4RyiwWq8/gQUC4oJL5uozaBgnUBbbKBv33JPrVjMUR5HY/iB
         D13A==
X-Gm-Message-State: APjAAAXqD9mdPWztkinhqD0VuC510Vk8W6bhINJQZVaV9i7Rti22s92g
        OcZjmAEmxUWvu7mWEFbAJ8w=
X-Google-Smtp-Source: APXvYqzo8SZLI9oJnmNzoGtQN07c2onReqwPBYB4P0a1qfMT8fP9DtXPqc9tdJCTHfB1sE2/MTUUEA==
X-Received: by 2002:a1c:7219:: with SMTP id n25mr17707619wmc.33.1571648966347;
        Mon, 21 Oct 2019 02:09:26 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p20sm9452942wmc.23.2019.10.21.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:09:25 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:09:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 00/16] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191021090922.GA41231@gmail.com>
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018073525.768931536@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Ftrace was one of the last W^X violators (and KLP it seems). These here patches
> move it over to the generic text_poke() interface and thereby get rid of this
> oddity.
> 
> The first 6 or so patches are more or less the same as in v3, except it has the
> bugs fixed that Steve found:
> 
>  - boot time function tracing works
>  - module loading with function tracing works
> 
> Then there's 10 new patches, that go all over the place, mostly inspired by
> staring at code touched by the first 6. That is, there's further ftrace and
> kprobes cleanups, as well fixes for various issues.
> 
> In the end, it will have removed the horrible set_all_modules_text_*()
> interface and reduced the ftrace module loading to a single callback (again).
> 
> The ARM patch is compiled only, I would be much obliged if someone could test
> that.

Ok, this looks all around like a nice improvement to me, and fixes a few 
bugs as well.

Steve, any objections to this series? If not I'll stick it into 
tip:core/kprobes with a tentative v5.5 upstream merge target.

Thanks,

	Ingo
