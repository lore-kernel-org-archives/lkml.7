Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B74C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0B12067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKRpP+uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfD1S0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:26:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46085 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1S0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:26:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so3988659pll.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFU9GH34/smqe3q1waAwKEe3yqknMZK4e/sD2+AvI0A=;
        b=JKRpP+uonR76Q0riZMPx6XjMcLgsN61N/H++LQd9dzamPoKYfPs5FVFbtwAeCaa+hb
         9fZukW4AsRNMX17nndYR9qSR29J8rbktv8t5Eqo3v8SebbThI4/IWNvIBrq7MZXgSxiv
         p5lBJJFzoEiw44+CFrM2Tp59Zqn2cMvfENrbIyAf2+c83WeJGk1HKZB7kQI0fDUHY41P
         aphM+anl+TQGQ9Eb/BMYglouIgvqvr9EFwZ8EckYMpHsjN9fgMa1Dx9jZZdD3Q+C++EN
         WAB2PcS/5eM5j1Fr5cZgAdEKg3aST6XuSe7G4fZqwPc74ohIe1sed61rClc4Xl7s703Y
         bf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFU9GH34/smqe3q1waAwKEe3yqknMZK4e/sD2+AvI0A=;
        b=TBHb8kBABWKOjy6lv212+QIyOOX+PmoLnhLCViyi4jC3MXuRtC6Xo7v4KP5GbqQL9R
         kvv3eg6jpPx8xqeKUpI4XS/om4TIj6yccPToq1cubnykupOyTmrLGoI8jTWzhNQ825aB
         UMPa1YGrqmhxIAlzwanC2PL8cdMDuXyQ8SHGXTzB+0Sf5caVOBx9cZpBVJ4Blr//281R
         3qqwhAz3C9TJlzmBMFYkpHhTL/nGAr/glSnSh1hLYiMpk+BVLDYBh5DrY38DL/IlLVOR
         MWiJSnMHlOZdIluq+ln5OeDpZb9Y/8Wv/vFRmE4FzhLmAOEqeaeNsEUrJSGVdGzDXxTI
         98Cw==
X-Gm-Message-State: APjAAAXivSY4VGomza+bfTL8ACUGw8tJh7aFeVzkTv5bfk+vE4qtMXkH
        FYCShLy/iojkRbYDE/8MJyw=
X-Google-Smtp-Source: APXvYqylrWILzYVdeSrowaNPzRYcxCoF3PBiuY6dIbvTLy63txlKEDxTAmA+pPT/yiOjyOAiyArnBg==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr4658133plt.157.1556475974166;
        Sun, 28 Apr 2019 11:26:14 -0700 (PDT)
Received: from localhost ([2601:640:4:d03c:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id p14sm58277175pfa.26.2019.04.28.11.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 11:26:13 -0700 (PDT)
Date:   Sun, 28 Apr 2019 11:26:12 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 1/6] lib/string: add strnchrnul()
Message-ID: <20190428182612.GA3150@yury-thinkpad>
References: <20190428032936.1317-1-ynorov@marvell.com>
 <20190428032936.1317-2-ynorov@marvell.com>
 <20190428160400.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428160400.GV9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 07:04:00PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 27, 2019 at 08:29:31PM -0700, Yury Norov wrote:
> > New function works like strchrnul() with a length limited strings.
> 
> The prototype better to be consistent with strchrnul() and memchr(), i.e.
> the size parameter to go last.
 
But if so it would be inconsistent with strnchr(). I'm OK to do the change,
but I'm not sure if this version better than that.

Parameter 'count' should be size_t, not int.
