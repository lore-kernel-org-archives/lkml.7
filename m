Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD69C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8E720727
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYU0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:26:41 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfKYU0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:26:41 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MODeL-1iBSJ70sZ7-00Oba1 for <linux-kernel@vger.kernel.org>; Mon, 25 Nov
 2019 21:26:40 +0100
Received: by mail-qt1-f179.google.com with SMTP id 14so18746677qtf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:26:40 -0800 (PST)
X-Gm-Message-State: APjAAAXXARep5FyAiHky2zPWyAveOdx8I+NsfzclJUmGmsbzDOq5CsyW
        ro8Nehm2yfOTic4QmknYPdvB5z3IA6Poc499qPE=
X-Google-Smtp-Source: APXvYqxWEY0+GZVbECiGpX8VO0AfY8QEZpDcExkgOlEql1Ch52KBJ6wWYHxwsis5y0vJfLvZZmdStzaB4rJfVUF3of0=
X-Received: by 2002:ac8:75c4:: with SMTP id z4mr30171906qtq.142.1574713599198;
 Mon, 25 Nov 2019 12:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de>
 <1634aafd2a99cedceb63efe57e4c7e0a7317917b.camel@codethink.co.uk>
In-Reply-To: <1634aafd2a99cedceb63efe57e4c7e0a7317917b.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Nov 2019 21:26:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2EfQnLjVfg6U0vCUp1S49CoWCMj-i8ojzbWEUAJAWV+Q@mail.gmail.com>
Message-ID: <CAK8P3a2EfQnLjVfg6U0vCUp1S49CoWCMj-i8ojzbWEUAJAWV+Q@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 21/23] y2038: itimer: change implementation to timespec64
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EVtmBHZzCuyX0+E/a/5yJvDmvVB1xZ8zRtnMR1fjvMXrqV0yQIa
 zZO7pT/Huh7u8B7lVsGh07e1nCVdPNJ9kWBmBJhNXN8BF0fPgXZ/rjylRkHilIeyWvZRthM
 vTVt1nYdq1Z5Ohb2lWrS/vXcOPZq+wP5zW5H09PMMBdjbTDHFylWdFreqTr8G5V7fQzfyI9
 Bdd0fkVa2OzGYTh9V+bzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcN+Wtu4XiE=:bWvrv4ql9K1b2OnpQ3IVTF
 6RcoNHcelotel/zyKvcHrvpVdZgWV2IA6M1PAEqQ4WAQAMh1VJwbqfE8W6Nzb2obH+SvlMtCx
 by5HosaPoWB0zTL2vF//EHORVCygTMXMmIiGiKu4D6ty30NIJg9lUZZkINnkyoRlhaxn0CmAI
 EBs53Yl0qO47oe8tD/W0M40FHYt9WIYQSNge5gYW/KUbLkFat92BXqvX9bk9nvUjIv78vxUba
 aSkRFyXdi/3IPFvQdq35FU5pQy9SPjCpEdbZmt9UgcXPDFgTTIV21Dv2HVk7z9NCMsh2naeGO
 eZCLx31H6yEOOejN2wqhN6WTbIkKM8x8xLG05sW15UjP7wfZjehapa+DZ6pNgjFXxcZ5xhnN8
 jlN6P+tgDxLCLZbaOR1xlnozYy//MzsDrGn5gxrH/Q86XpAzywpP0uzNRRkJkY3T6Ixt/v4qN
 tDXj9Xi1aW84DFepCUJxLjd9OJjF8ikVIwxX4nQdZxdKWs5KCw6oU5iN2UlZOnjv+kTi81cb9
 JMz70BICOfZeTXViK0bu3uvaQ1cOqLQD9dNhdWQxRo7HjwKpxO5zFQtWX9Bpt4/Xznmyj3fJh
 lhev6egRMAoZ0Mg/BVLvpDn5sMtKbAut9SEWXcgNgmndwkeXdRgFrzxhta+0pUQUhmIgjiTN+
 KV1K5CmIaTd7gVXan3geKmATjyUuKOrJ5TDrmcCWtDBYmSmB3z3vNPhydnFIS55sW/D0irQrT
 /kjAliLTaNeC4LvkzERB2h2xXoCPQgAb5LGscNnMFIWFp+zGvfykAxkfUfnWDU6JpFQ4ZzGwm
 LT8k/6zrgCR5N40kSt00Yq9+DsNr6Py+AqQuPUsx1kJAnVgB5FTM1bbh11mU90qILfXuHLbJB
 2xiJtEdEY/fWNMceqn4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 5:52 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:12 +0100, Arnd Bergmann wrote:
> [...]
> > @@ -292,8 +296,8 @@ static unsigned int alarm_setitimer(unsigned int seconds)
> >        * We can't return 0 if we have an alarm pending ...  And we'd
> >        * better return too much than too little anyway
> >        */
> > -     if ((!it_old.it_value.tv_sec && it_old.it_value.tv_usec) ||
> > -           it_old.it_value.tv_usec >= 500000)
> > +     if ((!it_old.it_value.tv_sec && it_old.it_value.tv_nsec) ||
> > +           it_old.it_value.tv_nsec >= 500000)
> [...]
>
> This is now off by a factor of 1000.  It might be helpful to use
> NSEC_PER_SEC / 2 here so no-one has to count the 0 digits.

Fixed now, thanks a lot for pointing it out!

        Arnd
