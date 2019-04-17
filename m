Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1156CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C720320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+0G96T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfDQChx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:37:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33262 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQChx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:37:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so11283776pgh.0;
        Tue, 16 Apr 2019 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAPp3R+MOdBi8t9sT4n1kbVy5KytQqCPQSxyvk75rjI=;
        b=C+0G96T+IqgB2W9tL++NxwgRA0AXtqA1S4o8nNlw5/yJDU5wQLvJ5K6rn5DUfqI+iQ
         /6as3D0/b142eBGmUuhx1axXfMqZz1iPSkelo1oJv/be3LAS4qrjYjzarkPun/zcHFAx
         +6LecIJqMuAcmgnQkYZsFrHtQKM4Ifla0v0Codpf5I061IiMjQrsNeE3a/x6iFOvaKUR
         UjJMNKQei9WLVw58ORPRb7LzAr9TT65jjc6J9Wt0kHm1KNwjPIaIqCBuJfCjiWSdyhOs
         uifIa2knvYVb1tKwVa33sVpInfPwij3gZcMb1vX2xqpyBq0Cywy2mAiHqIuyseiBVy+l
         J5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAPp3R+MOdBi8t9sT4n1kbVy5KytQqCPQSxyvk75rjI=;
        b=DMZvUZxnOWyfJRmuTOjV1A7KUGt9tYDXHvABwFN+gzdPj/P+ZDuz1Jpx/857gaYkRH
         Te1UY95UISmm7YhQPBX/4VIjr99gxNc7pjR9MyS/wDYKa/AEB3g+X3RmagRI8ovBAImT
         KOcIXdWWGfOOZYMUrv50VXpRBxv64IvvvnpAqrbxi7U5A27jwyUmPUf/qcL7gdo2q8Ze
         6iidS1K9YmVHZJZLLuzKxJQIJ1XFyLcO9LI3I5X2vYRT8DswcSXgQqxUIf3lmtDlE7vo
         jDNjyEpMfU1Kpx74/1S9V7OFl83WwkwUv8mpyQ8RPvklGOExkM4cwmzqXgGVgtSVVBRD
         7vRg==
X-Gm-Message-State: APjAAAUJNPGMAvpg8E/mkO+msLMtuMa/pt52wGiTgAFZFvtAVxBQkBaz
        XQdQordgSFKw3igaHad0TRMN3WX+f5392qITOioix/sq
X-Google-Smtp-Source: APXvYqxsjmd02TNAY80aiwGs5tRn46q4MkQrqn6TmMzVycuLmCLflZhlZtDrPeNml7JCgATeXya+G7zOgkr2eXvW7fI=
X-Received: by 2002:a62:e213:: with SMTP id a19mr87912521pfi.85.1555468672615;
 Tue, 16 Apr 2019 19:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic> <20190416221852.GA10781@agluck-desk>
 <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
 <20190416232833.GA17372@agluck-desk> <CAM_iQpXBJ2eAz4TW_GmOWRLrkyJcO=u-8VSnmv91ZABG-21Agg@mail.gmail.com>
 <20190417015351.GA28490@agluck-desk> <CAM_iQpWXYTivg6tmGxB0xVSrcz8_Envb+yRh_6tBuX-DYKuL1Q@mail.gmail.com>
In-Reply-To: <CAM_iQpWXYTivg6tmGxB0xVSrcz8_Envb+yRh_6tBuX-DYKuL1Q@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 19:37:41 -0700
Message-ID: <CAM_iQpVom+7oHCUh1=oWrR9NiHfDSGOWoOFV4tkdT6nnZKicmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 7:31 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> Yes it is, I have a stacktrace in production which clearly shows
> del_elem.isra.1+0x34/0x40, unlike the one I triggered via fake
> PFN's. I can show you if you want, it is on 4.14, so very unlikely
> it is interesting to anyone here.

Correct myself:

The one triggered via fake PFN's also shows
del_elem.constprop.1+0x39/0x40.

Sorry for the mistake, I kinda read into another crash...
