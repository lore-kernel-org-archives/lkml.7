Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C17B2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wQ0F7MN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfCVNsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:48:18 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36077 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCVNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:48:17 -0400
Received: by mail-pg1-f175.google.com with SMTP id r124so1578741pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AfG6ydgW6QAgdRu0lPyaYwrTA2PIAMVgtJGbLxqf6f8=;
        b=wQ0F7MN/BRC+grJ37+Jrxn5/Cc5NiddnHVQsU/qd4Rq35QlMy9QBnSd4ufaMb/P2b1
         y49hKhVbf9/FiywuGsPKINPiGQgC5peD8b8pXI+KKYbLUGJ3Q7DfPaBgIZQNKs3xspfJ
         BlT8BacmP224TkrSI7ooDYsJ+QmhwQcNSCvr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AfG6ydgW6QAgdRu0lPyaYwrTA2PIAMVgtJGbLxqf6f8=;
        b=jfoC+uWPEyQsrwLkC8lXIqRM0yANaqi2UCeRXGLGtq2OhFN9rf/fbFTMWxmGZr4z/u
         BmZYKPtcpnqoKUOVqX58TiKkKm6V7iNHXaHwrBxdT7makUL+qljzTX63HoadDUPsEymZ
         Xuz249CVhAQ5PZIkdpdVokwN0zxosZFIdvoAWXi3WiaH3p2H+ESAoix0bzAFsWPkqsoS
         h8+0M2nz5UHSxDdyEa+4P3sDySlf+bs6x924KySPsaWM3Og1RDjYUV7Udd52f3WUSHMl
         Y8v62SMjUoSMcz058SeepP8tZ6uzJsGFocwFV6HU1TffoaQdlDTDYstQ8jk/t9w1Gdjh
         6XdA==
X-Gm-Message-State: APjAAAWC0jYos950FrVLWno5TI+Oc2UblBt6IQVhAACz/5GXQ/9PQO23
        Q1kpqpvFQWclsn4V731Otsp8yg==
X-Google-Smtp-Source: APXvYqw0Q5ZfYsdTeFIMNNyM64OkLsokqKxBXQL11dXTJAFIGO56YvAn3xFE5h4t1cyz5p1AvOXjUQ==
X-Received: by 2002:a63:f84d:: with SMTP id v13mr9074070pgj.384.1553262496814;
        Fri, 22 Mar 2019 06:48:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j9sm13170269pfc.67.2019.03.22.06.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 06:48:15 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:48:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        diamon-discuss@lists.linuxfoundation.org,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Message-ID: <20190322134814.GB56461@google.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
 <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
 <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
 <20190321124122.GA30542@google.com>
 <20190321091356.38a6988d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321091356.38a6988d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:13:56AM -0400, Steven Rostedt wrote:
> On Thu, 21 Mar 2019 08:41:22 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Also does it also make sense for lttng ring buffer to use the ftrace code for
> > ring buffer, or make the ftrace ring buffer better and have lttng use it? Or
> > is the lttng ring buffer design too radically different?
> 
> We tried in the past and never actually got something that we both
> could agree on. Now I believe the user space tools depend on the way
> each one is, so to change one will break the tools that read it.

I understand :-\

thanks,

 - Joel

