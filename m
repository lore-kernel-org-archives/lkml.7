Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC25620661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2I2NOfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgAIRjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:39:04 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33060 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgAIRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:39:04 -0500
Received: by mail-pf1-f173.google.com with SMTP id z16so3705081pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSJaP50tcbssCy+wUHSI0wzNq4LNnMEZ5ONXZaI5D4I=;
        b=O2I2NOfW3ZzTMKDu+2e+6Yl41lYKxciM2sBKL8NB28ZcdKYRMF6ymbVNs84yIDIWI2
         8pF8jZwIROiLfJM0TrXw7t56QW3lMPuxU7nNitfw4id6JaIrfZFGl8mQc2SBTsBP967P
         MZpUHXhgxc7/MdB6FPrGD/E9D//fy4bShGxkm4KdvxQeQYhpofhIN2jSkGOCjUaw0C2j
         ouHl49YyDXs6V6TOBAyGM4yXVL4LhGNQU9ts0oEyH0/EY9OtaHo4liqb+PSot2M0gsIn
         Z7pVMANRRardfAPxnlc3XiTMFx11ymdzKZrR+ZTtDB8iiRApU8dXfNLMQAHQx+US/wlt
         Stug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSJaP50tcbssCy+wUHSI0wzNq4LNnMEZ5ONXZaI5D4I=;
        b=afRbwlGkWJN2irFsFg2eSwy9+220RNlehleEYzsPFvMi1Glm76QW7TwIOCRO5E9KJR
         tLc11B4cqE5dCfXeNn6MHk0QdbQV0QwX8eB40aPAV6gnaUQAAB9w201dNzVW1pgphD3R
         puIn9TEYIS2WtoB9txhXJokMhT5FqToLOKwNBRIrsNAtS5T3KGUoCSLgFU4uUflYaBgX
         DaYHTtOF+RhZsLXlY9fVhmHYJPnbh4jZuDM4SeW4e9tFx1ygEt5umOdejr3pQIXL5Nj/
         DXcFzErqoHVORJcFN1IirZ/2HJ/zd5zWixpr5IHBd00ZUGSzdcwn/pULWk3Vs/zdK1rF
         hw9Q==
X-Gm-Message-State: APjAAAVH6OKKdm0mkrcJKJUT4EkJj3GbRg+AvAzIhIzpccmCG0+PID1i
        Yz4i8r+RSaogVuFtG6X7PcQSvsEzq0dfpIHiluIYMg==
X-Google-Smtp-Source: APXvYqxMLgu1YynAtEP2Gz+LeswqtA5jhI/1rpWxGJvi2RKbW+mrDjEhcutfFfMn3bKHlcTjz4OK7Q6tfKe+Ru96n9k=
X-Received: by 2002:a62:e215:: with SMTP id a21mr12577184pfi.3.1578591543402;
 Thu, 09 Jan 2020 09:39:03 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
 <CACT4Y+Z3GCncV3G1=36NmDRX_XOZsdoRJ3UshZoornbSRSN28w@mail.gmail.com>
 <CACT4Y+ZyVi=ow+VXA9PaWEVE8qKj8_AKzeFsNdsmiSR9iL3FOw@mail.gmail.com>
 <CACT4Y+axj5M4p=mZkFb1MyBw0MK1c6nWb-fKQcYSnYB8n1Cb8Q@mail.gmail.com>
 <CAG_fn=XddhnhqwFfzavcNJSYVprapH560okDL+mYmJ4OWGxWLA@mail.gmail.com>
 <CAKwvOdmYM+sfn3pNOxZm51K40MjyniEmBvwQJVxshq=FMaW_=Q@mail.gmail.com> <CACT4Y+apeR4GJdS3SwNZLAuGeojj0jKvc-s5jA=VBECnRFmunQ@mail.gmail.com>
In-Reply-To: <CACT4Y+apeR4GJdS3SwNZLAuGeojj0jKvc-s5jA=VBECnRFmunQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Jan 2020 09:38:52 -0800
Message-ID: <CAKwvOdkh8CV0pgqqHXknv8+gE2ovoKEV_m+qiEmWutmLnra3=g@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Axtens <dja@axtens.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 9:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Jan 9, 2020 at 6:17 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > I disabled loop unrolling and loop unswitching in LLVM when the loop
> > contained asm goto in:
> > https://github.com/llvm/llvm-project/commit/c4f245b40aad7e8627b37a8bf1bdcdbcd541e665
> > I have a fix for loop unrolling in:
> > https://reviews.llvm.org/D64101
> > that I should dust off. I haven't looked into loop unswitching yet.
>
> c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is in the range between the
> broken compiler and the newer compiler that seems to work, so I would
> assume that that commit fixes this.
> We will get the final stamp from syzbot hopefully by tomorrow.

How often do you refresh the build of Clang in syzbot? Is it manual? I
understand the tradeoffs of living on the tip of the spear, but
c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is 6 months old.  So upstream
LLVM could be regressing more often, and you wouldn't notice for 1/2 a
year or more. :-/

-- 
Thanks,
~Nick Desaulniers
