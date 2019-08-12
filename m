Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F78120874
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZiO6DEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHLBho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 21:37:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32899 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLBhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:37:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id i7so2534210vsp.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 18:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LvnTipJZhZIUoRbWH0WQTQrByqAr4V2iqODb0EELto=;
        b=SZiO6DEOIuyIhDHVG+GnlEin+uNFqKBQipgtk36IXhXF1wSZzH4nnCKhrLWOSlpIRO
         q5pzayzwz5vRvu90mtASG4006WIp47vBQvOex/05Py76sArBAEfJbX+E9g/k7pEJttu7
         NbNu3WpFyjx9+q3+IUMCoU/wL+Qjl4VAcRsj9TSpD1+lghCVx+59zJkpF6mSMskDjRk9
         XOgSue0Fh84YKh7QuLx46d+rHY+y7byVzs5sdi6/Lg5yYhoPRX9p6r2rokgieZslHFvY
         57vbYtPb7tkEuXOS9YcJbostJENVMDO2mt/cBcJuiUuVDanqsAFr8mQ2C4kY2A0NE21x
         6/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LvnTipJZhZIUoRbWH0WQTQrByqAr4V2iqODb0EELto=;
        b=Gnfrvojf09FPbNGjF9DdNPggBIXlqTdA155ee34Ocxyv9M7zHnw3DlOPHWhkOK/ZHF
         9xJubkU6TaiTmvNtqPO9F/z/4RAJ6Pe2gEmp/+fwgvWGgjtkl/aIRmNhcFMA5yvKAIdE
         xxGk7vhmTEwAghh2uYCSlkgcfa2qGROWohQRLQil54o4zkZ6wEb6n3mA853knRelzpCp
         KBnY2Kt1ys8jPurMtNSsyNUiMNfIZCoxbmwK3gwKcWaoO1JYgXSTHM1H/AEDE47F++8X
         E2z4U3ATS+FkCqu2Q8V9QeM/KEPZUNDgrWeG/8Z/Dn9RLigAyeB25o/HDbmFX3m0SoNT
         ciUw==
X-Gm-Message-State: APjAAAUe2Uzi9Z/rXlFLPtgKiIL0U/I1BKfEjEUPI3ATtkccmEAPihtm
        2JxqGmjKkKo8YuF2bC/2kttmNTE40A1NJ4XofokULg==
X-Google-Smtp-Source: APXvYqyXrQBmouu5GDDT5m91pjiFtd39uZBKfcErjB7T8vaeySN7FBJrwBC4os/PtCmiK1g2TAsdryg5ahnIiPnj/is=
X-Received: by 2002:a67:3251:: with SMTP id y78mr11021809vsy.39.1565573862229;
 Sun, 11 Aug 2019 18:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190811184613.20463-1-urezki@gmail.com> <20190811184613.20463-2-urezki@gmail.com>
In-Reply-To: <20190811184613.20463-2-urezki@gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Sun, 11 Aug 2019 18:37:30 -0700
Message-ID: <CANN689GT3CorHHegQBFR8tiVPqv5XAb2oYLCEbjB=tBhkO2PCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] augmented rbtree: use max3() in the *_compute_max() function
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 11:46 AM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> Recently there was introduced RB_DECLARE_CALLBACKS_MAX template.
> One of the callback, to be more specific *_compute_max(), calculates
> a maximum scalar value of node against its left/right sub-tree.
>
> To simplify the code and improve readability we can switch and
> make use of max3() macro that makes the code more transparent.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks. The change is correct but I think I prefer it the "before"
version. My reasons are:

- I don't have a strong style preference either way - it's the same
amount of code either way, admittedly more modular in your proposal,
but also with more indirection (compute_max refers to get_max and
max3). The indirection doesn't hinder readability but IMO it makes it
harder to be confident that the compiler will generate quality code,
compared to the "before" approach which just lays down all the pieces
in a linear way.

- A quick check shows that the proposed change generates larger code
for mm/interval_tree.o:
   2757       0       0    2757     ac5 mm/interval_tree.o
   2533       0       0    2533     9e5 mm/interval_tree.o.orig
  This does not happen for every RB_DECLARE_CALLBACKS_MAX use,
lib/interval_tree.o in particular seems to be fine. But it does go
towards my gut feeling that the change trusts the compiler/optimizer
more than I want to.

- Slight loss of generality. The "before" code only assumes that the
RBAUGMENTED field can be compared using "<" ; the "after" code also
assumes that the minimum value is 0. While this covers the current
uses, I would prefer not to have that limitation.
