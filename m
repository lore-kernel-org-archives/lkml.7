Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E553C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EBE222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USekCAdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfJETqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:46:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43179 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJETqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:46:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so9739003ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIRtXMzeKU/5iWBtHcvdAVzohUlQNYBWg9glyekRjho=;
        b=USekCAdzBBS2vPp1Kbs7c8ZuFj1hxIcTm3ZnzErvDhKIP7zQmD2LZ7wIpbvoUctPE1
         ubsft+BbXfoZ/YStIB7/yv5LqQYQtqRme9fFkqnHVPDLflQT63d5hUu6z2b+ib7t9pba
         iY7WeWiBqg6hTD0YSf+BVrJ75lOtuDHQDERTe2ysc1nSXMm874Jz7dgp1W5uOS4fOBj1
         xDk2qIYvscGHqjxErhcMSNq6JzeG2l+KyT5gL/TNl0ug/BIJVeoCiFLeEV76k6/jw0ju
         AWUqnWUVAlX37t1TtyFuY+t19GTSo+ppQ/nb5v4UOQuRtgnq2Rc39Tv67ypLqr8LBg+N
         Pj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIRtXMzeKU/5iWBtHcvdAVzohUlQNYBWg9glyekRjho=;
        b=WP5zfLJkbJZTjuA9Y2pLYD/9Dvyn5OGmN/w3GmmtEXvSI8xfEGdKpQUwM7gh39sg2v
         kwYqe354SrtEcQqys7xYC+BUQwB7tntux6ENFU8ZepgUZCJU88M8VPvxR4cvKv7y4ZjK
         5onPsTrX4fuClEiMMdis+kFVb6rDyCt8AHmBCIVyjYqupcNecRnuFjTkEKB8qmuKyr8t
         br3yTW/qvhHkH1yvG3HdbZoKaZe9A+V/714JViCkufyZegEoBemmcJDMGmcrCOphQjq7
         Kl0ShLwK7zkWbotMzeCkYqdw53Yb0d6/KMhzicGmgnP/JMyP//CNKkHBUarbtnOWCsxn
         SS9g==
X-Gm-Message-State: APjAAAXlCjRCIY3KsynBhdQZrGITNMUIJAn7A8REOjBnitFhPlVRpTtw
        D7kiD9Ll5AOW9g919xOo4+o=
X-Google-Smtp-Source: APXvYqz78uYXi/QmR5Xe88a/NPo3a70vR6WSNUBuYFhVYdCBbuZ678Yq4X9J4WX7E/0L1UxAvmt2RQ==
X-Received: by 2002:a2e:9049:: with SMTP id n9mr13136819ljg.45.1570304793994;
        Sat, 05 Oct 2019 12:46:33 -0700 (PDT)
Received: from rikard (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id h10sm2043194ljb.14.2019.10.05.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 12:46:33 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sat, 5 Oct 2019 21:46:27 +0200
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH v3 0/3] Add compile time sanity check of GENMASK inputs
Message-ID: <20191005194627.GA1817543@rikard>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 08:49:35PM +0200, Rikard Falkeborn wrote:
> Hello,
> 
> A new attempt to try to add build time validity checks of GENMASK (and
> GENMASK_ULL) inputs. There main differences from v2:
> 
> Remove a define of BUILD_BUG_ON in x86/boot to avoid a compiler warning
> about redefining BUILD_BUG_ON. Instead, use the common one from
> include/.
> 
> Drop patch 2 in v2 where GENMASK arguments where made more verbose.
> 
> Add a cast in the BUILD_BUG_ON_ZERO macro change the type to int to
> avoid the somewhat clumpsy casts of BUILD_BUG_ON_ZERO. The second patch
> in this series adds such a cast to BUILD_BUG_ON_ZERO, which makes it
> possible to avoid casts when using BUILD_BUG_ON_ZERO in patch 3.
> 
> I have checked all users of BUILD_BUG_ON_ZERO and I did not find a case
> where adding a cast to int would affect existing users but I'd feel much
> more comfortable if someone else double (or tripple) checked (there are
> ~80 instances plus ~10 copies in tools). Perhaps I should have CC:d
> maintainers of files using BUILD_BUG_ON_ZERO?
> 
> Finally, use __builtin_constant_p instead of __is_constexpr. This avoids
> pulling in kernel.h in bits.h.
> 
> Joe Perches sent a patch series to fix existing misuses, currently there
> are five such misuses (which patches pending) left in Linus tree and two
> (with patches pending) in linux-next. Those patches should fix all
> "simple" misuses of GENMASK (cases where the arguments are numerical
> constants). Pushing v2 to linux-next also revealed an arm-specific
> misuse where GENMASK was used in another macro (and also broke the
> arm-builds). There is a patch to fix that by Nathan Chancellor (not in
> linux-next yet). Those patches should be merged before the last patch of
> this series to avoid breaking builds.
> 

Ping.

The current status is that patch 1 has been merged into Linus tree
through the x86 tree. The patches mentioned about actually fixing the
existing misuses have all been merged except two of Joe Perches patches
[0], [1], but those patches fixes misuse in unused macros, and will not
affect anyones build.

I have testbuilt the two remaining patches rebased on top of Linus tree
and on linux-next for aarch64 and x86 without seeing any problems (when
v2 of the series went into linux-next, those were the only archs where
any problems were spotted (build warning on x86, build error on
aarch64)).

[0] https://lore.kernel.org/lkml/cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com/
[1] https://lore.kernel.org/lkml/d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com/

Rikard
