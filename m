Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AFCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B0B2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="De16ed2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDKQSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:18:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38726 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:18:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so7785565qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dtBnB10BHscANlI2Pry7Ppm8oEPt+C4ZM4LG9RdUtdk=;
        b=De16ed2XEEtRbo1CKENs6sMutHD49Q/cAstG3x5wpdUx4DYv3vn40aZ7zGxs9pKUVk
         ek9QFv0RYGM538H15uQSE5LbohaaIJCUg3LcLe/YhVbL6RalwlCudvAPNrrnoKElWsFy
         JbF/ndTJJqlDbBBt3CnWLC2x1CfLe3+PtzByzBGTFse0rpiDiCHpCqH597QWvGbXVEyG
         FEtE4zye0+fCtu9PhwqVIEGGh9u/EPP+2pTHpDHfkdI4CPDLNUN3oGq220fh2X2a8qHw
         NgNJikpyAVpALN8w62AAEgQHCP1yb5FfC3P6SpnQjNJU4Kkr2Kpre+vEGC8ZjZKo8Gl5
         o8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dtBnB10BHscANlI2Pry7Ppm8oEPt+C4ZM4LG9RdUtdk=;
        b=FAlYRWQdezLkTyT+mjbjGoXctf17yEQYbpsQhw2mfn8zG7wqT5spuTbfW/eu/0MAEA
         U9z+aVr5ozAKPUDoqnshjWPyKTE06XZDGRGpbDXY28jk+oRxmMww+RN4XLCa9j0BDKfW
         Bdi5fJUrNA9qk4Hh2zJlgjQDs01ffBF0qHbi6dPEwV20M4AxBVuhUwdu/zByJXE9iNGK
         GnbtHYBOxf8xDXw2ReyTVCJviDaCqkWiHSPM2NfxgkzWznY7zoIBUixaGHp0tnNFaSQM
         wN62GInNFxUIoD0jy61xbEKmAzAex6M6txT37yFE9vp43jwmx3G85L5lK2gk7KGSDt+t
         yf4g==
X-Gm-Message-State: APjAAAVZfsr3Mur685gr+7saK97s4/Mr6IcQLj7iCPchsFSCi6OMRQ/E
        P/bnuey7P4IhVIaP9utHz2q7zwuxqR3lRLMra2hbvA==
X-Google-Smtp-Source: APXvYqx5CWpGgbACybyrinBfzS83tX4KRJs57zlMkMYYYLfTduHXBqgvj3424Yc5issdUsStUoC8yj5bc9QGP2WynL0=
X-Received: by 2002:ac8:1a21:: with SMTP id v30mr42590152qtj.103.1554999525039;
 Thu, 11 Apr 2019 09:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411105111.GR10383@dhcp22.suse.cz>
In-Reply-To: <20190411105111.GR10383@dhcp22.suse.cz>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 11 Apr 2019 12:18:33 -0400
Message-ID: <CAJWu+oq45tYxXJpLPLAU=-uZaYRg=OnxMHkgp2Rm0nbShb_eEA@mail.gmail.com>
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        penguin-kernel@i-love.sakura.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:51 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> [...]
> > Proposed solution uses existing oom-reaper thread to increase memory
> > reclaim rate of a killed process and to make this rate more determinist=
ic.
> > By no means the proposed solution is considered the best and was chosen
> > because it was simple to implement and allowed for test data collection=
.
> > The downside of this solution is that it requires additional =E2=80=9Ce=
xpedite=E2=80=9D
> > hint for something which has to be fast in all cases. Would be great to
> > find a way that does not require additional hints.
>
> I have to say I do not like this much. It is abusing an implementation
> detail of the OOM implementation and makes it an official API. Also
> there are some non trivial assumptions to be fullfilled to use the
> current oom_reaper. First of all all the process groups that share the
> address space have to be killed. How do you want to guarantee/implement
> that with a simply kill to a thread/process group?

Will task_will_free_mem() not bail out in such cases because of
process_shares_mm() returning true? AFAIU, Suren's patch calls that.
Also, if I understand correctly, this patch is opportunistic and knows
what it may not be possible to reap in advance this way in all cases.
        /*
         * Make sure that all tasks which share the mm with the given tasks
         * are dying as well to make sure that a) nobody pins its mm and
         * b) the task is also reapable by the oom reaper.
         */
        rcu_read_lock();
        for_each_process(p) {
                if (!process_shares_mm(p, mm))

> > Other possible approaches include:
> > - Implementing a dedicated syscall to perform opportunistic reclaim in =
the
> > context of the process waiting for the victim=E2=80=99s death. A natura=
l boost
> > bonus occurs if the waiting process has high or RT priority and is not
> > limited by cpuset cgroup in its CPU choices.
> > - Implement a mechanism that would perform opportunistic reclaim if it=
=E2=80=99s
> > possible unconditionally (similar to checks in task_will_free_mem()).
> > - Implement opportunistic reclaim that uses shrinker interface, PSI or
> > other memory pressure indications as a hint to engage.
>
> I would question whether we really need this at all? Relying on the exit
> speed sounds like a fundamental design problem of anything that relies
> on it. Sure task exit might be slow, but async mm tear down is just a
> mere optimization this is not guaranteed to really help in speading
> things up. OOM killer uses it as a guarantee for a forward progress in a
> finite time rather than as soon as possible.

Per the data collected by Suren, it does speed things up. It would be
nice if we can reuse this mechanism, or come up with a similar
mechanism.

thanks,

 - Joel
