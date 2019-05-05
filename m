Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CAC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FCF2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJRd3Mvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfEEMHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 08:07:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40793 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEEMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 08:07:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id w20so307073qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 05:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-transfer-encoding:message-id;
        bh=fhuMdr4ue4iw0OKDysFq+M/gteJlPKUxyQ/+TugYxZc=;
        b=vJRd3MvwNmSOrCLcrDcIljtWX9H0ynnxZc4g+tPCp/jLIlqyMcdBXH33uMLzWuY1ku
         /nt2ZoGJ64nSeHp96eaIkwugNmtEytYWhNNLaP1VigR5MV4Oy7JxUs5MK9xI92EPb6ie
         YMEkPGHXDu9ksd82Ng1p54cO671m+1QoUDhOFpObvtgSxtYnP+oi5THC9XGZ85aavy22
         xtT6WyV8TAG1nNFhTdG/37AJd5Bmc4Kn6q98SzjyojTXBZv3Wircu4XRSzbu4zIf39RL
         ufUWpeEWl5jFTp+fXV16uWDaT/wmgsyDnMQk0yzyVqV8ZZ71N7B3oa0TiJLScjW6Og9i
         Yc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-transfer-encoding:message-id;
        bh=fhuMdr4ue4iw0OKDysFq+M/gteJlPKUxyQ/+TugYxZc=;
        b=Vm3Wfkq8ebxkt7eLP4qFVUSHZtA+63gXBM73O5VGfTK/BxbQG7WP1yxnEswY5rrGvA
         5iudNfDav9uh3S6P6KMxMMRv34QuoC2Xa7i3D731RizYf2qz+GWUIqn0eEWWNCyC+Z67
         FckSRz7GoCc+qGvO04UdZUsgIe69Q2li/g3VUCqEXpcz/C3KbKlCtgCEss0A4cHaBive
         tk2RJOmPg0zgHYBzhCYkSYkKHlIcJRMjXC2IsJsotip7Gxg6u+xj3WM8z/wFkZkYwK9O
         i/K/cnr9Aq4y5jvHn1O5znfstbFO0hAcnylx6K2WPb9ISYJFWZljqURNY8pl/0MObi07
         MmoQ==
X-Gm-Message-State: APjAAAWpQ1zJ06JmO5/5SGRP1DRYAaaBBR7wbmgAgzZR2Yi2oJwy93IV
        u8UNSl4OGgyaO+NaAM/+JiI=
X-Google-Smtp-Source: APXvYqwMOMguo6xj2k36egfwJjuFFroW1TYees+7IQAUVkgp+24keO7Tz+fO1l7Wx+vzKBRUytOQqw==
X-Received: by 2002:a37:b7c1:: with SMTP id h184mr15125541qkf.153.1557058074003;
        Sun, 05 May 2019 05:07:54 -0700 (PDT)
Received: from s19.localnet (pool-173-49-117-165.phlapa.east.verizon.net. [173.49.117.165])
        by smtp.gmail.com with ESMTPSA id r189sm4419943qkf.61.2019.05.05.05.07.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 May 2019 05:07:53 -0700 (PDT)
From:   rhkramer@gmail.com
To:     vsnsdualce2@redchan.it
Subject: Re: Can a recipients rights under GNU GPL be revoked? - Bradley M. Kuhn is not an attorney (he should go get his JD and get licensed).
Date:   Sun, 5 May 2019 08:07:51 -0400
User-Agent: KMail/1.13.7 (Linux/3.2.0-5-amd64; KDE/4.8.4; x86_64; ; )
Cc:     debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
        Ivan Ivanov <qmastery16@gmail.com>, mailinglists@mattcrews.com,
        jhasler@newsguy.com, scdbackup@gmx.net, richard@walnut.gen.nz,
        curty@free.fr, jmtd@debian.org, mick.crane@gmail.com,
        tomas@tuxteam.de, steve@einval.com, joe@jretrading.com,
        rms@gnu.org, esr@thyrsus.com
References: <60c1b08305c5326e3503f51d81622541@redchan.it>
In-Reply-To: <60c1b08305c5326e3503f51d81622541@redchan.it>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201905050807.51462.rhkramer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 05, 2019 12:51:15 AM vsnsdualce2@redchan.it wrote:
> Bar rules do not allow lawyers to serve under a non-lawyer
> in
> an organization, and the organization was essentially a pro-bono law
> firm
> (which really needed a attorney in it's ranks...)

That's interesting, but (off the point of this email exchange), it puzzles me 
-- many corporations headed by non-lawyers have lawyers on staff, so I'm 
guessing that the statement you made applies only to organizations like law 
firms, or, the lawyers on the staff of a non-law corporation are in something at 
least a little different than the normal employer / employee relationship.

(PS: I stand corrected on Kuhn being a lawyer -- thanks for the correction.)

Now I have to debate (with myself) whether to prune the cc list -- I forget 
the original post -- was it really this widespread?
