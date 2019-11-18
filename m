Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D279C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F281020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plexistor-com.20150623.gappssmtp.com header.i=@plexistor-com.20150623.gappssmtp.com header.b="S9620AOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKRPoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:44:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35284 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfKRPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:44:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id r16so13972011edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GJ0ekK883NeZMZUbnOx6tfv6CYBKEfSHTXUjhDwyUeM=;
        b=S9620AOuV0azBwnQgkKe4MAK6feIQfFzXCjM5rT1d89T1eIJAs7kOTyI85ZQm5Kr10
         pf5jmg9z1o1gEw7OJdcFjbRBbBCv+SMqb/e2SQTbbNtYOrD3xq4mvrlM10vYBJSOsGWe
         fzG5BLD+8C+1bDvhz09LiWNF9sI0aza27W4zPf1qNeSbP+XE0qaBSoqAmKPtGwjUwxHq
         aSKvtereJnp8IhP4N5c5t9fCLRJ6TgGVdyZzjJf2yGc50jYrFwam33ZFNsYhCurLOLqF
         2E8oHxL1si4ofca6N9yYU9Cuc4+mhhqyDbKVPegWgmvxLpuKYTeCcnTCq9zGKKj450dV
         LDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GJ0ekK883NeZMZUbnOx6tfv6CYBKEfSHTXUjhDwyUeM=;
        b=iRD4sz8Bx1YANmsLPr+FRIUKyydd8U3DRDbAUPzL/xQQIcQ+9BRjP4TDDUbee1nWXC
         28koRV6DPKyWnPEB1pCfTFfB/q/nYA3Ar7X+hAzGjG/72nL3ntnTFvC6CjQzbXnwVF8a
         Jf6Y4LqZCd3sXnyzZnaFEk0Va6A6rxAX0L65fud0/cBwv2hmjajI8Zp8dOfOlgkd3E6u
         yixhGp54gSt8g++Ne4EXgA/7rt+I6SAZlb+0W5mBO12O9RkKP+pEGkBrsRa5MCnSKxI0
         oOWBM4CoUWDnuz1drpvqYCFjN35Ke7/KC+E9Cs9pOwD2+KgJORohyHALZejI6mZ4tl7R
         Oe4w==
X-Gm-Message-State: APjAAAUJe3JKSSCxlo06N7MWlZZteMSkqtDG89S4YEn8O+Fv2Oy8stZj
        X/hBkT/PdiBwJGFonhjlA2A9Vg47thk=
X-Google-Smtp-Source: APXvYqzQZ+zTMiGJgBJzjoGforYJd5khUjKhu4zz2kwvxF3RMtFM54UppBbSXMQg2P/IPL+P5Mtn0g==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr15819405ejd.226.1574091868834;
        Mon, 18 Nov 2019 07:44:28 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id t4sm266331ejd.9.2019.11.18.07.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:44:28 -0800 (PST)
Subject: Re: Please add the zuf tree to linux-next
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org>
 <20191029160733.298c6539@canb.auug.org.au>
 <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com>
 <CAJfpegtT-nX7H_-5xpkP+fp8LfdVGbSTfnNf-c=a_EfOd3R5tA@mail.gmail.com>
 <e723e3cc-210a-4d6d-af86-b3a9c94cb379@plexistor.com>
 <CAJfpegsnuJANxUesWfWPBWw2pc+XtJJfRMfqxfYHB3ee1o2ZZA@mail.gmail.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <fbfd6a02-a1a1-360b-3f33-37a5a5f53063@plexistor.com>
Date:   Mon, 18 Nov 2019 17:44:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegsnuJANxUesWfWPBWw2pc+XtJJfRMfqxfYHB3ee1o2ZZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 10:04, Miklos Szeredi wrote:
> On Thu, Nov 14, 2019 at 5:04 PM Boaz Harrosh <boaz@plexistor.com> wrote:
<>
>> - The way we do the mount is very different. It is not the Server that does
>>   The mount but the Kernel. So auto bind mount works (same device different dir)
> 
> This is not a significant difference.  I.e. the following could be
> added to the fuse protocol to optionally operate this way:
> 
> - server registers filesystem at startup, does not perform any mount
> (sends FUSE_NOTIFY_REGISTER)
> - on mount kernel sends a FUSE_FS_LOOKUP message, server looks up or
> creates filesystem instance and returns a filesystem ID
> - filesystem ID is sent in further message headers (there's a 32bit
> spare field where this fits nicely)
> 

OK

>> - The way zuf owns the devices in the Kernel, and supports multi-devices.
> 
> Same as above, one server process could handle as many filesystem
> instances (possibly of different type) as necessary.
> 

[md]
You misunderstood me. In zuf similar to btrfs. We support multiple devices
under the same supper-block via a device_table. Any device from the list
given on the command line will mount the all device_table in the correct
locking order. Including auto-bind mount. Any device given on command line
will find and loaded the same SB.

Once device_table is loaded the all t1 (pmem) space is presented as a single
linear address space to the Server. As well as the all t2 (non-pmem) device-space
is presented as one abstract linear array.

>>   And has support for pmem devices as well as what we call t2 (regular) block
>>   devices. And the all API for transfer between them. (The all md.* thing).
> 
> Extending the protocol to pass reference to pmem or any other device
> is certainly possible.  See the  FUSE2_DEV_IOC_MAP_OPEN in the
> prototype.
> 

