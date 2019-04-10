Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F948C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621152075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfDJSLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:11:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40958 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDJSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:11:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEHh9-00005Z-G1; Wed, 10 Apr 2019 18:11:35 +0000
Date:   Wed, 10 Apr 2019 19:11:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190410181135.GA32071@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk>
 <20190326014552.GY2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326014552.GY2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:45:52AM +0000, Al Viro wrote:
> On Mon, Mar 25, 2019 at 11:37:32PM +0000, Al Viro wrote:
> 
> > For debugfs it's clearly "use default ->evict_inode(), have explicit
> > ->destroy_inode() using free_inode_nonrcu()" - there we have nothing
> > else done in ->evict_inode() and kfree is obviously safe in softirq.
> > I'll post that (or push to vfs.git#fixes), along with minimal fixes
> > for other 3.  If bpf_any_put() is softirq-safe, we'll have the full
> > set for -stable and the rest could be done on top of that.
> > 
> > Won't solve the documetation problem, unfortunately ;-/
> 
> Posted; all of those (as well as Daniel's bpf patch) are Cc:stable
> fodder.  Documentation is still, er, deficient...

... and unfortunately there are two more, exactly like debugfs -
securityfs and apparmorfs, found while sorting out the series
for separate rcu-delayed counterpart of ->destroy_inode().

Both are in vfs.git#fixes.  Which way should that go - directly or
via linux-security.git?  Both are stable fodder, in theory, but
much harder to hit than their ubifs/debugfs/bpf counterparts...
