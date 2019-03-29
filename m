Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D058DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2E92184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSjKgns9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfC2AKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:10:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44552 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfC2AKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:10:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so135219pfm.11;
        Thu, 28 Mar 2019 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIS2AJu1GYbVOnoh2B2P7L1YQEPVwJ1O9tE1zb1TA34=;
        b=jSjKgns9EDxKAfQ2We7ZRrRTQfa1QpSu5k12DW0FQ8JxqKkJhitz3uz9JN/MX/5iSB
         KY3e+dGonESu3mvz50DS84bp7scQqkj/gHxnqO7jseEf1nBBbn1TRhWEWuAXdcSIkcrg
         pkbE9mdjXqe56oPkTdbFcg0vJb4S8kuvzaf9A+fQbdKWxV5fkSeUgbH3dbFvNNr5p6Ev
         UvXPwSU6TTlEXZ9vtV5v8gh7AenfOPT+I7/UoS0okN+yQoyTxfXasKoP3sc8A2zBNZ6S
         OoL8vytqjSN3+b7XPWImNPSXFZEtNGLwRtHddKG7aIYl7xUcYUcfb3nOQcUbA7VZImLb
         /pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIS2AJu1GYbVOnoh2B2P7L1YQEPVwJ1O9tE1zb1TA34=;
        b=EsdNWjbcOSZ66zzFZdFVkP1Dwn1r2sda4thyjd6CnAqt1Zz1CNFWtS+YxY1T+6OM9s
         jhh7XXY5l9ZlEgIFvS7GQW50tEodgM9h5dhKsuUEnS2+WE6ZztNxUDyH8fxkZWjrT+i2
         +jsKPQy7c77L8fzqZWGa9FEAGv4/dKBx6e1cwb/vn1RpdcgEqBnql+ihuVcdyF0u1en5
         3y+kSpGn+OZl0uKpBasDjXiR8bZ63VuvDFtI7gW0pVLXNT/lt7zkFf1U6H7zbscZvbTM
         6WG0ozHEoeY0AjIIYf6BUs2Qkp0eqfMSc9NR6Fhpjj8t2sQ2flkvkTR5KMuDOrs8+U5E
         /EPg==
X-Gm-Message-State: APjAAAVuS2/yLeQcTbUa5PQ6W0ndgi1G68b73+hkC/cc9OZnY9j7wFUw
        nuG+PV+Rp+vbC2aW38ZvoWq21IvQNPA=
X-Google-Smtp-Source: APXvYqwo2VAzI1nPzQDKFyYM1CuwA8hHl7R0/sW7QPHSCfr9FTBYFGxq6zlOmKEtXtNUly/RYLl1xw==
X-Received: by 2002:a63:2c06:: with SMTP id s6mr43259297pgs.245.1553818231185;
        Thu, 28 Mar 2019 17:10:31 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n9sm385361pff.43.2019.03.28.17.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 17:10:30 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:10:22 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190329001020.utauchuqsqt5maww@mail.google.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
 <20190328103902.1084337d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328103902.1084337d@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:39:02AM -0600, Jonathan Corbet wrote:
> On Fri, 29 Mar 2019 00:26:58 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux ACPI docs to rst
> > format in this serias.
> 
> Thanks for doing this.  I've only looked quickly at this point, so I just
> have a couple of high-level comments.
> 
>  - If at all possible, I would really rather this not be placed in the
>    top-level of the document tree.  Things are far too cluttered there
>    already; I would prefer to take stuff out instead.
> 
>    That said, I'm not at this point sure of where I think it should go.
>    We may want to consider splitting it up; some of it appears to be
>    suitable for the driver API manual, while some of it might be best in
>    the admin guide.  And some probably doesn't fit either.  I'll try to
>    ponder on this a bit more.
>
Agree, they should be arranged for different roles of readers.

>  - It would be a good idea to add SPDX tags to the files while you're
>    working through them.
> 
Will add them. Thanks for reviewing.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
