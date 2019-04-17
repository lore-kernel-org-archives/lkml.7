Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B32CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537DC2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMgW8PzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfDQHlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:41:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46383 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfDQHlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:41:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so9162010lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsZQ54Mb58ojmhd4luSv5Cy/zFTCqmtd7c8rf02fwtI=;
        b=fMgW8PzH9WCt/OmE/UBhZ+VVupVzHD99xmsYUq73sxK68TNLBa7xsVQrDq6jqVUl+W
         pGyZy0cP7/bqLnGOqXvipQ0gK5MzD6wC2btKnabHBTaAibd6fO5C/HLvxpMDkeNWBO4/
         6vnbloCy/Fbm4TNmYVDmWPcXd2FuVSJ87ztWqJen1j01Bl1j+WJ9CnfIkNU+Wt5c+LWu
         BzDEREygS9BrT0UDbL2zzlpu2BLrS0VCpyozocAHVR7uv0vqt37rw0sDA5cunIvWvvn4
         OJM0mtQIeLEJSBQrHuuklBa1mvB6RreAGA+qRH5AeYpdDUI8dpJx/K1uQZsK6QBaVRmo
         KGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsZQ54Mb58ojmhd4luSv5Cy/zFTCqmtd7c8rf02fwtI=;
        b=AIuIyHmJBLvNe0vMucTrDlEkeSgHuAO4gjwHipaA9V4YH4pm3vFE4Uyr4G8NIwRTDv
         F2IcxFcwqanmhW7IscWVkuwVMrGtHMCeY0Nr1R1ddS/OEkG3RFDJSVZo4Ab4aAZL7hjZ
         6AwkIw5vC9rooyFs5IJrfXD40wMCmDRXb32f1KQD/yKnwmdLuAcuwDhbRVqiLSz+scqg
         3G3U/zvbW8eLKO7qlRp2uy4sko850nvsLo/Ncsmj3bqN3S18ROuXcK/wt/ReP/N33dKt
         1bANoUra+F76jBtMAtuCzPX0ejrXOOIQF6TMK+Tes1EXjF4HAoOajk6bOVBaZS4cNlZq
         t8Zg==
X-Gm-Message-State: APjAAAUYRQrxdOokeDb6F8IsbUk89s6CpHv/Km3wL7HIpdvPsp2dbmHT
        uhbYnUkYRdIPlIlSNofGETpnJWuojatitad1AIc=
X-Google-Smtp-Source: APXvYqw5ECPwxD37+hTt5ipw7RkA1Q3i7SdFpRyl3rgucmQGPVxJgB4cvMcM9QT7bHIs0228e2yjmAmb0L5MHMZt5pg=
X-Received: by 2002:a19:f001:: with SMTP id p1mr4731539lfc.27.1555486902459;
 Wed, 17 Apr 2019 00:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com> <20190416161840.c54f8fce7557e24fe0922338@linux-foundation.org>
In-Reply-To: <20190416161840.c54f8fce7557e24fe0922338@linux-foundation.org>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Wed, 17 Apr 2019 09:41:31 +0200
Message-ID: <CAMJBoFOz41qyxwnQaJbDuv3n0Nzbzmwdx=Kyv=1wV51jr0ivKg@mail.gmail.com>
Subject: Re: [PATCH 0/4] z3fold: support page migration
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Oleksiy.Avramchenko@sony.com, Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den ons 17 apr. 2019 kl 01:18 skrev Andrew Morton <akpm@linux-foundation.org>:
>
> On Thu, 11 Apr 2019 17:32:12 +0200 Vitaly Wool <vitalywool@gmail.com> wrote:
>
> > This patchset implements page migration support and slightly better
> > buddy search. To implement page migration support, z3fold has to move
> > away from the current scheme of handle encoding. i. e. stop encoding
> > page address in handles. Instead, a small per-page structure is created
> > which will contain actual addresses for z3fold objects, while pointers
> > to fields of that structure will be used as handles.
>
> Can you please help find a reviewer for this work?
>
> For some reason I'm seeing a massive number of rejects when trying to
> apply these.  It looks like your mail client performed some sort of
> selective space-stuffing.  I suggest you email a patch to yourself,
> check that the result applies properly.


Sorry about that. You can never be sure when you work with
Thunderbird. I checked the tabs were not converted to spaces but
Thunderbird managed to add extra space in the beginning of each
unchanged line of the patch.

I'll just to a v2 patchset today.
