Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75057C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE10214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfKEP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:28:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389546AbfKEP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:28:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FD16AC44;
        Tue,  5 Nov 2019 15:28:22 +0000 (UTC)
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
To:     snazy@snazy.de, Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
References: <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
 <20191025121104.GH17610@dhcp22.suse.cz>
 <c8950b81000e08bfca9fd9128cf87d8a329a904b.camel@gmx.de>
 <20191025132700.GJ17610@dhcp22.suse.cz>
 <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
Date:   Tue, 5 Nov 2019 16:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 2:23 PM, Robert Stupp wrote:
> "git bisect" led to a result.
> 
> The offending merge commit is f91f2ee54a21404fbc633550e99d69d14c2478f2
> "Merge branch 'akpm' (rest of patches from Andrew)".
> 
> The first bad commit in the merged series of commits is
> https://github.com/torvalds/linux/commit/6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> . a75d4c33377277b6034dd1e2663bce444f952c14, the commit before 6b4c9f44,
> is good.

Ah, great you could bisect this. CCing people from the commit
6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")

First mail in thread:
https://lore.kernel.org/linux-mm/b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org/

> I've also verified 5.1.21 and 5.3.8 (from
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/)
> without 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11 and both builds are
> good.
> (The 5.1.21 and 5.3.7 builds from Ubuntu were bad, so I haven't cross-
> checked "vanilla" 5.1.21 and 5.3.8 kernel builds.)
> 
> 
> 
> Recap symptoms:
> - `mlockall(MCL_CURRENT)` hangs
> - shutdown/reboot hangs when it reaches "shutdown->reboot"
> - `cat /proc/$(pidof test)/smaps` shows "Locked" w/ odd values, which
> are equal to "Pss"
> 
> Affected:
> - `cryptsetup luksOpen` hangs (when it tries to lock memory)
> - Apache Cassandra hangs during startup (when it performs an
> `mlockall(MCL_CURRENT)`)
> 
> 
> 
> git checkout v5.1.21
> # revert the "comment-only" commit (no need to test this one)
> # "filemap: add a comment about FAULT_FLAG_RETRY_NOWAIT behavior"
> git revert 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
> # "filemap: drop the mmap_sem for all blocking operations"
> git revert 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> --> GOOD
> 
> git checkout v5.3.8
> # revert the "comment-only" commit (no need to test this one)
> # "filemap: add a comment about FAULT_FLAG_RETRY_NOWAIT behavior"
> git revert 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
> # "filemap: drop the mmap_sem for all blocking operations"
> git revert 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> --> GOOD
> 
> 
> 
> Bisect log:
> git bisect start
> # bad: [9e98c678c2d6ae3a17cb2de55d17f69dddaa231b] Linux 5.1-rc1
> git bisect bad 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> # good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
> git bisect good 1c163f4c7b3f621efff9b28a47abb36f7378d783
> # good: [e266ca36da7de45b64b05698e98e04b578a88888] Merge tag 'staging-
> 5.1-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good e266ca36da7de45b64b05698e98e04b578a88888
> # good: [36011ddc78395b59a8a418c37f20bcc18828f1ef] Merge tag 'gfs2-
> 5.1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-
> gfs2
> git bisect good 36011ddc78395b59a8a418c37f20bcc18828f1ef
> # good: [6bc3fe8e7e172d5584e529a04cf9eec946428768] tools: mark
> 'test_vmalloc.sh' executable
> git bisect good 6bc3fe8e7e172d5584e529a04cf9eec946428768
> # good: [dc2535be1fd547fbd56aff091370280007b0a1af] Merge tag 'clk-for-
> linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good dc2535be1fd547fbd56aff091370280007b0a1af
> # bad: [2b9c272cf5cd81708e51b4ce3e432ce9566cfa47] Merge tag 'fbdev-
> v5.1' of git://github.com/bzolnier/linux
> git bisect bad 2b9c272cf5cd81708e51b4ce3e432ce9566cfa47
> # good: [9bc446100334dbbc14eb3757274ef08746c3f9bd] Merge tag
> 'microblaze-v5.1-rc1' of git://git.monstr.eu/linux-2.6-microblaze
> git bisect good 9bc446100334dbbc14eb3757274ef08746c3f9bd
> # bad: [5160bcce5c3c80de7d8722511c144d3041409657] Merge tag 'f2fs-for-
> 5.1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
> git bisect bad 5160bcce5c3c80de7d8722511c144d3041409657
> # good: [240a59156d9bcfabceddb66be449e7b32fb5dc4a] f2fs: fix to add
> refcount once page is tagged PG_private
> git bisect good 240a59156d9bcfabceddb66be449e7b32fb5dc4a
> # good: [9352ca585b2ac7b67d2119b9386573b2a4c0ef4b] Merge tag 'pm-5.1-
> rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 9352ca585b2ac7b67d2119b9386573b2a4c0ef4b
> # good: [f261c4e529dac5608a604d3dd3ae1cd2adf23c89] Merge branch 'akpm'
> (patches from Andrew)
> git bisect good f261c4e529dac5608a604d3dd3ae1cd2adf23c89
> # good: [aadcef64b22f668c1a107b86d3521d9cac915c24] f2fs: fix to avoid
> deadlock in f2fs_read_inline_dir()
> git bisect good aadcef64b22f668c1a107b86d3521d9cac915c24
> # bad: [8b0f9fa2e02dc95216577c3387b0707c5f60fbaf] filemap: add a
> comment about FAULT_FLAG_RETRY_NOWAIT behavior
> git bisect bad 8b0f9fa2e02dc95216577c3387b0707c5f60fbaf
> # bad: [6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11] filemap: drop the
> mmap_sem for all blocking operations
> git bisect bad 6b4c9f4469819a0c1a38a0a4541337e0f9bf6c11
> # bad: [a75d4c33377277b6034dd1e2663bce444f952c14] filemap: kill
> page_cache_read usage in filemap_fault
> git bisect good a75d4c33377277b6034dd1e2663bce444f952c14
> 
> 
> All kernels built with
> make oldconfig # accept the defaults
> make bindeb-pkg
> 
> 
> 
> On Fri, 2019-10-25 at 17:58 +0200, Robert Stupp wrote:
>> On Fri, 2019-10-25 at 16:00 +0200, Michal Hocko wrote:
>>> And one more thing. Considering that you are able to reproduce and
>>> you
>>> have a working kernel, could you try to bisect this?
>>
>> Yikes - running self-built kernels brings back a lot of memories ;)
>>
>> Anyway, going this route (using the `config` from Ubuntu 5.1.x as a
>> base and accepting the defaults for `make oldconfig`):
>>
>> git checkout v5.1-rc1
>> git bisect start
>> git bisect bad
>> git bisect good v5.0
>>
>> ... first try @ e266ca36da7de45b64b05698e98e04b578a88888 is a `git
>> bisect good`
>>
>> Will report back, when I've got a result...
>>
> 
> 

