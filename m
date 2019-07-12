Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9501C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE720989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 21:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1NJ3vGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfGLVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 17:45:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36238 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfGLVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 17:45:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so11342210wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ATNfSpw40QJzhhmM/AqxBd603LftgZCAUUTDncPbSUo=;
        b=A1NJ3vGrQAvQDYKJQw1mGDT57CH7hwMPVXKblswoAFvlMSz+oZUQX9WF8xFVO7dMTJ
         FL5GJ4wpjBWJu+Vd/BnX+zadjd3/p3F2Pl0F7ftrL0MIfGgP9MtENJ2DruIm3XeUv8DK
         NiaTCs1QSE1+LTnc6hpQT/xXxKRnwji+klChyKJ7ez7KUxrz54Pynux2wotdEfBd/5SG
         CohaJamz40XsZlBDuKTifmOGWOcC7bOElzM9W/0jSrSmNSOgfmTfyqqlSd4L/anBvLoA
         t0rdGZfa6ctlbIJC9fLasymb5wrcZ/daQWTJOGF7hYLD2oun/ZAIHbo+MKyBvkiPyTZs
         pMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATNfSpw40QJzhhmM/AqxBd603LftgZCAUUTDncPbSUo=;
        b=BVsM9uEZrjwONw6+M0p438Anw1aWdy7GU+FtSY0cVEq1ieTUF8QmWhtqYyhPVce7ni
         sElUOKS2m0uDco+gQMQGd1S5oVPqhDwvHQZLRK54rf27aD0Lh9hfiyLJo5S+vJc70OLX
         JfIRshjuNhYXP5wEnqMX7KGUqyLUBLO6E5tsr0mWiPK87yeBwaefK9PlyJZSwYls/bZE
         c2Zd2cStcqMll/X5TMaG7cnnRnHgQ1CBP+AXsWLp5KuVVCaeEelLPE9U3zIxaNfBLIAC
         do+QzVaOBc6IMt7t7n0cgBk67QdTXIYjY0kKrDRsGiylnSPFxuiDTcBFAh+swYLp/wN9
         3jjw==
X-Gm-Message-State: APjAAAVR9KDNoHwYzvIo9EfqcEYRYTAW3acvoQXvhk0GEYMq1EXQ7wLE
        lN+e+d8iCExy4FGgRssboxI6QLatikRVfw==
X-Google-Smtp-Source: APXvYqxoVeJA4InoqJk9xacyO4bBnEhopJIOvYl+1KsriZ44DwVyfbfApOlrO8h0ep6oloJNy0Y7KQ==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr1245773wrm.55.1562967925560;
        Fri, 12 Jul 2019 14:45:25 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id z19sm6509333wmi.7.2019.07.12.14.45.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 14:45:25 -0700 (PDT)
Date:   Fri, 12 Jul 2019 14:45:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712214523.GA74798@archlinux-threadripper>
References: <20190712073623.GA16253@kroah.com>
 <20190712074023.GD16253@kroah.com>
 <20190712210922.GA102096@archlinux-threadripper>
 <CAHk-=wh0XHkcLYh+pMPJrf8WmD6zOgXfq7HuLi7gmzb8aPEOvQ@mail.gmail.com>
 <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimmESHGRKNnZV0TfNStqNrruxzXaT_S=8g6K4G84p54w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:43:28PM -0700, Linus Torvalds wrote:
> On Fri, Jul 12, 2019 at 2:37 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > My bad. Will apply the fix properly.
> 
> Ok, _now_ your fix is finally in my tree. D'oh.
> 
>               Linus

Great, thank you for the quick response! :)

Nathan
