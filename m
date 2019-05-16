Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DBBC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C3E20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558032202;
	bh=rdmSNUy/n5TWTgBsZs5YjiSbaOAojzGIidFrDTyi6dM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B48tJ8EhjSgOYtnLU4TxCVu5PczouRZaWMek3yz9GwGk1rOmvjKL6FBTWpJQDFv5E
	 acvIB6q/jtPFKAxpMcfHSqluwcjYFY5Fb32QRY5jw7ThhiME05kCi+9TidvklkZhgi
	 VUw+YDL9H0nJJh4oJtV/N4eTAN9aJxj7kMc/MFF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfEPSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:43:21 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33734 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfEPSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:43:17 -0400
Received: by mail-lj1-f180.google.com with SMTP id w1so4084689ljw.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cZ1i1PlSN05rjwgmeSPBOyRXDYpMKnhLwTSuPaFE/U=;
        b=EfMguayduqZ24ff/F2BHhhOzDjdyonEf/8VAfENfIiKBoB1yeFBf4g99m6HV/ITW75
         ljiBLFVvQ2AmeClpItH1kbP5DUhFgHjF3hBfb0bAa+H9/32UpRA/gA93SgH3F+wg+0iD
         Q4TO8Dsk7hrNYV0eWnI/r80xmPZC2tINDBImE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cZ1i1PlSN05rjwgmeSPBOyRXDYpMKnhLwTSuPaFE/U=;
        b=Ipl1GMcQejQG1fsD96xR5r/gyX7W+S/avTCluc9vsT5A0mo/Wyh0w0Uzt1c8Wby+HM
         bRA9qOL5NyEsHG3YvMgyeXMkVw6jaCwhWIn0xjce8h221Ssl6cNjdHtkPgHRDyDFuL3a
         F+cobg0mSg+zhyTTXKbT4AAEBu8XKpkGGaF5yBARwW/04wtaQTkyxOSVsN1LY/7D+KOE
         HDpREcvGQxG9Qo9ac79bLx18u+7S8BTGycphKAyIJobGNQT4utqxHvqBpsXFbYayM5Pz
         qzVy74oaeMYIYN2tKRUeLRw7SiarnrE0ikx2qlJbVkkD351NQ73wXY/Du+z/+c+NAG94
         Q6AQ==
X-Gm-Message-State: APjAAAUKorwP4lOV6Vn++EMCqaAb4T6EUlVOI5ioP2GVYfIIHTX7bBH3
        kf+uhvcsEISWGoJRNWKsGlD7Naqx5mA=
X-Google-Smtp-Source: APXvYqzNs9NfA66QniJh4DcChpaqTaHtBbOXXYh5pk9XKH5y/2jNv6xL8yOPXHd2BKKiJBV9CoISkg==
X-Received: by 2002:a2e:824b:: with SMTP id j11mr24408315ljh.197.1558032195176;
        Thu, 16 May 2019 11:43:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n18sm1181679lji.63.2019.05.16.11.43.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:43:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id l26so3391496lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:43:14 -0700 (PDT)
X-Received: by 2002:a19:5015:: with SMTP id e21mr25981649lfb.62.1558032194090;
 Thu, 16 May 2019 11:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190516160135.GA45760@gmail.com> <CAHk-=wgtHi5mT7y=0ij-AksQQOBQJqV1apk2bRaH2tfRTxyFcg@mail.gmail.com>
 <20190516183945.GA6659@kroah.com>
In-Reply-To: <20190516183945.GA6659@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 11:42:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNFabppzpSQQgt7ajrYqmFjtkn2D3n=RvSEDryCLO+=g@mail.gmail.com>
Message-ID: <CAHk-=wgNFabppzpSQQgt7ajrYqmFjtkn2D3n=RvSEDryCLO+=g@mail.gmail.com>
Subject: Re: [GIT PULL] locking fix
To:     Greg KH <greg@kroah.com>
Cc:     Ingo Molnar <mingo@kernel.org>, stable <stable@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:39 AM Greg KH <greg@kroah.com> wrote:
>
> Thanks, I'll work on that later tonight...

Note that it probably is almost entirely impossible to trigger the
problem in practice, so it's not like this is a particularly important
stable back-port.

I just happened to look at it and go "hmm, it's not _marked_ for stable".

                  Linus
