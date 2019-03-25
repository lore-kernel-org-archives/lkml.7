Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E41C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1792083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9UfVDgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfCYXoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:44:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCYXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:44:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7355266pgf.2;
        Mon, 25 Mar 2019 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etDxjsM9Oq3NHJQ+SQ3jlnMOWQWp78+pUjuw+dnW+Ds=;
        b=Z9UfVDgPKmnVQMFOE1ahz/vuUM9OipGgovWywGGS54Fui1y/9MZp4KoFSl5eEEcMGC
         yw777vb4DDkBSPbVXMm1EkSxj+ikmqJlaGbFTgTvps5/AW095qIs3QCm9mSwFNMaDvfm
         LZkUETeqaerHg/iGhESrZNn9ckQm3NlNIH2G6Udfv2VwiFTjYBesQm/Ysp1B0DSbjE5U
         G3zyc0rHqUfW6iknywwl8oYgCYKpTd9Bb3Y4guDms8ovwFyQatq74+tpR73l8brND9qG
         8DE0N60fsh3Qg3otrpUhZlUA9H3C+XpwTjHR649FBxe9lukFhSWTV7jv/4b9bJbp7+Fp
         N1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etDxjsM9Oq3NHJQ+SQ3jlnMOWQWp78+pUjuw+dnW+Ds=;
        b=n5bPLEhg8BI//qGGsmJ6QE3rMUa24dzmvI95RG+mXGkxqY5NwL4GqHMhp9lOn85BnD
         2BtsFIDHTk2es5uYxgpUVPpw/NByq70bKsvk/Gmp4TfzH24joO8TwE0aHqxrVIqU0Vc8
         f/XCY0RFCcXQScX9VhaODgRsw5kD5eFU8Uz/2ezorQyvCxaSFi9Y5m+bFs9X0CDgRbYB
         MBSvUp0P/OwusYEd3fXOPqLT8M72rt1OteAPi1Cl+ZOr0V52DX/J6NQul5j4eUMINjHO
         GOxVKpGtKPn658UtdN/WELNNjR0QceSNuveHthLop2DQ6DNlx98idqP9djfZ6V1f6j8M
         wMoA==
X-Gm-Message-State: APjAAAW+Gi5zfc0zLknjL6bw26j8SwwC5jYUDPmu4eKio2oyJGR/KHm/
        zGqWIBhtQPMCmJO1mQ8B7sg=
X-Google-Smtp-Source: APXvYqxzAkcO2M9gqyLaJ+VvG0z0Hjh2W32jd1R5CTgEuPPEucbQwjqugLgKcinqDxapICJCl5/M+g==
X-Received: by 2002:a62:2a97:: with SMTP id q145mr27320245pfq.22.1553557483270;
        Mon, 25 Mar 2019 16:44:43 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::3:b0d9])
        by smtp.gmail.com with ESMTPSA id a7sm20671208pfc.45.2019.03.25.16.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 16:44:42 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:44:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325234439.jimxj6q4bs5ndrwf@ast-mbp>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325233731.GS2217@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:37:32PM +0000, Al Viro wrote:
> 
> For debugfs it's clearly "use default ->evict_inode(), have explicit
> ->destroy_inode() using free_inode_nonrcu()" - there we have nothing
> else done in ->evict_inode() and kfree is obviously safe in softirq.
> I'll post that (or push to vfs.git#fixes), along with minimal fixes
> for other 3.  If bpf_any_put() is softirq-safe, we'll have the full
> set for -stable and the rest could be done on top of that.

Yes. bpf_any_put() is safe to be called from softirq.

