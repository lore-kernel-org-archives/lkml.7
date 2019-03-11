Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C458C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E88206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLykHwrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCKSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:47:53 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:42042 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:47:53 -0400
Received: by mail-qt1-f181.google.com with SMTP id u7so6285583qtg.9;
        Mon, 11 Mar 2019 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHvm8fC0zr2NnYb7Uwd8oO4goIQ3d7xhi+qOYTqdW5A=;
        b=CLykHwrl25DfH2AMrkVYD2QoEx/X4upU+Z0jOJDUQfGWjPOKQZ5ZhWJYJyzBD4OtF5
         sNQ4lNhKlu2cz12v84dJb+jf5sH01IYp4RfdYTLxxLutRI8uxFfAFgFhMrHFNLTiau0z
         KslllNb2XMAKPhrdDBE6E8tnminJAzzfgQEZ3b849nWUNL8ZiNZKVopUDhBhlkp9kLzl
         l+8Py16Vfn7+ycJfr9+JKoxnC1dVcyPsFK7bg1cd4qMNaIoAA8oTqbAC2bxHdJtsE/oU
         LTPZaqS/8TmFO1ef6Rz97QAMuf1zf94j1f6BTNBbYG6ohiBpGARugbqa1WOkG4jgvGZU
         9WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHvm8fC0zr2NnYb7Uwd8oO4goIQ3d7xhi+qOYTqdW5A=;
        b=pu2diUezmR4SogFBCHvrYuInyrH3k79pHr+Iv6AMRdtk66ZfqtejkNXwSrdOWhkBsf
         ow7MVtHKgZJrppbnncNyAoFnlDY5JAAy2s3Svq/r8PcIrYPZg/h52vDh8ObFPphfp3eK
         z0fSLGnCgIyOhay5665l/J8ZnDD4kTwa8HFoLZi0yGAoVrNpgb8GHrtP4aDvPRFL1I4T
         bIYsG9lVRYTpsW5IKZlfW3bKTy1gtXcfzKP+6aW26q2jloR06MlLYP+pKw7Q7NXhl2m0
         Lexs5/m8xmY5Nd8nviTzdg4lWeYE52bujkkKzqvoN2U7tBg/ff3uYYp5DqCUeV5r8t6f
         WtTQ==
X-Gm-Message-State: APjAAAVyx3wLquSl+ZXz+pX+aGVGYMPWXaIKhsI3OFtYYn62PuOr8XDH
        wQGYXdZ12Cj9LFUKJe2joM3duE4Vr0l+azYFWlomWw==
X-Google-Smtp-Source: APXvYqxlfYP1/elaoi31pz6noK3NOmuyEdkvaXWfSDleeLQjjJd+34Rxw1YOCMvJoyJRw15BIZiMBnc8P78RCPKNXMc=
X-Received: by 2002:ac8:2999:: with SMTP id 25mr26761568qts.383.1552330071961;
 Mon, 11 Mar 2019 11:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <1551940186.8289.60.camel@HansenPartnership.com>
In-Reply-To: <1551940186.8289.60.camel@HansenPartnership.com>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Mon, 11 Mar 2019 11:47:41 -0700
Message-ID: <CA+8MBb+MJhS9ejWQ0+vjDyhdnK5bsuaLPwpM5f-h1-6tHr4rVg@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.0+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:30 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Hannes Reinecke (4):
>       scsi: kill command serial number

ia64 build error with arch/ia64/configs/sim_defconfig

arch/ia64/hp/sim/simscsi.c: In function 'simscsi_interrupt':
arch/ia64/hp/sim/simscsi.c:108:51: error: 'struct scsi_cmnd' has no
member named 'serial_number'

-Tony
