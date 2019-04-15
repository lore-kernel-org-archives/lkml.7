Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569DC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F39420848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtyQa9N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDOLIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:08:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45624 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:08:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id o26so14260188edv.12;
        Mon, 15 Apr 2019 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=iwamuJBb/aWKsektGv0E0dzF5zrlTS3SZaEszHzpS3Y=;
        b=AtyQa9N7OZZHpQK1HwsD8nnsSgel5bHFwYxHkDNHHCuORfs4M3+XzEO+XLk9+W1OTO
         1lI+cZyueLJ0p7L66OV+e5ikHDlhjFPR+U7/kbKq8uIZ3FPibCCrthM5T+WpFTK13hoS
         aego1RwUVVHqcGnrDXIJh3lMymZj2d9OA5XHdeENZrJjAA9ZltU+Fj0sFHQHP/4xf1nL
         HM+VzxFKx2K45mYYCxu4xWJyJNkZ0lLNnmzaYQzGXkBXZlMxtW3/pi2JkSkM7myANgua
         ppfCXOcs5DA/gwoCPVJUF7m9P22qiihaG7eRz/qn6lR3X22ICOpzmfDR24+Ok2im1MWo
         A/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=iwamuJBb/aWKsektGv0E0dzF5zrlTS3SZaEszHzpS3Y=;
        b=inV6Yd/cSuH0Elrhb5CFqxanHscwX9DNHFh1vv86JhRb6cBwkPJf30g7lyMs9KsMUl
         hugZIlgmuUNB4iLG1MW1UT+YxZJD3nNJHyhCWFSeJnYKWDwCUeX2Vi+rFIYQE/FuvK6D
         xAsSMaldmYQFMSlphTegEas7NJoDeVdAUth1vPkf66jo7J4K4f6x4zDr25MYqak5VXZJ
         64N4zo9JHaGxM3O/eQiBYHgU9fLfiSeM3/NfMJxCHS40w69pjCtT8Op0k3K4mILdPf10
         LllqfvxaoH8eyyNiCAthSu2DGkx480E6qCTCRoqbqoOwedMdl8XgifqPoeUThV7b82W+
         IeNg==
X-Gm-Message-State: APjAAAUMPlsWBDQKEZ9vrQ2N4FEgsE/x2Rq1Ck1U5h3WRuxLW70MWAfi
        keSq3lHAMuwBdZPPYFmtlpbtjf5S6awVQNnbp7s=
X-Google-Smtp-Source: APXvYqxfXNEJiCL3IUkTeVWRaKUr8gka+gxTOoqblELUfigE3Q/Xrmr6Mt7v72JXsqiuUCBkg2CQoocanAm0PPsZzFg=
X-Received: by 2002:a50:c905:: with SMTP id o5mr5334132edh.252.1555326509809;
 Mon, 15 Apr 2019 04:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <CABCHxwFMp+vFpv8V-c0=CeXnNmymEuvm_7adGnOnUfCUH7C5+w@mail.gmail.com>
 <8970d433-8c7e-23d8-7d04-b9344adbf3ad@cs.ucla.edu>
In-Reply-To: <8970d433-8c7e-23d8-7d04-b9344adbf3ad@cs.ucla.edu>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 15 Apr 2019 13:08:17 +0200
Message-ID: <CAKgNAkjAp89DfGynMs3v=29egqwouaZhUt993wpeu=t+257oCQ@mail.gmail.com>
Subject: Re: bug#35275: spelling mistake manual pages
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Vikas Talan <vikas.chaudhary2608@gmail.com>,
        35275-done@debbugs.gnu.org, majordomo@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kernel-announce@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        libc-alpha-subscribe@sourceware.org,
        libc-help-subscribe@sourceware.org, manpages@packages.debian.org,
        listar@nl.linux.org, linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

But also, the report is simply wrong.


On Mon, 15 Apr 2019 at 07:34, Paul Eggert <eggert@cs.ucla.edu> wrote:
>
> That report appears to be about the glibc manual. Please report glibc bugs as
> described here:
>
> https://sourceware.org/glibc/wiki/FilingBugs
>
> Also, please use plain text rather than images to describe bugs in a text file.



--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
