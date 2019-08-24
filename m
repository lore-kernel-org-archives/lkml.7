Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC79C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD6720870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHXAcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfHXAcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:32:03 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E17BC08C325
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 00:32:02 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r9so4904128wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=v6yGslRWKQbnbzawZHfpm4myFDx8OIr1Kch/Aw5UbLU=;
        b=OCWZVybh1Yy1Xb4KzOeY0Fv6eDWzVmmD9pEJ7jUjtSbwZfV+D5b+VXFVGrryzJ4jbD
         n/Aem7xyCbxWsRaFJhmRn0Ssywk/YX0Nu/sLW0YKHzbpXnUmPxx0eVWfdw/AARlXhO8K
         dEtw7sBZ7AdR2l5MrZHUndN+iJBhQMHQpsvH1JqSUpIDdPbgqMFesAHBLTbsG+yFvOJ/
         YMhQgiW/gowqlcOf9RURJNpwky7iqQBeGucfvxRnvAMTpEo6ktRTCPAJDGmoOZmlFdcM
         4CEZ0xa34BF1pIbhp1LAundX3DT5ldIXehQTFdfE8QPtvNfs1/Z+uMvtXil4C3dRRl+9
         t55w==
X-Gm-Message-State: APjAAAVA2T+oloESPI/YJ5Koh3y3m82fm0pDa5D3GeBEiUZaCbfrWLX5
        ++OOqs9c0OpK6WRIe15xK1axahXApVqK2yrup7hpFyvEvMivAw4ErRlr1SAqYSISTsVqq44iR+f
        pMDyccnEaoRWzU5qbpQhoqBcV
X-Received: by 2002:a1c:107:: with SMTP id 7mr7938878wmb.84.1566606720691;
        Fri, 23 Aug 2019 17:32:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqXgoJTESXJP84jZ24DCDQs3wUu8A0ZqXY0CLspNoheat3ANG9iCnAmk7klnkb79pTEomjvw==
X-Received: by 2002:a1c:107:: with SMTP id 7mr7938869wmb.84.1566606720399;
        Fri, 23 Aug 2019 17:32:00 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.82.15])
        by smtp.gmail.com with ESMTPSA id u8sm3532874wmj.3.2019.08.23.17.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 17:31:59 -0700 (PDT)
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Luca Abeni <luca.abeni@santannapisa.it>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [CFP] Real-Time Summit 2019 Call for Presentations
Message-ID: <6c78f0b0-c124-b8b7-1cb9-7422179a8200@redhat.com>
Date:   Sat, 24 Aug 2019 02:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Real-Time Summit is organized by the Linux Foundation Real-Time Linux (RTL)
collaborative project. The event is intended to gather developers and users of
Linux as a Real-Time Operating System. The main intent is to provide room for
discussion between developers, tooling experts, and users.

The summit will take place alongside the Open Source Summit + Embedded Linux
Conference Europe 2019 in Lyon, France. The summit is planned the day after the
main conference, Thursday, October 31st, 2019, from 8:00 to 17:00 at the
conference venue. If you are already considering your travel arrangements for
the Open Source Summit + Embedded Linux Conference Europe 2019 in Lyon, France,
and you have a general interest in this topic, please extend your travel by one
day to be in Lyon on Thursday, 31st.

If you are interested to present, please submit a proposal [1] before September
14th, 2019, at 23:59 EST. Please provide a title, an abstract describing the
proposed talk (900 characters maximum), a short biography (900 characters
maximum), and describe the targeted audience (900 characters maximum). Please
indicate the slot length you are aiming for: The format is a single track with
presentation slots of 30, 45 or 60 minutes long. Considering that the
presentation should use at most half of the slot time, leaving the rest of the
slot reserved for discussion. The focus of this event is the discussion.

We are welcoming presentations from both end-users and developers, on topics
covering, but not limited to:

 - Real-time Linux development
 - Real-time Linux evaluation
 - Real-time Linux use cases (Success and failures)
 - Real-time Linux tooling (tracing, configuration, …)
 - Real-time Linux academic work, already presented or under development, for
   direct feedback from practitioners community.

Those can cover recently available technologies, ongoing work, and new ideas.

Important Notes for Speakers:

 - All speakers are required to adhere to the Linux Foundation events’ Code of
   Conduct. We also highly recommend that speakers take the Linux Foundation
   online Inclusive Speaker Orientation Course.

 - Avoid sales or marketing pitches and discussing unlicensed or potentially
   closed-source technologies when preparing your proposal; these talks are
   almost always rejected due to the fact that they take away from the integrity
   of our events, and are rarely well-received by conference attendees.

 - All accepted speakers are required to submit their slides prior to the
    event.

Submission must be received by 11:59 pm PST on September 14th, 2019

[1] Submission page: https://forms.gle/yQeqyrtJYezM5VRJA

Important Dates:

  - CFP Close: Saturday, September 14th, 2019, 11:59PM PST
  - Speaker notification: September 21st, 2019
  - Conference: Thursday, October 31st, 2019

Questions on submitting a proposal?
Email Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
