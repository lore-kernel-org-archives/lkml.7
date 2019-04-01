Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141124;
	bh=XRJGXhzu6hxZGMfSc7/r5ToGCpGK797KROFn4TK6XZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Z8QUOICRDZ4hOdOkMjV3fvuwq4c05BZpgLHlQczp1xiZpJkVLZ7SbLyN05srgf/Lr
	 dCWDG1FRpFYML4qILHAsENuohPU/k2uxDqhWSY9DD3L3Bi2RnH7oaAmFuHu2ddG/jp
	 A7v2SxrHJbkuH+aN/h7PK24n0ex+6G+gRYbHZWqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbfDARwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:03 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43212 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfDARv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:51:59 -0400
Received: by mail-lf1-f46.google.com with SMTP id g7so6931274lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PHMeePNk5+WqIP9bn6Ly7V2tLpJ0ch+LgEkGb4MdyLk=;
        b=BTqw7lO5Xbdw7L1gGrjWfzTyh1Ekkfz4Gc6wDzzinjrCDP1+luYqbVnMNflJqqnDtA
         xcdigwvpgyhnqYJ/Klzenr7m04aoLdciK90EWH6zC8c4knB44hTOmuVt/cr0vAtCqJwh
         BMYqYQa0HJwmXd0frGFAdPacmKjV2q+LYfSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PHMeePNk5+WqIP9bn6Ly7V2tLpJ0ch+LgEkGb4MdyLk=;
        b=pBsusxLpWlxFbmUuXbN5q2kQhAqmZFUsiTeX1MWUtR4h8++3VMwkGFjsGRFmF1Nr/E
         a4gzEsihkqk+ChCFbK3FmJlzehuz3/Z0kirwNaFHDGhB5HjyVRCZ2YuXJRpmxpwSsQ5W
         p6dFyj7wKvdQVwI3HGjimFXOYa+nm/AStvQf5OB2wu6h45uBoWCZyBDcgB6woU1qSOgR
         7Sg6DkqqsOuURkilaI58YFUy2PYjNcylHG8b9fpHUfANRzl1U3u9ScVrz4zag6yDd0ek
         hm1Hc4AoJQdI0+y37YdYLaphxG10wdM53MsniimKY2amsJ3a75+5osN9igCKsMZD644U
         G8gA==
X-Gm-Message-State: APjAAAXItNdO9k41ZQ157l1nbm6W3goWzoNB6pnNjgEhyX9Z1TgKvHPS
        Ki87Kg0vQRTiQyoBTczaUfE2aBgvENg=
X-Google-Smtp-Source: APXvYqyo7Od9uDeunc8CYDMvzS7telJNTgf6b4NqgnLhrBtfhxzSsI2t+N5PhP9FgWITq5BDgFphRQ==
X-Received: by 2002:a19:ab1a:: with SMTP id u26mr34926138lfe.65.1554141116342;
        Mon, 01 Apr 2019 10:51:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f1sm2239261ljf.40.2019.04.01.10.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:51:55 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v14so6961813lfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:51:55 -0700 (PDT)
X-Received: by 2002:a19:9145:: with SMTP id y5mr35643508lfj.35.1554141115065;
 Mon, 01 Apr 2019 10:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190331230940.GA30957@mit.edu>
In-Reply-To: <20190331230940.GA30957@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 10:51:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4OqHpbckCcan73TXkB-rxS1C2M53uLs27Gw2w4PzR5g@mail.gmail.com>
Message-ID: <CAHk-=wg4OqHpbckCcan73TXkB-rxS1C2M53uLs27Gw2w4PzR5g@mail.gmail.com>
Subject: Re: How to add Unicode character tables to the kernel?
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 4:09 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> The question is how to do this, with different tradeoffs.  One is to
> simply include a utf8data.h file, which will be 320k.  That might
> sound large, but in fs/nls there are 3544k worth of similar files.
> Some are relatively small --- only 16k.  But others are quite large
> --- 480k to 856k.  The table for Chinese character set is such an
> example.  So in comparison, the 320k size of utf8data.h is quite
> compact.
>
> The problem with this solution is that the files in fs/nls, and the
> proposed utf8data.h, are generated files.

Oh, we definitely don't want to copy the original huge tables, and we
don't even *want* people to edit those things in the first place.

So generated files are fine. It's not like the source data isn't
public, and yes, the commit message should have a pointer to it and
how to get the source and the generated files. But no, we shouldn't
feel like we should encourage people to be able to generate their own
modified unicode tables.

                Linus
