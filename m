Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7DFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280B02053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249343;
	bh=J+tzrorskhEWR6DbA2fLSLNOi6J3SwyUd9oxVyOCX9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TLdhuNPKA/pNTB+vPJnfXJDGqOC+2KcR8RE0fd4I5Jekp+qzRRvXorDlWvrT5BSX0
	 ZghOJ4OnaelgUlUURvM4y7a5xZYGOaP/8W7HX361+02DdTyCo31MRgZeymlY2Pbvx6
	 M6LZ9Xcz5f+GlNnbgmqhsjom8YTtq4goW4Xm0XsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfEGRPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:15:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34329 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:15:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so10222168lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAvQTClftltYLCbDqLCq0/xQYu65sVI0pkYjzVTBcB0=;
        b=NsaoLR6Ao9J19zGZUHECQ1qcF7jO6hioHJJfXFH7MjyM/ZZTDUiryrhvQk2YIHQ681
         EBOTavV5RShPc+LyF7LHGtUfsXEm9A5iJNtu5FInwxpehCTg0ugf5fdz41X0mZTg1qa6
         tJJWZ6eAmCN37uHbershG6h8l0gVd8ZV+wf1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAvQTClftltYLCbDqLCq0/xQYu65sVI0pkYjzVTBcB0=;
        b=VN6JJy+6XZYAbpgk3Zxa3QK16fElgh/4V6As5HrhmFVXtfsVMA1iZJMXehR6zvgfnk
         PrHS41yXP8kxtb43cK5mmiojRTk3e27eKOMFYHD9LmiO2OL+Gi7ooXeUjD+77fhRgH5A
         Mkv/Ox5kpQHxk3obfLJGdsk+C2OZJhmlUKCA9A1lZUM/iuLXUm/LjJQeduhfRNlErWJp
         hLvA5wbXyc5bRYtJ8WoNMrESaoIKNw3nYdW46yxv568td4dVZnoSTRa/mLGQwngwr/eq
         Sg0YXfJFs1TcDk7gcbdCy5RyVX2feYATU0/Ze8ZRXqagBPvwSlg/1IPwj6wuiaMc6EKi
         RVeg==
X-Gm-Message-State: APjAAAWYomzevVjdyBOeQADJEymag9MqjyE+vme780uN9qY2Upvhg1xz
        RdD+0UwEOus+3DqCxUoXOU1gTqM23XU=
X-Google-Smtp-Source: APXvYqzEAy/Gfn41M+3taeeF8wUpthK267x7mFokqCe0j8/93YW1B81SvhqOrx5EVK5X4rhywXKdlg==
X-Received: by 2002:ac2:4a8c:: with SMTP id l12mr1137549lfp.53.1557249339340;
        Tue, 07 May 2019 10:15:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s26sm3263131ljj.52.2019.05.07.10.15.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:15:36 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id d15so15032155ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:15:35 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr8769035ljg.2.1557249335169;
 Tue, 07 May 2019 10:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190507053826.31622-1-sashal@kernel.org> <20190507053826.31622-62-sashal@kernel.org>
 <CAKgT0Uc8ywg8zrqyM9G+Ws==+yOfxbk6FOMHstO8qsizt8mqXA@mail.gmail.com>
 <CAHk-=win03Q09XEpYmk51VTdoQJTitrr8ON9vgajrLxV8QHk2A@mail.gmail.com> <20190507170208.GF1747@sasha-vm>
In-Reply-To: <20190507170208.GF1747@sasha-vm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 10:15:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
Message-ID: <CAHk-=wi5M-CC3CUhmQZOvQE2xJgfBgrgyAxp+tE=1n3DaNocSg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 62/95] mm, memory_hotplug: initialize struct
 pages for the full memory section
To:     Sasha Levin <sashal@kernel.org>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 10:02 AM Sasha Levin <sashal@kernel.org> wrote:
>
> I got it wrong then. I'll fix it up and get efad4e475c31 in instead.

Careful. That one had a bug too, and we have 891cb2a72d82 ("mm,
memory_hotplug: fix off-by-one in is_pageblock_removable").

All of these were *horribly* and subtly buggy, and might be
intertwined with other issues. And only trigger on a few specific
machines where the memory map layout is just right to trigger some
special case or other, and you have just the right config.

It might be best to verify with Michal Hocko. Michal?

              Linus
