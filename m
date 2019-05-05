Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EEC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D6D208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Wx8/Qn4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfEEN02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:26:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40238 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEEN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:26:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id w20so367038qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=Wx8/Qn4lhOzjepZEXkLBZ+w8/WHG8jhLCLZePQswk3nuOkWjV3N5eH3aZKCgdybogp
         7/TReM/N6U6Lw8RYN3lD4pnUWUG8h7F81NJCRUMPZDWBZMOfV4oc9MoHAgMWetH1nZpI
         OHyXUY0uszNgLft1e5rlQxJbPefuA34AZXXgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMs3ZDG4UTtB7mWeq9fogx8Im6FYMW4NfffNVZ0T6g0=;
        b=o9i8MKxh7cAqldJfEG5sYOtxKwEEJp+kWjUTaLDtYHsc6c6oAfRqHBR7xSW6YLhwUD
         3OpAIynlB/wk1O6kKPO45NyW6VWFsC4TuDI1JGoyUw2C5h6AaG+MsGQgMYV8RYnXF9Rd
         v4no211RDySIILQD6+0naxMP2S2jCjxSYWpQekM3e4mDj7xU3H3vLnR/gPge5jteKdFF
         63V+FWjb5lu64XJfQ4mKlLb0831pJGl+obZ9iMPBGFrybgetKhRkf1o9W4aukOKB5YeB
         GBQqofGlJkQwNyJl9KgRVu5yjns06evboAHDvy2yU8Br65QgP01HcBz3+VZ7/eG6SmVO
         d38g==
X-Gm-Message-State: APjAAAWVxH1Uz7VwTLS/YAQG/PD4VlroqfN5jZA/3ZaP72gSdQdGnDLd
        k6kimmVkj8Qcbrhb8HmJaJwbTw==
X-Google-Smtp-Source: APXvYqzN3LNC9F4r23JL3m1ARyAewSM1naLPRx+StaQtVcEsebbIkaf5I9yTOOJzVD+6xM/cfuUBLQ==
X-Received: by 2002:ae9:df43:: with SMTP id t64mr15613710qkf.250.1557062786462;
        Sun, 05 May 2019 06:26:26 -0700 (PDT)
Received: from localhost (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id k127sm4921838qkb.96.2019.05.05.06.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 06:26:25 -0700 (PDT)
Date:   Sun, 5 May 2019 13:26:23 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190505132623.GA3076@localhost>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
 <20190504123650.GA229151@google.com>
 <20190505091030.GA25646@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505091030.GA25646@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2019 at 11:10:30AM +0200, Greg KH wrote:
> On Sat, May 04, 2019 at 08:36:50AM -0400, Joel Fernandes wrote:
> > > But, you should change S_IRUGO to the correct octal number, checkpatch
> > > should have barfed on this change.
> > 
> > fixed, below is the updated patch inline, thanks!
> 
> Please resend as a "real" submission, doing so in this format is a bit
> more difficult to apply.

git am --scissors can do it, but no problem I will send as a formal
submission. Thanks a lot.


> 
> thanks,
> 
> greg k-h
