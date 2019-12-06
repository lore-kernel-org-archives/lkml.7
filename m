Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51521C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7E20707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mcohcs6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFBIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:08:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34351 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfLFBII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:08:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so2429601pgf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 17:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QNT5TPRX9LvCPG87QD5zupwCfbpXJ322naahbA3zsE=;
        b=mcohcs6IvVzKE1WtjTt3SAAgCpPpyXT7KNl1cy4GGYGRNjcaD6CS5SbdB543e71BOd
         oL0rhLUqg+P9u3sQS3kajx81HG2lBrDnMCcpOBqeHEbMvW12ttL+z9k6ZayGpKuFhJWZ
         RMEa57xuCixXLoDIk6h3FLyjCzE/UlVMvHB6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QNT5TPRX9LvCPG87QD5zupwCfbpXJ322naahbA3zsE=;
        b=UMSVMpSPRrThvwcsr8bnkGw6t0NVovPgdGjgQ6O+XOzlpfDm2J6Kf7gAR+VuF2rR4L
         ICeWR+C0dW3i5SK7jE/CjjYOBYTcSX0vR/ASyhIM9cU1iRgE6VLU6FvPa5z0FrJAKbAw
         u7ibTr9nk14r/f54i+5848WBSrc7G+xJpY6L668VNeSSG7ssVERqCGu98v1LFUN2IXHi
         +WRTBsKkbN5WNlBnrU5eLcxfhqJr5LPys1xWCQdq9Tsl5r0wO+O8jfCTNi3ZtRDH+Ym5
         pF+oNHxxLj+GKCDvyDAwlcqzBE+n0qeNFAW+ol3gbKssWXfk8VXZTy0QZSFnhKfc8JFM
         SMjA==
X-Gm-Message-State: APjAAAWRnT9i2nju1XPgaMd1Nn4d0mg8TgYah8lh5DHmCUcl2UMTp3U1
        9LqB2paLJfVVL8iI/lMOeLv1zw==
X-Google-Smtp-Source: APXvYqy7slV1vspesqiwQNeIaiovm3Q3/BPlms15Vf02v4G2S8j6tKfI0uxzWagh5nTrPJ2bHNG9kg==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr11881014pfc.179.1575594487954;
        Thu, 05 Dec 2019 17:08:07 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 143sm13650519pfz.67.2019.12.05.17.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:08:07 -0800 (PST)
Date:   Thu, 5 Dec 2019 20:08:06 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191206010806.GA142442@google.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191203064132.38d75348@lwn.net>
 <20191204082412.GA6959@workstation-kernel-dev>
 <20191204074833.44bcc079@lwn.net>
 <20191204153958.GA17404@google.com>
 <20191204084729.184480f3@lwn.net>
 <20191204163552.GE17404@google.com>
 <20191205151418.GA3424@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205151418.GA3424@workstation-kernel-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:44:18PM +0530, Amol Grover wrote:
> On Wed, Dec 04, 2019 at 11:35:52AM -0500, Joel Fernandes wrote:
> > On Wed, Dec 04, 2019 at 08:47:29AM -0700, Jonathan Corbet wrote:
> > > On Wed, 4 Dec 2019 10:39:58 -0500
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > > Actually I had asked Amol privately to add the backticks. It appeared
> > > > super weird in my browser when some function calls were rendered
> > > > monospace while others weren't. Not all functions were successfully
> > > > cross referenced for me. May be it is my kernel version?
> > > 
> > > If you have an example of a failure to cross-reference a function that
> > > has kerneldoc comments *that are included in the toctree*, I'd like to see
> > > it; that's a bug.
> > > 
> > > Changing the font on functions without anything to cross-reference to is
> > > easy enough and should probably be done; I'll look into it when I get a
> > > chance.
> > 
> > I tried on a different machine (my work machine) and the cross-referencing is
> > working fine. So I am not sure if this could be something related to Sphinx
> > version or I had used an older kernel tree before. This kernel tree is
> > Linus's master.
> > 
> 
> This is great! I'll remove the "``" from function text and send in the
> updated version. However, should I leave in the "``CONSTANTS``" and
> "``variables``"? They dont' have any kernel docs to be cross-referenced
> with and also make them distinguishable from the normal text.

I think you should.

thanks,

 - Joel

