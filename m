Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F8C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABBC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEOSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:53:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36555 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:53:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so1036655otr.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+uKuYKH8D9C30taRndDf2f3BiyObetVuhxljsMhA+w=;
        b=dTqiLoCH2iQkNJUPDJknBnM3tDtd768jhXToiFyVq4ug5i6Vakk6P0sQk/1fhqy7W4
         kX0YLPugcPJcC2Pv8v10vwL1hm+3Ju3gROtHO3i2yI/HMlOW8GXAc4J3ae8ELir4o/Ui
         RrYh1KWyfn6+NYgfqyUCHK6XxkFl2nKO8w/JqpQXpdpPT5212hUXuZmt/bAkT6MH5dzi
         NIyWVJlddrSiHpwv6eCX/OVVXZpsAfPduSGCjqweBBKvy2pGI/pyXMnEoPdKM2bYO0Xm
         cjAaN8mhTuZyN3yoQdVG4Du6zHIHCdC4TTFcINrEvttd+efVT6quenheBcGiJUrwqiZ0
         mbSA==
X-Gm-Message-State: APjAAAXxAkT9T1zP7yX2/EnBHY3R+oTMFl8bCjLlxnDXWNoJx+JeTfcH
        52L8CkaQRZVpp6Ha4s+oJqc=
X-Google-Smtp-Source: APXvYqyB1lZtLwM2VdgPfATea+juZlcCsSuhi3KGqNsEZFCafam8pMbRKx9qHz3/tcPn80X+Dfi0tA==
X-Received: by 2002:a9d:7643:: with SMTP id o3mr17247096otl.129.1557946381574;
        Wed, 15 May 2019 11:53:01 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id h23sm1062735oic.10.2019.05.15.11.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:53:01 -0700 (PDT)
Date:   Wed, 15 May 2019 11:52:57 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190515185257.GC2888@sultan-box.localdomain>
References: <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
 <20190509183353.GA13018@sultan-box.localdomain>
 <20190510151024.GA21421@redhat.com>
 <20190513164555.GA30128@sultan-box.localdomain>
 <20190515145831.GD18892@redhat.com>
 <20190515172728.GA14047@sultan-box.localdomain>
 <20190515143248.17b827d0@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515143248.17b827d0@oasis.local.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:32:48PM -0400, Steven Rostedt wrote:
> I'm confused why you did this?

Oleg said that debug_locks_off() could've been called and thus prevented
lockdep complaints about simple_lmk from appearing. To eliminate any possibility
of that, I disabled debug_locks_off().

Oleg also said that __lock_acquire() could return early if lock debugging were
somehow turned off after lockdep reported one bug. To mitigate any possibility
of that as well, I threw in the BUG_ON() for good measure.

I think at this point it's pretty clear that lockdep truly isn't complaining
about simple_lmk's locking pattern, and that lockdep's lack of complaints isn't
due to it being mysteriously turned off...

Sultan
