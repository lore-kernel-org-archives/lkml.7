Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E4F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="lJJ0Qj7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfK0TfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:35:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34637 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfK0TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:35:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so82632lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uTDWkxIvzQK+lQ6yvWXXgVNUrJqpN09xTPjHaxPQoxg=;
        b=lJJ0Qj7D+dByWJS0P6lbl2YTSw5nnndoomDD1/OzRqldJjevFbG79ofjqOuANzJHli
         l65FVcWNEp7RGL6g5oYA7NG9p3mxo+nRF4a3TXUdUQjpwmQitca7JJID5APlQ7L/gLWh
         eyE+16ND26CWr5DhHmj5hPyJaj/Yi9QiYbQ7WF6GfkMfSbF3SkkrQY2b/bQ404Bv+bR5
         TwxKwlbGI4guP7fMs6PipnKw5eaeC6HKgwgl3uaR6cYSXODM+K8LO9SVqJd8JcM4Z0u0
         b46DIgYZCGVfmTXhT64lQsJIUii2Tou/XhLqm9K1EyGTL+VAyTXrblOWGsS5FKmJCAje
         yDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uTDWkxIvzQK+lQ6yvWXXgVNUrJqpN09xTPjHaxPQoxg=;
        b=W/qUPmALcdigXkRqEet4ruAqgrfJuk9FdxHuw5Ns6Fon8jVi7//Fg+l2iZLF8gw0rW
         h+nWpGl9f2CLsDSKPNEoZ2Ye+eg7B6i3sM4uaUGBKj2PmLlnDLSZGJmlSWkFmhLt0juI
         x5miwo/p82/x8sRBPHIOarmW5Td9TA/NuDq44d3zRxmSg7DPyhDHYEHh9rUad+2+4qrf
         s7PoV4zdO3xtAoZV85AVbb8JDPpyhGw4Ss1jf4+1W0guB4h3w6HYcN5q67ztAtkLtPQb
         6KybT1iBcKbmXCKE4auTBGGP2TFWAxzqjzLOZIWqU3e9G/NL7EoQtjCXndGNasP5c6u3
         5FRg==
X-Gm-Message-State: APjAAAUE7Ob76hIsfKa5zmf1zppTR4S17tPY0QzlYQ9G8e7O51R8fmJj
        0NjCSwsLvnNiXZ9/H3gIKRdQh/n/qBYmMe47tKw=
X-Google-Smtp-Source: APXvYqyTR9+SLPlISNvDfDWPlEthYrImWYnPuGVb+3H6C39rsGqaoxdYBYdMOlpFIMkU7cN4gQ8WEg==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr26994057lfa.116.1574883316489;
        Wed, 27 Nov 2019 11:35:16 -0800 (PST)
Received: from ?IPv6:2a00:1370:812c:3592:7897:598b:7870:e1b? ([2a00:1370:812c:3592:7897:598b:7870:e1b])
        by smtp.gmail.com with ESMTPSA id p24sm7366773lfc.96.2019.11.27.11.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:35:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <5c9b5bd3-028a-5211-30a6-a5a8706b373e@phunq.net>
Date:   Wed, 27 Nov 2019 22:35:13 +0300
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9F8658C-B88F-44A1-BBEF-98A8259E0712@dubeyko.com>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <8ece0424ceeeffbc4df5d52bfa270a9522f81cda.camel@dubeyko.com>
 <5c9b5bd3-028a-5211-30a6-a5a8706b373e@phunq.net>
To:     Daniel Phillips <daniel@phunq.net>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 11:28 AM, Daniel Phillips <daniel@phunq.net> =
wrote:
>=20
> On 2019-11-26 11:40 p.m., Vyacheslav Dubeyko wrote:
>> As far as I know, usually, a folder contains dozens or hundreds
>> files/folders in average. There are many research works that had =
showed
>> this fact. Do you mean some special use-case when folder could =
contain
>> the billion files? Could you share some research work that describes
>> some practical use-case with billion files per folder?
>=20
> You are entirely correct that the vast majority of directories contain
> only a handful of files. That is my case (1). A few directories on a
> typical server can go into the tens of thousands of files. There was
> a time when we could not handle those efficiently, and now thanks to
> HTree we can. Some directories go into the millions, ask the Lustre
> people about that. If you could have a directory with a billion files
> then somebody will have a use for it. For example, you may be able to
> avoid a database for a particular application and just use the file
> system instead.
>=20
> Now, scaling to a billion files is just one of several things that
> Shardmap does better than HTree. More immediately, Shardmap implements
> readdir simply, accurately and efficiently, unlike HTree. See here for
> some discussion:
>=20
>   https://lwn.net/Articles/544520/
>   "Widening ext4's readdir() cookie"
>=20


