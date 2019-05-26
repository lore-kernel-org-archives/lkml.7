Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869F9C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1120863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QK2w6qXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEZTZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:25:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45000 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfEZTZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:25:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so13014328otj.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hHbIltnugKcSDkBP0lFOF1T4eFARSdfUL7k351u/Evs=;
        b=QK2w6qXcjqOvIUgpyQlpPFFjMAx81QOLpKVkdFtld089OLUqJpdi1Yfx3n2vrMdix0
         4bkuis4j8RuyeclsOLtCMzw/vbD1J+8e8S7fOugD1ShLWOnTFJg2shFLzyFJD6l36wux
         dHpEEcI+p4hl92BRM/Hk9Xb79aO2SLOAhVGFd87Yxkm6D9+LiSHad7jrdqQYB21u1nd+
         picqBODCleGqEvYomTllLg2bwr45cB2FKK6grOmMljelrhs/AJqjUt8oipo1j+wyxEYM
         IJn8fqoE8kmmLtjeueQUfNSRybqb8nGF3k8T+sOU3y1AOH5MAOFrFTM6pcjYcwe5eUoE
         HNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hHbIltnugKcSDkBP0lFOF1T4eFARSdfUL7k351u/Evs=;
        b=X+Ey0DJqSVegL38t2wOFtjb8Kf/pwl6YiOU7nDaiuBs4QQNrx4n2psOgd24gQeBjyp
         Lf/XXXc/d0igvuz9RTq/Aj/VC2smDSReFgG3y0K3yHU6VKY11Bjsnh230IRMpSKHQeYO
         Z+panbgpbzn6Eufw//I1ICo46ZSrfwTimH3Z5JwSutyQP9fv3mA4WpZLy/c0L3hDCuQt
         /DXyT1z3cV70CUpbs7PRFS4DULsOr0mnYaOoGTpLI1MfuoY+cYCqu2Y48Q0YEHV4upx/
         XujSZW8syYIPttlK6eYuwP2C7fqTqJDX/jm0enckgkD4YXIPN0w6IuWxJC9oLYp9Iekj
         l/yQ==
X-Gm-Message-State: APjAAAW8LNNuvNiYpLj93SrvqBT0QTZPHVfgoWttI+ye156WdGOnY0jc
        xtp64pnjXjfHwKWq7dI+0w3qNA==
X-Google-Smtp-Source: APXvYqxVQoWiTR05hJVsUZbOaOESbV3MUJKHQDyMkTGxJ4szy2pu1e8Vna2Lax9Tx2JCqEE05NMJrA==
X-Received: by 2002:a9d:3de6:: with SMTP id l93mr7378609otc.51.1558898746865;
        Sun, 26 May 2019 12:25:46 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 43sm3340057oth.47.2019.05.26.12.25.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 12:25:45 -0700 (PDT)
Date:   Sun, 26 May 2019 12:25:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Hugh Dickins <hughd@google.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/fpu: Use fault_in_pages_writeable() for
 pre-faulting
In-Reply-To: <20190526173501.6pdufup45rc2omeo@linutronix.de>
Message-ID: <alpine.LSU.2.11.1905261211400.2004@eggly.anvils>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de> <20190526173501.6pdufup45rc2omeo@linutronix.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-668670725-1558898745=:2004"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-668670725-1558898745=:2004
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 26 May 2019, Sebastian Andrzej Siewior wrote:
> On 2019-05-26 19:33:25 [+0200], To Hugh Dickins wrote:
> From: Hugh Dickins <hughd@google.com>
> =E2=80=A6
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
> Hugh, I took your patch, slapped a signed-off-by line. Please say that
> you are fine with it (or object otherwise).

I'm fine with it, thanks Sebastian. Sorry if I wasted your time by not
giving it my sign-off in the first place, but I was not comfortable to
dabble there without your sign-off too - which it now has. (And thought
you might already have your own version anyway: just provided mine as
illustration, so that we could be sure of exactly what I'd been testing.)

Hugh
--0-668670725-1558898745=:2004--
