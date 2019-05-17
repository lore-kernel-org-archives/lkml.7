Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45365C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DA92087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558128035;
	bh=CxmHyKbaJ0SAGbp3+NGZ1i5ZIwp5SxEuGhAJO7MyA1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=byeZhzeGhYlJ95Qj6PBeZQ3rjMKgK68JeGelxaGQphRXRHVcpK3dOauDBpo2nVsJZ
	 ze+U7VcDBGnE9OzmBC7mTDFK+259UT/0MTjjjTguBN95vbVCWPoP/kSMUvTHhkyq6V
	 SoxBCzVdbwgwCKokyfiaVY7gQNUnffdohkv8S3sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfEQVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:20:34 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36485 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfEQVUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:20:33 -0400
Received: by mail-lf1-f45.google.com with SMTP id y10so6316869lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeG6rEmkcjh6hsbhIni+X0M4ao2fCvuLYPl9D/OPgmE=;
        b=d3YwA7IHFLGisd9uu9yYMbG89YFREzsaXn8L9GK8jHU/c0VcceV3lgAYucSxVuRIBm
         FvtO/1clDFuC1lO3mu7dZDcyBVuugXShHFSzscIXYDoL/J7+LoN0Xx2GBrO84CyTj93W
         lmp1jxHZmFhWSipBZ0y+mPuv+wl4eU/a6XI18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeG6rEmkcjh6hsbhIni+X0M4ao2fCvuLYPl9D/OPgmE=;
        b=kvtYJmHRk3uHWzyKzYwkFntOavQk6pyKQaCWYNwdI7NJGHO1V0sqJ4pSwxKu1Ni63h
         FAt/Reuwz273f6f9L/7Lmm0C50owUpykEo8bzpMLqJ4MsmrN2HUcX4wO6t8RNavQk9mT
         obgUAAAzlhWxoPXdGNQjl/9ddYQOfFmvDuvNC4xaywotEZM+WVPTuW+lC/8g1hs5fuT3
         DEYKryxrgPuLZIFb/85wElZbMHy2oFFfF+/BkXxLFTrR4NH4iUBRR6Yiyi2W+4cwd26F
         UjfY7g8c6KFGpBQ7pmKqy1XLXy+f7xKnhtdX2SJiI4efwrXlBwZOGwLzI3/6pPc/ezzA
         8GDg==
X-Gm-Message-State: APjAAAW60nsMmelWoWGaa5vn0rM6I/D5oQ6GLzLHGlFUqhtZH2vHCJk+
        TofRJmXyRWvpKHnSoKpBpNO+a2haEw0=
X-Google-Smtp-Source: APXvYqyjHn8W6H6Kq6kjF4NOBfRZQxhCwv8HnAtw64STH1byVNBpXyQw3Y7qty8GAyVTV+lFNIZE2w==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr20243361lfh.66.1558128031406;
        Fri, 17 May 2019 14:20:31 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 8sm1903985lft.97.2019.05.17.14.20.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:20:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y10so6316818lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:20:30 -0700 (PDT)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr21391396lfc.54.1558128029916;
 Fri, 17 May 2019 14:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <1558104285.3050.8.camel@HansenPartnership.com>
In-Reply-To: <1558104285.3050.8.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 May 2019 14:20:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
Message-ID: <CAHk-=wiAdmRv-Piq6LKvgLDgQC+AV-RYK2O-RC09SRRGq3v1cw@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.1+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 7:44 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is the final round of mostly small fixes in our initial
> submit.  The fix for the read only regressions is the most extensive
> change and also intrudes outside of SCSI because the partition and read
> only handling is mostly in block.

No. That code is insane. It looks very fishy indeed to me, and I'm not
pulling it this late in the game.

If the partition table gets re-read, the old read-only state should go
away - for all ew know, the partition numbers may have changed, for
chrissake! So you can't just say "oh, partition number 1 used to be
read-only, so now we need to keep it read-only". That partition might
be something completely different after the parition table has been
invalidated.

So the new model that code uses looks completely bogus to me, and is
not anything we've ever done before.

Just revert the oneliner SCSI change that caused the regression.

             Linus
