Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640FCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF10320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572441332;
	bh=I8xKnzR5oNcw2WY4enVa81i7GJZV+DkmFl+4Z2SB7OM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0DEai5W4cBQZUKEXWRTMtEVh3jRxcbZ+9LMpssJUpGd0fIRmB9UAV4PTzVOJZyrEU
	 DTblLSdtyzqGEPBO6Vw9MIZ8SSYKrkZ3WazFtPO2R9N6FBCNznmvz8QPmdkM01r1EZ
	 5qQYfw7Z8ECDludE5rNVG8G37jHHMINke3q1ar7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfJ3NPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:15:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34030 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3NPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:15:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id f5so1534174lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OWOFC9Vd/fJAJ3RAjW3BcHuOSkS0sKPacDNJdaNMlA=;
        b=AYc+eMPb7t7V/IgqOVYH5K3UrmXqZQeUHzT3eASCCnqoEuysmjE0x9w018Baw5soU8
         KHqeLYTWYEWYL1wcgjZktYPugcq4oUD8s7/1/mrjRyJfqbAtn2211DSlTeue3CJFSSYY
         VXtD5xvbAaldbzu/6uqvH3p5jndWBpa9/A0so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OWOFC9Vd/fJAJ3RAjW3BcHuOSkS0sKPacDNJdaNMlA=;
        b=lOIvI1xHkFMUQbT91aoC7xiluN8/tcZ/OXAdnbQVqifx7eJckp24J7wu0ui4QC63vA
         9Nm8TSFx1vRMhUbbAN4VCpta3oq+qVtNJwv2gQXTARKdHnug64qO1SrQeYrV+yDkh/BW
         so1+jfEprNDlyPSH05vlR7yKhL69bssTuSYZqACFgOD37IRX7CwPGsfViYzoq5c+kEhY
         I8sxl9+TS9XsNCFIwsKUrfR+L7HygL/dW6/ZI0dPtrKD3yy1FD45coF3CaYARGhJorS+
         rmDheVaxUeTYfd2/W0476MsIZf3r2/wvysbpI4dAO7jAXGg9SwQRuNtTR+fSAMLAUhMj
         Cw6g==
X-Gm-Message-State: APjAAAUOxL2ubJ1h/X1kxUl40wk2Z1sqZP9KMkTpa3GUL0a3ORF8i2cB
        PJkqNNMP9xlYDaJIbdhZIUZMnVtkSHrz0w==
X-Google-Smtp-Source: APXvYqzaVVPzh7OBIICvQRjULT5QrzON4/q6XdlHAKhsN3W8x52o5kuo5kPstkCPyDMtkJGGklNVqg==
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr6330000lfp.184.1572441326248;
        Wed, 30 Oct 2019 06:15:26 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a14sm32319lff.44.2019.10.30.06.15.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 06:15:25 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a21so2602427ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 06:15:24 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr6751144ljg.26.1572441324701;
 Wed, 30 Oct 2019 06:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191030113703.266992083E@mail.kernel.org>
In-Reply-To: <20191030113703.266992083E@mail.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Oct 2019 14:15:08 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
Message-ID: <CAHk-=wgx_pSBtvmQE9zuNB6aoP52z601SG1pQDtrhm9ZMHNPMw@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 5.4-rc
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, Stephen Hemminger <sthemmin@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:37 PM Sasha Levin <sashal@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

No, Sasha, I'm not pulling this.

It's completely broken garbage.

You already sent me two of those fixes earlier, and they got pulled in
commit 56c642e2aa1c ("Merge tag 'hyperv-fixes-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/hyper>") two weeks ago.

Fine - of the three fixes you claim, I could do this pull, and get at
least one of them.

Except YOU HAVE REBASED your branch, so I see the other two fixes that
I already got as duplicates.

WHY?

Stop this. Read the documentation on rebasing, and stop doing this
kind of insane thing.

                Linus
