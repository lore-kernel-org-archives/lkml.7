Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5530BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B6B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574089776;
	bh=VuoNvHpDZLgHQJqYY7f0Za6yif768qWcOc9m84+1LQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wi8l8JPrpNitIkaNlUTrNpyKRBLv8t9sqPa2YDhLDXjFcV5vzJviOBeCLW0t2Hw0
	 /3Dx5zoVW/3zx6HFqkeGQ1UvA4te+4+0UHXWaz0TnBVZQUsQ/0NpZUEmhXmgPFSYPX
	 yau0ajpsFRxtNIMf12eIlUL8dp2XGdn09PuaGIHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKRPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:09:34 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:32997 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfKRPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:09:33 -0500
Received: by mail-qk1-f182.google.com with SMTP id 71so14701542qkl.0;
        Mon, 18 Nov 2019 07:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsoQlqze8gB2f3xbdeFwVUdIX/+4vI9Doot9Gwt9WcA=;
        b=l4WWPLesPXUj+TG08vUC6nF5KGBOssYHtH1jzOopCnkLWVJiQNcwN86ZSs5F6fUUKs
         oA04Z8xvJl6FNvP/PB3uKnH0vi2ZjX9gE4vd2LYq28nHChrtNy9AnPR8ZoDuMs9FkCTI
         FjK4pQRDEkfHHyVofi7RO66bqYxw/0QhUIHnYdXTPM/FldqIhcV/unE3BQz7q4Wvxv9C
         y9Zznu2cDF/SEgUDgBv8aCMnhGdSAnTbnwA17dsaPUqozKnuRKknER33LZUmcfHNZYca
         Zw+I2scfrCB1i8XJDelMSlnUfCXI3q6StLyZUIy+zse1uNwVVPyCeJxqnXC70VvEMkxQ
         F2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsoQlqze8gB2f3xbdeFwVUdIX/+4vI9Doot9Gwt9WcA=;
        b=WBMCj52EwPgDT5BYT1RMojoZhasxA8Tqw8CstOBHNzeiG4QgmbaDsSk6G7OO86VNno
         P8JGBIZQuK0hamT3ZJ71DETis4OIv9wmOlEIYe0BWrN2lKaucHOcoYuRqF0ebfkIDrMx
         CxyZ6HL034gHku7DPDk9Nt+XYP1mPibXHwrL2m1jDYHmuwAr6EPhlERGhDjEVzVOcxsK
         pXL70kO8QJLkRAPlz2ZADqS8j/+Ene2cPluQCVz4P90lBPbF32WkSXZ9GZCD9KtiMZq9
         vEV077tjD//fo2A/Le0zrcJaI2ydoCLel5PjLNptINMmojYR8OG+J9aiQq+vIjvj6tRt
         BiNQ==
X-Gm-Message-State: APjAAAWzWNIt3vhqp7a9wjoftBW5MxcatVYlV5YMuNe/iZjcXpsdzzfX
        dyziiXs7+1DTfqIr05abBnE=
X-Google-Smtp-Source: APXvYqwsT/mLCvwvc4hOqC4sRPkplNYXUsyeO4hXmai3GifjbEYFySlRKAhYciVCtjQMuHxY0Ul7hg==
X-Received: by 2002:a37:a58b:: with SMTP id o133mr24242049qke.418.1574089772261;
        Mon, 18 Nov 2019 07:09:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:ed5d])
        by smtp.gmail.com with ESMTPSA id 130sm8750750qkd.33.2019.11.18.07.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:09:31 -0800 (PST)
Date:   Mon, 18 Nov 2019 07:09:29 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: linux-next: manual merge of the workqueues tree with the tip tree
Message-ID: <20191118150929.GT4163745@devbig004.ftw2.facebook.com>
References: <20191118150858.1a436a12@canb.auug.org.au>
 <20191118090000.hpnibmk6xculuwii@linutronix.de>
 <20191118125046.GB74767@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118125046.GB74767@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:50:46PM +0100, Ingo Molnar wrote:
> So 5a6446626d7e is currently queued up for v5.5 as part of the RCU tree. 
> 
> I can cherry pick 5a6446626d7e into tip:core/urgent if Paul and Tejun 
> agree.

Yeah, please go ahead.

Thanks.

-- 
tejun
