Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3386C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12A920717
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8Fsa8oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406389AbfITSQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:16:54 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33533 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404864AbfITSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:16:54 -0400
Received: by mail-pf1-f175.google.com with SMTP id q10so5064586pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRYsl4kbwSC/bZBUIUOMAhY4tlK0GbxtJtIAdokA6Ow=;
        b=P8Fsa8oc28GG87andEaXrr+qNwZa+kesukHYV2tO2wySoV1aWE0RWjAV3m4sDrgZSP
         blnnQDZL42c8p5pjNmaGzEPNMC4p20HyaI/+zk7IP/DRc8HVJrm257RjBAbCqSsLt420
         NrBEt60pAEu+Bw1EBEZYCVllTEckZGeybkNyPd3LomcUdO5stEsn/tH3APsSrBK+lX24
         E4iA83c1C3qSKp9vhc8VZUb/Ljhd/uOg8n5KGKAH2zpPI1XDkqQVCFsgGAa6n4GY7rcr
         eFkNEjqBtsNR/Cz3td+CFtKq3K22ZDxmQYjEcihORpjtEUSdAu0HWa2LpSJQTxgXVG+a
         3Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRYsl4kbwSC/bZBUIUOMAhY4tlK0GbxtJtIAdokA6Ow=;
        b=C0BY6/kXLTMmzyE/tEQNTlXvHopaWGYf1y70W2Kdao60knxrdwXAjVZk0QZkj+MZZh
         JN/yKKaOy8A4C/7nITHX0UuHAhPP7dSwDGQ+O5KCfRybZJKT8CVJXkPRh+xaPkq7td2Z
         XDrttanRuGmSJPbc1HPQse6YterpM52OHCRS8cRuq+Okn6kFF0d/yGDJ9OvBB0ZSJBnp
         1mPqhLFlpt1lGcK5pdSgMnGGKQ8slyDJaGhygovG7Oc8gektjtEeZcfbsHEorV4ZoOaS
         aXC+L5EzR3K8IAxcKOvIGfeIhA/rmP4kcB0OQAW9oeuLRB+m4D+ul7IufzvDGmERI0Ze
         BcMg==
X-Gm-Message-State: APjAAAU5TNbsiIx6fwQndRlAAkWAuPuxq+zXVDyGxDb4LelqYfX0esLa
        q1s9H/YH70mFJLVrPbV9NJFdo80GqVa/8Y/1CMJloN+E1lc=
X-Google-Smtp-Source: APXvYqzmPYjHEihFc1rlwR8O2boZQRGHg+Ybxnn6AupPB2AjIwzWhoF9wR+AjNhTZn/qSkO+G2QnIsQteqieDZPr5h8=
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr5969190pjr.84.1569003413024;
 Fri, 20 Sep 2019 11:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <CAFd5g46b1S5TZYGMP4F2f3Xhb1HrYTUFBOEK5gXuMBFEkzhZ3A@mail.gmail.com> <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
In-Reply-To: <CAHk-=whr5K4ZH2K9pj=PZNWbiHfuz4noorjJa746_FOxLAgfxw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Sep 2019 11:16:41 -0700
Message-ID: <CAFd5g47=QykaDJZQMY=gzGX4626vrFk3E2JQK=zCPAO2O2=qzw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 20, 2019 at 11:03 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Fair enough. On that note, are you okay with the `include/kunit/`
> > directory, or do you want me to move it to `include/linux/kunit`?
>
> "include/kunit" should work just fine for me. At least I didn't react
> to it immediately when I had done my test-pull, and it doesn't change
> any auto-completion patterns for me either.

Sounds good to me.

Thanks!
