Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A191C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA8521883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXDD4U/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfIDP1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:27:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34512 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:27:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so16315347lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kv+2wLnUgOif3ThoOBB61ROD4VGFmjn42c/IHIPsCvo=;
        b=pXDD4U/igN/ckHfDYvEalA2WyC5R9b/soOpEWiHB1bt1n/s8CaSjzE1pqhHvu4xh+4
         AkmR5U4BpcQHmoCwI/KVdv1aeYQZdTBuuggCoJayY+k/IsM/WktDwOGue13H9dezTIu1
         +YXAj53T+tpxetS+VOAAJXswWLtMHZDF+pWmO83F5UNIxsFBwrFRjequBqYumqxyLqQC
         HOHxd47G4he3ee/kJMlpTXE+qu/iJcv1Svfmm1LSD/AwdY7LLj4rcgOpjQhBwSDuAash
         o3j5VnzSHaPI8Z7veJ6Vr8WvT9zhwzoKsPTkIn3FRKAQn53xhYyFnH+5UddR6jcee8Th
         QoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kv+2wLnUgOif3ThoOBB61ROD4VGFmjn42c/IHIPsCvo=;
        b=mg2Zyj/u/eAxGiEEqNhHj81s/VmASOiCvCt9wGGOawEs/t4axX2wyuJPRZmlydMH4B
         mZZc68FOY/4lPRokkH/KUKoCTXy4SWCA80aIsUjVkLX8jPDZZR7BdB5TvpiDz55ilNrs
         lzH437PLhIs0k5GzrebseEo2cZvAmuYkBtXGoUR5WFFbcKaEHZBDT+MhoM2NEs7Z5xPj
         O4oCaLNwmm1Ehz1ZC+rrJQC2sCoY/NSmRSlnVnfRIYujVVXEaDih02Lc7QOj4/swrxjA
         +IGDHNT4w71DihfZKPNxzHKrXj7aN6DsNlUGVDMXkRmTA18u45duWAoUoEwLkgygkXe+
         gEfA==
X-Gm-Message-State: APjAAAUwoDNFes0OgCZL/5HhfWAJ/o1rjpKI2h0u7zt3voUBGb5FxxQ9
        0vStDRHaLSe68x1pOPYh+f+ol0JglohJ039AT5k=
X-Google-Smtp-Source: APXvYqwJMcWK+hsiNyl5imyLDP69KNM91uSgCzrhW/1FVA4Th0151mRDUss+5abEYcbz3f5P8NA5+daOLdcovMTZXa0=
X-Received: by 2002:ac2:4257:: with SMTP id m23mr4424389lfl.6.1567610823532;
 Wed, 04 Sep 2019 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154340.860299-1-rkrcmar@redhat.com> <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com> <20190904042310.GA159235@google.com>
 <20190904081448.GZ2349@hirez.programming.kicks-ass.net> <20190904131154.GF144846@google.com>
In-Reply-To: <20190904131154.GF144846@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Sep 2019 08:26:52 -0700
Message-ID: <CAADnVQL3CsB6z98BFWd8wn7WKk+W4UVH2NbzrhJgeaU-D-n3ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>, Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 6:14 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> True. However, for kprobes-based BPF program - it does check for kernel
> version to ensure that the BPF program is built against the right kernel
> version (in order to ensure the program is built against the right set of
> kernel headers). If it is not, then BPF refuses to load the program.

This is not true anymore. Users found few ways to workaround that check
in practice. It became useless and it was deleted some time ago.
