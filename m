Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5743C47E49
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11121726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9CXeZ0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKBPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:55:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:55:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so774311wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHgA3aOgWjIxl0qn62I+cGe5Q1kSJeNXPkSnAw6wxo0=;
        b=b9CXeZ0Kt9j/VH0zPJp+WpaNlnTomuRQN/Ywv/yTp6vEpPUyLZqh/qmMDVUBC0qNGC
         jh2KFZTh2PAYQeCQXsPZNfPxTl2WQ6eno4QTYnTOn5YDzOfx2NO+REB661RIN/iZm/CF
         d4Cl2Doe4X0nF1ecI6JCm5gPFO+MXsMcaOKAROqGraRSLUlA4+wBIk47KDbObwdYpAuG
         ypkkpcnbQJGN/Kr2RwG1MQAxpfpbM5iJTI3QiBae4xxER0fluC+xu/kCfrZF/5z+Vt8M
         GV8CpKEyJczB6lANsrsDUlXywNxxurdEN9sz1to/tEF2mzQMcanfXlAHIY5MEGwPJ90K
         Soug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHgA3aOgWjIxl0qn62I+cGe5Q1kSJeNXPkSnAw6wxo0=;
        b=qCekb6Pm9pbBwwoBAfTmoHzwsmjGlgMtnwsF2Km2pmipSaxfyYsk6kPQcovekIGagi
         tO2dCl8h6ghwkUcHZKtWz4sLcapkmkBeUQb2TSGzP/gbHdZz/ShaAIVnXnUkSKeEoqP4
         B741c1h+WIIFgX5o6PqQYZoS8JBZu6XiQKNxR202+HUQYw6lQe322gURnwBjWubnXVpx
         0dbHt24Jg42BaXI/MBWnc/xfP1AoTi3HX8QqK66vw/xcGhDvNxuv/o6S9JN6Y5IK0yNE
         c0fgKHkYzdOnnvwwmw1m/LHVtRL8eIa69IEi977N0ff/XfvpVLZmpwo5lTx89jDDktpm
         afGQ==
X-Gm-Message-State: APjAAAUqrcAirhFzABIE5IL8FzCLqzu2eSCTOvLyM38dW37f/sDm2VZe
        tLcrH7Fs89XAvsePXlJpMw==
X-Google-Smtp-Source: APXvYqzTAMVZEW3OLjdyx3dhT8V8uUCGC7IR/94K6k/I57UA9wySYWu5NURdhJYi3cctmp0TRaZJDA==
X-Received: by 2002:a1c:9601:: with SMTP id y1mr14907470wmd.157.1572710140068;
        Sat, 02 Nov 2019 08:55:40 -0700 (PDT)
Received: from avx2 ([46.53.250.90])
        by smtp.gmail.com with ESMTPSA id g184sm13984243wma.8.2019.11.02.08.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 08:55:39 -0700 (PDT)
Date:   Sat, 2 Nov 2019 18:55:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191102155536.GA10251@avx2>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
 <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
 <20191101110901.GB690103@chrisdown.name>
 <20191101144540.GA12808@cmpxchg.org>
 <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
 <20191101192405.GA866154@chrisdown.name>
 <20191101122920.798a6d61b2725da8cfe80549@linux-foundation.org>
 <20191101123544.c9b0024a1e8f5ddf63148b48@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191101123544.c9b0024a1e8f5ddf63148b48@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 12:35:44PM -0700, Andrew Morton wrote:
> On Fri, 1 Nov 2019 12:29:20 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > Either change is an upgrade from the current situation, at least. I prefer 
> > > towards whatever makes the API the least confusing, which appears to be 
> > > Johannes' original change, but I'd support a patch which always set it to 
> > > 0 instead if it was deemed safer.
> > 
> > On the other hand..  As I mentioned earlier, if someone's code is
> > failing because of the permissions change, they can chmod
> > /proc/sys/vm/drop_caches at boot time and be happy.  They have no such
> > workaround if their software misbehaves due to a read always returning
> > "0".
> 
> I lied.  I can chmod things in /proc but I can't chmod things in
> /proc/sys/vm.  Huh, why did we do that?

To conserve memory! It was in 2007.
For the record I support 0200 on vm.drop_caches.

	commit 77b14db502cb85a031fe8fde6c85d52f3e0acb63
	[PATCH] sysctl: reimplement the sysctl proc support

	+static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
	+{
	+       struct inode *inode = dentry->d_inode;
	+       int error;
	+
	+       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
	+               return -EPERM;
