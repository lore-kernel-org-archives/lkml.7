Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CE925363
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsFyPSmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaEzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:55:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44394 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaEzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:55:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so6796414lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtczSeucUoHeYtIiYUJky9w29yvcYMkcpiT/47ZO0RE=;
        b=LsFyPSmJ03t3UE7s46qhpMX3JDLFjR+QS84P1/WvHBkfcUQhLDMjqHAVPl/nu0cePc
         n5V4RiqwpI69g8DGAb0X9YxZRfSYFQZrbJS8nK0tHMZu5Qr7lzh8VfB/OFBQXz+JtF80
         7IgLlVP4rgrI05Z4yAkFYQNwlhqsyj6NbckkGzRNU0/0wGOJHZW/tqT7VpZR2mvwFd0w
         +lL48O7kEdcdf2zhBysIr+BPnDMNxy729hFOlBVINBdJv5yE6NwJj+/v8OcvbCAVnXRI
         jEN6088isurTNqUkVSpfp5JgWjBHD2GALP1EfkWZFEQ3V0UWVOOLdr4iCOS/FPC0GSlV
         9cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtczSeucUoHeYtIiYUJky9w29yvcYMkcpiT/47ZO0RE=;
        b=RdB7fO5apNgcJFRHsMxhtCeRlNw7Mvx1J+WXUocwckwZyRzPkULs80/w3+7gOLc2A/
         Z/YTnbL8tmINmsLRR4ipZBifaZn4SpQ0mpp7bPl1QAZUAnzAcWqumP1u1MOf22KY2KTz
         42LumCiFG0JRAQUlkcGF5OTNuI8i87MzkkvBSPl4XjZ24XRSgjySwU3wz39uKbCXQfpc
         pqOSSB3VQfvCfEbyJMimYtsle++9Nfb7uwmP4Df9kO6+t6BpZUE3NqE0AgWoCueKOlK8
         NfwNFUxlMGe8OZd9TftHRvmujQDfVCJXC4TtoN3FFww6SBfAtF7VFr+fXPTWRc/hb8Bi
         0JzA==
X-Gm-Message-State: APjAAAWqEV7pSY9n0SE+57SQXMs6ickGdcT4YrSsgWa5anyq/hqD4G9T
        9ZAuK9ilBlmyo9tua5hTBnLOzQeLs3pAGGQD3ls=
X-Google-Smtp-Source: APXvYqzgHzTHOlOpxNFOabvhzsir+AGzMDROYdjP3rpSYVbgqe7YzHBgwdjpViixNa0/WeXhyeKB9GkghyIl/EilXHo=
X-Received: by 2002:ac2:42cb:: with SMTP id n11mr3987145lfl.179.1559278541220;
 Thu, 30 May 2019 21:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com> <20190530141725.GA15172@sinkpad>
In-Reply-To: <20190530141725.GA15172@sinkpad>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 31 May 2019 12:55:28 +0800
Message-ID: <CAERHkrtVKQjkv_R4cj8Szt3fcJAhY1YLXNbL_EnBjUA7Pp8s-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:17 PM Julien Desfossez
<jdesfossez@digitalocean.com> wrote:
>
> Interesting, could you detail a bit more your test setup (commands used,
> type of machine, any cgroup/pinning configuration, etc) ? I would like
> to reproduce it and investigate.

Let me see if I can simply my test to reproduce it.

Thanks,
-Aubrey