So, it looks like that Shardmap could be better for the case of billion =
files in one folder.
But what=E2=80=99s about the regular case when it could be =
dozens/hundreds of files in one
folder? Will Shardmap be better than HTree? If the ordinary user =
hasn=E2=80=99t visible
performance improvement then it makes sense to consider Shardmap like =
the
optional feature. What do you think?

Does it mean that Shardmap is ext4 oriented only? Could it be used for =
another
file systems?


> See the recommendation that is sometimes offered to work around
> HTree's issues with processing files in hash order. Basically, read
> the entire directory into memory, sort by inode number, then process
> in that order. As an application writer do you really want to do this,
> or would you prefer that the filesystem just take care of for you so
> the normal, simple and readable code is also the most efficient code?
>=20


I slightly missed the point here. To read the whole directory sounds =
like to read
the dentries tree from the volume. As far as I can see, the dentries are =
ordered
by names or by hashes. But if we are talking about inode number then we =
mean
the inodes tree. So, I have misunderstanding here. What do you mean?


>> If you are talking about improving the performance then do you mean
>> some special open-source implementation?
>=20
> I mean the same kind of kernel filesystem implementation that HTree
> currently has. Open source of course, GPLv2 to be specific.
>=20

I meant the Shardmap implementation. As far as I can see, the user-space =
implementation
is available only now. So, my question is still here. It=E2=80=99s hard =
to say how efficient the Shardmap
could be on kernel side as ext4 subsystem, for example.


>>> For delete, Shardmap avoids write multiplication by appending =
tombstone
>>> entries to index shards, thereby addressing a well known HTree =
delete
>>> performance issue.
>>=20
>> Do you mean Copy-On-Write policy here or some special technique?
>=20
> The technique Shardmap uses to reduce write amplication under heavy
> load is somewhat similar to the technique used by Google's Bigtable to
> achieve a similar result for data files. (However, the resemblance to
> Bigtable ends there.)
>=20
> Each update to a Shardmap index is done twice: once in a highly
> optimized hash table shard in cache, then again by appending an
> entry to the tail of the shard's media "fifo". Media writes are
> therefore mostly linear. I say mostly, because if there is a large
> number of shards then a single commit may need to update the tail
> block of each one, which still adds up to vastly fewer blocks than
> the BTree case, where it is easy to construct cases where every
> index block must be updated on every commit, a nasty example of
> n**2 performance overhead.
>=20


It sounds like adding updates in log-structured manner. But what=E2=80=99s=
 about
the obsolete/invalid blocks? Does it mean that it need to use some GC =
technique
here? I am not completely sure that it could be beneficial for the ext4.

By the way, could the old index blocks be used like the snapshots in the =
case
of corruptions or other nasty issues?


>> How could be good Shardmap for the SSD use-case? Do you mean that we
>> could reduce write amplification issue for NAND flash case?
>=20
> Correct. Reducing write amplification is particularly important for
> flash based storage. It also has a noticeable beneficial effect on
> efficiency under many common and not so common loads.
>=20
>> Let's imagine that it needs to implement the Shardmap approach. Could
>> you estimate the implementation and stabilization time? How expensive
>> and long-term efforts could it be?
>=20
> Shardmap is already implemented and stable, though it does need wider
> usage and testing. Code is available here:
>=20
>   https://github.com/danielbot/Shardmap
>=20
> Shardmap needs to be ported to kernel, already planned and in progress
> for Tux3. Now I am proposing that the Ext4 team should consider =
porting
> Shardmap to Ext4, or at least enter into a serious discussion of the
> logistics.
>=20
> Added Darrick to cc, as he is already fairly familiar with this =
subject,
> once was an Ext4 developer, and perhaps still is should the need =
arise.
> By the way, is there a reason that Ted's MIT address bounced on my
> original post?
>=20

It=E2=80=99s hard to talk about stability because we haven=E2=80=99t =
kernel-side implementation
of Shardmap for ext4. I suppose that it needs to spend about a year for =
the porting
and twice more time for the stabilization. To port a user-space code to =
the kernel
could be the tricky task. Could you estimate how many lines of code the =
core
part of Shardmap contains? Does it need to change the ext4 on-disk =
layout for
this feature? How easy ext4 functionality can be modified for Shardmap =
support?

Thanks,
Viacheslav Dubeyko.

