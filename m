Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189AC2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552409801;
	bh=2UpKgzhLXyGuLTgZCbo7ryE7W32Q5yF/zhNaQF0qBM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kZqEy/HBUl4LbKsIoH4ZqsZvPE4jBF1SF69ueeTaH2Oh9Q4NrlmDjniZAxqoE6b3D
	 /9FTLEYTYFNZKy0WMJD6IPrNPAnK+0ZS0etCDA870tex17MmTJJGiwFxwAmgJTz17y
	 8vmLSwtTziBj770RJS2rE/dFDsPkW6jHaLUlJJnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCLQ4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:56:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39625 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:56:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id g80so2971018ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF5lVqPLBS/uxnhm4n2xGsj3Kv+seVXuIOQeBS2mG9U=;
        b=gaQvpyiOpcBciA2py1anFU+mRILNf3ZK89HjzEcAn49ZEEJ94e7VvzGX5EUkcoT2y/
         bLP3XTAFtlwo49OJ8LCaQarY3+60J5LGsh92XStmzjj4a9zdnJ9nYPLHHWadmoCxec92
         eL9tIp3WZ8YbDlyUrQMDVCOKUOe+vYj2V8Dac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF5lVqPLBS/uxnhm4n2xGsj3Kv+seVXuIOQeBS2mG9U=;
        b=sbmWtK5MDCQ47ftfd7o4KgtZHmju8cCapE2CchPieSQ3CGL77PkXxknHTahAeulqMi
         qGFM1Cz5uoAqKMkd+H2QwSY4hsf1qFqhDnqejXcshELtNRL78fqFlv0ziBXwGfZE1Imt
         4Q5I6xuZL4i6Ri1dUVykAJKIC/pj7G4rcqbjjAA6cgz2mxur+qaKpMfhkHnPxrEdt2ej
         GHH3O6+mHThROC8OBLhSt+tvj3LWqY2FqkXC1rPpY5gb2raIpUtUcv8sjWb/LxUSM5ZP
         p0TfbW0pGXSOKVMEl6ivkV9MZWb/ArbRqsB7ezsuOvdpTvFwhuaPz/1f2BG4hFMiZpXB
         zJJQ==
X-Gm-Message-State: APjAAAXd1BGY8KDb6eDNdgdSmpQvz51o6av3kVIwj0KndGJVComaFTAr
        JD7VgJtXhJgrGqqt8cPzF5s3+6gt/yY=
X-Google-Smtp-Source: APXvYqzfEVeEHM7m6TWM17fqtrxnLJP5Ih0WlqXa3BKPsx6js33l2nWa4byu99Yrv+qslXkR6aw1RA==
X-Received: by 2002:a2e:5bc5:: with SMTP id m66mr3290050lje.19.1552409796176;
        Tue, 12 Mar 2019 09:56:36 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y2sm1451293lji.46.2019.03.12.09.56.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:56:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id g80so2970919ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:56:34 -0700 (PDT)
X-Received: by 2002:a2e:87cf:: with SMTP id v15mr3035351ljj.22.1552409794563;
 Tue, 12 Mar 2019 09:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190312043908.GA261883@google.com>
In-Reply-To: <20190312043908.GA261883@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Mar 2019 09:56:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg50Hn+vBmTSLVc2dG0+3Sjn0ZeL22RH2YxgpgvKw5NpQ@mail.gmail.com>
Message-ID: <CAHk-=wg50Hn+vBmTSLVc2dG0+3Sjn0ZeL22RH2YxgpgvKw5NpQ@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform updates for v5.1
To:     Benson Leung <bleung@google.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        enric.balletbo@collabora.com, bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:39 PM Benson Leung <bleung@google.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.1

No diffstat in the pull request? And the shortlog looks truncated too,
with Nick Crews being reported as having four commits, but only two
visible.

(And yes, there are four commits in the pull itself).

Finally, you say:

> 2. Cleanup series between mfd and chrome/platform, moving
>    cros-ec attributes from mfd/cros_ec_dev to sub-drivers in platform/chrome.

which I don't see at all in that pull. But that turns out to be
because it already came through the mfd tree.

Things look otherwise sane and I did the pull, but please fix your
script and/or workflow. The "it already came through the mfd tree"
issue is fine, but diffstat and truncated shortlog is bad.

                    Linus
