Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBD8206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555437705;
	bh=lcvB5HPV3XZt/o8dWH//tCJcYHx8A+AxZs62yM/KmOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oocxuG5jE8ZWt8NSjOW7izAWvt+QoN616e22EUz5lV/A6zB1RYb5woTV6bUtHsvQc
	 fuBfJU4tcfkMkubYgNLVRipk3bqhP3EspFqjKAKQrJWLKo27kL9KJD2q6vTweka7E6
	 iiYQ1yturJsGwtN9ptEDL1x78Qi627jaOiVx1IEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfDPSBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:01:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35532 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:01:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so11447963ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVX1mRjtOMg4oUiuXYi0KIk3f+D6U6uz40uSXEDtIcQ=;
        b=gI7R1joKcdprGnzH4172rzwlL2Ug3RT0nPsB7yY5nMnCRSFjxdywOtsPMIXT18cpR0
         qJm6nmdIMeQFWw9LzziVNlVgyl4wXSb0OCmEo2UAJCUV0D4389nbQ/1nH/RLAxCnaxVz
         QKOqRI1chXXaLokBikM4ubnFEVYWB5/taJo7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVX1mRjtOMg4oUiuXYi0KIk3f+D6U6uz40uSXEDtIcQ=;
        b=hLr0Ru7cLT5T7nhQeePYO3bTGYZpclb1CDiff609PPiCoN3QrhW9u8JmT/nr5mx/sM
         JtiVW1i9rHkMyLgwCGhZUNrijHSep0oMzi8JxYj1lCTpAwr3+X3B5mLPWD/Jvv/i6B8O
         x6hkr1jaB3oSPNtjdEYJhwq8EUzNaASqFOgd/ogosX0LK3LDTbOtbezffilrRQGZJIe2
         2OYCWIq2he6ytbuwAErZoT2i7Kg1vXcf1eKzdd7tvMrVaBKgtLeCE+sQOd2cMyDj8cT3
         +ojOvpAAasHS3fAv16mIbn3X76xnTNMaXibIMi4j7n+fP7fjGypjkYr/Vv5TaTI6TjFT
         wlXw==
X-Gm-Message-State: APjAAAXYsOrNzzTw6XY+zDvQV0oHy1BXF06c79sYQnLoeTYrX5v2migu
        VfWWgMBD8oLCGgtJgNzJllOoRLzWfdU=
X-Google-Smtp-Source: APXvYqzfPHn/nlUaRwRymZ1jTsB/MZkqqdn/MWQEGI8R03+EwmbJVFziVMYSU08GUckEGPN4vpUi3A==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr35380745ljr.8.1555437701054;
        Tue, 16 Apr 2019 11:01:41 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i66sm10377006lji.43.2019.04.16.11.01.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:01:40 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id k8so19954620lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:01:32 -0700 (PDT)
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr44357745lji.127.1555437692315;
 Tue, 16 Apr 2019 11:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
In-Reply-To: <20190416174900.GT2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Apr 2019 11:01:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
Message-ID: <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in ->destroy_inode()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  83 files changed, 241 insertions(+), 516 deletions(-)

I think this single line is pretty convincing on its own. Ignoring
docs and fs/inode.c, we have

 80 files changed, 190 insertions(+), 494 deletions(-)

IOW, just over 300 lines of boiler plate code removed.

The additions are

 - Ten more lines of actual code in fs/inode.c (and that's not
actually added complexity, it looks simpler if anything - most of it
is the new "i_callback()" helper function)

 - 19 lines of doc updates.

So it absolutely looks fine to me.

I only skimmed through the actual filesystem (and one networking)
patches, but they looked like trivial conversions to a better
interface.

                    Linus
