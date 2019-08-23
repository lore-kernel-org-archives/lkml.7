Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7156FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6FB22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsZhZA5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392082AbfHWF2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 01:28:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392067AbfHWF2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 01:28:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so7402376wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jZOuGomjvqGYTjnoHRQnEezUC30S/yYktb2hSFP7WE=;
        b=ZsZhZA5toWhhCMR8ORZnkeX18nS/RQ2ih4MGR5PbRXW4fGxvgYg41L5YkbhqfuMXAg
         mkAKeh3DAtZHZr2Hy8m1ZZEyMd0RYkpIVNOinUsUm9LSyeaZL5xjE5mDmFb6hBOgPoP4
         x3XX/VTD9ZCimPxO3iHOWmMSWKM9ozmfQpa5ODTu03PSPfBQAxVrqHRR4i7tCTvrEuvD
         8S4CM2B8GSezAVMEVwuJrKF8O2JJxynlNW2q3whLIqL8iKIymONrlRfa354T15nmpb9t
         YQQLUdqtjyw97shJg5StkamMN1OCVetEtqsQEjw5m9+DxyojtsUay/oeJ2Pz6F1jVb2r
         84zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jZOuGomjvqGYTjnoHRQnEezUC30S/yYktb2hSFP7WE=;
        b=EaNhgp6+IoX2Vg1t6sojoi6pbuwORAKl7ucg+2X30DkOK9nayDi6bIwWbtXBDNZCtr
         xwc9+NZ/EbcBSTdKxMTyI9mwtmU30US/ey2fz+n4ZJIIx6dhu1swjAPZc9vkGdjBHJbn
         za/to6yJ82IzBoE4SwSUM5k4lp9oWd4EtntJkBcvEL5iPkNcFD+RGTsHkU7x0VK5h6br
         omIIrL0t1XXTSP6TBJLZFT0z/4q++VtzZYzSzWB3OxM2G5BVkyiOBWymvVyu4a69Vpl3
         gE41IeFXaMd7nkmXRUjhiSCRqYPsl3aYwsDVWyOM4N68Ge7HXeW3Fw5vydMPVFPy7D7U
         Ivyg==
X-Gm-Message-State: APjAAAXZeOk5c7QoDogESwCJpVCSHbHRt6/VNjCrqXIQsjKOKP6yO370
        u6ktUwd4eHLy9L7gS7nqKs0=
X-Google-Smtp-Source: APXvYqz0Z2vhDlK0hJlhKifI62Nz2sFkvKxwoKaEwtT65rtUxiNhzfI4E7Wt5QqqMivW9WMKUI00cg==
X-Received: by 2002:a5d:50cb:: with SMTP id f11mr2663367wrt.277.1566538127201;
        Thu, 22 Aug 2019 22:28:47 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id w5sm2377262wmm.43.2019.08.22.22.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 22:28:46 -0700 (PDT)
Date:   Thu, 22 Aug 2019 22:28:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miles Chen =?utf-8?B?KOmZs+awkeaouik=?= 
        <miles.chen@mediatek.com>, Tri Vo <trong@google.com>
Subject: Re: [PATCH v3] ARM: UNWINDER_FRAME_POINTER implementation for Clang
Message-ID: <20190823052844.GA70417@archlinux-threadripper>
References: <CAKwvOd=wKUhnWr4UhVvgn6NYh+=zQOpMmKG9d_zEqaKLa4_9FA@mail.gmail.com>
 <20190822183022.130790-1-nhuck@google.com>
 <CAKwvOdn6av8bX4xUtuuKeJQdiQU+_Ty2aM8wtjP9+teU0Gt6Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn6av8bX4xUtuuKeJQdiQU+_Ty2aM8wtjP9+teU0Gt6Yg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 01:02:05PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Thu, Aug 22, 2019 at 11:30 AM Nathan Huckleberry <nhuck@google.com> wrote:
> >
> > The stackframe setup when compiled with clang is different.
> > Since the stack unwinder expects the gcc stackframe setup it
> > fails to print backtraces. This patch adds support for the
> > clang stackframe setup.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Tri Vo <trong@google.com>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Great, thanks for following up on the suggestions from code review.
> Since this is going to go up via the arm tree, which has its own
> process, please add my:
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> to the commit message, then submit the patch to the maintainer's patch
> tracking system:
> https://www.armlinux.org.uk/developer/patches/info.php
> (create a login, sign in, then visit:
> https://www.armlinux.org.uk/developer/patches/add.php . I think the
> correct thing is to put the first line of the commit in the summary
> field, next/master as the kernel version (I applied/tested off of
> -next), then the rest of the commit message body in the Patch Notes
> field.  Make sure to attach the patch file.  Finally, it should appear
> at https://www.armlinux.org.uk/developer/patches/section.php?section=0
> I think within 24hrs).

Also for the record, I came across this a couple of months ago, Catalin
Marinas had a git config alias that could be used for sending one patch
to the patches email address so that you don't have to muck around the
web interface:

https://lore.kernel.org/lkml/20190624144924.GE29120@arrakis.emea.arm.com/

Web interface works fine but I prefer everything via the command line :)

Cheers,
Nathan