This is new, not yet tested code that I believe was inspired by zufs?
Our ZUFS_IOC_IO is much much richer (Just because it is older), then
fuse's.

Our code is very stable and heavily tested. And runs at costumers sites.

Just one more reason why ZUFS should be in Kernel. Linux forte is because
of its diversity, and the way projects interchange ideas and code.
FUSE already gained so much from ZUFS. Why would we not have it in Kernel?

>>   Proper locking of devices.
> 
> Care to explain?
> 

See the [md] explanation above. Think of a race between:

mount /dev/pmem0 /foo
mount /dev/pmem1 /bar

But pmem0 && pmem1 belong to the same FS (under same SB). Can user-mode
resolve such a race? never. Only Kernel, one central point can.
Again see md.* files in the zuf project. This is important code.

>> - The way we are true zero-copy both pmem and t2.
> 
> See FUSE_MAP request in fuse2 prototype.
> 

Again very new code. Our is richer and older and very much stabilized.
And has some unique fixtures that can be only under zuf and the way it
is structured.

>> - The way we are DAX both pwrite and mmap.
> 
> This is not implemented yet in the prototype, but there's nothing
> preventing the mapping returned by the FUSE_MAP request to be cached
> and used for mmap and  I/O without any further exchanges with server.
> 

Again FUSE_MAP is newer code then ZUFS. And is yet lacking fixtures
in order to work for zufs and dax.

>> - The way we are NUMA aware both Kernel and Server.
> 
> I've tested the prototype on huge NUMA systems, and it certainly was
> very scalable.
> 

I am not sure you have ever implemented multy-numa pmem and multy-numa
RDMA NICs and NvME cards. These are not supported by FUSE and very
hard to implement by other Kernel APIs.

The md.h code is from the base NUMA aware and presents the server with
the full information it needs.

No other Filesystem in the world does that.

>> - The way we use shared memory pools that are deep in the protocol between
>>   Server and Kernel for zero copy of meta-data as well as protocol buffers.
> 
> Again, the fuse2 prototype uses shared memory for communication, and
> this helps (though not as much as CPU locality).
> 

Yes inspired by zufs? You said yourself "fuse2 prototype". Our code
is two years old is way passed prototype. Even passed alfa and beta
and runs at costumers data centers.

For the "fuse2 prototype" to support the special needs of ZUFS it will
need more changes still.

>> - The way we do pigy-back of operations to save round-trips.
> 
> It is not difficult to extend the FUSE protocol to allow bundling of
> several requests and replies.
> 

Again this is already done.

>> - The way we use cookies in Kernel of all Server objects so there are no
>>   i_ino hash tables or look-ups.
> 
> I don't get that.  zuf_iget() calls iget_locked() which does the inode
> hash lookup.
> 

Sorry I did not explain well. I mean in fuse communication passes an i_ino
to denote what file to write to. therefor userspace needs an hash-table to
look-up i_ino-to-FS-object at every API call?

In zufs we have an opaque struct zus_inode associated per kernel-inode so
the only hash is the Kernel hash. The same is with all other Server objects like
per-sb, per FS-register, xattrs and so on.

>> - The way we use a single Server with loadable FS modules. That the ZUSD comes
>>   with the distro and only the FS-pluging comes from Vendor. So Kernel=Server API
>>   is in sync.
> 
> Same abstraction is provided by libfuse.  Pluggable fs modules are
> also certainly possible, in fact libfuse already has something like
> that: fuse_register_module().
> 
 ---
>> - The way ZUFS supports root filesystem.
> 
> Why is that a unique feature?
> 

Can fuse be the root FS, I did not now? Can you install and boot a Fedora on it?

>> - The way ZUFS supports VM-FS to SHARE same p-memory as HOST-FS
>> - The way we do Zero-copy IO, both pmem and bdevs
> 
> I think these have been mentioned above already.
> 
 ---
<>
> Well, I'm not saying it would be an easy job, just sthat doing a
> rewrite with the already existing and well established API might well
> pay off in the long run.
> 

I think the opposite. I think the projects separate would be more stable
and less risky and less work. They do come to solve two opposite sides
of the problem spectrum. (See page-cache vs pmem)

bloating everything in one place is sometimes risky to the two sides.

<>
> 
> Again, I'm not suggesting that you add zufs features to fuse.   I'm
> suggesting that you implement zufs features with the fuse protocol,
> extending it where needed, but keeping the basic format the same.
> 

Sigh, FUSE has legacy I do not want. And the new stuff that I need
is in prototype stage and very big parts are still missing.
I still do not see the merits why keep them the same. The FS will need to
know.

I am not sure you are fully aware of the ZUFS API and what it enables.
An FS that supports both pmem and bdev devices under the same SB and
behind the scene migrates data from hot-to-cold or cold-to-hot storage
is hard to do. The lucking and racing takes a long time to master. The
DAX thing that ZUFS is doing is not so simple too.

I am the laziest person there is. Believe me. What you are suggesting is
much much more work. short term and long. And I do not see any other benefits.
Having all this extra bloat in fuse is not good for fuse users. And ....
Fuse will never be what zufs wants to be, because of legacy and structure

I do see a lot of merit to have both projects in Kernel and both
projects feed and inspire each other. Just as they already are.

<>
> 
> I hope to get around to do a review eventually.  API design is hard.
> I know how many times I got it wrong in fuse, and how much pain that
> has caused.
> 

True

> Thanks,
> Miklos
> 

Thanks Miklos. I will think some more about what you are saying.
Boaz
