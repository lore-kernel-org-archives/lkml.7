Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A72C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C90208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560814215;
	bh=inxI2FD+NSrc2vztLTOTjoOdwRJjtcUN7ryXfqqWYkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mo0t4cERXrTDdXBE0YqGRq5MxPZoE/I/f0CZYJlrFPxCV+sxlE10XAmzG9vYPBnO6
	 0Pic/HNr+1LfDFHiFHqjpFrXhLhe76bF/kGuFY2gtIN8EBBmnIYAGbVbScMJ/QbzQZ
	 vMFO5LZuEwVfc506u8wFB3FBts3RuiW2JL6WnqlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfFQXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:30:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38301 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQXaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:30:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so11086711ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSlnrikhmcgad5C0n4qp/v4MF0qr179vLd3WTKmDTCM=;
        b=BxpvYJ+agSNLwq4y9NHDYqRZrmep21oIT9drwkiIH2vfs5ZeeuU6IKHLuxX9G306a4
         4mMlrj/9OewJMlCd2mOEFWBGl+lmtDoa19iHj8blbUjKhIUwxNFWEzt6rRvmSEdNkivr
         WGZut+frZ7Ro5jVpYWitT+690GF3d6LM1mkuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSlnrikhmcgad5C0n4qp/v4MF0qr179vLd3WTKmDTCM=;
        b=mqaD8cuSVXVTKDn0sTjG7U//EjQirWD6QL6/lrzGUqKVMMZPjVDospq1TaPnZj1cwp
         7fMKDjBBCI98NCWX65RPGLZDP5Cp22mtIIRRb7uB4kEy8W+yNX/FD93bZHcSu+Xus9Tm
         ioDFIafrVEXnaiVTMn6/cbZ8m66kzJJ2fluu4YrXJfYP+i2n5STE4VvcxLnMgIaeM/wU
         JXngDTLReCHFd4WyvXQikTmDvReW6fTofbu7ZWm8XzqeCMcTQvFRnBkCw/DowT/25+Li
         RAjBZFCGX0GgABPTfJxWAbEsbBxCKjbRJqmEWLJ4H90mS44NBDtKl03Anh5mmWLpNO7N
         4YmA==
X-Gm-Message-State: APjAAAWTGzUmaqgf1UWAyGYkXPPs+i6r+CkAY8KhqkdihPGMsRMOO/t4
        tfyfc1FUfJQcOyxfLhiazdbnbAfODNM=
X-Google-Smtp-Source: APXvYqxOQ8rSUxlbzEfNyXVfcLKOmtmsIzwVTb02LTN9lDjaGE4dAJUlArMUan+d4N5/TqDM2RkvHg==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr32663698ljp.202.1560814211227;
        Mon, 17 Jun 2019 16:30:11 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j7sm2574586lji.27.2019.06.17.16.30.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id a25so7819265lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr544968lfm.170.1560814210085;
 Mon, 17 Jun 2019 16:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190617212214.29868-1-christian@brauner.io> <20190617213211.GV17978@ZenIV.linux.org.uk>
In-Reply-To: <20190617213211.GV17978@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 16:29:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvURjNyBUx_V7z3ukSeHN6A5jbQF5c53X40undQy8v9w@mail.gmail.com>
Message-ID: <CAHk-=whvURjNyBUx_V7z3ukSeHN6A5jbQF5c53X40undQy8v9w@mail.gmail.com>
Subject: Re: [PATCH v1] fs/namespace: fix unprivileged mount propagation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Applied.  Linus, if you want to apply it directly, feel free to add my
> Acked-by.  Alternatively, wait until tonight and I'll send a pull request
> with that (as well as missing mntget() in fsmount(2) fix, at least).

I've pulled it from you. Thanks,

                   Linus
