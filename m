Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6E8C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694F92075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGIri8Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfEZUgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:36:16 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39819 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfEZUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:36:16 -0400
Received: by mail-ot1-f47.google.com with SMTP id r7so13111048otn.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rvY1bULnaeo7Db8jSakyFk+Wm8YWMrv8FmOFXZGqPcQ=;
        b=vGIri8Xftkl1yf3/Zu4MbsdPt65qozukjAtSRtQSsF/n55A+AoevHVJpMrc4jtKos1
         f4YDeXA9PYad2hbWrJmNhq8tOv/tQnSEQOxHYswni+ZT5lQryZutu9wn34muMOlSlHYu
         8LO+HX7L0MJiGyAOGhigm/TX6hSleTuzvQwUSY9KmNFbDOMCJV3cFopUPq6q/1qUR65S
         uXMcO4WpXXuOjDc4QhdHVwLj2w0LH7Ecw41TP123cgGRbaQW1UdpmW2KO+wxTpoqM1j/
         8H4SN7XKlDugwt5wYd0iRmj2tkyTAOTt7QW1PsISc4fBrYG66DwrqKanpcmdUGLJFwG+
         ubKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rvY1bULnaeo7Db8jSakyFk+Wm8YWMrv8FmOFXZGqPcQ=;
        b=VgxvYpBsGdZvqCScR1DQ7M5jj7A2LY3VatzpKl9CbP7FlmE8VR/1gkpCDbKjqujkxY
         xZSXeXQgF1h5GSqcvf5BoG4bPtBFKR02SljyTTz14eOyXQHUWKHBv4v/YuYH8wrapsyk
         WvubCv9/DoDZXKELJ8uDrajBlHbEVzETEbPkhjWvy692OZdtY4RwKQXYd9cbDVbS/Dwb
         6Wm9FhKjFAc4qIPkPxmXchSuFoyU6RkoIGoMa3IGGn0AyAr+bRhHZhsnzhvXD1geiaFf
         5eVOf2sgKZplyxcQykahcjH2cbDwbqJhzHXsMcWxsqORkpI2AsNDmFn3iGImV1dfqGZM
         TbOQ==
X-Gm-Message-State: APjAAAW8LtUR5YefgLQY5+1PFmhydHEsIMI9/4qSaatEoJSbTZ1NSmUa
        q5rF8xaa3VX3/3PzyfdBwVVEtQ==
X-Google-Smtp-Source: APXvYqxZPhw0yJl3r45T/Fa8fJz2+UtOH66bNRUU7eiwEabg3U0n31CTMjdqLD1inBJYM+ERKVw6eg==
X-Received: by 2002:a05:6830:11da:: with SMTP id v26mr3470395otq.137.1558902974916;
        Sun, 26 May 2019 13:36:14 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 33sm3454974otb.56.2019.05.26.13.36.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 13:36:14 -0700 (PDT)
Date:   Sun, 26 May 2019 13:36:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Pavel Machek <pavel@ucw.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Revert "leds: avoid races with workqueue"?
In-Reply-To: <20190526172002.GB1282@xo-6d-61-c0.localdomain>
Message-ID: <alpine.LSU.2.11.1905261318290.2394@eggly.anvils>
References: <alpine.LSU.2.11.1905241540080.1674@eggly.anvils> <20190525093759.GA17767@amd> <alpine.LSU.2.11.1905251025300.1112@eggly.anvils> <20190526172002.GB1282@xo-6d-61-c0.localdomain>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2019, Pavel Machek wrote:
> On Sat 2019-05-25 10:32:31, Hugh Dickins wrote:
> > 
> > Thanks, Pavel: yes, that works fine for me on the T420s, no debug
> > complaints, good and silent; and the wifi LED is blinking as before.
> 
> I'd like to prevent recurrence of similar problem, and I wonder if you
> can give me a hint.
> 
> I can annotate code that can sleep with might_sleep().
> 
> How can I annotate code that can not sleep? I might do 
> 
> spin_lock(&dummy);
> this_should_not_sleep();
> spin_unlock(&dummy);
> 
> But I don't really need extra serialization. I just want annotations for
> lockdep. Any ideas?

I haven't tried to do that directly, so I'm likely to give bad advice:
in particular, I forget the limitations of checking in_atomic().

But very useful (and much cheaper than lockdep) debug options in
this area are CONFIG_DEBUG_PREEMPT and CONFIG_DEBUG_ATOMIC_SLEEP.

Hugh
